package com.workerman.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.dao.CommonDao;
import com.workerman.vo.FaqListVo;
import com.workerman.vo.FaqResVo;

@Service("faqService")
public class FaqService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	/**
	 * FAQ목록
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public FaqResVo faqList(){
		
		FaqResVo faqResVo = new FaqResVo();
		
		FaqListVo faqListVo = new FaqListVo(); 
		
		faqListVo.setList(commonDao.queryForList("faq.selectFaqList"));
		
		faqResVo.setResult_data(faqListVo);
		
		faqResVo.setErrorNone();
		
		return faqResVo;
	}
	
	
	
}
