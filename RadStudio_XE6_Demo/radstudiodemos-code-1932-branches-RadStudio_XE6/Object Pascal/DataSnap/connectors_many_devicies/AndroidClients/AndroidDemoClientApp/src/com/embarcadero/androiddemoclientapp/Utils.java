package com.embarcadero.androiddemoclientapp;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.preference.PreferenceManager;
import android.widget.Toast;

public class Utils {
	
	public static void ShowMessage(Context context, String Title, String Message, DialogInterface.OnClickListener onClickListener){
		AlertDialog.Builder builder = new AlertDialog.Builder(context);
		builder.setTitle(Title)
					 .setMessage(Message)
					 .setCancelable(false)
					 .setIcon(R.drawable.icon)
					 .setNeutralButton("OK", onClickListener)
					 .create().show();
	}

	public static void ShowToast(Context context, String Message){
		Toast.makeText(context, Message, Toast.LENGTH_LONG).show();
	}	
	
	public static String getServerHost(Context context) {

		return PreferenceManager.getDefaultSharedPreferences(context)
				.getString("host", "datasnap.embarcadero.com");
	}

	public static String getServerPort(Context context) {

		return PreferenceManager.getDefaultSharedPreferences(context)
				.getString("port", "8086");
	}
}
