package com.embarcadero.androiddemoclientapp;

import com.embarcadero.javaandroid.DBXException;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;

public class DialogActivity extends ServiceBoundedActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		AlertDialog alertDialog = new AlertDialog.Builder(this).create();
		alertDialog.setTitle("Warning...");
		alertDialog.setMessage(getIntent().getStringExtra("error"));
		alertDialog.setButton("OK", new DialogInterface.OnClickListener() {
			public void onClick(DialogInterface dialog, int which) {
				try {
					getCBService().logout();
				} catch (DBXException e) {
					getCBService().resetProxy();
				}
				finish();
				Intent loginPage = new Intent(DialogActivity.this,
						LoginActivity.class);
				startActivity(loginPage);
			}
		});
		alertDialog.show();
	}

}
