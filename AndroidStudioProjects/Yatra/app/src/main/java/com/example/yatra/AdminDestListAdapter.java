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
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

public class AdminDestListAdapter extends ArrayAdapter<AdminDest> {

    private final Context context;
    private final ArrayList<AdminDest> itemList;
    String tt;
    AppDatabase mydb;

    public AdminDestListAdapter(Context context, ArrayList<AdminDest> itemList) {

        super(context, R.layout.admindestlistrow, itemList);

        this.context = context;
        this.itemList = itemList;
    }

    customButtonListener1 customListner;
    public interface customButtonListener1 {
        public void onButtonClickListner(int position);
        public void onButtonClickListner2(int position);
    }
    public void setCustomButtonListner(customButtonListener1 listener) {
        this.customListner = listener;
    }

    @Override
    public View getView(final int position, final View convertView, final ViewGroup parent) {
        // 1. Create inflater
        LayoutInflater inflater = (LayoutInflater) context
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        // 2. Get rowView from inflater
        final View rowView = inflater.inflate(R.layout.admindestlistrow, parent, false);

        // 3. Get the two text view from the rowView
         final TextView labelView = (TextView) rowView.findViewById(R.id.Destination);
        ImageButton edit = (ImageButton) rowView.findViewById(R.id.EditDestimageButton);
        ImageButton delete = (ImageButton) rowView.findViewById(R.id.DeleteDestimageButton);
        // 4. Set the text for textView
        labelView.setText(itemList.get(position).getmText());
        edit.setTag(itemList.get(position).getIButton1Id());
        delete.setTag(itemList.get(position).getIButton2Id());



        edit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mydb = new AppDatabase(parent.getContext());
                TextView Main = (TextView) labelView.findViewById(R.id.Destination);
                String s = Main.getText().toString();
                Cursor cursor = mydb.getGuestDest(s);
                cursor.moveToNext();
                Intent intent = new Intent(parent.getContext(), EditDestActivity.class);
                intent.putExtra("DestId", cursor.getInt(0));
                intent.putExtra("DPlName", cursor.getString(1));
                intent.putExtra("DDName", cursor.getString(2));
                intent.putExtra("DDIntro", cursor.getString(3));
                intent.putExtra("DDDes", cursor.getString(4));
                intent.putExtra("DDImg", cursor.getBlob(5));
                getContext().startActivity(intent);

                if (customListner != null) {
                    customListner.onButtonClickListner(position);
                }
            }
        });

        delete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mydb = new AppDatabase(parent.getContext());
                int delete = mydb.deleteDest(labelView.getText().toString());
                if(delete > 0){
                    Toast.makeText(parent.getContext(), "Deleted", Toast.LENGTH_LONG).show();

                    AlertDialog.Builder builder = new AlertDialog.Builder(parent.getContext());
                    builder.setTitle("Destination Deleted");
                    builder.setMessage("Go to place list and check the updation of its destination list, by clicking on place");
                    builder.setPositiveButton("Go", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                          Intent intent = new Intent(parent.getContext(), AdminPlaceViewActivity.class);
                          getContext().startActivity(intent);
                        }
                    });
                    builder.show();
                }else{
                    Toast.makeText(parent.getContext(), "Not Deleted", Toast.LENGTH_LONG).show();
                }


                if (customListner != null) {
                    customListner.onButtonClickListner2(position);
                }
            }
        });
//        tt = labelView.getText().toString();

//        Intent intent = new Intent();
//        intent.putExtra("Text", tt);
        // 5. retrn rowView
        return rowView;
    }
}
