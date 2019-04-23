package com.example.yatra;

import android.content.Intent;
import android.icu.lang.UCharacter;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class AdminLoginActivity extends AppCompatActivity {

    Button AdminLogin;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_admin_login);

        AdminLogin = (Button) findViewById(R.id.admin_login_button);

        AdminLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(AdminLoginActivity.this, AdminPlaceViewActivity.class);
                startActivity(intent);
            }
        });
    }
}
