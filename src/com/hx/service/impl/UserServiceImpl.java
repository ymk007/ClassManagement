package com.hx.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hx.dao.CurriculumMapper;
import com.hx.dao.UserMapper;
import com.hx.pojo.Curriculum;
import com.hx.pojo.User;
import com.hx.service.UserService;
@Service("userService")
public class UserServiceImpl implements UserService {
	@Autowired
	UserMapper userMapper;
	@Autowired
	CurriculumMapper curriculumMapper;
	
	@Override
	public User loginCheck(Map<String, String> map) {
		
		return userMapper.loginCheck(map);
	}

	@Override
	public int changePassword(Map<String, Object> map) {
		
		return userMapper.changePassword(map);
	}

}
