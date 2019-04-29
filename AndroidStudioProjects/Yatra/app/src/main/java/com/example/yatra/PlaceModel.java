package com.example.yatra;

import java.util.Arrays;

public class PlaceModel {

    private int P_id;
    private String P_Name;
    private String P_Intro;
    private String P_Des;
    private byte[] P_Image;

    public PlaceModel(int Id, String p_Name, String p_Intro, String p_Des, byte[] p_image) {
        P_id = Id;
        P_Name = p_Name;
        P_Intro = p_Intro;
        P_Des = p_Des;
        P_Image = p_image;
    }

    public int getP_id() {
        return P_id;
    }

    public void setP_id(int p_id) {
        P_id = p_id;
    }

    public String getP_Intro() {
        return P_Intro;
    }

    public void setP_Intro(String p_Intro) {
        P_Intro = p_Intro;
    }

    public byte[] getP_Image() {
        return P_Image;
    }

    public void setP_Image(byte[] p_Image) {
        P_Image = p_Image;
    }

    public String getP_Name() {
        return P_Name;
    }

    public void setP_Name(String p_Name) {
        P_Name = p_Name;
    }

    public String getP_Des() {
        return P_Des;
    }

    public void setP_Des(String p_Des) {
        P_Des = p_Des;
    }

    @Override
    public String toString() {
        return "PlaceModel{" +
                "P_id=" + P_id +
                ", P_Name='" + P_Name + '\'' +
                ", P_Intro='" + P_Intro + '\'' +
                ", P_Des='" + P_Des + '\'' +
                ", P_Image=" + Arrays.toString(P_Image) +
                '}';
    }
}
