package com.workerman.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

import lombok.extern.slf4j.Slf4j;

/**
 * 공통 비지니스 로직
 */

@Slf4j
@SuppressWarnings("unused")
@Configuration
public class BaseService {
	
	@Value("${email.logo}") public String email_logo;
	@Value("${email.logo.foot}") public String email_logo_foot;
	@Value("${work.s3.bucket}") public String s3_bucket;
	@Value("${work.s3.url}") public String s3_url;
	@Value("${upload.temp.dir}") public String temp_dir;
	@Value("${sms.send.phone}") public String sms_send_phone;
	@Value("${address.search.key}") public String address_search_key;
	
	@Autowired
	private Properties systemProp;
	
	@Autowired
	private Environment env;
	
	protected String getMessage(String code) {
		return env.getProperty(code);
	}

	public String getUpladPath() {
		return temp_dir;
	}
	/**
	 * Ajax 공통리턴용
	 * @param input
	 * @return
	 */
	public Map<String, Object> returnResult(String input) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("result", input);
		return result;
	}
	
	/**
	 * 공통 Null 체크용
	 * @param input
	 * @return
	 */
	public boolean isEmpty(String input){
		return input == null || input.equals("");
	}
	
	public boolean isEmpty(int input){
		return input == 0;
	}
	
	public boolean isEmpty(Object input){
		return input == null || input.equals("");
	}
	
	public boolean equals(Object target, Object input) {
		return target != null && input != null && target.equals(input);
	}
	
	/**
	 * 널체크
	 * @param param
	 * @param key
	 * @return
	 */
	public boolean isNull(Map<String, Object> param, String... keys) {
		
		for (String key : keys) {
			if (param == null || param.get(key) == null || param.get(key).equals("")) { 
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 인트형반환
	 * @param param
	 * @param key
	 * @return
	 */
	public int getIntValue(Map<String, Object> param, String key) {
		return Integer.parseInt(param.get(key)+"");
	}
	
	/**
	 * 롱형반환
	 * @param param
	 * @param key
	 * @return
	 */
	public long getLongValue(Map<String, Object> param, String key) {
		return Long.parseLong(param.get(key)+"");
	}
	
	/**
	 * 부울형반환
	 * @param param
	 * @param key
	 * @return
	 */
	public boolean getBooleanValue(Map<String, Object> param, String key) {
		return Boolean.parseBoolean(param.get(key)+"");
	}
	
}
