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
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageButton;
import android.widget.ListAdapter;
import android.widget.ListView;

import java.util.ArrayList;

public class AdminPlaceViewActivity extends AppCompatActivity implements AdminPlaceListAdapter.customButtonListener{

    AdminPlaceListAdapter adapter;
//    ImageButton edit, del;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_admin_place_view);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        adapter = new AdminPlaceListAdapter(this, generateData());

        final ListView listView = (ListView) findViewById(R.id.AdminPlaceList);

//        final ImageButton edit = (ImageButton) findViewById(R.id.EditimageButton);
//       final ImageButton del = (ImageButton) findViewById(R.id.DeleteimageButton);
        adapter.setCustomButtonListner(this);
        listView.setAdapter(adapter);
        listView.setFocusable(false);
//        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
//            @Override
//            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
//                Intent intent = new Intent(AdminPlaceViewActivity.this, AdminDestListActivity.class);
//                String PText = listView.getItemAtPosition(position).toString();
//                intent.putExtra("PlaceText", PText);
//                startActivity(intent);
//            }
//        });

    }

    @Override
    public void onButtonClickListner(int position) {
        Intent intent = new Intent(AdminPlaceViewActivity.this, EditPlaceActivity.class);
        startActivity(intent);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_admin_place_view, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        switch (id){
            case R.id.AddPlaceItem:
                Intent intent = new Intent(AdminPlaceViewActivity.this, AddPlaceActivity.class);
                startActivity(intent);
                break;
        }
        return super.onOptionsItemSelected(item);
    }

    private ArrayList<AdminPlaces> generateData() {
        ArrayList<AdminPlaces> items = new ArrayList<AdminPlaces>();
        items.add(new AdminPlaces("Haridwar", R.id.EditimageButton, R.id.DeleteimageButton));
        items.add(new AdminPlaces("Amritsar", R.id.EditimageButton, R.id.DeleteimageButton));
        return items;
    }

}
