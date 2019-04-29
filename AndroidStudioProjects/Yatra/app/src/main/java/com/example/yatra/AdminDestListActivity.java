package com.example.yatra;

import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import org.w3c.dom.Text;

import java.util.ArrayList;

public class AdminDestListActivity extends AppCompatActivity implements AdminDestListAdapter.customButtonListener1{

    String t1, t2;
    TextView text;
    AdminDestListAdapter adapter;
    ImageButton editDest, DelDest;
    AppDatabase mydb;
    Button AddDestination;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_admin_dest_list);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

          mydb = new AppDatabase(this);

          AddDestination = (Button) findViewById(R.id.AddDestinationbutton);


            // 1. pass context and data to the custom adapter
            adapter = new AdminDestListAdapter(this, generateData1());

        // 2. Get ListView from activity_main.xml
        final ListView listView = (ListView) findViewById(R.id.AdminDestList);
//        editDest = (ImageButton) findViewById(R.id.EditDestimageButton);
       DelDest = (ImageButton) findViewById(R.id.DeleteDestimageButton);
        adapter.setCustomButtonListner(this);
        listView.setAdapter(adapter);

        AddDestination.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(AdminDestListActivity.this, AddDestinationActivity.class);
                startActivity(intent);
            }
        });

    }

    @Override
    public void onButtonClickListner(int position) {
//        Intent intent1 = new Intent(AdminDestListActivity.this, EditDestActivity.class);
//        startActivity(intent1);
    }

    @Override
    public void onButtonClickListner2(int position) {

    }

    private ArrayList<AdminDest> generateData1() {
        Intent intent = getIntent();
        if(intent != null){
            t1 = intent.getStringExtra("PlaceText");
        }
        Cursor cursor = mydb.getDestAdmin(t1);

        ArrayList<AdminDest> items = new ArrayList<AdminDest>();
        if(cursor.getCount() == 0){
            Toast.makeText(AdminDestListActivity.this, "Sorry, Empty Destinations, Please Add Destinations", Toast.LENGTH_LONG).show();
        }else{
            while(cursor.moveToNext()){
                items.add(new AdminDest(cursor.getString(7), R.id.EditDestimageButton, R.id.DeleteDestimageButton));
            }
        }

        return items;
    }



}
