package com.workerman.controller.page;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.workerman.controller.BaseController;
import com.workerman.service.CodeService;

@Controller
@RequestMapping(value = "/common/")
public class CommonController extends BaseController{

	@Autowired
	private CodeService codeService;


	/**
	 * @Author : dw.kwon
	 * @Date	: 2021. 05. 27.
	 * @Method Name : list
	 * @return : String
	 * @note : 코드목록 조회
	 */
	@PostMapping(path="code/list/ajax")
	public ResponseEntity<Map<String, Object>> codeListAll(@RequestParam Map<String, Object> param) throws Exception {
		Map<String,Object> returnMap = new LinkedHashMap<String, Object>();

		List<Map<String, Object>> list = codeService.selectCodeAllList();
		
		String pre_code_gb = "";	// 이전 코드구분값 확인.
		
		List<Map<String, Object>> _list = new ArrayList();	
		
		Map<String, Object> code_gb = new HashMap<String, Object>();
		
		for(Map<String, Object> tmp: list) {
			if(pre_code_gb.equals("") || pre_code_gb.equals((String)tmp.get("code_gb"))) {
				_list.add(tmp);
			} else {
				returnMap.put(pre_code_gb, _list);
				_list = new ArrayList();
				_list.add(tmp);	// first item
			}
			pre_code_gb = (String)tmp.get("code_gb");
		}
		
		returnMap.put(pre_code_gb, _list);	// last item
		
		//returnMap.put("data", code_gb);
		return new ResponseEntity<Map<String, Object>>(returnMap, HttpStatus.OK);
	}

	@GetMapping("memory-status")
	public ResponseEntity<Map<String, Object>> getMemoryStatistics() {
	    Map<String,Object> returnMap = new LinkedHashMap<String, Object>();
	    returnMap.put("HeapSize", Runtime.getRuntime().totalMemory());
	    returnMap.put("HeapMaxSize", Runtime.getRuntime().maxMemory());
	    returnMap.put("HeapFreeSize", Runtime.getRuntime().freeMemory());
	    return new ResponseEntity<Map<String, Object>>(returnMap, HttpStatus.OK);
	}
}
