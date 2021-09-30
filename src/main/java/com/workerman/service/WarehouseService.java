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
 * 물류센터 관리
 * 
 */
@Service("warehouseService")
public class WarehouseService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	@Autowired 
	private S3UploadService sSUploadService;
	
	
	/******************************************* 물류센터 *******************************************/
	
	/**
	 * 물류센터 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listWarehouse(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("material.listMaterial", param);
	}
	
	/**
	 * 물류센터 조회 count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int listWarehouseCnt(Map<String, Object> param) throws Exception{
		return (Integer)commonDao.queryForInt("material.listMaterialCnt", param);
	}
	
	/**
	 * 물류센터 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveWarehouse(Map<String, Object> param) throws Exception{
		if(StringUtils.isBlank((String)param.get("material_no"))){	// check pk-key
			return insertWarehouse(param);
		} else {
			return updateWarehouse(param);
		}
	}
	
	/**
	 * 물류센터 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertWarehouse(Map<String, Object> param) throws Exception{
		int result = commonDao.insert("material.insertWarehouse", param);
		return result;
	}
	
	/**
	 * 물류센터 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateWarehouse(Map<String, Object> param) throws Exception{
		int result = commonDao.update("material.updateWarehouse", param);
		return result;
	}
	
	/**
	 * 물류센터 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteWarehouse(Map<String, Object> param) throws Exception{
		return commonDao.update("material.deleteWarehouse", param);
	}
	
	/**
	 * 물류센터 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectWarehouse(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("material.selectWarehouse", param);
	}
	
}