package com.example.medicalrecord.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class CommUtils {
    public static String gerTime(){
        Calendar now = Calendar.getInstance();
        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return fmt.format(now.getTime());
    }
}
