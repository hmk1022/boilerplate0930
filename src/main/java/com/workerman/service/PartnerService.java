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
 * 파트너 관리
 * 
 */
@Service("partnerService")
public class PartnerService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	@Autowired 
	private S3UploadService sSUploadService;
	
	
	/******************************************* 파트너 *******************************************/
	
	/**
	 * 파트너 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listPartner(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("partner.listPartner", param);
	}
	
	/**
	 * 파트너 조회 count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int listPartnerCnt(Map<String, Object> param) throws Exception{
		return (Integer)commonDao.queryForInt("partner.listPartnerCnt", param);
	}
	
	/**
	 * 파트너 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int savePartner(Map<String, Object> param) throws Exception{
		if(StringUtils.isBlank((String)param.get("partner_no"))){	// check pk-key
			return insertPartner(param);
		} else {
			return updatePartner(param);
		}
	}
	
	/**
	 * 파트너 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertPartner(Map<String, Object> param) throws Exception{
		int result = commonDao.insert("partner.insertPartner", param);
		/* upload file */
		fileService.saveImgInfo(param);
		return result;
	}
	
	/**
	 * 파트너 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updatePartner(Map<String, Object> param) throws Exception{
		int result = commonDao.update("partner.updatePartner", param);
		/* upload file */
		param.put("key_no", param.get("partner_no"));
		fileService.saveImgInfo(param);
		return result;
	}
	
	/**
	 * 파트너 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deletePartner(Map<String, Object> param) throws Exception{
		return commonDao.update("partner.deletePartner", param);
	}
	
	/**
	 * 파트너 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectPartner(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("partner.selectPartner", param);
	}
	
}