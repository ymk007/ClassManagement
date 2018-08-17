package com.hx.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hx.pojo.Curriculum;
@Repository("curriculumMapper")
public interface CurriculumMapper {
    int deleteByPrimaryKey(Short id);

    int insert(Curriculum record);

    int insertSelective(Curriculum record);

    Curriculum selectByPrimaryKey(Short id);

    int updateByPrimaryKeySelective(Curriculum record);

    int updateByPrimaryKey(Curriculum record);
    
    List<Curriculum> selectByUserIdAndTime(Map<String, Object> map);
    
    List<Curriculum> selectByTime(String time);
    
   
}