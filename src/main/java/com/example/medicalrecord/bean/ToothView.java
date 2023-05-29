package com.example.medicalrecord.bean;

import lombok.Data;
import org.springframework.context.annotation.Bean;

import java.util.ArrayList;
import java.util.List;

@Data
public class ToothView {
    private int toothId;
    private String teeth1;
    private String teeth2;
    private String teeth3;
    private String teeth4;

    public ToothView(String teeth1, String teeth2, String teeth3, String teeth4) {
        this.teeth1 = teeth1;
        this.teeth2 = teeth2;
        this.teeth3 = teeth3;
        this.teeth4 = teeth4;
    }

    public ToothView() {
    }

}
