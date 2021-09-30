package com.workerman.controller.rest;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.workerman.dao.CommonDao;
import com.workerman.service.BrandService;
import com.workerman.service.TestService;


@RestController
public class TestConroller {
	
	

	@Autowired
	private TestService testService;
	
	
	@GetMapping("/")
	public List<Map<String, Object>> test() {
		
		
		return testService.testList(null);
	}
}
