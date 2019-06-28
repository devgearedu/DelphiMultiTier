package com.embarcadero.blackberrydemoclientapp;

import com.embarcadero.javablackberry.DBXCallback;
import com.embarcadero.javablackberry.TJSONObject;
import com.embarcadero.javablackberry.TJSONValue;

public class CTCMDCallback extends DBXCallback {

	public CTCMDCallback() {
		super();
	}

	public TJSONValue execute(TJSONValue value, int JSONType) {
		TJSONObject obj =  (TJSONObject) value;
		String cmd = obj.getString("cmd");
		if (cmd.equalsIgnoreCase("ring"))
			NotificationManager.ring();
		if (cmd.equalsIgnoreCase("vibrate"))
			NotificationManager.vibrate();
		return null;
	}

}
