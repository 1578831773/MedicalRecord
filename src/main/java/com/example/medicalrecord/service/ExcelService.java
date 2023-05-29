package com.example.medicalrecord.service;

import java.io.File;
import java.util.List;

import com.example.medicalrecord.bean.Record;
import com.example.medicalrecord.mapper.LogMapper;
import com.example.medicalrecord.mapper.RecordMapper;
import com.example.medicalrecord.utils.CommUtils;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ExcelService {
    @Autowired
    private RecordMapper recordMapper;
    @Autowired
    private LogService logService;
    public void getExcels() {
        try {
            WritableWorkbook wwb = null;

            // 创建可写入的Excel工作簿
            String fileName = "D://record_"+ CommUtils.gerTime().substring(0, 10)+".xls";
            System.out.println(fileName);
            File file=new File(fileName);
            if (!file.exists()) {
                file.createNewFile();
            }
            //以fileName为文件名来创建一个Workbook
            wwb = Workbook.createWorkbook(file);

            // 创建工作表
            WritableSheet ws = wwb.createSheet("Test Shee 1", 0);

            //查询数据库中所有的数据
            List<Record> list= recordMapper.getAllRecordList();
            //要插入到的Excel表格的行号，默认从0开始
            Label labelId= new Label(0, 0, "病例编号(medical_id)");//表示第
            Label labelName= new Label(1, 0, "姓名(name)");
            Label labelSex= new Label(2, 0, "性别(sex)");
            Label labelAge= new Label(3, 0, "年龄(age)");
            Label labelPhone= new Label(4, 0, "电话(phone)");
            Label labelTime= new Label(5, 0, "初诊时间(firstVisitTime)");
            Label labelDiagnose= new Label(6, 0, "诊断(diagnose)");
            Label labelCure= new Label(7, 0, "治疗方案(cure)");
            Label labelAllInCost= new Label(8, 0, "总费用(allInCost)");
            Label labelRecCost= new Label(9, 0, "已收费(recCost)");
            Label labelDetail= new Label(10, 0, "备注(detail)");
            ws.addCell(labelId);
            ws.addCell(labelName);
            ws.addCell(labelSex);
            ws.addCell(labelAge);
            ws.addCell(labelPhone);
            ws.addCell(labelTime);
            ws.addCell(labelDiagnose);
            ws.addCell(labelCure);
            ws.addCell(labelAllInCost);
            ws.addCell(labelRecCost);
            ws.addCell(labelDetail);
            for (int i = 0; i < list.size(); i++) {

                Label labelId_i= new Label(0, i+1, list.get(i).getMedicalId()+"");
                Label labelName_i= new Label(1, i+1, list.get(i).getName());
                Label labelSex_i= new Label(2, i+1, list.get(i).getSex());
                Label labelAge_i= new Label(3, i+1, list.get(i).getAge()+"");
                Label labelPhone_i= new Label(4, i+1, list.get(i).getPhone());
                Label labelTime_i= new Label(5, i+1, list.get(i).getFirstVisitTime());
                Label labelDiagnose_i= new Label(6, i+1, list.get(i).getDiagnose());
                Label labelCure_i= new Label(7, i+1, list.get(i).getCure());
                Label labelAllInCost_i= new Label(8, i+1, list.get(i).getAllInCost()+"");
                Label labelRecCost_i= new Label(9, i+1, list.get(i).getRecCost()+"");
                Label labelDetail_i= new Label(10, i+1, list.get(i).getDetail());
                ws.addCell(labelId_i);
                ws.addCell(labelName_i);
                ws.addCell(labelSex_i);
                ws.addCell(labelAge_i);
                ws.addCell(labelPhone_i);
                ws.addCell(labelTime_i);
                ws.addCell(labelDiagnose_i);
                ws.addCell(labelCure_i);
                ws.addCell(labelAllInCost_i);
                ws.addCell(labelRecCost_i);
                ws.addCell(labelDetail_i);
            }

            //写进文档
            wwb.write();
            // 关闭Excel工作簿对象
            System.out.println("数据导出成功!");
            logService.addLog("导出为excel表格，保存为"+fileName);
            wwb.close();

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}