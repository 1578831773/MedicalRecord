package com.example.medicalrecord.contoller;

import com.example.medicalrecord.bean.PayRecord;
import com.example.medicalrecord.service.MyPrintService;
import com.example.medicalrecord.service.PayService;
import com.example.medicalrecord.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/pay")
public class PayController {
    @Autowired
    private PayService payService;
    @Autowired
    private MyPrintService printTest;
    @Autowired
    private RecordService recordService;

    @PostMapping("/add")
    public ModelAndView addPayRecord(PayRecord payRecord){
        ModelAndView modelAndView = new ModelAndView();
        int code = payService.insertPayRecord(payRecord);
        if(code == 0){
            modelAndView.addObject("msg", "添加成功");
            modelAndView.setViewName("redirect:/pay/list?medicalId="+payRecord.getMedicalId());
        }else{
            modelAndView.addObject("msg", "添加失败。参数错误");
            modelAndView.setViewName("forward:/jsp/detail_2.jsp");
        }
        return modelAndView;
    }

    @GetMapping("/list")
    public ModelAndView getPayRecordList(int medicalId){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("detail", recordService.getRecordByMedicalId(medicalId));
        modelAndView.addObject("payList", payService.getPayRecordList(medicalId));
        modelAndView.addObject("printRecords", printTest.getPrintRecords(medicalId));
        modelAndView.setViewName("forward:/jsp/payRecord.jsp");
        return modelAndView;
    }

    @PostMapping("/update")
    public ModelAndView updatePayRecord(PayRecord payRecord){
        ModelAndView modelAndView = new ModelAndView();
        payService.updatePay(payRecord);
        modelAndView.setViewName("redirect:/pay/list?medicalId="+payRecord.getMedicalId());
        return modelAndView;
    }
}
