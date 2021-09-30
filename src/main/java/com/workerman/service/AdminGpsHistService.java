package com.workerman.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.dao.CommonDao;
import com.workerman.utils.Utils;
import com.workerman.vo.AdminGpsReqVo;
import com.workerman.vo.ResultVo;

@Service("adminGpsHistService")
public class AdminGpsHistService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	/**
	 * 관리자위치등록
	 * @param adminGpsReqVo
	 * @return
	 * @throws Exception
	 */
	public ResultVo insertAdminGpsHist(AdminGpsReqVo adminGpsReqVo) throws Exception{
		
		ResultVo resutlVo = new ResultVo();
		
		commonDao.insert("adminGpsHist.insertAdminGpsHist", Utils.objectToMap(adminGpsReqVo));
		
		resutlVo.setErrorNone();
		
		return resutlVo;
	}
	
}
