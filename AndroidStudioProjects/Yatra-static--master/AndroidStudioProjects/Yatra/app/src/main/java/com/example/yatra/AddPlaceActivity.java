package com.example.yatra;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.provider.MediaStore;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import java.io.ByteArrayOutputStream;

public class AddPlaceActivity extends AppCompatActivity {

    Button Add, see;
    AppDatabase mydb;
    EditText e1, e2, e3;
    ImageView ip;
    Bitmap bp;
    byte[] photo;
    public static final int RESULT_LOAD_IMAGE = 1;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_place);

        mydb = new AppDatabase(this);

        Add = (Button) findViewById(R.id.AddPlacebutton);
        see = (Button) findViewById(R.id.ViewPlacebutton);

        e1 = (EditText) findViewById(R.id.PlaceNameeditText);
        e3 = (EditText) findViewById(R.id.PlaceDescriptioneditText);
        e2 = (EditText) findViewById(R.id.PIntroeditText);

        ip = (ImageView) findViewById(R.id.PlaceimageView);

    Add.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            if(e1.getText().toString().trim().isEmpty() || e2.getText().toString().trim().isEmpty() || e3.getText().toString().trim().isEmpty()){
                Toast.makeText(AddPlaceActivity.this, "Blank spaces not allowed", Toast.LENGTH_LONG).show();
            }else {
                try {
                    boolean insert = mydb.insertPlace(e1.getText().toString(), e2.getText().toString(), e3.getText().toString(), getPPic());
                    if (insert) {
                        Toast.makeText(AddPlaceActivity.this, "Place Added", Toast.LENGTH_LONG).show();
                    } else {
                        Toast.makeText(AddPlaceActivity.this, "Place Not Added", Toast.LENGTH_LONG).show();
                    }
                } catch (NullPointerException e) {
                    Toast.makeText(AddPlaceActivity.this, "Please fill all details", Toast.LENGTH_LONG).show();
                }
            }
           }

    });

    see.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            Intent intent = new Intent(AddPlaceActivity.this, AdminPlaceViewActivity.class);
            startActivity(intent);
        }
    });

    ip.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            Intent galleryIntent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
            startActivityForResult(galleryIntent, RESULT_LOAD_IMAGE);
        }
    });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == RESULT_LOAD_IMAGE && resultCode == RESULT_OK && data != null) {
            Uri selectedImage = data.getData();
            bp = decodeUri(selectedImage);
            ip.setImageURI(selectedImage);
        }

    }

    protected Bitmap decodeUri(Uri choosenImage) {
        BitmapFactory.Options o = new BitmapFactory.Options();

        try {
            return BitmapFactory.decodeStream(getContentResolver().openInputStream(choosenImage), null, o);
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }
    private byte[] hImage(Bitmap b){
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        b.compress(Bitmap.CompressFormat.JPEG, 0, bos);
        return bos.toByteArray();
    }

    private byte[] getPPic(){
        photo = hImage(bp);
        return photo;
    }
}
