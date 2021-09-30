package com.workerman.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.dao.CommonDao;
import com.workerman.utils.Utils;
import com.workerman.vo.QuestionReqVo;
import com.workerman.vo.ResultVo;

@Service("contactService")
public class ContactService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	/**
	 * 1:1문의등록
	 * @param questionReqVo
	 * @return
	 */
	public ResultVo addContact(QuestionReqVo questionReqVo) {
		
		ResultVo resultVo = new ResultVo();
		
		commonDao.update("contact.insertContact", Utils.objectToMap(questionReqVo));
		
		resultVo.setErrorNone();
		
		return resultVo;
	}
	
}
