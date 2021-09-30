package com.workerman.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.aws.S3UploadService;
import com.workerman.config.Constants;
import com.workerman.dao.CommonDao;


/**
 * @author dwkwon
 * 결제/매출관리 관리
 * 
 */
@Service("paymentService")
public class PaymentService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	
	/******************************************* 결제/매출관리 *******************************************/
	
	/**
	 * 결제/매출관리 조회
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String, Object>> listPayment(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("abc_payment.selectPaymentList", param);
	}
	
	/**
	 * 결제/매출관리 조회 count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int listPaymentCnt(Map<String, Object> param) throws Exception{
		return (Integer)commonDao.queryForInt("abc_payment.selectPaymentListCnt", param);
	}
	
	/**
	 * 결제/매출관리 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int savePayment(Map<String, Object> param) throws Exception{
		if(StringUtils.isBlank((String)param.get("pay_no"))){	// check pk-key
			return insertPayment(param);
		} else {
			return updatePayment(param);
		}
	}
	
	/**
	 * 결제/매출관리 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertPayment(Map<String, Object> param) throws Exception{
		
		int result = commonDao.insert("abc_payment.insertPayment", param);
		/* upload file */
		fileService.saveImgInfo(param);
		return result;
	}
	
	/**
	 * 결제/매출관리 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updatePayment(Map<String, Object> param) throws Exception{
		int result = commonDao.update("abc_payment.updatePayment", param);
		/* upload file */
		param.put("key_no", param.get("pay_no"));
		fileService.saveImgInfo(param);
		return result;
	}
	
	/**
	 * 결제/매출관리 증빙 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updatePaymentApproval(Map<String, Object> param) throws Exception{
		int result = commonDao.update("abc_payment.updatePaymentApproval", param);
//		if(result > 0) {
//			result = commonDao.update("abc_payment.updatePaymentStat", param);
//		}
		return result;
	}
	
	
	/**
	 * 결제/매출관리 증빙 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updatePaymentComplete(Map<String, Object> param) throws Exception{
		int result = commonDao.update("abc_payment.updatePaymentComplete", param);
		return result;
	}
	
	/**
	 * 결제/매출관리 상태 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updatePaymentStat(Map<String, Object> param) throws Exception{
		int result = commonDao.update("abc_payment.updatePaymentStat", param);
		return result;
	}
	
	/**
	 * 결제/매출관리 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deletePayment(Map<String, Object> param) throws Exception{
		return commonDao.update("abc_payment.deletePayment", param);
	}
	
	/**
	 * 결제/매출관리 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectPayment(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("abc_payment.selectPayment", param);
	}
	

	/**
	 * 결제/매출관리 자료 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updatePaymentInfo(Map<String, Object> param) throws Exception{
		int result = commonDao.update("abc_payment.updatePaymentInfo", param);
		return result;
	}
}