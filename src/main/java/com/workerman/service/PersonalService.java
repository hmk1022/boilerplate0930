package com.workerman.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.dao.CommonDao;
import com.workerman.utils.Utils;
import com.workerman.vo.TermsDataVo;
import com.workerman.vo.TermsReqVo;
import com.workerman.vo.TermsResVo;
import com.workerman.vo.TermsVo;

@Service("personalService")
public class PersonalService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	/**
	 * 약관정보조회
	 * @param termsReqVo
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public TermsResVo termsList(TermsReqVo termsReqVo) {
		
		TermsResVo termsResVo = new TermsResVo();
		
		TermsVo termsVo = new TermsVo();
		
		termsVo.setTerms_list(commonDao.queryForList("personal.selectPersonalList"));

		termsVo.setTerms((TermsDataVo)commonDao.queryForObjectNoCast("personal.selectPersonal", Utils.objectToMap(termsReqVo)));
		
		termsResVo.setResult_data(termsVo);
		
		termsResVo.setErrorNone();
		
		return termsResVo;
	}
	
}
