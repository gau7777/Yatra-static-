package com.example.yatra;

import java.util.Arrays;

public class DestModel {

    private String PName;
    private String D_NAME;
    private String D_Intro;
    private String D_DES;
    private byte[] D_Image;

    public DestModel(String PName, String d_NAME, String d_Intro, String d_DES, byte[] d_Image) {
        this.PName = PName;
        D_NAME = d_NAME;
        D_Intro = d_Intro;
        D_DES = d_DES;
        D_Image = d_Image;
    }

    public String getD_Intro() {
        return D_Intro;
    }

    public void setD_Intro(String d_Intro) {
        D_Intro = d_Intro;
    }

    public String getPName() {
        return PName;
    }

    public void setPName(String PName) {
        this.PName = PName;
    }

    public String getD_NAME() {
        return D_NAME;
    }

    public void setD_NAME(String d_NAME) {
        D_NAME = d_NAME;
    }

    public String getD_DES() {
        return D_DES;
    }

    public void setD_DES(String d_DES) {
        D_DES = d_DES;
    }

    public byte[] getD_Image() {
        return D_Image;
    }

    public void setD_Image(byte[] d_Image) {
        D_Image = d_Image;
    }

    @Override
    public String toString() {
        return "DestModel{" +
                "PName='" + PName + '\'' +
                ", D_NAME='" + D_NAME + '\'' +
                ", D_Intro='" + D_Intro + '\'' +
                ", D_DES='" + D_DES + '\'' +
                ", D_Image=" + Arrays.toString(D_Image) +
                '}';
    }
}
