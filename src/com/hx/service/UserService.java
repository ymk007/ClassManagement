package com.hx.service;

import java.util.List;
import java.util.Map;

import com.hx.pojo.Curriculum;
import com.hx.pojo.User;

public interface UserService {
	  User loginCheck(Map<String, String> map);
	  int changePassword (Map<String, Object> map);
	 
}
