package com.example.medicalrecord.bean;

import lombok.Data;

@Data
public class PrintRecord {
    private int printId;
    private int medicalId;
    private String name;
    private String diagnoseTime;
    private String cure;
    private String printTime;
    private double allInCost;
    private double recCost;
}
