package com.embarcadero.blackberrydemoclientapp;

import net.rim.device.api.system.EncodedImage;
import net.rim.device.api.ui.Manager;
import net.rim.device.api.ui.Screen;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.BitmapField;
import net.rim.device.api.ui.component.TextField;
import net.rim.device.api.ui.container.HorizontalFieldManager;

import com.embarcadero.javablackberry.DBXCallback;
import com.embarcadero.javablackberry.TJSONObject;
import com.embarcadero.javablackberry.TJSONValue;

public class CTCallback extends DBXCallback {

	private Screen mScreen;

	public CTCallback() {
		super();
	}

	private void addTextLabel(String username, String message) {
		synchronized (UiApplication.getEventLock()) {
			HorizontalFieldManager hfm = new HorizontalFieldManager(Manager.NO_HORIZONTAL_SCROLL
					| Manager.FIELD_HCENTER | Manager.FIELD_VCENTER);
			hfm.setMargin(10, 10, 0, 10);
			TextField txt = new TextField(TextField.FIELD_VCENTER|TextField.READONLY);
			txt.setLabel(username + " : ");
			txt.setText(message);
			txt.setMargin(0, 0, 0, 20);
			BitmapField btm = new BitmapField(EncodedImage.getEncodedImageResource("img/tweet_icon.png").getBitmap(),BitmapField.FIELD_VCENTER);
			hfm.add(btm);
			hfm.add(txt);
			mScreen.add(hfm);
			mScreen.invalidate();
			hfm.setVisualState(Manager.VISUAL_STATE_ACTIVE|Manager.VISUAL_STATE_FOCUS);
		}
	}

	public TJSONValue execute(TJSONValue value, int JSONType) {
		final TJSONObject obj =  (TJSONObject) value;
		if (UiApplication.getUiApplication().getActiveScreen() instanceof FollowingTweetsScreen) {
			//TJSONObject obj =  params.getJSONObject(0);
			mScreen = UiApplication.getUiApplication().getActiveScreen();
			addTextLabel(obj.getString("username"),
					obj.getString("message"));
			NotificationManager.ring_tweet();
		}
		//TODO:: add this in if you want users to receive notification of new messages while on the users list page
//		else {
//			synchronized (UiApplication.getEventLock()) {
//				UiApplication.getUiApplication().invokeLater(new Runnable() {
//					public void run() {
//					  Dialog.inform(obj.getString("message"));
//					}
//				});
//			}
//		}
			
		return null;
	}

}
