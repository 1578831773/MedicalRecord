package com.example.medicalrecord.contoller;

import com.example.medicalrecord.bean.PatientCard;
import com.example.medicalrecord.bean.PrintRecord;
import com.example.medicalrecord.bean.Record;
import com.example.medicalrecord.service.ExcelService;
import com.example.medicalrecord.service.PrintService;
import com.example.medicalrecord.service.RecordService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("/record")
public class RecordController {
    @Autowired
    private RecordService recordService;
    @Autowired
    private PrintService printTest;
    @Autowired
    private ExcelService excelService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView recordList(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        String pageStr = request.getParameter("page");
        int page = 1;
        if(StringUtils.isNotBlank(pageStr)){
            page = Integer.parseInt(pageStr);
        }
        List<Record> recordList = recordService.getRecordList(page);
        if(recordList.size() == 0){
            page = 1;
        }
        recordList = recordService.getRecordList(page);
        modelAndView.addObject("recordList", recordList);
        modelAndView.addObject("page", page);
        int startPage = 1;
        if(page > 10){
            if(page % 10 == 0){
                startPage = (page / 10 - 1)*10 + 1;
            }else{
                startPage = (page/10)*10+1;
            }
        }
        modelAndView.addObject("startPage", startPage);
        int pageCount = recordService.getRecPageCount(page);
        modelAndView.addObject("pageCount", pageCount);

        modelAndView.setViewName("forward:/jsp/recordList.jsp");
        return modelAndView;
    }

    @PostMapping(value = "/addRecord")
    public ModelAndView addRecord(HttpServletRequest request){
//        System.out.println(recordStr);
//        Record record = JSON.parseObject(recordStr, Record.class);
        ModelAndView modelAndView = new ModelAndView();
        String patientIdStr = request.getParameter("patientId");
        String name = request.getParameter("name");
        String age = request.getParameter("age");
        String sex = request.getParameter("sex");
        String diagnose = request.getParameter("diagnose");
        String cure = request.getParameter("cure");
        String allInCost = request.getParameter("allInCost");
        String recCost = request.getParameter("recCost");
        String phone = request.getParameter("phone");
        String detail = request.getParameter("detail");
        if(StringUtils.isNotBlank(name) && StringUtils.isNotBlank(age) && StringUtils.isNotBlank(allInCost) && StringUtils.isNotBlank(recCost)){
            Record record = new Record(name, sex, Integer.parseInt(age), phone, diagnose, cure,
                    Double.parseDouble(allInCost), Double.parseDouble(recCost), detail);
            int patientId = 0;
            if(StringUtils.isNotBlank(patientIdStr) && StringUtils.isNumeric(patientIdStr)){
                patientId = Integer.parseInt(patientIdStr);
                record.setPatientId(patientId);
            }
            int rel = recordService.addRecord(record);
            if (rel < 0){
                modelAndView.setViewName("forward:/jsp/addRecord.jsp");
            }else{
                modelAndView.setViewName("redirect:/record/detail?medicalId="+rel);
            }
        }else{
            modelAndView.addObject("errorMsg", "参数错误");
            modelAndView.setViewName("forward:/jsp/addRecord.jsp");
        }

        return modelAndView;
    }

    @PostMapping(value = "/add")
    public ModelAndView recordAdd(PatientCard patientCard){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("patient", patientCard);
        modelAndView.setViewName("forward:/jsp/addRecord.jsp");
        return modelAndView;
    }

    @PostMapping(value = "/update")
    public ModelAndView updateRecord(HttpServletRequest request){
//        System.out.println(recordStr);
//        Record record = JSON.parseObject(recordStr, Record.class);
        ModelAndView modelAndView = new ModelAndView();
        String page = request.getParameter("page");
        String medicalId = request.getParameter("medicalId");
        String patientId = request.getParameter("patientId");
        String name = request.getParameter("name");
        String age = request.getParameter("age");
        String sex = request.getParameter("sex");
        String diagnose = request.getParameter("diagnose");
        String cure = request.getParameter("cure");
        String allInCost = request.getParameter("allInCost");
        String recCost = request.getParameter("recCost");
        String phone = request.getParameter("phone");
        String detail = request.getParameter("detail");
        Record record = new Record(name, sex, Integer.parseInt(age), phone, diagnose, cure,
                Double.parseDouble(allInCost), Double.parseDouble(recCost), detail);
        record.setMedicalId(Integer.parseInt(medicalId));
        record.setPatientId(Integer.parseInt(patientId));
        int rel = recordService.updateRecord(record);
        modelAndView.addObject("state", rel);
        modelAndView.addObject("page", Integer.parseInt(page));
        modelAndView.setViewName("redirect:/record/detail?medicalId="+rel);
        return modelAndView;
    }


    @GetMapping(value = "/detail")
    public ModelAndView getRecordDetail(HttpServletRequest request){
        String medicalId = request.getParameter("medicalId");
        String page = request.getParameter("page");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("detail", recordService.getRecordByMedicalId(Integer.parseInt(medicalId)));
        modelAndView.addObject("printRecords", printTest.getPrintRecords(Integer.parseInt(medicalId)));
        if(StringUtils.isNotBlank(page)){
            modelAndView.addObject("page", Integer.parseInt(page));
        }else{
            modelAndView.addObject("page", 1);

        }
        modelAndView.setViewName("forward:/jsp/detail.jsp");
        return modelAndView;
    }

    @GetMapping(value = "/search")
    public ModelAndView search(HttpServletRequest request){
        String pageStr = request.getParameter("page");
        String content = request.getParameter("content");
        String searchFlg = request.getParameter("searchFlg");
        if(!StringUtils.isNotBlank(searchFlg)){
            searchFlg = "1";
        }
        ModelAndView modelAndView = new ModelAndView();
        if(StringUtils.isNotBlank(content)){
            int pageCount = 0;

            int page = 1;
            if(StringUtils.isNotBlank(pageStr)){
                page = Integer.parseInt(pageStr);
            }
            List<Record> recordList = recordService.searchRecord(content, searchFlg, page);
            if(recordList.size() == 0){
                page = 1;
            }
            recordList = recordService.searchRecord(content, searchFlg, page);
            modelAndView.addObject("recordList", recordList);
            modelAndView.addObject("page", page);
            int startPage = 1;
            if(page > 10){
                if(page % 10 == 0){
                    startPage = (page / 10 - 1)*10 + 1;
                }else{
                    startPage = (page/10)*10+1;
                }
            }
            modelAndView.addObject("startPage", startPage);
            if(!(searchFlg.equals("2") && StringUtils.isNumeric(content))){
                modelAndView.addObject("redContent", content);
                pageCount = recordService.getRecPageCountForSearch(page, content);
            }
            modelAndView.addObject("pageCount", pageCount);
            modelAndView.setViewName("forward:/jsp/searchRel.jsp");
        }else{
            modelAndView.setViewName("redirect:/record/list");
        }

        return modelAndView;
    }

    @PostMapping("/print")
    public ModelAndView printRecord(PrintRecord printRecord, int page){
        ModelAndView modelAndView = new ModelAndView();
        printTest.startPrintRecord(printRecord);
        modelAndView.addObject("medicalId", printRecord.getMedicalId());
        modelAndView.addObject("page", page);
        modelAndView.setViewName("redirect:/record/detail");
        return modelAndView;
    }

    @GetMapping("/excel")
    public ModelAndView printRecord(){
        ModelAndView modelAndView = new ModelAndView();
        excelService.getExcels();
        modelAndView.setViewName("redirect:/record/list");
        return modelAndView;
    }

    String concatStr(String[] strings){
        String rel = "";
        if(strings == null){
            return rel;
        }
        for(int i = 0; i < strings.length; i ++){
            rel += strings[i] + ",";
        }
        rel.substring(0, rel.length()-1);
        return rel;
    }

}
