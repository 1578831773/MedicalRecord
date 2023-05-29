package com.example.medicalrecord.service;

import com.example.medicalrecord.bean.PatientCard;
import com.example.medicalrecord.bean.Record;
import com.example.medicalrecord.mapper.PatientMapper;
import com.example.medicalrecord.mapper.RecordMapper;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PatientService {
    @Autowired
    private PatientMapper patientMapper;
    @Autowired
    private RecordMapper recordMapper;

    public PatientCard getPatientCardByPatientId(int patientId){
        return patientMapper.getPatientByPatientId(patientId);
    }

    public List<PatientCard> getPatientList(String content, String flag, int page){
        if(StringUtils.isNotBlank(content)){
            if(StringUtils.isNotBlank(flag) && StringUtils.isNumeric(flag)){
                if(flag.equals("1")){
                    return patientMapper.getPatientListByName(content, (page-1)*8);
                }else{
                    List<PatientCard> patientCards = new ArrayList<>();
                    PatientCard patientCard = patientMapper.getPatientByPatientId(Integer.parseInt(content));
                    if(patientCard != null){
                        patientCards.add(patientCard);
                    }
                    return patientCards;
                }
            }else{
                return patientMapper.getPatientListByName(content, (page-1)*8);
            }
        }else{
            return patientMapper.getPatientList((page-1)*8);
        }
    }

    public List<Record> getRecordsByPatientId(int page, int patientId){
        return recordMapper.getRecordsByPatientId(patientId, (page-1)*10);
    }

    public int getRecPageCount(int page){
        if(page % 10 == 0){
            return 0;
        }
        int recCounts = patientMapper.getPatientCount() - page * 8;
        if(recCounts <= 0){
            return 0;
        }
        int recPage = recCounts / 8;
        if(recCounts % 8 != 0){
            recPage += 1;
        }
        if(10 - page%10 > recPage){
            return recPage;
        }
        return 10 - page%10;
    }

    public int getRecPageCountForSearch(int page, String content){
        if(page % 10 == 0){
            return 0;
        }
        int recCounts = patientMapper.getPatientCountForSearch(content) - page * 8;
        if(recCounts <= 0){
            return 0;
        }
        int recPage = recCounts / 8;
        if(recCounts % 8 != 0){
            recPage += 1;
        }
        if(10 - page%10 > recPage){
            return recPage;
        }
        return 10 - page%10;
    }

    public int getRecPageCount(int page, int patientId){
        if(page % 10 == 0){
            return 0;
        }
        int recCounts = recordMapper.getRecordsCountByPatientId(patientId) - page * 10;
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
