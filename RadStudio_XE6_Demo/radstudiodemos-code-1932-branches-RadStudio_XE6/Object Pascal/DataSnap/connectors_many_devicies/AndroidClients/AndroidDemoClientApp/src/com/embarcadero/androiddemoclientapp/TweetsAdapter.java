package com.embarcadero.androiddemoclientapp;

import java.util.List;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

public class TweetsAdapter extends ArrayAdapter<String> {

	private LayoutInflater mInflater;

	public TweetsAdapter(Context context, int textViewResourceId, List<String> objects) {
		super(context, textViewResourceId, objects);
		mInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {		
		String v = this.getItem(position);
		boolean isAdmin = v.startsWith("ADMIN");		
		if (convertView == null) {
			if (isAdmin)
			{
				convertView = mInflater.inflate(R.layout.tweet_row_admin, null);
				convertView.setId(R.layout.tweet_row_admin);
			}
			else
			{
				convertView = mInflater.inflate(R.layout.tweet_row, null);
				convertView.setId(R.layout.tweet_row);				
			}
		} else {
			
			if (isAdmin)
			{
				if (convertView.getId() != R.layout.tweet_row_admin)
				{
					convertView = mInflater.inflate(R.layout.tweet_row_admin, null);
					convertView.setId(R.layout.tweet_row_admin);
				}
			}
			else
			{
				if (convertView.getId() != R.layout.tweet_row)
				{
					convertView = mInflater.inflate(R.layout.tweet_row, null);
					convertView.setId(R.layout.tweet_row);
				}
			}
		}
		
		((TextView)convertView.findViewById(R.id.rowText)).setText(v);		
		return convertView;
	}

}
