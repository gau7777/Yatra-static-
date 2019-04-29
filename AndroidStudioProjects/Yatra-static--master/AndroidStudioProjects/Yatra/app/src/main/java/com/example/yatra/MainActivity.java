package com.example.yatra;

import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    Button Admin;
    AppDatabase mydb;
    GuestPlaceListAdapter GP;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        mydb = new AppDatabase(this);

        Admin = (Button) findViewById(R.id.Adminbutton);

        GP = new GuestPlaceListAdapter(this, generateData());

        final ListView listView = (ListView) findViewById(R.id.GuestPlaceList);

        listView.setAdapter(GP);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
//               String txt = listView.getItemAtPosition(position).toString();
//               Intent intent = new Intent(MainActivity.this, GuestDestListActivity.class);
//               intent.putExtra("ListItemText", txt);
//               startActivity(intent);
            }
        });

        Admin.setOnClickListener(this);
    }

    private ArrayList<GuestPlace> generateData() {
        Cursor cursor = mydb.getPlace();
        ArrayList<GuestPlace> items = new ArrayList<GuestPlace>();
        if(cursor.getCount() == 0){
            Toast.makeText(MainActivity.this, "Sorry, Empty Places", Toast.LENGTH_LONG).show();
        }else {
            while (cursor.moveToNext()) {
                items.add(new GuestPlace(cursor.getString(1), cursor.getString(2), convertToBitmap(cursor.getBlob(4))));
            }
        }
        return items;
    }

    private Bitmap convertToBitmap(byte[] b) {
        return BitmapFactory.decodeByteArray(b, 0, b.length);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.Adminbutton:
                Intent intent = new Intent(MainActivity.this, AdminLoginActivity.class);
                startActivity(intent);

        }
    }

}