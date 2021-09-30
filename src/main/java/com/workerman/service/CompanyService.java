package com.workerman.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.workerman.commons.CommonCode;
import com.workerman.dao.CommonDao;
import com.workerman.utils.Utils;

@Service("companyService")
public class CompanyService extends BaseService {

	@Autowired
	private CommonDao commonDao;

	/**
	 * 업체목록조회
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCompanyList(){
		return commonDao.queryForList("company.selectCompanyList");
	}
}
