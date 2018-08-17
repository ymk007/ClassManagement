package com.hx.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hx.pojo.User;
@Repository("userMapper")
public interface UserMapper {
    int deleteByPrimaryKey(Short userId);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Short userId);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    User loginCheck(Map<String, String> map);
    int changePassword (Map<String, Object> map);
}