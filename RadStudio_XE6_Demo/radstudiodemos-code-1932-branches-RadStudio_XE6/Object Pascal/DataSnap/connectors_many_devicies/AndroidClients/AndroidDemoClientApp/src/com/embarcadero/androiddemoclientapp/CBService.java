package com.embarcadero.androiddemoclientapp;

import android.app.Service;
import android.content.Intent;
import android.os.Binder;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.preference.PreferenceManager;
import android.util.Log;
import android.widget.Toast;

import com.embarcadero.javaandroid.DBXCallback;
import com.embarcadero.javaandroid.DBXException;
import com.embarcadero.javaandroid.DSCallbackChannelManager;
import com.embarcadero.javaandroid.DSCallbackChannelManager.DSCallbackChannelManagerEventListener;
import com.embarcadero.javaandroid.DSProxy;
import com.embarcadero.javaandroid.DSProxy.TCompanyTweet;
import com.embarcadero.javaandroid.DSRESTConnection;
import com.embarcadero.javaandroid.TJSONArray;

public class CBService extends Service {

	public class MyLocalBinder extends Binder {
		CBService getService() {
			return CBService.this;
		}
	}

	@Override
	public IBinder onBind(Intent intent) {
		Log.i(TAG, "onBind");
		return mBinder;
	}

	private final IBinder mBinder = new MyLocalBinder();

	private String username;

	private DSCallbackChannelManager manager = null;

	private DSCallbackChannelManager manager_cmd = null;

	private ITweetsView iTweetsView;

	private boolean notification = false;

	private static final String TAG = "CBService";

	@Override
	public void onCreate() {
		super.onCreate();
		Log.i(TAG, "CBService Created");
	}

	@Override
	public void onDestroy() {
		Log.i(TAG, "CBService Destroyed");
		try {
			getCompanyTweet().Logout();
			manager.closeClientChannel();
			manager_cmd.closeClientChannel();
		} catch (Exception e) {
			e.printStackTrace();
		}
		super.onDestroy();
	}

	@Override
	public int onStartCommand(Intent intent, int flags, int startId) {
		// We want this service to continue running until it is explicitly
		// stopped, so return sticky.
		return START_STICKY;
	}

	// custom methods
	public void showSomething(String message) {
		Toast.makeText(this, message, Toast.LENGTH_LONG).show();
	}

	public TJSONArray getUsersList() throws DBXException {
		return getCompanyTweet().UsersList();
	}

	public void setUsersToFollow(TJSONArray usersToFollow) throws DBXException {
		getCompanyTweet().SetUsersToFollow(usersToFollow);
	}

	public void sendTweet(String tweet) throws DBXException {
		getCompanyTweet().SendTweet(tweet);
	}

	public String getUserName() {
		return username;
	}

	public void logout() throws DBXException {
		try {
			//logging out closes the session. Closing the session stops the callback tunnels
			if (instance != null)
				getCompanyTweet().Logout();
		} catch (Exception ex) {
			//do nothing
		} finally {
			resetProxy();
		}
	}

	public DSProxy.TCompanyTweet.LoginUserReturns loginUser(String username)
			throws DBXException {
		DSProxy.TCompanyTweet.LoginUserReturns result = null;
		result = getCompanyTweet().LoginUser(username);
		if (result.returnValue) {
			this.username = username;
			registerCallbacks();
		}
		return result;

	}

	public void setTweetsView(ITweetsView tv) {
		iTweetsView = tv;
	}

	public void clearTweetsActivity() {
		setTweetsView(null);
	}

	public void enableNotification(boolean value) {
		notification = value;
	}

	private boolean isNotificationEnabled() {
		return notification;
	}

	private Handler handler = new Handler() {
		@Override
		public void handleMessage(Message msg) {
			switch (msg.what) {
			case 1: { // tweet message
				String usr = msg.getData().getString("username");
				String txt = msg.getData().getString("message");
				CTNotificationManager.ring_tweet(CBService.this);
				if (iTweetsView != null)
					iTweetsView.getAdapter().add(usr + ": " + txt);
				if (isNotificationEnabled())
					CTNotificationManager.notify(CBService.this,
							FollowingTweetsActivity.class, "New notification from Company Tweet", "Company Tweet", usr
									+ " has tweeted you", usr, txt);
				break;
			}
			case 2: { // cmd message
				String cmd = msg.getData().getString("cmd");

				if (cmd.equalsIgnoreCase("ring")) {
					CTNotificationManager.ring(CBService.this);
				}
				if (cmd.equalsIgnoreCase("vibrate")) {
					CTNotificationManager.vibrate(CBService.this);
				}
				break;
			}
			}
		}
	};

	private void registerCallbacks() {
		DSCallbackChannelManagerEventListener mEventListener;
		mEventListener = new DSCallbackChannelManagerEventListener() {
			public void onException(DSCallbackChannelManager mngr, Throwable e) {
				/*
				Intent dialog = new Intent(CBService.this, DialogActivity.class)
						.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
				if (e instanceof SocketTimeoutException)
					dialog.putExtra("error", "Timeout occurred");
				else
					dialog.putExtra("error", e.getMessage());
				if (!isNotificationEnabled()) {
					startActivity(dialog);
				} else {
				*/				
					if (iTweetsView != null)						
						iTweetsView.goToDisconnectedMode();
					resetProxy();
					CTNotificationManager.ring_tweet(CBService.this);
					CTNotificationManager.notify(CBService.this,
							LoginActivity.class, "Connection problems", "Company Tweet",
							"You are disconnected. Click here to login.", "", "");
				/*}*/
			}
		};

		// Register the tweet channel
		manager = new DSCallbackChannelManager(getCompanyTweet().getConnection().Clone(true), "ct");
		manager.setMaxRetries(10);
		manager.setRetryDelay(2000);
		DBXCallback cb = new CTCallback(handler);
		try {
			manager.registerCallback(getUserName(), cb);
			manager.setEventListener(mEventListener);			
		} catch (Exception e) {
			e.printStackTrace();
			Utils.ShowToast(this, e.getMessage());			
		}
		

		// Register the "command" channel
		manager_cmd = new DSCallbackChannelManager(getCompanyTweet().getConnection().Clone(true), "cmd");
		manager_cmd.setMaxRetries(10);
		manager_cmd.setRetryDelay(2000);		
		DBXCallback cb_cmd = new CTCMDCallback(handler);		
		try {
			manager_cmd.registerCallback("cbcmd", cb_cmd);
			manager_cmd.setEventListener(mEventListener);			
		} catch (Exception e) {		
			Utils.ShowToast(this, e.getMessage());			
		}
	}

	private TCompanyTweet instance = null;

	protected void resetProxy() {
		instance = null;
		manager = null;
		manager_cmd = null;
		CTNotificationManager.cancelAllNotification(CBService.this);
	}

	protected TCompanyTweet getCompanyTweet() {
		if (instance == null) {
			Log.i(TAG, "NEW COMPANY TWEET");
			DSRESTConnection connection = new DSRESTConnection();
			String host = PreferenceManager.getDefaultSharedPreferences(this)
					.getString("host", "datasnap.embarcadero.com");
			String port = PreferenceManager.getDefaultSharedPreferences(this)
					.getString("port", "8086");
			connection.setHost(host);
			connection.setPort(Integer.valueOf(port));
			connection.setProtocol("http");
			connection.setConnectionTimeout(6000);
			connection.setCommunicationTimeout(10000);
			instance = new TCompanyTweet(connection);
		}
		return instance;
	}
}