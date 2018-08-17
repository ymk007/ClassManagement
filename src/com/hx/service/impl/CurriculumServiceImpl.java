package com.hx.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hx.dao.CurriculumMapper;
import com.hx.pojo.Curriculum;
import com.hx.service.CurriculumService;
@Service("curriculumService")
public class CurriculumServiceImpl implements CurriculumService {
	@Autowired
	CurriculumMapper curriculumMapper;
	
	@Override
	public List<Curriculum> selectByTime(String time) {
		
		return curriculumMapper.selectByTime(time);
	}

	@Override
	public int deleteByPrimaryKey(Short id) {
		// TODO Auto-generated method stub
		return curriculumMapper.deleteByPrimaryKey(id);
	}

	@Override
	public Curriculum selectByPrimaryKey(Short id) {
		// TODO Auto-generated method stub
		return curriculumMapper.selectByPrimaryKey(id);
	}

	@Override
	public int insertSelective(Curriculum record) {
		// TODO Auto-generated method stub
		return curriculumMapper.insertSelective(record);
	}

	@Override
	public int updateByPrimaryKeySelective(Curriculum record) {
		// TODO Auto-generated method stub
		return curriculumMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<Curriculum> selectByUserIdAndTime(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return curriculumMapper.selectByUserIdAndTime(map);
	}

}
