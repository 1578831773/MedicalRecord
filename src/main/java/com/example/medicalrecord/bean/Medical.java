package com.example.medicalrecord.bean;

import lombok.Data;

@Data
public class Medical {
    private String mainSuit;
    private String historyOfPresentIllness;
    private String previousHistory;
    private String healthCheckUp;
    private String diagnose;
    private String cure;
    private String signature;

    public Medical() {
    }

    public Medical(String mainSuit, String historyOfPresentIllness, String previousHistory, String healthCheckUp, String diagnose, String cure, String signature) {
        this.mainSuit = mainSuit;
        this.historyOfPresentIllness = historyOfPresentIllness;
        this.previousHistory = previousHistory;
        this.healthCheckUp = healthCheckUp;
        this.diagnose = diagnose;
        this.cure = cure;
        this.signature = signature;
    }
}
