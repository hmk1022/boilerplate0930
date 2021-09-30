package com.workerman.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.aws.S3UploadService;
import com.workerman.config.Constants;
import com.workerman.dao.CommonDao;
import com.workerman.utils.StringUtil;


/**
 * @author dwkwon
 * 입/출고 관리
 * 
 */
@Service("materialBoundService")
public class MaterialBoundService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	@Autowired 
	private S3UploadService sSUploadService;
	
	@Autowired
	private MaterialBoundInoutService materialBoundInoutService;
	
	@Autowired 
	private VendorService vendorService;
	
	/******************************************* 입/출고 *******************************************/
	
	/**
	 * 입/출고 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listMaterialBound(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("material_bound.listMaterialBound", param);
	}
	
	/**
	 * 입/출고 조회 count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int listMaterialBoundCnt(Map<String, Object> param) throws Exception{
		return (Integer)commonDao.queryForInt("material_bound.listMaterialBoundCnt", param);
	}
	
	/**
	 * 입/출고 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> saveMaterialBound(Map<String, Object> param) throws Exception{
		
		// if direct_vendor
		if(StringUtils.equals("direct", (String)param.get("vendor_no"))) {
			param.put("vendor_no", null);
			if(StringUtil.isNotEmpty((String)param.get("direct_vendor"))) {
				// 기존에 동일한 명이 있는 경우.
				param.put("vendor_name", param.get("direct_vendor"));
				Map<String, Object> vendorMap = vendorService.selectVendorName(param);
				if(vendorMap != null) {
					param.put("vendor_no", vendorMap.get("vendor_no"));
				} else {
					param.put("vendor_name", param.get("direct_vendor"));	//
					param.put("work_cate1", "기타출고등록");	//
					param.put("vendor_hp1", "999");	//
					vendorService.saveVendor(param);
					param.put("vendor_no", param.get("key_no"));
				}
			} 
		}
		
		if(StringUtils.isBlank((String)param.get("material_bound_no"))){	// check pk-key
			insertMaterialBound(param);
		} else {
			updateMaterialBound(param);
		}
		return param;
	}
	
	/**
	 * 입/출고 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertMaterialBound(Map<String, Object> param) throws Exception{
		
		/* get material_bound_id */
		String material_bound_id = commonDao.queryForString("material_bound.getMaterialBoundId", param);
		param.put("material_bound_id", material_bound_id);
		int result = commonDao.insert("material_bound.insertMaterialBound", param);
		param.put("material_bound_no", param.get("key_no"));
		
		return result;
	}
	
	
	/**
	 * 입/출고 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateMaterialBound(Map<String, Object> param) throws Exception{
		int result = commonDao.insert("material_bound.updateMaterialBound", param);
		return result;
	}
	
	/**
	 * 구매상태 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateMaterialBoundStat(Map<String, Object> param) throws Exception{
		/* 상태변경 */
		int result = commonDao.update("material_bound.updateMaterialBoundStat", param);
		
		if(result > 0) {
			/* 결제요청*/ 
			String bound_stat = String.valueOf(param.get("bound_stat"));
			
			// TODO: 구매 결제요청 데이터 인서트.!!!!
			// 구매 --> 비용
			if(StringUtils.equals(Constants.PCS_STAT_REQ_PAY, bound_stat)) {
				
			}
			// TODO: 구매 입고 데이터 인서트.!!!! 
			// 구매 --> 입고전표생성
			else if (StringUtils.equals(Constants.PCS_STAT_INCOME, bound_stat)) {
				
			} 
		}
		
		return result;
	}
	
	/**
	 * 입/출고 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteMaterialBound(Map<String, Object> param) throws Exception{
		return commonDao.update("material_bound.deleteMaterialBound", param);
	}
	
	/**
	 * 입/출고 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMaterialBound(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("material_bound.selectMaterialBound", param);
	}
	
	/**
	 * 구매 총금액 update
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updateMaterialBoundSumPrice(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("material_bound.updateMaterialBoundSumPrice", param);
	}
	
	
	/**
	 * 입/출고 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
//	public int insertMaterialBoundDoc(Map<String, Object> param) throws Exception{
//
//		// 요청여부 확인 
//		Long material_bound_no = (Long)commonDao.queryForObjectNoCast("material_bound.getMaterialBoundDocNo", param);
//		
//		int result = 0;
//		if(material_bound_no == null) {
//			/* get material_bound_id */
//			String material_bound_id = commonDao.queryForString("material_bound.getMaterialBoundId", param);
//			param.put("material_bound_id", material_bound_id);
//			
//			result = commonDao.insert("material_bound.insertMaterialBound", param);
//			param.put("material_bound_no", param.get("key_no"));
//		}
//		else {
//			param.put("material_bound_no", material_bound_no);
//		}
//		
//		materialBoundInoutService.insertMaterialBoundInout(param);
//		
//		/* 금액 수정 */
//		updateMaterialBoundSumPrice(param);
//		
//		return result;
//	}
	
	
	
	/**
	 * 입/출고 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertMaterialBoundPcs(Map<String, Object> param) throws Exception{

		// 요청여부 확인 
		Long material_bound_no = (Long)commonDao.queryForObjectNoCast("material_bound.getMaterialBoundPcsNo", param);
		
		int result = 0;
		if(material_bound_no == null) {
			/* get material_bound_id */
			String material_bound_id = commonDao.queryForString("material_bound.getMaterialBoundId", param);
			param.put("material_bound_id", material_bound_id);
			
			result = commonDao.insert("material_bound.insertMaterialBound", param);
			param.put("material_bound_no", param.get("key_no"));
		}
		else {
			param.put("material_bound_no", material_bound_no);
		}
		
		materialBoundInoutService.insertMaterialBoundInout(param);
		
		/* 금액 수정 */
		updateMaterialBoundSumPrice(param);
		
		return result;
	}
}