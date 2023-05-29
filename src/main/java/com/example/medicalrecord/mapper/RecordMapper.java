package com.example.medicalrecord.mapper;

import com.example.medicalrecord.bean.Record;
import com.example.medicalrecord.bean.ToothView;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface RecordMapper {
    @Insert("insert into record(patient_id, first_visit_time, diagnose, " +
            "cure, all_in_cost, rec_cost, detail) " +
            "values(#{patientId}, #{firstVisitTime}, #{diagnose}, " +
            "#{cure}, #{allInCost}, #{recCost}, #{detail})")
    @Options(useGeneratedKeys = true, keyProperty = "medicalId")
    void insertRecord(Record record);


    @Select("select a.*, b.*" +
            " from record a" +
            " left join patient b on a.patient_id = b.patient_id" +
            " order by a.medical_id desc limit #{s}, 10")
    List<Record> getRecordList(int s);


    @Select("select a.*, b.*" +
            " from record a" +
            " left join patient b on a.patient_id = b.patient_id" +
            " order by a.medical_id")
    List<Record> getAllRecordList();

    @Select("select a.*, b.* from record a" +
            " left join patient b on a.patient_id = b.patient_id" +
            " where a.medical_id = #{medicalId}")
    Record getRecordByMedicalId(int medicalId);

    @Update("update record set diagnose = #{diagnose}, cure = #{cure}, all_in_cost = #{allInCost}, rec_cost = #{recCost}, " +
            "detail = #{detail} where medical_id = #{medicalId}")
    void updateRecord(Record record);

    @Select("select a.*, b.* from record a" +
            " left join patient b on a.patient_id = b.patient_id" +
            " where a.diagnose like concat('%', concat(#{content}, '%')) or a.cure like concat('%', concat(#{content}, '%'))" +
            " or a.detail like concat('%', concat(#{content}, '%'))" +
            " or b.name like concat('%', concat(#{content}, '%'))" +
            " or b.sex like  concat('%', concat(#{content}, '%'))" +
            " or b.age like concat('%', concat(#{content}, '%'))" +
            " or b.phone like concat('%', concat(#{content}, '%'))" +
            " order by a.medical_id desc limit #{s}, 10")
    List<Record> searchRecord(String content, int s);



    @Select("select count(*) from record")
    int getRecordsCount();

    @Select("select count(*) from record a" +
            " left join patient b on a.patient_id = b.patient_id" +
            " where a.diagnose like concat('%', concat(#{content}, '%')) or a.cure like concat('%', concat(#{content}, '%'))" +
            " or a.detail like concat('%', concat(#{content}, '%'))" +
            " or b.name like concat('%', concat(#{content}, '%'))" +
            " or b.sex like  concat('%', concat(#{content}, '%'))" +
            " or b.age like concat('%', concat(#{content}, '%'))" +
            " or b.phone like concat('%', concat(#{content}, '%'))")
    int getRecordsCountForSearch(String content);

    @Update("update record set if_printed = if_printed + 1 where medical_id = #{medicalId}")
    int addPrintCount(int medicalId);

    @Select("select *" +
            " from record" +
            " where patient_id = #{patientId}" +
            " order by medical_id desc limit #{s}, 10")
    List<Record> getRecordsByPatientId(int patientId, int s);


    @Select("select count(*)" +
            " from record a" +
            " left join patient b on a.patient_id = b.patient_id" +
            " where a.patient_id = #{patientId}")
    int getRecordsCountByPatientId(int patientId);
}
