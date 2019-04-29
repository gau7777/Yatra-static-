package com.example.yatra;

public class PlaceContract {
    public static final String TABLE_NAME = "placetable";

    public static class Columns{
        public static final String Place_Id = "Place_Id";
        public static final String Place_Name = "Place_Name";
        public static final String Place_Intro = "Place_Intro";
        public static final String Place_Des = "Place_Des";
        public static final String Place_Image = "Place_Image";

        private Columns(){

        }
    }
}
