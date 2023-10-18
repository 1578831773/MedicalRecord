package com.example.medicalrecord.service;

import com.example.medicalrecord.bean.PayRecord;
import com.example.medicalrecord.mapper.PayMapper;
import com.example.medicalrecord.mapper.RecordMapper;
import com.example.medicalrecord.utils.CommUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PayService {
    @Autowired
    private PayMapper payMapper;
    @Autowired
    private RecordMapper recordMapper;
    @Autowired
    private LogService logService;

    @Transactional(rollbackFor = {RuntimeException.class, Error.class})
    public int insertPayRecord(PayRecord payRecord){
        if(payRecord == null) {
            return -1;
        }else if (payRecord.getMedicalId() == 0){
            return -1;
        }
        payRecord.setPayTime(CommUtils.gerTime());
        recordMapper.updatePaid(payRecord.getMedicalId(), payRecord.getPay());
        payMapper.addPayRecord(payRecord);
        logService.addLog("编号"+payRecord.getMedicalId()+"病历添加收款记录："+payRecord.toString());
        return 0;
    }

    public List<PayRecord> getPayRecordList(int medicalId){
        return payMapper.getPayRecordList(medicalId);
    }

    @Transactional(rollbackFor = {RuntimeException.class, Error.class})
    public void updatePay(PayRecord payRecord){
        PayRecord yPay = payMapper.getUsedPay(payRecord.getPayId());
        recordMapper.updatePaid(payRecord.getMedicalId(), payRecord.getPay()-yPay.getPay());
        payMapper.updatePay(payRecord);
        logService.addLog("收款记录"+yPay.toString()+"修改为："+payRecord.toString());

    }
}
