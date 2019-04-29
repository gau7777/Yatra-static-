package com.example.yatra;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

public class GuestDestDetailsActivity extends AppCompatActivity {

    TextView Title, Description;
    ImageView DestImage;
    AppDatabase mydb;
    String s1,s2;
    byte[] Dpic;
    GuestDestListAdapter gd;
    @SuppressLint("SetTextI18n")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_guest_dest_details);

        Title = (TextView) findViewById(R.id.DestTitle);
        Description = (TextView) findViewById(R.id.DestDescription);

        DestImage = (ImageView) findViewById(R.id.DestImage);

        mydb = new AppDatabase(this);

        Intent intent = getIntent();
        if (intent != null) {
            s1 = intent.getStringExtra("DName");
            s2 = intent.getStringExtra("DDes");
            Dpic = intent.getByteArrayExtra("DImg");

        }



                Title.setText(s1);
                Description.setText(s2);
                DestImage.setImageBitmap(convertToBitmap(Dpic));


    }
    private Bitmap convertToBitmap(byte[] b) {
        return BitmapFactory.decodeByteArray(b, 0, b.length);
    }
}
