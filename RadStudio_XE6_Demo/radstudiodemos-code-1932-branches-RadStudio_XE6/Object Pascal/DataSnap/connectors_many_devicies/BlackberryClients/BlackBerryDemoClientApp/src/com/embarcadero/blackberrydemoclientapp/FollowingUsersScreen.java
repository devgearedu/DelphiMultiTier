package com.embarcadero.blackberrydemoclientapp;

import net.rim.device.api.ui.Field;
import net.rim.device.api.ui.FieldChangeListener;
import net.rim.device.api.ui.Manager;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.ButtonField;
import net.rim.device.api.ui.component.CheckboxField;
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.container.HorizontalFieldManager;
import net.rim.device.api.ui.container.MainScreen;

import org.json.me.bc.JSONArray;

import com.embarcadero.javablackberry.DBXException;
import com.embarcadero.javablackberry.DSProxy.TCompanyTweet;
import com.embarcadero.javablackberry.TJSONArray;
import com.embarcadero.javablackberry.TJSONObject;

public class FollowingUsersScreen extends MainScreen {

	private TCompanyTweet company = ((BBDemoClientApp) UiApplication
			.getUiApplication()).getCompanyTweet();
	private ButtonField forward;
	private ButtonField refresh;
	private HorizontalFieldManager hfm;
	private BBDemoClientApp myapp = ((BBDemoClientApp) UiApplication
			.getUiApplication());
	private int end_keycode = 1179648; // 1179648 the keycode of home button

	public FollowingUsersScreen() {
		super();
		TJSONArray Users = null;
		refresh = new ButtonField("Refresh", ButtonField.CONSUME_CLICK);
		forward = new ButtonField("Next", ButtonField.CONSUME_CLICK);

		refresh.setChangeListener(new FieldChangeListener() {

			public void fieldChanged(Field field, int context) {
				try {
					company.SetUsersToFollow(new TJSONArray(getUsersToFollow()));
				} catch (DBXException e) {
					Dialog.alert(e.getMessage());
					logoutAndLoginPage();
				}
				UiApplication.getUiApplication().popScreen(getScreen());
				UiApplication.getUiApplication().pushScreen(
						new FollowingUsersScreen());
			}
		});

		forward.setChangeListener(new FieldChangeListener() {
			public void fieldChanged(Field field, int context) {
				try {
					company.SetUsersToFollow(new TJSONArray(getUsersToFollow()));
				} catch (DBXException e) {
					Dialog.alert(e.getMessage());
					logoutAndLoginPage();
				}
				UiApplication.getUiApplication().popScreen(getScreen());
				UiApplication.getUiApplication().pushScreen(
						new FollowingTweetsScreen());
			}
		});

		hfm = new HorizontalFieldManager(Manager.NO_HORIZONTAL_SCROLL
				| Manager.FIELD_HCENTER);
		hfm.add(refresh);
		hfm.add(forward);
		add(hfm);
		try {
			Users = company.UsersList();
			TJSONObject obj;
			for (int i = 0; i < Users.size(); i++) {
				obj = Users.getJSONObject(i);
				add(new CheckboxField(obj.getString("username"), obj
						.getBoolean("followed").booleanValue()));
			}
		} catch (DBXException e) {
			Dialog.alert(e.getMessage());
			logoutAndLoginPage();
		}

		// Create a menu item
		MenuItem _viewItem = new MenuItem("Logout", 0, 0) {
			public void run() {
				if (Dialog.ask(Dialog.D_OK_CANCEL, "Are you sure ? ") == Dialog.D_OK) {
					logoutAndLoginPage();
				}
			}
		};

		addMenuItem(_viewItem);

	}

	private JSONArray getUsersToFollow() {

		JSONArray usersToFollow = new JSONArray();
		for (int i = 0; i < getScreen().getFieldCount(); i++) {
			if (getScreen().getField(i) instanceof CheckboxField) {
				CheckboxField cb = (CheckboxField) getScreen().getField(i);
				if (cb.getChecked())
					usersToFollow.put(cb.getLabel());
			}
		}
		return usersToFollow;
	}

	protected boolean keyDown(int keycode, int time) {
		// 1179648 the keycode of home button
		if (keycode == end_keycode) {
			if (Dialog.ask(Dialog.D_OK_CANCEL, "Are you sure to quit? ") == Dialog.D_OK) {
				logoutAndLoginPage();
			} else
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
		if (Dialog.ask(Dialog.D_OK_CANCEL, "Are you sure to quit? ") == Dialog.D_OK) {
			logoutAndLoginPage();
		}
		return true;
	}
}
