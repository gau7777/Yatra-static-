package com.example.yatra;

import android.content.ClipData;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

public class GuestDestListActivity extends AppCompatActivity {

    String t1;
    GuestDestListAdapter adapter;
    TextView Main;
    AppDatabase mydb;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_guest_dest_list);

        mydb = new AppDatabase(this);

            adapter = new GuestDestListAdapter(this, generateData1());

        // 2. Get ListView from activity_main.xml
        final ListView listView = (ListView) findViewById(R.id.GuestDestList);

        // 3. setListAdapter
        listView.setAdapter(adapter);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Main = view.findViewById(R.id.Heading);
                String s = Main.getText().toString();
                   Cursor res = mydb.getGuestDest(s);
                   res.moveToNext();
                   Intent intent = new Intent(GuestDestListActivity.this, GuestDestDetailsActivity.class);
                   intent.putExtra("DName", res.getString(2));
                   intent.putExtra("DDes", res.getString(4));
                   intent.putExtra("DImg", res.getBlob(5));
                   startActivity(intent);
            }
        });
    }

    private ArrayList<GuestDest> generateData1() {
        Intent intent = getIntent();
        if(intent != null){
            t1 = intent.getStringExtra("Place");
        }
        Cursor cursor = mydb.getDestAdmin(t1);
        ArrayList<GuestDest> items = new ArrayList<GuestDest>();
        if(cursor.getCount() == 0){
            Toast.makeText(GuestDestListActivity.this, "Sorry, Empty Destenations", Toast.LENGTH_LONG).show();
        }else{
            while(cursor.moveToNext()){
                items.add(new GuestDest(cursor.getString(7), cursor.getString(8), convertToBitmap(cursor.getBlob(10))));
            }
        }

        return items;
    }

    private Bitmap convertToBitmap(byte[] b) {
        return BitmapFactory.decodeByteArray(b, 0, b.length);
    }
}
