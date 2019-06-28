package com.embarcadero.blackberrydemoclientapp;

import java.io.IOException;

import javax.microedition.media.MediaException;
import javax.microedition.media.Player;
import javax.microedition.media.control.VolumeControl;

import net.rim.device.api.system.Alert;

public final class NotificationManager {

	private static Player cmd_mp;
	private static Player tweet_mp;

	
	public static void vibrate() {
		Alert.startVibrate(1000);
	}
	
	public static void ring() {
		try {
			if (cmd_mp == null)
				cmd_mp = javax.microedition.media.Manager.createPlayer(
						NotificationManager.class
								.getResourceAsStream("/sounds/cmd.mp3"),
						"audio/mpeg");
			cmd_mp.realize();
			VolumeControl volume = (VolumeControl) cmd_mp
					.getControl("VolumeControl");
			volume.setLevel(100);
			cmd_mp.start();
		} catch (IOException e) {
			System.out.println(e.getMessage());
		} catch (MediaException e) {
			System.out.println(e.getMessage());
		}
	}

	public static void ring_tweet() {
		
		try {
			if (tweet_mp == null)
				tweet_mp = javax.microedition.media.Manager.createPlayer(
						NotificationManager.class
								.getResourceAsStream("/sounds/tweet.mp3"),
						"audio/mpeg");
			tweet_mp.realize();
			VolumeControl volume = (VolumeControl) tweet_mp
					.getControl("VolumeControl");
			volume.setLevel(100);
			tweet_mp.start();
		} catch (IOException e) {
			System.out.println(e.getMessage());
		} catch (MediaException e) {
			System.out.println(e.getMessage());
		}
		
		
	}

}
