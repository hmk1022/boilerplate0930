package com.workerman.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.aws.S3UploadService;
import com.workerman.dao.CommonDao;
import com.workerman.utils.StringUtil;


/**
 * @author dwkwon
 * 견적서 관리
 * 
 */
@Service("estimateResourceService")
public class EstimateResourceService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	@Autowired 
	private S3UploadService sSUploadService;
	
	
	/******************************************* 견적서 *******************************************/
	
	/**
	 * 견적서 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listEstimateResource(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("estimateResourceResource.listEstimateResource", param);
	}
	
	
	/**
	 * 견적서 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveEstimateResource(Map<String, Object> param) throws Exception{
		if(StringUtil.isBlank(String.valueOf(param.get("resource_no")))){	// check pk-key
			return insertEstimateResource(param);
		} else {
			return updateEstimateResource(param);
		}
	}
	
	/**
	 * 견적서 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertEstimateResource(Map<String, Object> param) throws Exception{
		int result = commonDao.insert("estimateResource.insertEstimateResource", param);
		return result;
	}
	
	/**
	 * 견적서 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateEstimateResource(Map<String, Object> param) throws Exception{
		int result = commonDao.update("estimateResource.updateEstimateResource", param);
		return result;
	}
	
	/**
	 * 견적서 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteEstimateResource(Map<String, Object> param) throws Exception{
		return commonDao.update("estimateResource.deleteEstimateResource", param);
	}
	
	
	
}