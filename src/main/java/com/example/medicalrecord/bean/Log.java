package com.example.medicalrecord.bean;

import lombok.Data;

@Data
public class Log {
    private int logId;
    private String logTime;
    private String content;
}
