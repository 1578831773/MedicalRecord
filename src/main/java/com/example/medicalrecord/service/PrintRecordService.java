package com.example.medicalrecord.service;

import java.awt.*;
import java.awt.print.*;

public class PrintRecordService implements Printable {

    @Override
    public int print(Graphics graphics, PageFormat pageFormat, int pageIndex) throws PrinterException {
        if (pageIndex > 0) {
            return NO_SUCH_PAGE;
        }

        Graphics2D g2d = (Graphics2D) graphics;
        g2d.translate(pageFormat.getImageableX(), pageFormat.getImageableY());

        // Define the medical record content
        String patientName = "John Doe";
        String gender = "Male";
        int age = 30;
        String phoneNumber = "123-456-7890";
        String chiefComplaint = "Fever and headache";
        String medicalHistory = "No significant medical history";
        String physicalExam = "Normal";
        String diagnosis = "Common cold";
        String treatment = "Rest and fluids";
        String doctorSignature = "Dr. Smith";
        String projectName = "Medical Consultation";
        double totalCost = 100.0;
        double paidAmount = 50.0;

        // Draw the medical record content using Graphics2D
        int y = 50;
        g2d.setFont(new Font("Arial", Font.BOLD, 12));
        g2d.drawString("Patient Information:", 50, y);
        y += 20;
        g2d.drawString("Name: " + patientName, 50, y);
        y += 15;
        g2d.drawString("Gender: " + gender, 50, y);
        y += 15;
        g2d.drawString("Age: " + age, 50, y);
        y += 15;
        g2d.drawString("Phone: " + phoneNumber, 50, y);

        y += 30;
        g2d.drawString("Medical History:", 50, y);
        y += 15;
        g2d.drawString("Chief Complaint: " + chiefComplaint, 50, y);
        y += 15;
        g2d.drawString("Medical History: " + medicalHistory, 50, y);
        y += 15;
        g2d.drawString("Physical Exam: " + physicalExam, 50, y);

        y += 30;
        g2d.drawString("Diagnosis and Treatment:", 50, y);
        y += 15;
        g2d.drawString("Diagnosis: " + diagnosis, 50, y);
        y += 15;
        g2d.drawString("Treatment: " + treatment, 50, y);

        y += 30;
        g2d.drawString("Doctor's Signature: " + doctorSignature, 50, y);

        y += 30;
        g2d.drawString("Project: " + projectName, 50, y);
        y += 15;
        g2d.drawString("Total Cost: " + totalCost, 50, y);
        y += 15;
        g2d.drawString("Paid Amount: " + paidAmount, 50, y);

        return PAGE_EXISTS;
    }

    public static void printRecord() {
        PrinterJob job = PrinterJob.getPrinterJob();
        PageFormat format = job.defaultPage();
        job.setPrintable(new PrintRecordService(), format);

        if (job.printDialog()) {
            try {
                job.print();
            } catch (PrinterException e) {
                e.printStackTrace();
            }
        }
    }
}
