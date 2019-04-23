package com.example.yatra;

public class AdminPlaces {
 private String text;
 private int IButton1Id;
 private int IButton2Id;

    public AdminPlaces(String text, int IButton1Id, int IButton2Id) {
        this.text = text;
        this.IButton1Id = IButton1Id;
        this.IButton2Id = IButton2Id;
    }

    public String getmText() {
        return text;
    }

    public void setmText(String text) {
        this.text = text;
    }

    public int getIButton1Id() {
        return IButton1Id;
    }

    public void setIButton1Id(int IButton1Id) {
        this.IButton1Id = IButton1Id;
    }

    public int getIButton2Id() {
        return IButton2Id;
    }

    public void setIButton2Id(int IButton2Id) {
        this.IButton2Id = IButton2Id;
    }

    @Override
    public String toString() {
        return "AdminPlaces{" +
                "text='" + text + '\'' +
                ", IButton1Id=" + IButton1Id +
                ", IButton2Id=" + IButton2Id +
                '}';
    }
}
