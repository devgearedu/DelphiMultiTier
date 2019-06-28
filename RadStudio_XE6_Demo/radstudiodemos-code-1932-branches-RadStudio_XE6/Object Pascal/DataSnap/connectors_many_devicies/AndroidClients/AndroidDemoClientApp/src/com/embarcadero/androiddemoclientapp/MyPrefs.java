package com.embarcadero.androiddemoclientapp;

import android.os.Bundle;
import android.preference.PreferenceActivity;

public class MyPrefs extends PreferenceActivity {
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		addPreferencesFromResource(R.xml.settings);		
	}
}

