package com.example.medicalrecord.mapper;

import com.example.medicalrecord.bean.Log;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface LogMapper {
    @Insert("insert into sys_log(log_time, content) values(#{logTime}, #{content})")
    void insertLog(Log log);


    @Select("select * from sys_log order by log_id desc limit #{s}, 10")
    List<Log> getLogList(int s);

    @Select("select count(*) from sys_log")
    int getLogCount();
}
