package com.embarcadero.blackberrydemoclientapp;

import com.embarcadero.javablackberry.DBXException;
import com.embarcadero.javablackberry.DSProxy.TCompanyTweet;
import com.embarcadero.javablackberry.DSProxy.TCompanyTweet.LoginUserReturns;
import net.rim.device.api.system.Bitmap;
import net.rim.device.api.ui.Field;
import net.rim.device.api.ui.FieldChangeListener;
import net.rim.device.api.ui.Graphics;
import net.rim.device.api.ui.Manager;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.ButtonField;
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.component.EditField;
import net.rim.device.api.ui.component.LabelField;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.ui.container.VerticalFieldManager;
import net.rim.device.api.ui.decor.BorderFactory;

/**
 * A class extending the MainScreen class, which provides default standard
 * behavior for BlackBerry GUI applications.
 */
public final class LoginScreen extends MainScreen {
	/**
	 * Creates a new MyScreen object
	 */

	private ButtonField button;
	private EditField edt;
    private LabelField userLabel;
	private Bitmap _backgroundBitmap = Bitmap.getBitmapResource("main.png");
	private VerticalFieldManager mainManager;
	private VerticalFieldManager subManager;
	private int deviceWidth = Graphics.getScreenWidth();
	private int deviceHeight = Graphics.getScreenHeight();
	private TCompanyTweet company;
	private BBDemoClientApp myapp;

	public LoginScreen() {
		// Set the displayed title of the screen
		super(NO_VERTICAL_SCROLL | FIELD_HCENTER);

		myapp = ((BBDemoClientApp) UiApplication.getUiApplication());
		myapp.resetProxy();
		mainManager = new VerticalFieldManager(Manager.NO_VERTICAL_SCROLL
				| Manager.NO_VERTICAL_SCROLLBAR | Manager.FIELD_HCENTER) {
			public void paint(Graphics graphics) {
				graphics.clear();
				graphics.drawBitmap(0, 0, deviceWidth, deviceHeight,
						_backgroundBitmap, 0, 0);
				super.paint(graphics);
			}
		};

		// this manger is used for adding the componentes
		subManager = new VerticalFieldManager(Manager.VERTICAL_SCROLL
				| Manager.VERTICAL_SCROLLBAR | Manager.FIELD_HCENTER) {
			protected void sublayout(int maxWidth, int maxHeight) {
				super.sublayout(deviceWidth, deviceHeight);
				setExtent(deviceWidth, deviceHeight);
			}
		};
		
		userLabel = new LabelField("Your Username:", Field.FIELD_VCENTER | FIELD_HCENTER);
		
		// / add your component to this subManager
		edt = new EditField("", "", 20, Field.FIELD_VCENTER | FIELD_HCENTER);
		edt.setBorder(BorderFactory.createRoundedBorder(new net.rim.device.api.ui.XYEdges(5, 5, 5, 5)));
		button = new ButtonField("Login", ButtonField.FIELD_VCENTER | FIELD_HCENTER | ButtonField.CONSUME_CLICK);
		userLabel.setMargin(deviceHeight / 4, deviceWidth / 4, 0, deviceWidth / 4);
		edt.setMargin(0, deviceWidth / 4, 0, deviceWidth / 4);
		button.setMargin(20, 0, 0, 0);

        subManager.add(userLabel);
		subManager.add(edt);
		subManager.add(button);
		button.setChangeListener(new FieldChangeListener() {
			public void fieldChanged(Field arg0, int arg1) {
				try {
					company = myapp.getCompanyTweet();
					LoginUserReturns result = company.LoginUser(edt.getText());
					Dialog.alert(result.ReturnMessage);
					if (result.returnValue) {
						((BBDemoClientApp) UiApplication.getUiApplication())
								.setUsername(edt.getText());
						((BBDemoClientApp) UiApplication.getUiApplication())
								.registerCallbacks();
						UiApplication.getUiApplication().popScreen(getScreen());
						UiApplication.getUiApplication().pushScreen(
								new FollowingUsersScreen());
					}
				} catch (DBXException e) {
					Dialog.alert(myapp.connectionError);
				}
			}
		});

		// add subManager over the mainManager
		mainManager.add(subManager);
		// finally add the mainManager over the screen
		this.add(mainManager);

		// Create a menu item
		MenuItem _viewItem = new MenuItem("Set Server Host", 0, 0) {
			public void run() {
				String[] buttons = { "Save", "Discard" };
				Dialog dialog = new Dialog("Set the server host", buttons,
						null, 0, null);

				EditField serverField = new EditField("Server: ",
						myapp.getServer());
				dialog.add(serverField);

				EditField portField = new EditField("Port: ", myapp.getPort(),
						5, EditField.FILTER_REAL_NUMERIC | EditField.EDITABLE);
				dialog.add(portField);

				if (dialog.doModal() == 0) {
					// set the server host
					myapp.setServer(serverField.getText());
					myapp.setPort(portField.getText());
				}
			}
		};
		addMenuItem(_viewItem);

	}

}
