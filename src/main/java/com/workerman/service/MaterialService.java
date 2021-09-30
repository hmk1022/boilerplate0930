package com.workerman.service;

import java.util.HashMap;
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
 * 자재 관리
 * 
 */
@Service("materialService")
public class MaterialService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	@Autowired 
	private S3UploadService sSUploadService;
	
	
	/******************************************* 자재 *******************************************/
	
	/**
	 * 자재 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listMaterial(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("material.listMaterial", param);
	}
	
	/**
	 * 자재 조회 count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int listMaterialCnt(Map<String, Object> param) throws Exception{
		return (Integer)commonDao.queryForInt("material.listMaterialCnt", param);
	}
	
	/**
	 * 자재 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveMaterial(Map<String, Object> param) throws Exception{
		if(StringUtils.isBlank((String)param.get("material_no"))){	// check pk-key
			return insertMaterial(param);
		} else {
			return updateMaterial(param);
		}
	}
	
	/**
	 * 자재 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertMaterial(Map<String, Object> param) throws Exception{
		/* get material_id */
		String material_id = commonDao.queryForString("material.getMaterialId", param);
		param.put("material_id", material_id);
		
		int result = commonDao.insert("material.insertMaterial", param);
		/* upload file */
		param.put("files", param.get("files"));
		fileService.saveImgInfo(param);
		
		return result;
	}
	
	/**
	 * 자재 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateMaterial(Map<String, Object> param) throws Exception{
		int result = commonDao.update("material.updateMaterial", param);
		
		/* upload file */
		param.put("key_no", param.get("material_no"));
		/* upload file */
		param.put("files", param.get("files"));
		fileService.saveImgInfo(param);
		
		return result;
	}

	/**
	 * 자재 수량 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateMaterialCnt(Map<String, Object> param) throws Exception{
		return commonDao.update("material.updateMaterialCnt", param);
	}
	
	/**
	 * 자재 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteMaterial(Map<String, Object> param) throws Exception{
		return commonDao.update("material.deleteMaterial", param);
	}
	
	/**
	 * 자재 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMaterial(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("material.selectMaterial", param);
	}

	/**
	 * 자재 등록 : 자재요청.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertMaterialDoc(Map<String, Object> param) throws Exception{
		/* get material_id */
		String material_id = commonDao.queryForString("material.getMaterialId", param);
		param.put("material_id", material_id);
		
		int result = commonDao.insert("material.insertMaterialDoc", param);
		
		/* insert image information */
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("add_img_type", Constants.IMG_TYPE_MATERIAL); // image
		imgMap.put("add_key_no", param.get("key_no"));
		imgMap.put("img_type", Constants.IMG_TYPE_MATERIAL_REQ); // image
		imgMap.put("key_no", param.get("key_no"));
		imgMap.put("create_no", param.get("material_req_no"));

		commonDao.insert("imgInfo.insertImgInfoDoc", imgMap);
		
		return result;
	}
}