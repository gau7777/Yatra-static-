package com.example.yatra;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

public class GuestPlace {

   private String PHeading;
   private String PIntro;
   private Bitmap PImageId;

    public GuestPlace(String PHeading, String PIntro, Bitmap PImageId) {
        this.PHeading = PHeading;
        this.PIntro = PIntro;
        this.PImageId = PImageId;
    }

    public String getPHeading() {
        return PHeading;
    }

    public void setPHeading(String PHeading) {
        this.PHeading = PHeading;
    }

    public String getPIntro() {
        return PIntro;
    }

    public void setPIntro(String PIntro) {
        this.PIntro = PIntro;
    }

    public Bitmap getPImageId() {
        return PImageId;
    }

    public void setPImageId(Bitmap PImageId) {
        this.PImageId = PImageId;
    }



    @Override
    public String toString() {
        return "GuestPlace{" +
                "PHeading='" + PHeading + '\'' +
                ", PIntro='" + PIntro + '\'' +
                ", PImageId=" + PImageId +
                '}';
    }
}
