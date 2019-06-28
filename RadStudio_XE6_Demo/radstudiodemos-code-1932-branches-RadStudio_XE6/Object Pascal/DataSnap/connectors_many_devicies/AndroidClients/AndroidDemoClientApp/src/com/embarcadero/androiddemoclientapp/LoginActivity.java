package com.embarcadero.androiddemoclientapp;

import com.embarcadero.javaandroid.DBXException;
import com.embarcadero.javaandroid.DSProxy;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.*;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class LoginActivity extends ServiceBoundedActivity implements
		OnClickListener {

	private Button btn;
	private EditText edt;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		edt = (EditText) findViewById(R.id.edtlogin);
		btn = (Button) findViewById(R.id.btnlogin);
		edt.setText("");
		btn.setEnabled(false);
		btn.setOnClickListener(this);
		edt.addTextChangedListener(new TextWatcher() {
			public void onTextChanged(CharSequence s, int start, int before,
					int count) {
				btn.setEnabled(getIsBound());
			}

			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {
			}

			public void afterTextChanged(Editable s) {
			}
		});
	}

	public void onClick(View v) {
		if (v.getId() == btn.getId()) {
			DSProxy.TCompanyTweet.LoginUserReturns result;
			try {
				getCBService().resetProxy();
				result = getCBService().loginUser(edt.getText().toString());
				if (result.returnValue)
					startActivity(new Intent(this, FollowingUsersActivity.class));

				Toast.makeText(this, result.ReturnMessage, Toast.LENGTH_LONG)
						.show();
			} catch (DBXException e) {
				AlertDialog alertDialog = new AlertDialog.Builder(this)
						.create();
				alertDialog.setTitle("Connection Error");
				alertDialog
						.setMessage("Failed to connect to the Server.\nThe server may be offline. You may also want to check your connection settings, to ensure they were entered correctly.");
				alertDialog.setButton("OK",
						new DialogInterface.OnClickListener() {
							public void onClick(DialogInterface dialog,
									int which) {
							}
						});
				alertDialog.show();
			}
		}
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		MenuInflater inflater = getMenuInflater();
		inflater.inflate(R.menu.menu, menu);
		menu.findItem(R.id.settings).setVisible(true);
		return true;
	}

	public boolean onKeyDown(int keyCode, KeyEvent event) {
		/*
		if (keyCode == KeyEvent.KEYCODE_BACK) {
			return true; WHY???
		}
		*/
		return super.onKeyDown(keyCode, event);
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case R.id.settings:
			super.onPause();
			try {
				getCBService().logout();
			} catch (DBXException e) {
				e.printStackTrace();
			}
			startActivity(new Intent(this, MyPrefs.class));
			return true;
		default:
			return super.onOptionsItemSelected(item);
		}
	}

}