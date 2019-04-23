package com.example.yatra;

import android.content.ClipData;
import android.content.Intent;
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
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_guest_dest_list);


        Intent intent = getIntent();
        if(intent != null){
            t1 = intent.getStringExtra("ListItemText");
        }
        if(t1.equals("Haridwar")){
            // 1. pass context and data to the custom adapter
            adapter = new GuestDestListAdapter(this, generateData1());

        }else if(t1.equals("Amritsar")){
            // 1. pass context and data to the custom adapter
            adapter = new GuestDestListAdapter(this, generateData2());
        }
        // 2. Get ListView from activity_main.xml
        final ListView listView = (ListView) findViewById(R.id.GuestDestList);

        // 3. setListAdapter
        listView.setAdapter(adapter);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Intent intent1 = new Intent(GuestDestListActivity.this, GuestDestDetailsActivity.class);
                Main = view.findViewById(R.id.Heading);
                    if(Main.getText().equals("Golden Temple")){
                    id=2;
                }else if (Main.getText().equals("Wagah Border")){
                    id=3;
                }


                intent1.putExtra("IPosition", id);
//                intent1.putExtra("Text", tt);
                startActivity(intent1);
            }
        });
    }

    private ArrayList<GuestDest> generateData1() {
        ArrayList<GuestDest> items = new ArrayList<GuestDest>();
        items.add(new GuestDest(R.drawable.mansadevi,"Mansa Devi", "Goddess Mansa Devi Temple...."));
        items.add(new GuestDest(R.drawable.harkipauri,"Har Ki Pauri", "Bath Ghat at holy river...."));
        return items;
    }

    private ArrayList<GuestDest> generateData2() {
        ArrayList<GuestDest> items = new ArrayList<GuestDest>();
        items.add(new GuestDest(R.drawable.goldentemple,"Golden Temple", "Also known as...."));
        items.add(new GuestDest(R.drawable.wagahborder,"Wagah Border", "India - Pakistan...."));
        return items;
    }
}
