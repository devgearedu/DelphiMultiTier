package com.embarcadero.androiddemoclientapp;

import org.json.JSONArray;

import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup.LayoutParams;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.embarcadero.javaandroid.DBXException;
import com.embarcadero.javaandroid.TJSONArray;
import com.embarcadero.javaandroid.TJSONObject;

public class FollowingUsersActivity extends ServiceBoundedActivity implements
		OnClickListener {

	private LinearLayout mListView;
	private Button follow_btn;
	private Button refresh_btn;
	private JSONArray usersToFollow;
	private boolean finished;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.contacts);
		mListView = (LinearLayout) findViewById(R.id.contactsll);
		follow_btn = (Button) findViewById(R.id.follow_btn);
		follow_btn.setOnClickListener(this);
		refresh_btn = (Button) findViewById(R.id.refresh_btn);
		refresh_btn.setOnClickListener(this);
		usersToFollow = new JSONArray();
	}

	@Override
	protected void serviceBounded() {
		super.serviceBounded();
		getCBService().enableNotification(false);
		try {
			refreshView();
		} catch (Exception ex) {
			Utils.ShowMessage(this, "Error", ex.getMessage(), new DialogInterface.OnClickListener() {				
				public void onClick(DialogInterface dialog, int which) {
					finish();				
				}
			});
		}
	}

	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		if (keyCode == KeyEvent.KEYCODE_BACK) {
			return true;
		}
		return super.onKeyDown(keyCode, event);
	}

	public void onClick(View v) {
		try {		
			switch (v.getId()) {
				case R.id.follow_btn: { // go to following tweet page
					Intent FollowingTweets = new Intent(this,
							FollowingTweetsActivity.class);
					addUserstoFollow();
					getCBService().setUsersToFollow(new TJSONArray(usersToFollow));
					finish();
					finished = true;
					startActivity(FollowingTweets);
					break;
				}
				case R.id.refresh_btn: { // refresh this page
					refreshView();
					break;
				}
			}
		}
		catch (Exception ex)
		{			
			Utils.ShowMessage(this, "Error", ex.getMessage(), new DialogInterface.OnClickListener() {							
							public void onClick(DialogInterface dialog, int which) {
								finish();				
							}
						 	});			
		}
	}

	/*
	 * Scan the JSONArray , create a checkbox for every user and set the checked
	 * state like "followed" param.
	 */

	private void load() throws DBXException {
		TJSONArray Users = getCBService().getUsersList();
		String user_name;
		TJSONObject obj;
		for (int i = 0; i < Users.size(); i++) {
			obj = Users.getJSONObject(i);
			user_name = obj.getString("username");
			addCheckbox(obj.getBoolean("followed"), user_name);
		}
	}

	private void refreshView() throws DBXException {
		mListView.removeAllViews();
		load();
	}

	private void addCheckbox(boolean checked, String user_name) {

		CheckBox cb = new CheckBox(this);
		cb.setLayoutParams(new LayoutParams(LayoutParams.FILL_PARENT,
				LayoutParams.WRAP_CONTENT));
		cb.setBackgroundColor(Color.WHITE);
		cb.setTextColor(Color.argb(255, 80, 80, 80));
		cb.setChecked(checked);
		cb.setTextSize(18);
		cb.setText("\t" + user_name);
		mListView.addView(cb);

	}

	private void addUserstoFollow() {

		for (int i = 0; i < mListView.getChildCount(); i++) {
			CheckBox cb = (CheckBox) mListView.getChildAt(i);
			if (cb.isChecked())
				usersToFollow.put(cb.getText().toString().replace("\t", ""));
		}
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case R.id.logout:
			try {
				getCBService().logout();
				Intent loginPage = new Intent(this, LoginActivity.class);
				startActivity(loginPage);
			} catch (DBXException e) {
				Toast.makeText(this, "logout failed " + e.getMessage(),
						Toast.LENGTH_LONG).show();
				return false;
			}
			return true;
		default:
			return super.onOptionsItemSelected(item);
		}
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		MenuInflater inflater = getMenuInflater();
		inflater.inflate(R.menu.menu, menu);
		menu.findItem(R.id.logout).setVisible(true);
		return true;
	}

	@Override
	protected void onStop() {
		if(!finished)
			getCBService().enableNotification(true);
		super.onStop();
	}

	@Override
	protected void onResume() {
		if (getCBService() != null)
			getCBService().enableNotification(false);
		super.onResume();
	}

}
