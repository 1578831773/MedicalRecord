package com.example.medicalrecord.mapper;

import com.example.medicalrecord.bean.PatientCard;
import com.example.medicalrecord.bean.Record;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface PatientMapper {
    @Insert("insert into patient(name, sex, age, phone) " +
            "values(#{name}, #{sex}, #{age}, #{phone})")
    @Options(useGeneratedKeys = true, keyProperty = "patientId")
    void addPatient(Record record);

    @Update("update patient set name = #{name}, sex = #{sex},  age = #{age}, phone = #{phone} where patient_id = #{patientId}")
    void updatePatient(Record record);

    @Select("select * from patient order by patient_id limit #{s}, 8")
    List<PatientCard> getPatientList(int s);

    @Select("select * from patient where name like concat('%', concat(#{name}, '%')) order by patient_id limit #{s}, 8")
    List<PatientCard> getPatientListByName(String name, int s);

    @Select("select * from patient where patient_id = #{patientId}")
    PatientCard getPatientByPatientId(int patientId);

    @Select("select count(*) from patient")
    int getPatientCount();

    @Select("select count(*) from patient where name like concat('%', concat(#{name}, '%'))")
    int getPatientCountForSearch(String name);

    @Select("select count(*) from patient where patient_id = #{patientId} and name = #{name} and age = #{age} and sex = #{sex} and phone = #{phone}")
    int ifPatientInfoSameByPatientId(PatientCard patientCard);

    @Select("select patient_id from patient where name = #{name} and age = #{age} and sex = #{sex} and phone = #{phone}")
    List<Integer> ifPatientInfoSame(PatientCard patientCard);

}
