package com.example.medicalrecord.service;

import com.example.medicalrecord.bean.PrintRecord;
import com.example.medicalrecord.bean.Record;
import com.example.medicalrecord.mapper.PrintMapper;
import com.example.medicalrecord.utils.CommUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.print.*;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.standard.Copies;
import java.awt.*;
import java.awt.print.*;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.List;




/**
 * 打印机测试类（58mm）
 * 1、目标打印机必须设置为默认打印机
 * 2、打印页面的宽度和具体的打印机有关，一般为打印纸的宽度，需要配置成系统参数
 * 3、一个汉字的宽度大概是12点
 */
@Service
public class MyPrintService {

    @Autowired
    private PrintMapper printMapper;
    @Autowired
    private LogService logService;

    public int startPrintRecord(PrintRecord printRecord){
        if(PrinterJob.lookupPrintServices().length>0){
			/*
        打印格式
       */
            PageFormat pageFormat = new PageFormat();
            //设置打印起点从左上角开始，从左到右，从上到下打印
            pageFormat.setOrientation(PageFormat.PORTRAIT);
			/*
        打印页面格式设置
       */
            Paper paper = new Paper();
            //设置打印宽度（固定，和具体的打印机有关）和高度（跟实际打印内容的多少有关）
            int height = (printRecord.getCure().length()/ 20 + 1) * 15;
            paper.setSize(500, 600 + height);
            //设置打印区域 打印起点坐标、打印的宽度和高度
            paper.setImageableArea(0, 0, 500, 600 + height);
            pageFormat.setPaper(paper);
            //创建打印文档
            Book book = new Book();
            book.append(new Printable() {
                            @Override
                            public int print(Graphics graphics, PageFormat pageFormat, int pageIndex) throws PrinterException {
                                if(pageIndex>0){
                                    return NO_SUCH_PAGE;
                                }
                                int x = 150;
                                int y = 20;
                                Graphics2D g2d = (Graphics2D) graphics;
                                g2d.setFont(new Font("Default", Font.PLAIN, 14));
                                g2d.drawString("永皓齿科", 100 + x, 20 + y);
                                g2d.drawString("-------------------------------------------------", 7 + x, 35 + y);
                                g2d.drawString("编号：" + printRecord.getMedicalId(), 7 + x, 45 + y);
                                g2d.drawString("姓名：" + printRecord.getName(), 7 + x, 65 + y);
                                g2d.drawString("就诊时间：" + printRecord.getDiagnoseTime(), 7 + x, 85 + y);

                                drawString(g2d, "治疗方案：" + printRecord.getCure(), 7 + x, 105 + y, 240, 15);
                                g2d.drawString("--------------------------------------------------", 7 + x, 120 + y + height);
                                g2d.setFont(new Font("Default", Font.PLAIN, 20));
                                g2d.drawString("总费用：" + printRecord.getAllInCost()+" 元", 7 + x, 145 + y + height);
                                g2d.drawString("本次付款：" + printRecord.getPay()+" 元", 7 + x, 175 + y + height);
                                g2d.drawString("已收款：" + printRecord.getRecCost()+" 元", 7 + x, 205 + y + height);
                                g2d.setFont(new Font("Default", Font.PLAIN, 14));
                                g2d.drawString("--------------------------------------------------", 7 + x, 215 + y + height);
                                printRecord.setPrintTime(CommUtils.gerTime());
                                g2d.drawString("*打印时间:" + printRecord.getPrintTime() + "*", 7 + x, 230 + y + height);
                                return PAGE_EXISTS;
                            }
                        }
                    , pageFormat);
            //获取默认打印机
            PrinterJob printerJob = PrinterJob.getPrinterJob();
            printerJob.setPageable(book);
            boolean flag = true;
            try {
                printerJob.print();
            }
            catch (PrinterException e) {
                e.printStackTrace();
                System.out.println("打印异常");
                flag = false;
                return 1;
            }
            if(flag){
                logService.addLog("打印收据，内容为："+printRecord.toString());
                printMapper.insertPrintRecord(printRecord);
                return 0;
            }

        } else{
            System.out.println("没法发现打印机服务");
            return 2;
        }
        return 0;
    }
    /**
     * 字符串输出
     * @param graphics2D  画笔
     * @param text     打印文本
     * @param x       打印起点 x 坐标
     * @param y       打印起点 y 坐标
     * @param lineWidth   行宽
     * @param lineHeight  行高
     * @return 返回终点 y 坐标
     */
    private int drawString(Graphics2D graphics2D, String text, int x, int y, int lineWidth, int lineHeight){
        FontMetrics fontMetrics = graphics2D.getFontMetrics();
        if(fontMetrics.stringWidth(text)<lineWidth){
            graphics2D.drawString(text, x, y);
            return y;
        } else{
            char[] chars = text.toCharArray();
            int charsWidth = 0;
            StringBuffer sb = new StringBuffer();
            for (int i=0; i<chars.length; i++){
                if((charsWidth + fontMetrics.charWidth(chars[i]))>lineWidth){
                    graphics2D.drawString(sb.toString(), x, y);
                    sb.setLength(0);
                    y = y + lineHeight;
                    charsWidth = fontMetrics.charWidth(chars[i]);
                    sb.append(chars[i]);
                } else{
                    charsWidth = charsWidth + fontMetrics.charWidth(chars[i]);
                    sb.append(chars[i]);
                }
            }
            if(sb.length()>0){
                graphics2D.drawString(sb.toString(), x, y);
                y = y + lineHeight;
            }
            return y - lineHeight;
        }
    }

    public List<PrintRecord> getPrintRecords(int medicalId){
        return printMapper.getPrintRecordByMedicalId(medicalId);
    }


    private String[] labels = {"姓名:", "性别:", "年龄:", "Phone:", "Chief Complaint:", "Medical History:",
            "Physical Exam:", "Diagnosis:", "Treatment:", "Doctor's Signature:", "Project:", "Total Cost:", "Paid Amount:"};

    private String[] values = {"John Doe", "Male", "30", "123-456-7890", "Fever and headache", "No significant medical history",
            "Normal", "Common cold", "Rest and fluids", "Dr. Smith", "Medical Consultation", "100.0", "50.0"};
    private int cellWidth = 120;
    private int cellHeight = 20;
    private int startX = 50;
    private int startY = 50;
    private int numRows = labels.length;
    private int numCols = 2; // Two columns: label and value



    private void drawTable(Graphics2D g2d) {
        g2d.setFont(new Font("Arial", Font.BOLD, 12));

        for (int row = 0; row < numRows; row++) {
            int x = startX;
            int y = startY + row * cellHeight;

            // Draw label
            g2d.drawString(labels[row], x, y);
            x += cellWidth;

            // Draw value
            g2d.drawString(values[row], x, y);
        }
    }

    public void printRecord(int medicalId){
        if(PrinterJob.lookupPrintServices().length>0){
			/*
        打印格式
       */
            PageFormat pageFormat = new PageFormat();
            //设置打印起点从左上角开始，从左到右，从上到下打印
            pageFormat.setOrientation(PageFormat.PORTRAIT);
			/*
        打印页面格式设置
       */
            Paper paper = new Paper();
            //设置打印宽度（固定，和具体的打印机有关）和高度（跟实际打印内容的多少有关）
            paper.setSize(500, 600);
            //设置打印区域 打印起点坐标、打印的宽度和高度
            paper.setImageableArea(0, 0, 500, 600);
            pageFormat.setPaper(paper);
            //创建打印文档
            Book book = new Book();
            book.append(new Printable() {
                            @Override
                            public int print(Graphics graphics, PageFormat pageFormat, int pageIndex) throws PrinterException {
                                if(pageIndex>0){
                                    return NO_SUCH_PAGE;
                                }

                                Graphics2D g2d = (Graphics2D) graphics;
                                g2d.translate(pageFormat.getImageableX(), pageFormat.getImageableY());

                                drawTable(g2d);
                                return PAGE_EXISTS;
                            }
                        }
                    , pageFormat);
            //获取默认打印机
            PrinterJob printerJob = PrinterJob.getPrinterJob();
            printerJob.setPageable(book);
            boolean flag = true;
            try {
                printerJob.print();
            }
            catch (PrinterException e) {
                e.printStackTrace();
                System.out.println("打印异常");
                flag = false;
            }

        } else{
            System.out.println("没法发现打印机服务");
        }
    }


    private static String generateMedicalRecord() {
        // 生成病历内容的逻辑
        // 这里返回一个示例的病历内容
        return "患者基本情况：\n" +
                "姓名：张三\n" +
                "性别：男\n" +
                "年龄：30\n" +
                "电话：123-456-7890\n" +
                // ... 其他病历内容
                "项目费用：\n" +
                "项目：检查\n" +
                "总费用：100.00\n" +
                "已收费用：50.00\n";
    }
}