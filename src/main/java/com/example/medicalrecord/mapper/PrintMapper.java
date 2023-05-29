package com.example.medicalrecord.mapper;

import com.example.medicalrecord.bean.PrintRecord;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface PrintMapper {
    @Insert("insert into print_record(medical_id, name, diagnose_time, cure, print_time, all_in_cost, rec_cost) " +
            "values(#{medicalId}, #{name}, #{diagnoseTime}, #{cure}, #{printTime}, #{allInCost}, #{recCost})")
    void insertPrintRecord(PrintRecord printRecord);

    @Select("select * from print_record where medical_id = #{medicalId}")
    List<PrintRecord> getPrintRecordByMedicalId(int medicalId);
}
