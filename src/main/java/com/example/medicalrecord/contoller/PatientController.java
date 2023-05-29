package com.example.medicalrecord.contoller;

import com.example.medicalrecord.bean.PatientCard;
import com.example.medicalrecord.bean.Record;
import com.example.medicalrecord.service.PatientService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("/patient")
public class PatientController {
    @Autowired
    private PatientService patientService;

    @GetMapping("/list")
    public ModelAndView getPatientList(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        String content = request.getParameter("content");
        String flag = request.getParameter("flag");
        String pageStr = request.getParameter("page");
        int page = 1;
        if(StringUtils.isNumeric(pageStr)){
            page = Integer.parseInt(pageStr);
        }
        List<PatientCard> patientCards = patientService.getPatientList(content, flag, page);
        if(patientCards.size() == 0){
            page = 1;
            patientCards = patientService.getPatientList(content, flag, page);
        }
        modelAndView.addObject("patientList", patientCards);
        int recPage = 0;
        if(StringUtils.isNotBlank(content)){
            if(StringUtils.isNotBlank(flag) && StringUtils.isNumeric(flag)){
                if(flag.equals("1")){
                    recPage = patientService.getRecPageCountForSearch(page, content);
                }
            }else{
                recPage = patientService.getRecPageCountForSearch(page, content);
            }
        }else {
            recPage = patientService.getRecPageCount(page);
        }
        modelAndView.addObject("content", content);
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
        modelAndView.addObject("pageCount", recPage);
        modelAndView.setViewName("forward:/jsp/patientList.jsp");
        return modelAndView;
    }

    @GetMapping("/records")
    public ModelAndView getPatientRecords(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        String pageStr = request.getParameter("page");
        String patientId = request.getParameter("patientId");
        if(!StringUtils.isNotBlank(patientId) || !StringUtils.isNumeric(patientId)){
            modelAndView.setViewName("redirect:/patient/list");
        }else{
            int page = 1;
            if(StringUtils.isNotBlank(pageStr)){
                page = Integer.parseInt(pageStr);
            }
            List<Record> recordList = patientService.getRecordsByPatientId(page, Integer.parseInt(patientId));
            if(recordList.size() == 0){
                page = 1;
            }
            recordList = patientService.getRecordsByPatientId(page, Integer.parseInt(patientId));
            modelAndView.addObject("patient", patientService.getPatientCardByPatientId(Integer.parseInt(patientId)));
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
            int pageCount = patientService.getRecPageCount(page, Integer.parseInt(patientId));
            modelAndView.addObject("pageCount", pageCount);
            modelAndView.setViewName("forward:/jsp/patientRecords.jsp");
        }

        return modelAndView;
    }
}
