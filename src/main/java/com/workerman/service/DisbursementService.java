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
 * 지출결의서 관리
 * 
 */
@Service("disbursementService")
public class DisbursementService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	
	/******************************************* 지출결의서 *******************************************/
	
	/**
	 * 지출결의서 조회
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String, Object>> listDisbursement(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("disbursement.listDisbursement", param);
	}
	
	/**
	 * 지출결의서 조회 count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int listDisbursementCnt(Map<String, Object> param) throws Exception{
		return (Integer)commonDao.queryForInt("disbursement.listDisbursementCnt", param);
	}
	
	/**
	 * 지출결의서 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveDisbursement(Map<String, Object> param) throws Exception{
		if(StringUtils.isBlank((String)param.get("disb_no"))){	// check pk-key
			return insertDisbursement(param);
		} else {
			return updateDisbursement(param);
		}
	}
	
	/**
	 * 지출결의서 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertDisbursement(Map<String, Object> param) throws Exception{
		
		/* get disb_id */
		String disb_id = commonDao.queryForString("disbursement.getDisbursementId", param);
		param.put("disb_id", disb_id);
		
		int result = commonDao.insert("disbursement.insertDisbursement", param);
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
	public int updateDisbursement(Map<String, Object> param) throws Exception{
		int result = commonDao.update("disbursement.updateDisbursement", param);
		/* upload file */
		param.put("key_no", param.get("disb_no"));
		fileService.saveImgInfo(param);
		return result;
	}
	
	/**
	 * 지출결의서 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteDisbursement(Map<String, Object> param) throws Exception{
		return commonDao.update("disbursement.deleteDisbursement", param);
	}
	
	/**
	 * 지출결의서 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectDisbursement(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("disbursement.selectDisbursement", param);
	}
	
	
}