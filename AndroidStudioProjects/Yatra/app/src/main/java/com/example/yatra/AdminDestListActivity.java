package com.example.yatra;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ListView;

import java.util.ArrayList;

public class AdminDestListActivity extends AppCompatActivity implements AdminDestListAdapter.customButtonListener1{

    String t1;
    AdminDestListAdapter adapter;
    ImageButton editDest, DelDest;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_admin_dest_list);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        Intent intent = getIntent();
        if(intent != null){
            t1 = intent.getStringExtra("PlaceText");
        }
        if(t1.equals("Haridwar")){
            // 1. pass context and data to the custom adapter
            adapter = new AdminDestListAdapter(this, generateData1());

        }else if(t1.equals("Amritsar")){
            // 1. pass context and data to the custom adapter
            adapter = new AdminDestListAdapter(this, generateData2());
        }
        // 2. Get ListView from activity_main.xml
        final ListView listView = (ListView) findViewById(R.id.AdminDestList);
//        editDest = (ImageButton) findViewById(R.id.EditDestimageButton);
//        DelDest = (ImageButton) findViewById(R.id.DeleteDestimageButton);
        adapter.setCustomButtonListner(this);
        listView.setAdapter(adapter);

    }

    @Override
    public void onButtonClickListner(int position) {
        Intent intent1 = new Intent(AdminDestListActivity.this, EditDestActivity.class);
        startActivity(intent1);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_admin_dest_list, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        switch (id){
            case R.id.AddDestinationItem:
                Intent intent = new Intent(AdminDestListActivity.this, AddDestinationActivity.class);
                startActivity(intent);
                break;
        }
        return super.onOptionsItemSelected(item);
    }

    private ArrayList<AdminDest> generateData1() {
        ArrayList<AdminDest> items = new ArrayList<AdminDest>();
        items.add(new AdminDest("Mansa Devi", R.id.EditDestimageButton, R.id.DeleteDestimageButton));
        items.add(new AdminDest("Har Ki Pauri", R.id.EditDestimageButton, R.id.DeleteDestimageButton));
        return items;
    }

    private ArrayList<AdminDest> generateData2() {
        ArrayList<AdminDest> items = new ArrayList<AdminDest>();
        items.add(new AdminDest("Golden Temple", R.id.EditDestimageButton, R.id.DeleteDestimageButton));
        items.add(new AdminDest("Wagah Border", R.id.EditDestimageButton, R.id.DeleteDestimageButton));
        return items;
    }

}
