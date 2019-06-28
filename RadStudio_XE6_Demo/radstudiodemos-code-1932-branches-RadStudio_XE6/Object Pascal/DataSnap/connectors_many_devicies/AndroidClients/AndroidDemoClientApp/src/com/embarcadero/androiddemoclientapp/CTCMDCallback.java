package com.embarcadero.androiddemoclientapp;


import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;

import com.embarcadero.javaandroid.DBXCallback;
import com.embarcadero.javaandroid.TJSONObject;
import com.embarcadero.javaandroid.TJSONValue;

public class CTCMDCallback extends DBXCallback {

	private Handler handler;

	public CTCMDCallback(Handler handler) {
		super();
		this.handler = handler;
	}	
	
	@Override
	public TJSONValue execute(TJSONValue value, int JSONType) {
		Log.i("callback", value.toString());
		TJSONObject obj =  (TJSONObject) value;
		Message m = handler.obtainMessage(2); //it's a CMD message
		Bundle b = new Bundle();
		b.putString("cmd", obj.getString("cmd"));
		b.putString("value", obj.getString("value"));
		m.setData(b);
		handler.sendMessage(m);
		return null;
	}

}
