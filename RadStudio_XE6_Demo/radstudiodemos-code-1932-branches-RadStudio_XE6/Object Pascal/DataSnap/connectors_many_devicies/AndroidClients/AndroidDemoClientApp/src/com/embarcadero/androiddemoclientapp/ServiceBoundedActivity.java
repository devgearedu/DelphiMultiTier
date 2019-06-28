package com.embarcadero.androiddemoclientapp;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.IBinder;
import android.util.Log;

public abstract class ServiceBoundedActivity extends Activity {
	final protected String TAG = "CT";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);				
	}
	
	@Override
	protected void onStart() {
		super.onStart();
		Log.i(TAG, "onStart ServiceBoundedActivity");		
		doBindService();
	}

	@Override
	protected void onStop() {
		Log.i(TAG, "onStop ServiceBoundedActivity");		
		doUnbindService();		
		super.onStop();
	}

	
	protected void serviceBounded()
	{
		//do nothing
	}
	
	boolean mIsBound = false;

	protected boolean getIsBound() {
		return mIsBound;
	}

	private CBService mBoundService;

	protected CBService getCBService() {
		return mBoundService;
	}

	
	
	void doBindService() {
		// Establish a connection with the service. We use an explicit
		// class name because we want a specific service implementation that
		// we know will be running in our own process (and thus won't be
		// supporting component replacement by other applications).
		startService(new Intent(this, CBService.class));
		bindService(new Intent(this, CBService.class), mConnection,
				Context.BIND_AUTO_CREATE);
		mIsBound = true;
	}

	void doUnbindService() {
		if (mIsBound) {
			// Detach our existing connection.
			unbindService(mConnection);
			mIsBound = false;
		}
	}

	private ServiceConnection mConnection = new ServiceConnection() {
		public void onServiceConnected(ComponentName className, IBinder service) {
			// This is called when the connection with the service has been
			// established, giving us the service object we can use to
			// interact with the service. Because we have bound to a explicit
			// service that we know is running in our own process, we can
			// cast its IBinder to a concrete class and directly access it.
			mBoundService = ((CBService.MyLocalBinder) service).getService();
			Log.i(TAG, "Connected to the service");			
			serviceBounded();			
		}

		public void onServiceDisconnected(ComponentName className) {
			// This is called when the connection with the service has been
			// unexpectedly disconnected -- that is, its process crashed.
			// Because it is running in our same process, we should never
			// see this happen.
			mBoundService = null;
			Log.i(TAG, "Disconnected from the service");
		}
	};

}
