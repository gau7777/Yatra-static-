package com.example.yatra;

import android.content.Intent;
import android.icu.lang.UCharacter;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class AdminLoginActivity extends AppCompatActivity {

    Button AdminLogin;
    EditText e1, e2;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_admin_login);

        AdminLogin = (Button) findViewById(R.id.admin_login_button);

        e1 = (EditText) findViewById(R.id.Admin_name_editText);
        e2 = (EditText) findViewById(R.id.Admin_pass_editText);

        AdminLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(e1.getText().toString().equals("Gaurav") && e2.getText().toString().equals("guruji")){
                Toast.makeText(AdminLoginActivity.this, "Welcome Admin", Toast.LENGTH_LONG).show();
                    Intent intent = new Intent(AdminLoginActivity.this, AdminPlaceViewActivity.class);
                    startActivity(intent);
                }else{
                    Toast.makeText(AdminLoginActivity.this, "Please try again", Toast.LENGTH_LONG).show();
                }

            }
        });
    }
}
