package com.embarcadero.androiddemoclientapp;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.media.MediaPlayer;
import android.os.Vibrator;
import android.preference.PreferenceManager;

public final class CTNotificationManager {

	private static MediaPlayer cmd_mp;
	private static MediaPlayer tweet_mp;
	private static Vibrator vibr;

	public static void vibrate(Context context) {

		if (PreferenceManager.getDefaultSharedPreferences(context).getBoolean(
				"vibrate", true)) {
			if (vibr == null)
				vibr = (Vibrator) context
						.getSystemService(Context.VIBRATOR_SERVICE);
			vibr.vibrate(500);
		}
	}

	public static void ring(Context context) {
		if (PreferenceManager.getDefaultSharedPreferences(context).getBoolean(
				"sound", true)) {
			if (cmd_mp == null)
				cmd_mp = MediaPlayer.create(context, R.raw.cmd);
			if (!cmd_mp.isPlaying())
				cmd_mp.start();
		}
	}

	public static void ring_tweet(Context context) {
		if (PreferenceManager.getDefaultSharedPreferences(context).getBoolean(
				"sound", true)) {
			if (tweet_mp == null)
				tweet_mp = MediaPlayer.create(context, R.raw.tweet);
			if (!tweet_mp.isPlaying())
				tweet_mp.start();
		}
	}
	
	public static void notify(Context context, Class<?> cls, String TickerText, String title, String message, String user, String txt){
		NotificationManager mNotificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
		int icon = R.drawable.icon;
		CharSequence tickerText = TickerText;
		long when = System.currentTimeMillis();
		Notification notification = new Notification(icon, tickerText, when);
		
		Intent notificationIntent = new Intent(context, cls);
		notificationIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP|Intent.FLAG_ACTIVITY_SINGLE_TOP);
		notificationIntent.putExtra("usr", user);
		notificationIntent.putExtra("txt", txt);
		PendingIntent contentIntent = PendingIntent.getActivity(context, 0, notificationIntent, 0);
		notification.setLatestEventInfo(context.getApplicationContext(), title, message, contentIntent);
		notification.flags = Notification.DEFAULT_LIGHTS | Notification.FLAG_AUTO_CANCEL;
		mNotificationManager.notify(0, notification);
		
	}
	
	public static void cancelAllNotification(Context context){
		NotificationManager mNotificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
		mNotificationManager.cancelAll();
	}
}
