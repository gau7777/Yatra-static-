package com.example.yatra;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.support.v7.app.AlertDialog;
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
    private  ArrayList<AdminPlaces> itemList;
    AppDatabase mydb;
    public AdminPlaceListAdapter(Context context, ArrayList<AdminPlaces> itemList) {

        super(context, R.layout.adminplacelistrow, itemList);

        this.context = context;
        this.itemList = itemList;
    }

    customButtonListener customListner;
    public interface customButtonListener {
        public void onButtonClickListner(int position);
        public void onButtonClickListner2(int position);
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
        final TextView labelView =  rowView.findViewById(R.id.Place);
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
                mydb = new AppDatabase(parent.getContext());
                Cursor res = mydb.getPlaceAdmin(labelView.getText().toString());
                res.moveToNext();
                Intent adminINtent= new Intent(parent.getContext(), EditPlaceActivity.class);
                adminINtent.putExtra("PlId", res.getInt(0));
                adminINtent.putExtra("PlName", res.getString(1));
                adminINtent.putExtra("PlIntro", res.getString(2));
                adminINtent.putExtra("PlDes", res.getString(3));
                adminINtent.putExtra("PlImg", res.getBlob(4));
                getContext().startActivity(adminINtent);

                if (customListner != null) {
                    customListner.onButtonClickListner(position);
                }
            }
        });

        delete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                AlertDialog.Builder b = new AlertDialog.Builder(parent.getContext());
                b.setTitle("Continue?");
                b.setMessage(labelView.getText().toString() + "'s destinations will also get delete.Do you want to continue? ");
                b.setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        mydb = new AppDatabase(parent.getContext());
                        int del = mydb.deletePlace(labelView.getText().toString());
                        int del2 = mydb.deletePlaceDest(labelView.getText().toString());
                        if(del > 0 && del2>0){
                            Toast.makeText(parent.getContext(), "Deleted", Toast.LENGTH_LONG).show();
                            AlertDialog.Builder builder = new AlertDialog.Builder(parent.getContext());
                            builder.setTitle(labelView.getText().toString() + "Deletion complete");
                            builder.setMessage("Click on above clock icon to refresh the list");
                            builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {

                                }
                            });
                            builder.show();



                            if (customListner != null) {
                                customListner.onButtonClickListner2(position);
                            }
                        }else{
                            Toast.makeText(parent.getContext(), "Not Deleted", Toast.LENGTH_LONG).show();
                        }
                    }
                });
                b.setNegativeButton("No", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                    }
                });
                b.show();
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

        // 5. retrn rowView
        return rowView;
    }


    }


