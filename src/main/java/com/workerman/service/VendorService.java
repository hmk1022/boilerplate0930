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
 * 거래처 관리
 * 
 */
@Service("vendorService")
public class VendorService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	@Autowired 
	private S3UploadService sSUploadService;
	
	
	/******************************************* 거래처 *******************************************/
	
	/**
	 * 거래처 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listVendor(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("vendor.listVendor", param);
	}
	
	/**
	 * 거래처 조회 count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int listVendorCnt(Map<String, Object> param) throws Exception{
		return (Integer)commonDao.queryForInt("vendor.listVendorCnt", param);
	}
	
	/**
	 * 거래처 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveVendor(Map<String, Object> param) throws Exception{
		if(StringUtils.isBlank((String)param.get("vendor_no"))){	// check pk-key
			return insertVendor(param);
		} else {
			return updateVendor(param);
		}
	}
	
	/**
	 * 거래처 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertVendor(Map<String, Object> param) throws Exception{
		/* get vendor_id */
//		String vendor_id = commonDao.queryForString("vendor.getVendorId", param);
//		param.put("vendor_id", vendor_id);
		
		int result = commonDao.insert("vendor.insertVendor", param);
		/* upload file */
		param.put("files", param.get("files1"));
		fileService.saveImgInfo(param);
		/* upload file */
//		param.put("files", param.get("files2"));
//		fileService.saveImgInfo(param);
		
		return result;
	}
	
	/**
	 * 거래처 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateVendor(Map<String, Object> param) throws Exception{
		int result = commonDao.update("vendor.updateVendor", param);
		
		/* upload file */
		param.put("key_no", param.get("vendor_no"));
		/* upload file */
		param.put("files", param.get("files1"));
		fileService.saveImgInfo(param);
		/* upload file */
//		param.put("files", param.get("files2"));
//		fileService.saveImgInfo(param);
		
		return result;
	}
	
	/**
	 * 거래처 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteVendor(Map<String, Object> param) throws Exception{
		return commonDao.update("vendor.deleteVendor", param);
	}
	
	/**
	 * 거래처 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectVendor(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("vendor.selectVendor", param);
	}
	
	/**
	 * 거래처 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectVendorName(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("vendor.selectVendorName", param);
	}
	
}