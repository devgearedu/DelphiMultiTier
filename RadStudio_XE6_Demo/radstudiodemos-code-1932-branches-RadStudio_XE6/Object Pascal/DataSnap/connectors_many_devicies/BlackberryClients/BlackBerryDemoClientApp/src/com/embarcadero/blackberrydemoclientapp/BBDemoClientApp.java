package com.embarcadero.blackberrydemoclientapp;

import com.embarcadero.javablackberry.DBXCallback;
import com.embarcadero.javablackberry.DSCallbackChannelManager;
import com.embarcadero.javablackberry.DSCallbackChannelManager.DSCallbackChannelManagerEventListener;
import com.embarcadero.javablackberry.DSRESTConnection;
import com.embarcadero.javablackberry.DSProxy.TCompanyTweet;

import net.rim.device.api.system.Application;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.Dialog;

/**
 * This class extends the UiApplication class, providing a graphical user
 * interface.
 */
public class BBDemoClientApp extends UiApplication {
	/**
	 * Entry point for application
	 * 
	 * @param args
	 *            Command line arguments (not used)
	 */
	private String username;

	private String server = "datasnap.embarcadero.com";
	private String port = "8086";

	private TCompanyTweet company;

	public String connectionError = "Failed to connect to the Server.\nThe server may be offline. You may also want to check your connection settings, to ensure they were entered correctly.";

	public TCompanyTweet getCompanyTweet() {
		if (company == null) {
			DSRESTConnection connection = new DSRESTConnection();
			connection.setHost(server);
			connection.setPort(Integer.valueOf(port).intValue());
			connection.setProtocol("http");
			connection.setConnectionTimeout(10000);
			company = new TCompanyTweet(connection);
		}
		return company;
	}

	public void setServer(String server) {
		this.server = server;
		logout();
	}

	public String getServer() {
		return server;
	}

	public void setPort(String port) {
		this.port = port;
		logout();
	}

	public String getPort() {
		return port;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUsername() {
		return username;
	}

	public static void main(String[] args) {
		// Create a new instance of the application and make the currently
		// running thread the application's event dispatch thread.
		BBDemoClientApp theApp = new BBDemoClientApp();
		theApp.enterEventDispatcher();
	}

	private DSCallbackChannelManager manager;

	private DSCallbackChannelManager manager_cmd;

	/**
	 * Creates a new MyApp object
	 */
	public BBDemoClientApp() {
		// Push a screen onto the UI stack for rendering.
		pushScreen(new LoginScreen());
	}

	public void registerCallbacks() {
		
		DSCallbackChannelManagerEventListener mEventListener;
		mEventListener = new DSCallbackChannelManagerEventListener() {
			public void onException(DSCallbackChannelManager mngr, Throwable e) {
				synchronized (UiApplication.getEventLock()) {
					final BBDemoClientApp myapp = ((BBDemoClientApp) UiApplication.getUiApplication());
					final String message = e.getMessage();
					myapp.resetProxy();
					myapp.invokeLater(new Runnable() {
						public void run() {
							Dialog.alert(message);
							myapp.popScreen(myapp.getActiveScreen());
							myapp.pushScreen(new LoginScreen());
						}
					});
				}
			}
		};

		// Register the tweet channel
		manager = new DSCallbackChannelManager(getCompanyTweet()
				.getConnection().Clone(true), "ct");
		manager.setMaxRetries(10);
		manager.setRetryDelay(2000);
		DBXCallback cb = new CTCallback();
		try {
			Thread.sleep(100);
			manager.registerCallback(getUsername(), cb);
			manager.setEventListener(mEventListener);
		} catch (Exception e) {
			Dialog.alert(e.getMessage());
		}
		
		// Register the "command" channel
		manager_cmd = new DSCallbackChannelManager(getCompanyTweet()
				.getConnection().Clone(true), "cmd");
		manager_cmd.setMaxRetries(10);
		manager_cmd.setRetryDelay(2000);
		DBXCallback cb_cmd = new CTCMDCallback();
		try {
			manager_cmd.registerCallback("cbcmd", cb_cmd);
			manager_cmd.setEventListener(mEventListener);
		} catch (Exception e) {
			Dialog.alert(e.getMessage());
		}

	}

	public void invokeAndWait(final Application application,
			final Runnable runnable) {
		final Object syncEvent = new Object();
		synchronized (syncEvent) {
			application.invokeLater(new Runnable() {
				public void run() {
					runnable.run();
					synchronized (syncEvent) {
						syncEvent.notify();
					}
				}
			});
			try {
				syncEvent.wait();
			} catch (InterruptedException e) {
				// This should not happen
				throw new RuntimeException(e.getMessage());
			}
		}
	}

	public void logout() {

		try {
			//logging out closes the session. closing the session closes all callback tunnels
			if (company != null)
				company.Logout();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			resetProxy();
		}

	}

	public void resetProxy() {
		company = null;
		manager = null;
		manager_cmd = null;
	}

}
