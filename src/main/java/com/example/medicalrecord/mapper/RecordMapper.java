package com.example.medicalrecord.mapper;

import com.example.medicalrecord.bean.Record;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface RecordMapper {


    @Update("update record set paid = paid + #{pay} where medical_id = #{medicalId}")
    void updatePaid(int medicalId, double pay);

    @Insert("insert into record(patient_id, first_visit_time, diagnose, " +
            "cure, all_in_cost, paid, detail, main_suit, history_of_present_illness, previous_history, health_check_up, signature, project) " +
            "values(#{record.patientCard.patientId}, #{record.firstVisitTime}, #{record.medical.diagnose}, " +
            "#{record.medical.cure}, #{record.projectCost.allInCost}, #{record.projectCost.paid}, #{record.detail}, " +
            "#{record.medical.mainSuit}, #{record.medical.historyOfPresentIllness}, #{record.medical.previousHistory}, #{record.medical.healthCheckUp}, #{record.medical.signature}, #{record.projectCost.project})")
    @Options(useGeneratedKeys = true, keyProperty = "medicalId")
    void insertRecord(@Param("record") Record record);

    List<Record> getRecordList(int s);

    List<Record> getAllRecordList();

    List<Record> getDeletedRecordList(int s);

    List<Record> getAllDeletedRecordList();


    Record getRecordByMedicalId(int medicalId);


    @Update("update record set patient_id = #{record.patientCard.patientId}, diagnose =  #{record.medical.diagnose}, " +
            "cure = #{record.medical.cure}, all_in_cost = #{record.projectCost.allInCost}, paid = #{record.projectCost.paid}, detail = #{record.detail}, " +
            "main_suit = #{record.medical.mainSuit}, history_of_present_illness = #{record.medical.historyOfPresentIllness}, previous_history = #{record.medical.previousHistory}, " +
            "health_check_up = #{record.medical.healthCheckUp}, signature = #{record.medical.signature}, project = #{record.projectCost.project} " +
            "where medical_id = #{record.medicalId}")
    void updateRecord(@Param("record") Record record);

    @Update("update record set name = #{name}, cure = #{cure}, all_in_cost = #{allInCost}, paid = #{paid} where medical_id = #{medicalId}")
    void updatePrintMsg(int medicalId, String name, String cure, double allInCost, double paid);


    List<Record> searchRecord(String content, int s);



    @Select("select count(*) from record where status = 0")
    int getRecordsCount();

    @Select("select count(*) from record where status = 1")
    int getDeletedRecordsCount();

    @Select("select count(*) from record a" +
            " left join patient b on a.patient_id = b.patient_id" +
            " where a.first_visit_time like concat('%', concat(#{content}, '%')) or a.diagnose like concat('%', concat(#{content}, '%')) or a.cure like concat('%', concat(#{content}, '%'))" +
            " or a.detail like concat('%', concat(#{content}, '%'))" +
            " or b.name like concat('%', concat(#{content}, '%'))" +
            " or b.sex like  concat('%', concat(#{content}, '%'))" +
            " or b.age like concat('%', concat(#{content}, '%'))" +
            " or b.phone like concat('%', concat(#{content}, '%'))")
    int getRecordsCountForSearch(String content);

    @Update("update record set if_printed = if_printed + 1 where medical_id = #{medicalId}")
    int addPrintCount(int medicalId);

    List<Record> getRecordsByPatientId(int patientId, int s);


    @Select("select count(*)" +
            " from record a" +
            " left join patient b on a.patient_id = b.patient_id" +
            " where a.patient_id = #{patientId}")
    int getRecordsCountByPatientId(int patientId);

    @Update("update record set status=1 where medical_id=#{medicalId}")
    void delete(int medicalId);

    @Update("update record set status=0 where medical_id=#{medicalId}")
    void recover(int medicalId);
}
