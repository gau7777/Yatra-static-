package com.example.yatra;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.provider.ContactsContract;
import android.provider.MediaStore;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import java.io.ByteArrayOutputStream;

public class EditPlaceActivity extends AppCompatActivity implements View.OnClickListener {

    Button edit, ViewEdit;
    EditText e0, e1, e2, e3;
    ImageView i1;
    String s1, s2, s3;
    int s0;
    byte[] b1,pv,pview;
    Bitmap bm, bview;
    AppDatabase mydb;
    public static final int RESULT_LOAD_IMAGE = 1;
    @SuppressLint("SetTextI18n")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_place);

        edit = (Button) findViewById(R.id.EditPlacebutton);
        ViewEdit = (Button) findViewById(R.id.ViewPlaceUpdatebutton);

        e0 = (EditText) findViewById(R.id.PlaceIdeditText);
        e1 = (EditText) findViewById(R.id.EditPlaceNameeditText);
        e2 = (EditText) findViewById(R.id.EditPlaceIntroeditText);
        e3 = (EditText) findViewById(R.id.EditPlaceDescriptioneditText);

        i1 = (ImageView) findViewById(R.id.EditPlaceimageView);

        mydb = new AppDatabase(this);

        Intent intent = getIntent();
        if(intent != null){
            s0 = intent.getIntExtra("PlId", 0);
            s1 = intent.getStringExtra("PlName");
            s2 = intent.getStringExtra("PlIntro");
            s3 = intent.getStringExtra("PlDes");
            b1 = intent.getByteArrayExtra("PlImg");
        }

        e0.setText(s0 + "");
        e1.setText(s1);
        e2.setText(s2);
        e3.setText(s3);
        i1.setImageBitmap(convertToBitmap(b1));
        bm = ((BitmapDrawable) i1.getDrawable()).getBitmap();
        pv = hImage(bm);

        edit.setOnClickListener(this);
        i1.setOnClickListener(this);
        ViewEdit.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()){
            case R.id.EditPlacebutton:
                try{
                    boolean update = mydb.updatePlace(e0.getText().toString(), e1.getText().toString(), e2.getText().toString(), e3.getText().toString(), gethImageView());
                    if(update){
                        Toast.makeText(EditPlaceActivity.this, "Place Updated successfully", Toast.LENGTH_LONG).show();
                    }else{
                        Toast.makeText(EditPlaceActivity.this, "Place Not Updated successfully", Toast.LENGTH_LONG).show();
                    }
                }catch (Exception e){
                    boolean update = mydb.updatePlace(e0.getText().toString(), e1.getText().toString(), e2.getText().toString(), e3.getText().toString(), pv);
                    if(update){
                        Toast.makeText(EditPlaceActivity.this, "Place Updated successfully", Toast.LENGTH_LONG).show();
                    }else{
                        Toast.makeText(EditPlaceActivity.this, "Place Not Updated successfully", Toast.LENGTH_LONG).show();
                    }
                }
                break;

            case R.id.EditPlaceimageView:
                Intent galleryIntent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                startActivityForResult(galleryIntent, RESULT_LOAD_IMAGE);
                break;

            case R.id.ViewPlaceUpdatebutton:
                Intent intent = new Intent(EditPlaceActivity.this, AdminPlaceViewActivity.class);
                startActivity(intent);
                break;

        }
    }

    private Bitmap convertToBitmap(byte[] b) {
        return BitmapFactory.decodeByteArray(b, 0, b.length);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == RESULT_LOAD_IMAGE && resultCode == RESULT_OK && data != null) {
            Uri selectedImage = data.getData();
            bview = decodeUri(selectedImage);
            i1.setImageURI(selectedImage);
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

    private byte[] hImage(Bitmap b) {

        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        b.compress(Bitmap.CompressFormat.JPEG, 0, bos);
        return bos.toByteArray();


    }

    private byte[] gethImageView(){
        pview = hImage(bview);
        return pview;
    }

}
