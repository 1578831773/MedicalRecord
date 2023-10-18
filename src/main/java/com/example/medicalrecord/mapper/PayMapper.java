package com.example.medicalrecord.mapper;

import com.example.medicalrecord.bean.PayRecord;
import org.apache.ibatis.annotations.*;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Mapper
public interface PayMapper {
    @Insert("insert into pay_record(pay, detail, pay_time, medical_id) values(#{payRecord.pay}, #{payRecord.detail}, #{payRecord.payTime}, #{payRecord.medicalId})")
    @Options(useGeneratedKeys = true, keyProperty = "payId")
    void addPayRecord(@Param("payRecord") PayRecord payRecord);

    @Select("select * from pay_record where medical_id = #{medicalId}")
    List<PayRecord> getPayRecordList(int medicalId);

    @Update("update pay_record set pay = #{payRecord.pay}, detail = #{payRecord.detail} where pay_id = #{payRecord.payId}")
    void updatePay(@Param("payRecord") PayRecord payRecord);

    @Select("select * from pay_record where pay_id=#{payId}")
    PayRecord getUsedPay(int payId);
}
