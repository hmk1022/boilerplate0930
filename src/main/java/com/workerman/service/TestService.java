package com.workerman.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.workerman.dao.CommonDao;

@Component("testService")
public class TestService {
	
	@Autowired
	private CommonDao commonDao;
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> testList(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("test.testList", param);
	}
	
	
}
