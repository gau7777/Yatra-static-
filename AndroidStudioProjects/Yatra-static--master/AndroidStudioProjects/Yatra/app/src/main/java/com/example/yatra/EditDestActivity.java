package com.example.yatra;

import android.annotation.SuppressLint;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.provider.MediaStore;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import java.io.ByteArrayOutputStream;

public class EditDestActivity extends AppCompatActivity implements View.OnClickListener {

    Button EditDest, ViewDest;
    EditText e0, e1, e2, e3, e4;
    int s0;
    ImageView i;
    String s1, s2, s3, s4;
    byte[] b, b1, b2;
    Bitmap bit1, bit2;
    AppDatabase mydb;
    public static final int RESULT_LOAD_IMAGE = 1;
    @SuppressLint("SetTextI18n")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_dest);

        EditDest = (Button) findViewById(R.id.EditDestbutton);
        ViewDest = (Button) findViewById(R.id.ViewDestUpdatebutton);

        e0 = (EditText) findViewById(R.id.DestIdeditText);
        e1 = (EditText) findViewById(R.id.EditDestPlaceNameeditText);
        e2 = (EditText) findViewById(R.id.EditDestNameeditText);
        e3 = (EditText) findViewById(R.id.EditDestIntroeditText);
        e4 = (EditText) findViewById(R.id.EditDestDescriptioneditText);

        i = (ImageView) findViewById(R.id.EditDestimageView);

        mydb = new AppDatabase(this);

        Intent intent = getIntent();
        if (intent != null) {
            s0 = intent.getIntExtra("DestId", 0);
            s1 = intent.getStringExtra("DPlName");
            s2 = intent.getStringExtra("DDName");
            s3 = intent.getStringExtra("DDIntro");
            s4 = intent.getStringExtra("DDDes");
            b = intent.getByteArrayExtra("DDImg");
        }

        e0.setText(s0 + "");
        e1.setText(s1);
        e2.setText(s2);
        e3.setText(s3);
        e4.setText(s4);
        i.setImageBitmap(convertToBitmap(b));
        bit1 = ((BitmapDrawable) i.getDrawable()).getBitmap();
        b1 = hImage(bit1);

        i.setOnClickListener(this);
        EditDest.setOnClickListener(this);
        ViewDest.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()){
            case R.id.EditDestbutton:
                 try{
                     boolean update = mydb.updateDest(e0.getText().toString(), e1.getText().toString(), e2.getText().toString(), e3.getText().toString(), e4.getText().toString(), gethImageView());
                     if(update){
                         Toast.makeText(EditDestActivity.this, "Destination Updated Successfully", Toast.LENGTH_LONG).show();
                     }else{
                         Toast.makeText(EditDestActivity.this, "Destination Not Updated Successfully", Toast.LENGTH_LONG).show();
                     }
                 }catch (Exception e){
                     boolean update = mydb.updateDest(e0.getText().toString(), e1.getText().toString(), e2.getText().toString(), e3.getText().toString(), e4.getText().toString(), b1);
                     if(update){
                         Toast.makeText(EditDestActivity.this, "Destination Updated Successfully", Toast.LENGTH_LONG).show();
                     }else{
                         Toast.makeText(EditDestActivity.this, "Destination Not Updated Successfully", Toast.LENGTH_LONG).show();
                     }
                 }
                break;

            case R.id.EditDestimageView:
                Intent galleryIntent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                startActivityForResult(galleryIntent, RESULT_LOAD_IMAGE);
                break;

            case R.id.ViewDestUpdatebutton:
                AlertDialog.Builder builder = new AlertDialog.Builder(this);
                builder.setTitle("Updated Destination List");
                builder.setMessage("Go to Place List and click on " + e1.getText().toString() + "to check its updated Destinations list");
                builder.setPositiveButton("Go", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        Intent intent = new Intent(EditDestActivity.this, AdminPlaceViewActivity.class);
                        startActivity(intent);
                    }
                });
                builder.show();
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
            bit2 = decodeUri(selectedImage);
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

    private byte[] hImage(Bitmap b) {

        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        b.compress(Bitmap.CompressFormat.JPEG, 0, bos);
        return bos.toByteArray();


    }

    private byte[] gethImageView(){
        b2 = hImage(bit2);
        return b2;
    }
}
