package com.example.medicalrecord.service;

import com.example.medicalrecord.bean.Log;
import com.example.medicalrecord.mapper.LogMapper;
import com.example.medicalrecord.utils.CommUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LogService {
    @Autowired
    private LogMapper logMapper;

    public void addLog(String content){
        System.out.println(content);
        Log log = new Log();
        log.setContent(content);
        log.setLogTime(CommUtils.gerTime());
        logMapper.insertLog(log);
    }

    public List<Log> getLogList(int page){
        return logMapper.getLogList((page-1)*10);
    }

    public int getRecPageCount(int page){
        if(page % 10 == 0){
            return 0;
        }
        int recCounts = logMapper.getLogCount() - page * 10;
        if(recCounts <= 0){
            return 0;
        }
        int recPage = recCounts / 10;
        if(recCounts % 10 != 0){
            recPage += 1;
        }

        if(10 - page%10 > recPage){
            return recPage;
        }
        return 10 - page%10;
    }
}
