package com.example.medicalrecord.service;

import com.example.medicalrecord.bean.*;
import com.example.medicalrecord.enums.StatusCode;
import com.example.medicalrecord.mapper.PatientMapper;
import com.example.medicalrecord.mapper.RecordMapper;
import com.example.medicalrecord.utils.CommUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class RecordService {
    @Autowired
    private RecordMapper recordMapper;
    @Autowired
    private PatientMapper patientMapper;
    @Autowired
    private LogService logService;


    @Transactional(rollbackFor = {RuntimeException.class, Error.class})
    public int addRecord(Record record){
        if(record == null){
            return StatusCode.ParamsInvalid.getCode();
        }else if(!StringUtils.isNotBlank(record.getName())){
            return StatusCode.ParamsMissing.getCode();
        }else if(!StringUtils.isNotBlank(record.getSex())){
            return StatusCode.ParamsMissing.getCode();
        }else if(!StringUtils.isNotBlank(record.getPhone())){
            return StatusCode.ParamsMissing.getCode();
        }
        record.setFirstVisitTime(CommUtils.gerTime());
        PatientCard patientCard = new PatientCard(record.getPatientId(), record.getName(), record.getSex(), record.getAge(), record.getPhone());
        if(record.getPatientId() != 0){
            if(patientMapper.ifPatientInfoSameByPatientId(patientCard) == 0){
                patientMapper.addPatient(record);
                logService.addLog("添加新病人为:"+record.getPatientToString());
            }
        }else{
            List<Integer> patientIds = patientMapper.ifPatientInfoSame(patientCard);
            if(patientIds.size() != 0){
                record.setPatientId(patientIds.get(0));
            }else{
                patientMapper.addPatient(record);
                logService.addLog("添加新病人为:"+record.getPatientToString());
            }
        }
        recordMapper.insertRecord(record);
        logService.addLog("添加新病例为:"+record.toString());
        return record.getMedicalId();
    }

    @Transactional(rollbackFor = {RuntimeException.class, Error.class})
    public int updateRecord(Record record){
        if(record == null){
            return StatusCode.ParamsInvalid.getCode();
        }else if(!StringUtils.isNotBlank(record.getName())){
            return StatusCode.ParamsMissing.getCode();
        }else if(!StringUtils.isNotBlank(record.getSex())){
            return StatusCode.ParamsMissing.getCode();
        }else if(!StringUtils.isNotBlank(record.getPhone())){
            return StatusCode.ParamsMissing.getCode();
        }
        record.setFirstVisitTime(CommUtils.gerTime());
        Record yRecord = recordMapper.getRecordByMedicalId(record.getMedicalId());
        patientMapper.updatePatient(record);
        recordMapper.updateRecord(record);
        logService.addLog("修改原病例:"+yRecord.toString()+"为:"+record.toString());
        return record.getMedicalId();
    }

    public List<Record> getRecordList(int page){
        return recordMapper.getRecordList((page-1) * 10);
    }

    public Record getRecordByMedicalId(int medicalId){
        if(medicalId <= 0){
            return null;
        }

        return recordMapper.getRecordByMedicalId(medicalId);
    }

    public List<Record> searchRecord(String content, String searchFlg, int page){
        if(searchFlg.equals("2") && StringUtils.isNumeric(content)){
            Record record = recordMapper.getRecordByMedicalId(Integer.parseInt(content));
            ArrayList<Record> records = new ArrayList<>();
            if(record != null){
                records.add(record);
            }
            return records;
        }else{
            return recordMapper.searchRecord(content, 10 * (page-1));
        }
    }

    public int getRecPageCount(int page){
        if(page % 10 == 0){
            return 0;
        }
        int recCounts = recordMapper.getRecordsCount() - page * 10;
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

    public int getRecPageCountForSearch(int page, String content){
        if(page % 10 == 0){
            return 0;
        }
        int recCounts = recordMapper.getRecordsCountForSearch(content) - page * 10;
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
