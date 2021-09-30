package com.workerman.controller.rest;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.workerman.controller.BaseController;
import com.workerman.service.AdminGpsHistService;
import com.workerman.service.AdminService;

@RestController
public class SampleRestController extends BaseController{
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private AdminGpsHistService adminGpsHistService;
	
	
	/**
	 * @Author : workerman
	 * @Date	: 2021. 03. 24.
	 * @Method Name : listActivityAdmin
	 * @return : String
	 * @note :워커맨용 알림리스트
	 */
	@PostMapping(path="/api/sample/sample1")
	public String sample(
			@RequestParam Map<String, Object> param,
			Model model
			) throws Exception {
	
		return "/test/sample1";
	}
	
	
	/**
	 * @Author : workerman
	 * @Date	: 2021. 03. 24.
	 * @Method Name : listActivityAdmin
	 * @return : String
	 * @note :워커맨용 알림리스트
	 */
	@GetMapping(path="/api/sample/sample1")
	public String sampleget(
			@RequestParam Map<String, Object> param,
			Model model
			) throws Exception {
		
		/* return test data */
		model.addAttribute("test", "test");
		
		return "/test/sample2";
	}
	
	
	/**
	 * @Author : workerman
	 * @Date	: 2021. 03. 24.
	 * @Method Name : listActivityAdmin
	 * @return : String
	 * @note :워커맨용 알림리스트
	 */
	@PostMapping(path="/gps/upload")
	public ResponseEntity<Map<String, Object>> test(@RequestParam Map<String, Object> param) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		return new ResponseEntity<Map<String, Object>>(returnMap, HttpStatus.OK);
	}
}