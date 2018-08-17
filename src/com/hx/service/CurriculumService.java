package com.hx.service;

import java.util.List;
import java.util.Map;

import com.hx.pojo.Curriculum;

public interface CurriculumService {
	 List<Curriculum> selectByTime(String time);
	 int deleteByPrimaryKey(Short id);
	 Curriculum selectByPrimaryKey(Short id);
	 int insertSelective(Curriculum record);
	 int updateByPrimaryKeySelective(Curriculum record);
	 List<Curriculum> selectByUserIdAndTime(Map<String, Object> map);
}
