package com.embarcadero.blackberrydemoclientapp;

import net.rim.device.api.ui.component.ButtonField;
import net.rim.device.api.ui.component.EditField;
import net.rim.device.api.ui.component.LabelField;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.component.SeparatorField;
import net.rim.device.api.ui.container.FlowFieldManager;
import net.rim.device.api.ui.container.HorizontalFieldManager;
import net.rim.device.api.ui.container.MainScreen;


 class ScreenLayoutScreen extends MainScreen {
	public ScreenLayoutScreen() {
		super();
		// By default the BlackBerry screen uses a
		// Vertical Flow Manager
		LabelField lblTitle = new LabelField("Screen Layout Sample",
				LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH);
		setTitle(lblTitle);
		add(new LabelField("Field 1"));
		add(new LabelField("Field 2"));
		add(new LabelField("Field 3"));

		// Now lets switch to a Horizontal flow manager
		HorizontalFieldManager hfm = new HorizontalFieldManager();
		this.add(hfm);
		hfm.add(new LabelField("Label Field 4"));
		hfm.add(new LabelField("Label Field 5"));
		hfm.add(new EditField("Edit Field", "1"));
		hfm.add(new EditField("Edit Field", "2"));

		// Now a flow field manager
		FlowFieldManager flowManager = new FlowFieldManager();
		this.add(flowManager);
		ButtonField button1 = new ButtonField("Button 1");
		ButtonField button2 = new ButtonField("Button 2");
		ButtonField button3 = new ButtonField("Button 3");
		ButtonField button4 = new ButtonField("Button 4");
		flowManager.add(button1);
		flowManager.add(button2);
		flowManager.add(button3);
		flowManager.add(button4);

		// Back to using the default vertical flow manager
		this.add(new SeparatorField());
		this.add(new RichTextField("Let's add some more edit fields:"));
		add(new EditField("Edit Field", "3"));
		add(new EditField("Edit Field", "4"));
	}
}
