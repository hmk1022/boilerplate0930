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
 * 고객사(지점) 관리
 * 
 */
@Service("customerService")
public class CustomerService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	@Autowired 
	private S3UploadService sSUploadService;
	
	
	/******************************************* 고객사 *******************************************/
	
	/**
	 * 고객사 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listCustomer(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("customer.listCustomer", param);
	}
	
	/**
	 * 고객사 조회 count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int listCustomerCnt(Map<String, Object> param) throws Exception{
		return (Integer)commonDao.queryForInt("customer.listCustomerCnt", param);
	}
	
	/**
	 * 고객사 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveCustomer(Map<String, Object> param) throws Exception{
		if(StringUtils.isBlank((String)param.get("customer_no"))){	// check pk-key
			return insertCustomer(param);
		} else {
			return updateCustomer(param);
		}
	}
	
	/**
	 * 고객사 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertCustomer(Map<String, Object> param) throws Exception{
		
		/* get customer_id */
		String customer_id = commonDao.queryForString("customer.getCustomerId", param);
		param.put("customer_id", customer_id);
		int result = commonDao.insert("customer.insertCustomer", param);
		/* upload file */
		fileService.saveImgInfo(param);
		return result;
	}
	
	/**
	 * 고객사 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateCustomer(Map<String, Object> param) throws Exception{
		int result = commonDao.update("customer.updateCustomer", param);
		/* upload file */
		param.put("key_no", param.get("customer_no"));
		fileService.saveImgInfo(param);
		return result;
	}
	
	/**
	 * 고객사 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteCustomer(Map<String, Object> param) throws Exception{
		return commonDao.update("customer.deleteCustomer", param);
	}
	
	/**
	 * 고객사 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectCustomer(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("customer.selectCustomer", param);
	}
	
	/******************************************* 고객사-지점 *******************************************/
	/**
	 * 고객사지점 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listCustomerBranch(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("customerBranch.listCustomerBranch", param);
	}
		
	/**
	 * 고객사지점 조회 count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int listCustomerBranchCnt(Map<String, Object> param) throws Exception{
		return (Integer)commonDao.queryForInt("customerBranch.listCustomerBranchCnt", param);
	}
	
	/**
	 * 고객사지점 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveCustomerBranch(Map<String, Object> param) throws Exception{
		if(StringUtils.isBlank((String)param.get("branch_no"))){	// check pk-key
			return insertCustomerBranch(param);
		} else {
			return updateCustomerBranch(param);
		}
	}
	
	/**
	 * 고객사지점 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertCustomerBranch(Map<String, Object> param) throws Exception{
		
		/* get branch_id */
		String branch_id = commonDao.queryForString("customerBranch.getBranchId", param);
		param.put("branch_id", branch_id);
		
		int result = commonDao.insert("customerBranch.insertCustomerBranch", param);
		/* upload file */
		fileService.saveImgInfo(param);
		return result;
	}
	
	/**
	 * 고객사지점 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateCustomerBranch(Map<String, Object> param) throws Exception{
		int result = commonDao.update("customerBranch.updateCustomerBranch", param);
		/* upload file */
		param.put("key_no", param.get("branch_no"));
		fileService.saveImgInfo(param);
		return result;
	}
	
	/**
	 * 고객사지점 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteCustomerBranch(Map<String, Object> param) throws Exception{
		return commonDao.update("customerBranch.deleteCustomerBranch", param);
	}
	
	/**
	 * 고객사지점 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectCustomerBranch(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("customerBranch.selectCustomerBranch", param);
	}
}