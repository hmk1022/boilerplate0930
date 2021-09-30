package com.workerman.service;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.config.Constants;
import com.workerman.dao.CommonDao;


/**
 * @author dwkwon
 * 비용확인 관리
 * 
 */
@Service("expensesConfirmService")
public class ExpensesConfirmService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private ExpensesService expensesService;
	
	/**
	 * 비용확인 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveExpensesConfirm(Map<String, Object> param) throws Exception{
		int result = 0 ;
		result = insertExpensesConfirm(param);
		if(result > 0) {
			param.put("exp_stat", param.get("pay_scope"));
			
			// 결제요청일 변경(일부결제일 경우)
			if(!StringUtils.isBlank((String)param.get("pay_next_date")) 
					&& StringUtils.equals((String)param.get("pay_scope"), Constants.PAY_SCOPE_PART)) {
				param.put("pay_req_date", param.get("pay_next_date"));
			}
			expensesService.updateExpStat(param);
		}
		return result;
	}
	
	/**
	 * 비용확인 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertExpensesConfirm(Map<String, Object> param) throws Exception{
		int result = commonDao.insert("expenses_confirm.insertExpensesConfirm", param);
		return result;
	}
	
}