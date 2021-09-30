package com.workerman.service;

import java.util.Collections;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.workerman.vo.AddressSearchReqVo;
import com.workerman.vo.AddressSearchResVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("commonService")
public class CommonService extends BaseService {

//	@Autowired
//	private CommonDao commonDao;
	
	@Autowired
	private RestService restService;
	
	/**
	 * 주소검색
	 * @param addressSearchReqVo
	 * @return
	 * @throws Exception
	 */
	public AddressSearchResVo selectAddress(AddressSearchReqVo addressSearchReqVo) throws Exception {
		
		AddressSearchResVo addressSearchResVo = new AddressSearchResVo();
		
		MultiValueMap<String, Object> params = new LinkedMultiValueMap<String, Object>(); // 반드시 MultiValueMap타입으로 보내야 파라메타가 전송된다.
		params.add("confmKey", address_search_key);
		params.add("currentPage", addressSearchReqVo.getStart_p());
		params.add("countPerPage", addressSearchReqVo.getCount());
		params.add("keyword", addressSearchReqVo.getKeyword());
		params.add("resultType", "json");
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON)); // 리턴받을타입
		httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED); // 전송하는파라메타타입
		
		ResponseEntity<?> result = restService.post("http://www.juso.go.kr/addrlink/addrLinkApi.do", httpHeaders, params, Map.class);
		
		log.debug("@ API CALL RESULT : "+result.getBody().toString());
		
		addressSearchResVo.setErrorNone();
		
		addressSearchResVo.setResult_data(result.getBody());
		
		return addressSearchResVo;
		
	}
	
	
	
}
