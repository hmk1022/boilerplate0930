package com.workerman.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.workerman.dao.CommonDao;
import com.workerman.utils.StringUtil;


/**
 * @author dwkwon
 * 지출결의서 관리
 * 
 */
@Service("expensesService")
public class ExpensesService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private MaterialPcsService materialPcsService;
	
	/******************************************* 지출결의서 *******************************************/
	
	/**
	 * 지출결의서 조회
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String, Object>> listExpenses(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("expenses.listExpenses", param);
	}
	
	/**
	 * 지출결의서 조회 count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int listExpensesCnt(Map<String, Object> param) throws Exception{
		return (Integer)commonDao.queryForInt("expenses.listExpensesCnt", param);
	}
	
	/**
	 * 지출결의서 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveExpenses(Map<String, Object> param) throws Exception{
		if(StringUtils.isBlank((String)param.get("exp_no"))){	// check pk-key
			return insertExpenses(param);
		} else {
			return updateExpenses(param);
		}
	}
	
	/**
	 * 지출결의서 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertExpenses(Map<String, Object> param) throws Exception{
		
		commonDao.insert("expenses.getExpensesId", param);
		
		/* get expenses_id */
		String exp_id = commonDao.queryForString("expenses.getExpensesId", param);
		param.put("exp_id", exp_id);
		
		int result = commonDao.insert("expenses.insertExpenses", param);
		/* upload file */
		fileService.saveImgInfo(param);
		return result;
	}
	
	/**
	 * 지출결의서 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateExpenses(Map<String, Object> param) throws Exception{
		int result = commonDao.update("expenses.updateExpenses", param);
		/* upload file */
		param.put("key_no", param.get("exp_no"));
		fileService.saveImgInfo(param);
		return result;
	}
	
	/**
	 * 지출결의서 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteExpenses(Map<String, Object> param) throws Exception{
		return commonDao.update("expenses.deleteExpenses", param);
	}
	
	/**
	 * 지출결의서 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectExpenses(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("expenses.selectExpenses", param);
	}
	
	/**
	 * 비용 반려
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int updateExpStat(Map<String, Object> param) throws Exception{
		int result = commonDao.update("expenses.updateExpStat", param);
		
		if(result > 0) {
			// 상태저장 후 구매 금액
			Map<String, Object> mapExp = commonDao.queryForObject("expenses.selectExpenses", param);
			
			if(StringUtil.equals("03", (String)mapExp.get("exp_stat"))	// 결제완료
				&& mapExp.get("material_pcs_no") != null // 구매번호
				//&& 	!StringUtil.isBlank((String)mapExp.get("material_pcs_item_no")) // 구매자재번호
				) {
				// TODO : 비용결제 후 구매 결제완료 상태 변경(구매 상태가 각 자재별인지 확인 필요함.)
				param.put("pcs_stat", "03"); // 구매 결제완료 처리
				param.put("material_pcs_no", mapExp.get("material_pcs_no")); // 구매 번호
				commonDao.update("material_pcs.updateMaterialPcsStat", param);
			}
		}
		return result;
	}
	
	
	/**
	 * 비용 구매 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertExpensesPcs(Map<String, Object> param) throws Exception{
		
		//commonDao.insert("expenses.getExpensesId", param);
		
		/* get expenses_id */
		String exp_id = commonDao.queryForString("expenses.getExpensesId", param);
		param.put("exp_id", exp_id);
		
		int result = commonDao.insert("expenses.insertExpensesPcs", param);
		/* upload file */
//		fileService.saveImgInfo(param);
		return result;
	}
}