package com.example.medicalrecord.bean;

import lombok.Data;

import java.util.List;

@Data
public class Record {
    private int medicalId;
    private String firstVisitTime;
    private PatientCard patientCard;
    private Medical medical;
    private ProjectCost projectCost;
    private String detail;
    private int ifPrinted;

    public Record() {
        super();
    }

    public Record(String name, String sex, int age, String phone,
                  String mainSuit, String historyOfPresentIllness, String previousHistory, String healthCheckUp, String diagnose, String cure, String signature,
                  String project, double allInCost, double paid,
                  String detail) {
        this.patientCard = new PatientCard(name, sex, age, phone);
        this.medical = new Medical(mainSuit, historyOfPresentIllness, previousHistory, healthCheckUp, diagnose, cure, signature);
        this.projectCost = new ProjectCost(project, allInCost, paid);
        this.detail = detail;
    }


    @Override
    public String toString() {
        return "Record{" +
                "medicalId=" + medicalId +
                ", firstVisitTime='" + firstVisitTime + '\'' +
                ", patientCard=" + patientCard.toString() +
                ", medical=" + medical.toString() +
                ", projectCost=" + projectCost.toString() +
                ", detail='" + detail + '\'' +
                '}';
    }
//    public String toString(){
//        return medicalId + "," + firstVisitTime + "," + patientCard.getPatientId()+"," + patientCard.getName()+"," + patientCard.getSex()+"," + patientCard.getSex()+"," + patientCard.getSex()+"," + patientCard.getPhone()+"," +
//                medical.getMainSuit()+"," + medical.getHistoryOfPresentIllness()+"," + medical.getPreviousHistory()+"," + medical.getHealthCheckUp()+"," + medical.getDiagnose()+"," + medical.getCure()+"," + medical.getSignature()+"," +
//                projectCost.getProject()+"," + projectCost.getAllInCost()+"," + projectCost.getPaid();
//    }
}
