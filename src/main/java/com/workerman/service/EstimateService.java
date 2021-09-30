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
 * 견적서 관리
 *
 */
@Service("estimateService")
public class EstimateService extends BaseService {

	@Autowired
	private CommonDao commonDao;

	@Autowired
	private EstimateResourceService estimateResourceService;


	/******************************************* 견적서 *******************************************/

	/**
	 * 견적서 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listEstimate(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("estimate.listEstimate", param);
	}
	
//	/** 
//	 * 견적서 저장
//	 * @param param
//	 * @return
//	 * @throws Exception
//	 */
//	public int saveEstimate(Map<String, Object> param) throws Exception{
//		if(StringUtils.isBlank((String)param.get("estimate_no"))){	// check pk-key
//			return insertEstimate(param);
//		} else {
//			return updateEstimate(param);
//		}
//	}

	/**
	 * 견적서 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveEstimate(Map<String, Object> param) throws Exception{

		int result = 0;
		Map<String, Object> estimateDataMap = commonDao.queryForObject("estimate.selectEstimate", param);
		if(estimateDataMap == null || estimateDataMap.isEmpty()){
			result = commonDao.insert("estimate.insertEstimate", param);
			param.put("estimate_no", param.get("key_no"));
		}else {
			param.put("estimate_no", estimateDataMap.get("estimate_no"));
		}

		/* resource 등록 */
		estimateResourceService.saveEstimateResource(param);

		return result;
	}

//	/**
//	 * 견적서 수정
//	 * @param param
//	 * @return
//	 * @throws Exception
//	 */
//	public int updateEstimate(Map<String, Object> param) throws Exception{
//		int result = commonDao.update("estimate.updateEstimate", param);
//		return result;
//	}

	/**
	 * 견적서 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteEstimate(Map<String, Object> param) throws Exception{
		return commonDao.update("estimate.deleteEstimate", param);
	}

	/**
	 * 견적서 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectEstimate(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("estimate.selectEstimate", param);
	}

	/**
	 * 견적서 pop 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectPopEstimate(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("estimatePop.selectPopEstimate", param);
//	estimatePop은 xml의 namespace와 같아야 한다..
	}
	
	// pop 견적 상세 조회
	public List<Map<String, Object>> listEstimateDetail(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("estimatePop.listEstimateDetail", param);
	}

	public List<Map<String, Object>> selectPopEstimatePrice(Map<String, Object> param) throws Exception{
		return commonDao.queryForList("estimatePop.selectPopEstimatePrice", param);
	}
	
	// pop 견적서 작업 리스트
	public List<Map<String, Object>> selectPopEstimateList(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("estimatePop.selectPopEstimateList", param);
	}
	// pop 견적서 상세 부모, 자식 견적 각각의 금액합
	public List<Map<String, Object>> listEstimatePrice(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("estimatePop.listEstimatePrice", param);
	}
	
	public Map<String, Object> selectCurrentAuthor(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("estimatePop.selectCurrentAuthor", param);
	}
	// 견적 총합
	public Map<String, Object> estTotalPrice(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("reportIn.estTotalPrice", param);
	}
	// 상세견적들의 각각 금액 총합
	public List<Map<String, Object>> selectListPrice(Map<String, Object> param) throws Exception{
		return commonDao.queryForList("estimatePop.selectListPrice", param);
	}
	
	
	/**
	 * 견적서 버전별 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEstimateVersionList(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("estimate.selectEstimateVersionList", param);
	}

	/**
	 * 견적서 버전 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int getEstimateVersion(Map<String, Object> param) throws Exception{
		return commonDao.queryForInt("estimate.getEstimateVersion", param);
	}


}