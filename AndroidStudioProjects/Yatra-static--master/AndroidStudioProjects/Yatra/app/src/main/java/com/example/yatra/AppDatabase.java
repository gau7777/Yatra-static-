package com.example.yatra;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.os.strictmode.SqliteObjectLeakedViolation;

public class AppDatabase extends SQLiteOpenHelper {
    public static final String DATABASE_NAME = "yatra.db";
    public static final int DATABASE_VERSION = 7;

    public AppDatabase(Context context){
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
         String sql1 = "CREATE TABLE " + PlaceContract.TABLE_NAME + "(" + PlaceContract.Columns.Place_Id + " INTEGER PRIMARY KEY AUTOINCREMENT, " + PlaceContract.Columns.Place_Name + " TEXT, " + PlaceContract.Columns.Place_Intro + " TEXT, " + PlaceContract.Columns.Place_Des + " TEXT, " + PlaceContract.Columns.Place_Image + " byte(10000000))";
         db.execSQL(sql1);

         String sql2 = "CREATE TABLE " + DestContract.TABLE_NAME + "(" + DestContract.Columns.Dest_Id + " INTEGER PRIMARY KEY AUTOINCREMENT, " + DestContract.Columns.DestPlace_Name + " TEXT, " + DestContract.Columns.Dest_Name + " TEXT, " + DestContract.Columns.Dest_Intro + " TEXT, " + DestContract.Columns.Dest_Des + " TEXT, " + DestContract.Columns.Dest_Image + " byte(10000000))";
         db.execSQL(sql2);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + PlaceContract.TABLE_NAME);
        db.execSQL("DROP TABLE IF EXISTS " + DestContract.TABLE_NAME);
        onCreate(db);
    }

    public boolean insertPlace(String PName, String PIntro, String PDescription, byte[] PImage){
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(PlaceContract.Columns.Place_Name, PName);
        contentValues.put(PlaceContract.Columns.Place_Intro, PIntro);
        contentValues.put(PlaceContract.Columns.Place_Des, PDescription);
        contentValues.put(PlaceContract.Columns.Place_Image, PImage);
        long result = db.insert(PlaceContract.TABLE_NAME, null, contentValues);
        if(result == -1){
            return false;
        }else{
            return true;
        }
    }

    public boolean insertDest(String DPName, String DName, String DIntro, String DDescription, byte[] DImage){
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(DestContract.Columns.DestPlace_Name, DPName);
        contentValues.put(DestContract.Columns.Dest_Name, DName);
        contentValues.put(DestContract.Columns.Dest_Intro, DIntro);
        contentValues.put(DestContract.Columns.Dest_Des, DDescription);
        contentValues.put(DestContract.Columns.Dest_Image, DImage);
        long result = db.insert(DestContract.TABLE_NAME, null, contentValues);
        if(result == -1){
            return false;
        }else{
            return true;
        }
    }

    public boolean updatePlace(String PID, String PName, String PIntro, String PDescription,  byte[] PImage){
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(PlaceContract.Columns.Place_Id, PID);
        contentValues.put(PlaceContract.Columns.Place_Name, PName);
        contentValues.put(PlaceContract.Columns.Place_Intro, PIntro);
        contentValues.put(PlaceContract.Columns.Place_Des, PDescription);
        contentValues.put(PlaceContract.Columns.Place_Image, PImage);
        db.update(PlaceContract.TABLE_NAME, contentValues, PlaceContract.Columns.Place_Id + "= ?", new String[] { PID });
        return true;
    }

    public boolean updateDest(String DID, String DPName, String DName, String DIntro,  String DDescription, byte[] DImage){
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(DestContract.Columns.Dest_Id, DID);
        contentValues.put(DestContract.Columns.DestPlace_Name, DPName);
        contentValues.put(DestContract.Columns.Dest_Name, DName);
        contentValues.put(DestContract.Columns.Dest_Intro, DIntro);
        contentValues.put(DestContract.Columns.Dest_Des, DDescription);
        contentValues.put(DestContract.Columns.Dest_Image, DImage);
        db.update(DestContract.TABLE_NAME, contentValues, DestContract.Columns.Dest_Id + "= ?", new String[] { DID });
        return true;
    }

    public int deletePlace(String PName){
        SQLiteDatabase db = this.getWritableDatabase();
        return db.delete(PlaceContract.TABLE_NAME, PlaceContract.Columns.Place_Name + "= ?", new String[] { PName });
    }

    public int deleteDest(String DName){
        SQLiteDatabase db = this.getWritableDatabase();
        return db.delete(DestContract.TABLE_NAME, DestContract.Columns.Dest_Name + "= ?", new String[] { DName });
    }

    public Cursor getPlace(){
        SQLiteDatabase db = this.getWritableDatabase();
        Cursor res = db.rawQuery("SELECT * FROM " + PlaceContract.TABLE_NAME, null);
        return res;
    }

    public Cursor getPlaceAdmin(String PName){
        SQLiteDatabase db = this.getWritableDatabase();
        Cursor res = db.rawQuery("SELECT * FROM " + PlaceContract.TABLE_NAME + " WHERE " + PlaceContract.Columns.Place_Name + "= ?", new String[] { PName });
        return res;
    }

    public Cursor getDestAdmin(String DPName){
        SQLiteDatabase db = this.getWritableDatabase();
        Cursor res = db.rawQuery("SELECT * FROM " + PlaceContract.TABLE_NAME + " P INNER JOIN " + DestContract.TABLE_NAME + " D" + " ON P." + PlaceContract.Columns.Place_Name + "= ?" + " WHERE P." + PlaceContract.Columns.Place_Name + "= D." + DestContract.Columns.DestPlace_Name, new String[] { DPName });
        return res;
    }

    public Cursor getGuestDest(String DName){
        SQLiteDatabase db = this.getWritableDatabase();
        Cursor res = db.rawQuery("SELECT * FROM " + DestContract.TABLE_NAME + " WHERE " + DestContract.Columns.Dest_Name + "= ?", new String[] { DName });
        return res;
    }


}
