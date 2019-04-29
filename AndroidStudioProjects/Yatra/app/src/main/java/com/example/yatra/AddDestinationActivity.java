package com.example.yatra;

import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.Image;
import android.net.Uri;
import android.provider.MediaStore;
import android.support.annotation.Nullable;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import java.io.ByteArrayOutputStream;

public class AddDestinationActivity extends AppCompatActivity implements View.OnClickListener {

    Button AddDest, ViewDest;
    EditText e1, e2, e3, e4;
    ImageView i;
    AppDatabase mydb;
    Bitmap bp;
    byte[] photo;
    public static final int RESULT_LOAD_IMAGE = 1;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_destination);

        mydb = new AppDatabase(this);

        AddDest = (Button) findViewById(R.id.AddDestbutton);
        ViewDest = (Button) findViewById(R.id.ViewDestinationbutton);

        e1 = (EditText) findViewById(R.id.DestPlaceNameeditText);
        e2 = (EditText) findViewById(R.id.DestNameEditText);
        e3 = (EditText) findViewById(R.id.DIntroeditText);
        e4 = (EditText) findViewById(R.id.DestDescriptioneditText);

        i = (ImageView) findViewById(R.id.DestimageView);

        AddDest.setOnClickListener(this);
        ViewDest.setOnClickListener(this);
        i.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
      switch (v.getId()){
          case R.id.AddDestbutton:
              if(e1.getText().toString().trim().isEmpty() || e2.getText().toString().trim().isEmpty() || e3.getText().toString().trim().isEmpty() || e4.getText().toString().trim().isEmpty()){
                  Toast.makeText(AddDestinationActivity.this, "Blank spaces not allowed", Toast.LENGTH_LONG).show();
              }else{
                  try{
                      boolean insert = mydb.insertDest(e1.getText().toString(), e2.getText().toString(), e3.getText().toString(), e4.getText().toString(), getPlacePic());
                      if(insert){
                          Toast.makeText(AddDestinationActivity.this, "Destination added", Toast.LENGTH_LONG).show();
                      }else{
                          Toast.makeText(AddDestinationActivity.this, "Destination not added", Toast.LENGTH_LONG).show();
                      }
                  }catch(NullPointerException e){
                      Toast.makeText(AddDestinationActivity.this, "Please fill all details", Toast.LENGTH_LONG).show();
                  }
              }

              break;

          case R.id.ViewDestinationbutton:
              AlertDialog.Builder builder = new AlertDialog.Builder(this);
              builder.setTitle("View Destination");
              builder.setMessage("Go to place list and check the updation of" + e1.getText().toString() + "'s destination list, by clicking on " + e1.getText().toString());
              builder.setPositiveButton("Go", new DialogInterface.OnClickListener() {
                  @Override
                  public void onClick(DialogInterface dialog, int which) {
                      Intent intent = new Intent(AddDestinationActivity.this, AdminPlaceViewActivity.class);
                      startActivity(intent);
                  }
              });
              builder.show();
              break;

          case R.id.DestimageView:
              Intent galleryIntent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
              startActivityForResult(galleryIntent, RESULT_LOAD_IMAGE);
              break;
      }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == RESULT_LOAD_IMAGE && resultCode == RESULT_OK && data != null) {
            Uri selectedImage = data.getData();
            bp = decodeUri(selectedImage);
            i.setImageURI(selectedImage);
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

    private byte[] getPlacePic(){
        photo = hImage(bp);
        return photo;
    }
}
