package com.example.medicalrecord.bean;

import lombok.Data;

import java.util.List;

@Data
public class Record extends PatientCard{
    private int medicalId;
    private String firstVisitTime;
    private String diagnose;
    private String cure;
    private double allInCost;
    private double recCost;
    private String detail;
    private int ifPrinted;

    public Record() {
        super();
    }

    public Record(String name, String sex, int age, String phone, String diagnose, String cure, double allInCost, double recCost, String detail) {
        super(name, sex, age, phone);
        this.diagnose = diagnose;
        this.cure = cure;
        this.allInCost = allInCost;
        this.recCost = recCost;
        this.detail = detail;
    }

    public String getPatientToString(){
        return super.toString();
    }

    @Override
    public String toString() {
        return "Record{" +
                "patientId=" + patientId +
                ", name='" + name + '\'' +
                ", sex='" + sex + '\'' +
                ", age=" + age +
                ", phone='" + phone + '\'' +
                ", medicalId=" + medicalId +
                ", firstVisitTime='" + firstVisitTime + '\'' +
                ", diagnose='" + diagnose + '\'' +
                ", cure='" + cure + '\'' +
                ", allInCost=" + allInCost +
                ", recCost=" + recCost +
                ", detail='" + detail + '\'' +
                ", ifPrinted=" + ifPrinted +
                '}';
    }
}
