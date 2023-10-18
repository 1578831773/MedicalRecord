package com.example.medicalrecord.bean;

import lombok.Data;

@Data
public class PayRecord {
    private int payId;
    private double pay;
    private String detail;
    private String payTime;
    private int medicalId;

    public PayRecord() {
    }

    public PayRecord(double pay, String detail, String payTime, int medicalId) {
        this.pay = pay;
        this.detail = detail;
        this.payTime = payTime;
        this.medicalId = medicalId;
    }

    @Override
    public String toString() {
        return "PayRecord{" +
                "pay=" + pay +
                ", detail='" + detail + '\'' +
                ", payTime='" + payTime + '\'' +
                '}';
    }
}
