package com.embarcadero.blackberrydemoclientapp;

import net.rim.device.api.ui.Field;
import net.rim.device.api.ui.FieldChangeListener;
import net.rim.device.api.ui.Manager;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.ButtonField;
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.component.EditField;
import net.rim.device.api.ui.container.HorizontalFieldManager;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.ui.decor.BorderFactory;

import com.embarcadero.javablackberry.DBXException;
import com.embarcadero.javablackberry.DSProxy.TCompanyTweet;

public class FollowingTweetsScreen extends MainScreen {

	private HorizontalFieldManager hfm;
	private EditField edt;
	private ButtonField btn;
	private TCompanyTweet company;
	private BBDemoClientApp myapp = ((BBDemoClientApp) UiApplication
			.getUiApplication());
	private int end_keycode = 1179648; // 1179648 the keycode of home button

	public FollowingTweetsScreen() {
		super();
		company = myapp.getCompanyTweet();
		edt = new EditField("", "", 140, FIELD_HCENTER | FIELD_VCENTER);
		edt.setMargin(0, 0, 0, 15);
		edt.setBorder(BorderFactory
				.createRoundedBorder(new net.rim.device.api.ui.XYEdges(5, 5, 5,
						5)));
		edt.setChangeListener(new FieldChangeListener() {

			public void fieldChanged(Field field, int context) {
//				if (edt.getTextLength() <= 0)
//					btn.setEnabled(false);
//				else
//					btn.setEnabled(true);
			}
		});
		btn = new ButtonField("Tweet", ButtonField.CONSUME_CLICK);
//		btn.setEnabled(false);
		btn.setChangeListener(new FieldChangeListener() {
			public void fieldChanged(Field field, int context) {
				try {
					company.SendTweet(edt.getText());
					edt.setText("");
				} catch (DBXException e) {
					Dialog.alert(e.getMessage());
					myapp.resetProxy();
					myapp.popScreen(getScreen());
					myapp.pushScreen(new LoginScreen());
				}
			}
		});

		hfm = new HorizontalFieldManager(Manager.NO_HORIZONTAL_SCROLL
				| Manager.FIELD_HCENTER | Manager.FIELD_VCENTER);
		hfm.setMargin(20, 10, 20, 10);
		hfm.add(btn);
		hfm.add(edt);

		add(hfm);

		// Create a menu item
		MenuItem _viewItem = new MenuItem("Logout", 0, 0) {
			public void run() {
				if (Dialog.ask(Dialog.D_OK_CANCEL, "Are you sure ? ") == Dialog.D_OK) {
					logoutAndLoginPage();
				}

			}
		};

		MenuItem active_users = new MenuItem("Active Users", 0, 0) {
			public void run() {
				UiApplication.getUiApplication().popScreen(getScreen());
				UiApplication.getUiApplication().pushScreen(
						new FollowingUsersScreen());

			}
		};

		addMenuItem(_viewItem);
		addMenuItem(active_users);

	}

	protected boolean keyDown(int keycode, int time) {
		// 1179648 the keycode of home button
		if (keycode == end_keycode) {
			if (Dialog.ask(Dialog.D_OK_CANCEL, "Are you sure to quit? ") == Dialog.D_OK)
				logoutAndLoginPage();
			else
				return true;
		}
		return super.keyDown(keycode, time);
	}

	private void logoutAndLoginPage() {
		myapp.logout();
		myapp.popScreen(getScreen());
		myapp.pushScreen(new LoginScreen());
	}

	public boolean onClose() {
		if (Dialog.ask(Dialog.D_OK_CANCEL, "Are you sure to quit? ") == Dialog.D_OK){
			logoutAndLoginPage();
		}
		return true;
	}
}