package com.example.medicalrecord.bean;

import lombok.Data;

@Data
public class PatientCard {
    protected int patientId;
    protected String name;
    protected String sex;
    protected int age;
    protected String phone;

    public PatientCard() {
    }

    public PatientCard(int patientId, String name, String sex, int age, String phone) {
        this.patientId = patientId;
        this.name = name;
        this.sex = sex;
        this.age = age;
        this.phone = phone;
    }

    public PatientCard(String name, String sex, int age, String phone) {
        this.name = name;
        this.sex = sex;
        this.age = age;
        this.phone = phone;
    }
}
