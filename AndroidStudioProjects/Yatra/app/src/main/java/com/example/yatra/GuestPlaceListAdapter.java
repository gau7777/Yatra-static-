package com.example.yatra;

import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;

public class GuestPlaceListAdapter extends ArrayAdapter<GuestPlace> {

    private final Context context;
    private final ArrayList<GuestPlace> itemList;
    String tt;
    AppDatabase mydb;

    public GuestPlaceListAdapter(Context context, ArrayList<GuestPlace> itemList){
        super(context, R.layout.guestplacerow, itemList);

        this.context = context;
        this.itemList = itemList;
    }


    @Override
    public View getView(final int position, View convertView, final ViewGroup parent) {
        LayoutInflater inflater = (LayoutInflater) context
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        View rowView = inflater.inflate(R.layout.guestplacerow, parent, false);

        TextView labelView = (TextView) rowView.findViewById(R.id.GuestPlaceHeading);
        TextView valueView = (TextView) rowView.findViewById(R.id.GuestPlaceIntro);
        ImageView imageView = (ImageView) rowView.findViewById(R.id.GuestPlaceimageView);


        labelView.setText(itemList.get(position).getPHeading());
        valueView.setText(itemList.get(position).getPIntro());
//        imageView.setImageResource(itemList.getBlob(position));
        imageView.setImageBitmap(itemList.get(position).getPImageId());

        rowView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(parent.getContext(), GuestDestListActivity.class);
                intent.putExtra("Place", itemList.get(position).getPHeading());
                getContext().startActivity(intent);
            }
        });

        return rowView;

    }

}
