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
 * 자재요청 관리
 * 
 */
@Service("materialDocService")
public class MaterialDocService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	@Autowired 
	private S3UploadService sSUploadService;
	
	@Autowired
	private MaterialReqService materialReqService;
	
	/******************************************* 자재요청 *******************************************/
	
	/**
	 * 자재요청 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listMaterialDoc(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("material_doc.listMaterialDoc", param);
	}
	
	/**
	 * 자재요청 조회 count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int listMaterialDocCnt(Map<String, Object> param) throws Exception{
		return (Integer)commonDao.queryForInt("material_doc.listMaterialDocCnt", param);
	}
	
	/**
	 * 자재요청 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> saveMaterialDoc(Map<String, Object> param) throws Exception{
		if(StringUtils.isBlank((String)param.get("material_doc_no"))){	// check pk-key
			insertMaterialDoc(param);
		} else {
			updateMaterialDoc(param);
		}
		return param;
	}
	
	/**
	 * 자재요청 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertMaterialDoc(Map<String, Object> param) throws Exception{
		
		/* get material_doc_id */
		String material_doc_id = commonDao.queryForString("material_doc.getMaterialDocId", param);
		param.put("material_doc_id", material_doc_id);
		
		int result = commonDao.insert("material_doc.insertMaterialDoc", param);
		return result;
	}
	
	/**
	 * 자재요청 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateMaterialDoc(Map<String, Object> param) throws Exception{
		int result = commonDao.update("material_doc.updateMaterialDoc", param);
		return result;
	}
	
	/**
	 * 자재산태 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateDocStat(Map<String, Object> param) throws Exception{
		int result = commonDao.update("material_doc.updateDocStat", param);
		return result;
	}
	
	/**
	 * 자재요청 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteMaterialDoc(Map<String, Object> param) throws Exception{
		return commonDao.update("material_doc.deleteMaterialDoc", param);
	}
	
	/**
	 * 자재요청 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMaterialDoc(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("material_doc.selectMaterialDoc", param);
	}
	
}