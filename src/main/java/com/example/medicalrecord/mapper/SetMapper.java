package com.example.medicalrecord.mapper;

import com.example.medicalrecord.bean.Cure;
import com.example.medicalrecord.bean.Diagnose;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface SetMapper {

    @Insert("insert into diagnose(diagnose) values(#{diagnose})")
    @Options(useGeneratedKeys = true, keyProperty = "diagnoseId")
    void addDiagnose(Diagnose diagnose);

    @Select("select * from diagnose where if_delete = 0")
    List<Diagnose> getDiagnoseList();

    @Insert("insert into cure(cure) values(#{cure})")
    @Options(useGeneratedKeys = true, keyProperty = "cureId")
    void addCure(Cure cure);

    @Select("select * from cure where if_delete = 0")
    List<Cure> getCureList();

}
