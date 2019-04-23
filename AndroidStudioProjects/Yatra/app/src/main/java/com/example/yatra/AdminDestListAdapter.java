package com.example.yatra;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageButton;
import android.widget.TextView;

import java.util.ArrayList;

public class AdminDestListAdapter extends ArrayAdapter<AdminDest> {

    private final Context context;
    private final ArrayList<AdminDest> itemList;
    String tt;

    public AdminDestListAdapter(Context context, ArrayList<AdminDest> itemList) {

        super(context, R.layout.admindestlistrow, itemList);

        this.context = context;
        this.itemList = itemList;
    }

    customButtonListener1 customListner;
    public interface customButtonListener1 {
        public void onButtonClickListner(int position);
    }
    public void setCustomButtonListner(customButtonListener1 listener) {
        this.customListner = listener;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        // 1. Create inflater
        LayoutInflater inflater = (LayoutInflater) context
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        // 2. Get rowView from inflater
        View rowView = inflater.inflate(R.layout.admindestlistrow, parent, false);

        // 3. Get the two text view from the rowView
        TextView labelView = (TextView) rowView.findViewById(R.id.Destination);
        ImageButton edit = (ImageButton) rowView.findViewById(R.id.EditDestimageButton);
        ImageButton delete = (ImageButton) rowView.findViewById(R.id.DeleteDestimageButton);
        // 4. Set the text for textView
        labelView.setText(itemList.get(position).getmText());
        edit.setTag(itemList.get(position).getIButton1Id());
        delete.setTag(itemList.get(position).getIButton2Id());
        tt = labelView.getText().toString();
        edit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (customListner != null) {
                    customListner.onButtonClickListner(position);
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
