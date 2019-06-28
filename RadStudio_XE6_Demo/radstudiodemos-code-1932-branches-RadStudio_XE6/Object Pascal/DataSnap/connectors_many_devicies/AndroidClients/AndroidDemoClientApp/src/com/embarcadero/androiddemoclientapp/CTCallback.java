package com.embarcadero.androiddemoclientapp;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;

import com.embarcadero.javaandroid.DBXCallback;
import com.embarcadero.javaandroid.TJSONObject;
import com.embarcadero.javaandroid.TJSONValue;

public class CTCallback extends DBXCallback {

	private Handler handler;

	public CTCallback(Handler handler) {
		super();
		this.handler = handler;
	}

	@Override
	public TJSONValue execute(TJSONValue value, int JSONType) {
		Log.i("callback", value.toString());
		TJSONObject obj =  (TJSONObject) value;
		Message m = handler.obtainMessage(1); //it's a simple tweet message
		Bundle b = new Bundle();
		b.putString("username", obj.getString("username"));
		b.putString("message", obj.getString("message"));
		m.setData(b);
		handler.sendMessage(m);
		return null;
	}

}
