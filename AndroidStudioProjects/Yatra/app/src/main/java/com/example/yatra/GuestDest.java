package com.example.yatra;

public class GuestDest {

    private String mName;
    private String mDes;
    private int imageId;

    public GuestDest(int imageId, String mName, String mDes) {
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

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
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
