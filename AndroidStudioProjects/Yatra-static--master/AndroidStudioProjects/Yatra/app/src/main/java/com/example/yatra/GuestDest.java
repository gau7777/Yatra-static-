package com.example.yatra;

import android.graphics.Bitmap;

public class GuestDest {

    private String mName;
    private String mDes;
    private Bitmap imageId;

    public GuestDest(String mName, String mDes, Bitmap imageId) {
        this.imageId = imageId;
        this.mName = mName;
        this.mDes = mDes;
    }


    public String getmName() {
        return mName;
    }

    public void setmName(String mName) {
        this.mName = mName;
    }

    public String getmDes() {
        return mDes;
    }

    public void setmDes(String mDes) {
        this.mDes = mDes;
    }

    public Bitmap getImageId() {
        return imageId;
    }

    public void setImageId(Bitmap imageId) {
        this.imageId = imageId;
    }

    @Override
    public String toString() {
        return "GuestDest{" +
                "mName='" + mName + '\'' +
                ", mDes='" + mDes + '\'' +
                ", imageId=" + imageId +
                '}';
    }
}
