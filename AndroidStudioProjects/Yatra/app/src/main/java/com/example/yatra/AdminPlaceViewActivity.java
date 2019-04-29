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
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;

public class AdminPlaceViewActivity extends AppCompatActivity implements AdminPlaceListAdapter.customButtonListener{

    AdminPlaceListAdapter adapter;
    Button AddPlace;
    AppDatabase mydb;
//    ImageButton edit, del;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_admin_place_view);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        AddPlace = (Button) findViewById(R.id.AddPlacebutton);

        mydb = new AppDatabase(this);

        adapter = new AdminPlaceListAdapter(this, generateData());

        final ListView listView = (ListView) findViewById(R.id.AdminPlaceList);

//        final ImageButton edit = (ImageButton) findViewById(R.id.EditimageButton);
//       final ImageButton del = (ImageButton) findViewById(R.id.DeleteimageButton);
        adapter.setCustomButtonListner(this);
        adapter.notifyDataSetChanged();
        listView.setAdapter(adapter);
//        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
//            @Override
//            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
//                Intent intent = new Intent(AdminPlaceViewActivity.this, AdminDestListActivity.class);
//                String PText = listView.getItemAtPosition(position).toString();
//                intent.putExtra("PlaceText", PText);
//                startActivity(intent);
//            }
//        });

        AddPlace.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(AdminPlaceViewActivity.this, AddPlaceActivity.class);
                startActivity(intent);
            }
        });

    }

    @Override
    public void onButtonClickListner(int position) {
//        Intent intent = new Intent(AdminPlaceViewActivity.this, EditPlaceActivity.class);
//        startActivity(intent);
    }

    @Override
    public void onButtonClickListner2(int position) {

    }

    private ArrayList<AdminPlaces> generateData() {
        Cursor cursor = mydb.getPlace();
        ArrayList<AdminPlaces> items = new ArrayList<AdminPlaces>();
        if(cursor.getCount() == 0){
            Toast.makeText(AdminPlaceViewActivity.this, "Sorry, Empty Places, Please Add Places", Toast.LENGTH_LONG).show();
        }else {
            while (cursor.moveToNext()) {
                items.add(new AdminPlaces(cursor.getString(1), R.id.EditimageButton, R.id.DeleteimageButton));
            }
        }
        return items;
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_admin_place_view, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        switch(id){
            case R.id.RefreshPlaceItem:
                Intent intent = new Intent(this, AdminPlaceViewActivity.class);
                startActivity(intent);
                finish();
                break;
        }
        return super.onOptionsItemSelected(item);
    }
}
