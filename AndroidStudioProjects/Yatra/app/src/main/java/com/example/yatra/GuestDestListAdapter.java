package com.example.yatra;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

public class GuestDestListAdapter extends ArrayAdapter<GuestDest> {


    private final Context context;
    private final ArrayList<GuestDest> itemList;
    String tt;

    public GuestDestListAdapter(Context context, ArrayList<GuestDest> itemList) {

        super(context, R.layout.listrow, itemList);

        this.context = context;
        this.itemList = itemList;
    }



    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        // 1. Create inflater
        LayoutInflater inflater = (LayoutInflater) context
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        // 2. Get rowView from inflater
        View rowView = inflater.inflate(R.layout.listrow, parent, false);

        // 3. Get the two text view from the rowView
        TextView labelView = (TextView) rowView.findViewById(R.id.Heading);
        TextView valueView = (TextView) rowView.findViewById(R.id.Description);
        ImageView imageView = (ImageView) rowView.findViewById(R.id.imageView2);

        // 4. Set the text for textView
        labelView.setText(itemList.get(position).getmName());
        valueView.setText(itemList.get(position).getmDes());
        imageView.setImageResource(itemList.get(position).getImageId());

        tt = labelView.getText().toString();

//        Intent intent = new Intent();
//        intent.putExtra("Text", tt);
        // 5. retrn rowView
        return rowView;
    }

}
