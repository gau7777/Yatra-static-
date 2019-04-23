package com.example.yatra;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

public class AdminPlaceListAdapter extends ArrayAdapter<AdminPlaces> {

    private final Context context;
    private final ArrayList<AdminPlaces> itemList;



    public AdminPlaceListAdapter(Context context, ArrayList<AdminPlaces> itemList) {

        super(context, R.layout.adminplacelistrow, itemList);

        this.context = context;
        this.itemList = itemList;



    }




    customButtonListener customListner;
    public interface customButtonListener {
        public void onButtonClickListner(int position);
    }
    public void setCustomButtonListner(customButtonListener listener) {
        this.customListner = listener;
    }

    @Override
    public View getView(final int position, View convertView, final ViewGroup parent) {
        // 1. Create inflater
        LayoutInflater inflater = (LayoutInflater) context
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        // 2. Get rowView from inflater
        View rowView = inflater.inflate(R.layout.adminplacelistrow, parent, false);

        // 3. Get the two text view from the rowView
        TextView labelView =  rowView.findViewById(R.id.Place);
        ImageButton edit =   rowView.findViewById(R.id.EditimageButton);
        ImageButton delete =  rowView.findViewById(R.id.DeleteimageButton);
        // 4. Set the text for textView
        String tt = itemList.get(position).getmText();
        labelView.setText(itemList.get(position).getmText());
        edit.setTag(itemList.get(position).getIButton1Id());
        delete.setTag(itemList.get(position).getIButton2Id());



        edit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent adminINtent= new Intent(parent.getContext(), EditPlaceActivity.class);
                getContext().startActivity(adminINtent);
            }
        });


        rowView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent adminINtent= new Intent(parent.getContext(), AdminDestListActivity.class);

                adminINtent.putExtra("PlaceText",itemList.get(position).getmText());
                getContext().startActivity(adminINtent);
            }
        });
        edit.setFocusable(false);
        edit.setFocusableInTouchMode(false);
//        Intent intent = new Intent();
//        intent.putExtra("Text", tt);
        // 5. retrn rowView
        return rowView;
    }
}
