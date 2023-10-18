package com.example.medicalrecord.bean;

import lombok.Data;

@Data
public class ProjectCost {
    private String project;
    private double allInCost;
    private double paid;

    public ProjectCost() {
    }

    public ProjectCost(String project, double allInCost, double paid) {
        this.project = project;
        this.allInCost = allInCost;
        this.paid = paid;
    }
}
