package com.embarcadero.androiddemoclientapp;

import java.util.LinkedList;
import java.util.List;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.embarcadero.javaandroid.DBXException;

public class FollowingTweetsActivity extends ServiceBoundedActivity implements
		OnClickListener, ITweetsView {
	private boolean disconnectedMode = false;
	private ListView mListTweet;
	private TweetsAdapter arrayAdapter;
	private Button btn_twt;
	private EditText edt_twt;
	private TextView lbl_usr;

	public TweetsAdapter getAdapter() {
		return arrayAdapter;
	}

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.following_tweets);
		mListTweet = (ListView) findViewById(R.id.listview);
		btn_twt = (Button) findViewById(R.id.btn_create_tweet);
		lbl_usr = (TextView) findViewById(R.id.txt_username);
		lbl_usr.setOnClickListener(this);
		btn_twt.setEnabled(false);
		btn_twt.setOnClickListener(this);
		edt_twt = (EditText) findViewById(R.id.edt_create_tweet);
		edt_twt.addTextChangedListener(new TextWatcher() {

			public void afterTextChanged(Editable s) {
				if (edt_twt.length() > 0)
					btn_twt.setEnabled(true);
				else
					btn_twt.setEnabled(false);
			}

			public void beforeTextChanged(CharSequence arg0, int arg1,
					int arg2, int arg3) {

			}

			public void onTextChanged(CharSequence s, int start, int before,
					int count) {

			}
		});
		loadView();
		if (getIntent().hasExtra("usr") && getIntent().hasExtra("txt"))
			getAdapter().add(
					getIntent().getStringExtra("usr") + ": "
							+ getIntent().getStringExtra("txt"));
	}

	public boolean onKeyDown(int keyCode, KeyEvent event) {
		if (keyCode == KeyEvent.KEYCODE_BACK) {
			return true;
		}
		return super.onKeyDown(keyCode, event);
	}

	@Override
	protected void serviceBounded() {
		super.serviceBounded();
		getCBService().setTweetsView(this);
		lbl_usr.setText("user: " + getCBService().getUserName());
		getCBService().enableNotification(false);
	}

	@Override
	protected void onStop() {
		getCBService().enableNotification(true);
		super.onStop();
	}

	@Override
	protected void onResume() {
		super.onResume();
		if (getCBService() != null) {
			getCBService().enableNotification(false);
		}
	}

	public void goToDisconnectedMode(){
		if (disconnectedMode)
			return;
		disconnectedMode = true;
		runOnUiThread(new Runnable() {			
			public void run() {
				lbl_usr.setTextColor(Color.RED);		
				lbl_usr.setText("You are disconnected.\nClick here to login");
				lbl_usr.setTextSize(30);
				lbl_usr.setGravity(Gravity.CENTER_HORIZONTAL | Gravity.TOP);
				mListTweet.setEnabled(false);
				btn_twt.setVisibility(View.GONE);
				edt_twt.setVisibility(View.GONE);
			}
		});		
	}
	
	private void loadView() {				
		List<String> arraydata = new LinkedList<String>();
		//arrayAdapter = new ArrayAdapter<String>(this, R.layout.tweet_row,
			//	R.id.rowText, arraydata);
		arrayAdapter = new TweetsAdapter(this, 0, arraydata); 		
		mListTweet.setAdapter(arrayAdapter);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		MenuInflater inflater = getMenuInflater();
		inflater.inflate(R.menu.menu, menu);
		menu.findItem(R.id.list_of_active_users).setVisible(true);
		menu.findItem(R.id.logout).setVisible(true);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case R.id.logout:
			doLogout();
			return true;		
		case R.id.settings:
			super.onPause();
			startActivity(new Intent(this, MyPrefs.class));
			return true;
		case R.id.list_of_active_users:
			super.onStop();
			getCBService().clearTweetsActivity();			
			Intent FollowingPage = new Intent(this,
					FollowingUsersActivity.class);
			startActivity(FollowingPage);
			return true;
		default:
			return super.onOptionsItemSelected(item);
		}
	}

	private void doLogout() {
		try {
			finish();			
			getCBService().clearTweetsActivity();
			getCBService().logout();						
		} catch (DBXException e) {
			Toast.makeText(this, "logout failed " + e.getMessage(),
					Toast.LENGTH_LONG).show();
		}
		Intent loginPage = new Intent(this, LoginActivity.class);		
		startActivity(loginPage);
	}

	public void onClick(View v) {
		if (v.getId() == lbl_usr.getId()) {
			if (disconnectedMode)
				doLogout();
		}		
		
		if (v.getId() == btn_twt.getId()) {
			try {
				getCBService().sendTweet(edt_twt.getText().toString());
				edt_twt.setText("");
			} catch (DBXException e) {
				AlertDialog alertDialog = new AlertDialog.Builder(this)
						.create();
				alertDialog.setTitle("Error...");
				alertDialog.setMessage(e.getMessage());
				alertDialog.setButton("OK",
						new DialogInterface.OnClickListener() {
							public void onClick(DialogInterface dialog,
									int which) {
								getCBService().resetProxy();
								finish();
								startActivity(new Intent(
										FollowingTweetsActivity.this,
										LoginActivity.class));
							}
						});
				alertDialog.show();
			}
		}
	}

}
