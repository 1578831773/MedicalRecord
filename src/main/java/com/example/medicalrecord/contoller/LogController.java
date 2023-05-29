package com.example.medicalrecord.contoller;


import com.example.medicalrecord.bean.Log;
import com.example.medicalrecord.service.LogService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("/log")
public class LogController {
    @Autowired
    private LogService logService;


    @GetMapping("/list")
    public ModelAndView getLogList(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        String pageStr = request.getParameter("page");
        int page = 1;
        if(StringUtils.isNumeric(pageStr)){
            page = Integer.parseInt(pageStr);
        }
        List<Log> logList = logService.getLogList(page);
        if(logList.size() == 0){
            page = 1;
            logList = logService.getLogList(1);
        }
        int recPage = logService.getRecPageCount(page);
        modelAndView.addObject("page", page);
        modelAndView.addObject("logList", logList);
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
        modelAndView.setViewName("forward:/jsp/logList.jsp");
        return modelAndView;
    }
}
