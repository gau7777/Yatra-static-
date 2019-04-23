package com.example.yatra;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;

public class GuestDestDetailsActivity extends AppCompatActivity {

    TextView Title, Description;
    ImageView DestImage;
    long txt;
    long ttt;

    GuestDestListAdapter gd;
    @SuppressLint("SetTextI18n")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_guest_dest_details);

        Title = (TextView) findViewById(R.id.DestTitle);
        Description = (TextView) findViewById(R.id.DestDescription);

        DestImage = (ImageView) findViewById(R.id.DestImage);

        Intent intent = getIntent();
        if(intent != null){
            txt = intent.getLongExtra("IPosition", 0);
//         ttt = intent.getLongExtra("Text", 0);
//            t = intent.getStringExtra("Text");
        }

        if(txt == 0){
            Title.setText("Mansa Devi");
            Description.setText("Mansa Devi Temple, Haridwar (Hindi: मंसा देवी मंदिर, हरिद्वार) is a Hindu temple dedicated to goddess Mansa Devi in the holy city of Haridwar in the Uttarakhand state of India. The temple is located atop the Bilwa Parvat on the Sivalik Hills, the southernmost mountain chain of the Himalayas. The temple, also known as Bilwa Tirth is one of the Panch Tirth (Five Pilgrimages) within Haridwar.");
            DestImage.setImageResource(R.drawable.mansadevi);
        }else if(txt == 1){
            Title.setText("Har Ki Pauri");
            Description.setText("Har Ki Pauri (Hindi: हर की पौड़ी) is a famous ghat on the banks of the Ganges in Haridwar in the Indian state of Uttarakhand. This revered place is the major landmark of the holy city of Haridwar. Literally, \"Har\" means \"Lord Shiva\" who is the god according to shaivite Rishav Bhagwan school of Hindu theology, \"Ki\" means \"of\" and \"Pauri\" means \"steps\". Lord Shiva and Lord Vishnu are believed to have visited the Brahmakund in Har Ki Pauri in the Vedic times.");
            DestImage.setImageResource(R.drawable.harkipauri);
        }else if(txt == 2){
            Title.setText("Golden Temple");
            Description.setText("The Harmandir Sahib also known as Darbar Sahib (Punjabi pronunciation: [dəɾbɑɾ sɑhɪb] or Sri Harmandir Sahib (\"Abode of God\", \"Exalted Holy Court\"), is a Gurdwara Sahib (Sikh temple) located in the city of Amritsar, Punjab, India. It is the holiest Gurdwara and the most important pilgrimage site of Sikhism. It is usually called the Golden Temple in English, because it is plated with gold.");
            DestImage.setImageResource(R.drawable.goldentemple);
        }else if(txt == 3){
            Title.setText("Wagah Border");
            Description.setText("Wagah (Urdu: واہگہ\u200E, Shahmukhi Punjabi: واہگہ) or Wahga is a village and union council (UC 181) located in the Wahga Zone of Lahore, Punjab, Pakistan.[1] The town is famous for the Wagah border ceremony and also serves as a goods transit terminal and a railway station between Pakistan and India.[2] Wagah is situated 600 metres (2,000 ft) west of the border and lies on the historic Grand Trunk Road between Lahore and Amritsar in India. The border is located 24 kilometres (15 mi) from Lahore and 32 kilometres (20 mi) from Amritsar. It is also 3 kilometres (1.9 mi) from the bordering village of Attari.");
            DestImage.setImageResource(R.drawable.wagahborder);
        }
    }
}
