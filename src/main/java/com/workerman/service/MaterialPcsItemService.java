package com.workerman.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.aws.S3UploadService;
import com.workerman.config.Constants;
import com.workerman.dao.CommonDao;
import com.workerman.utils.StringUtil;


/**
 * @author dwkwon
 * 구매자재 관리
 * 
 */
@Service("materialPcsItemService")
public class MaterialPcsItemService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	@Autowired 
	private S3UploadService sSUploadService;

	@Autowired 
	private MaterialPcsService materialPcsService;
	
	/******************************************* 구매자재 *******************************************/
	
	/**
	 * 구매자재 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listMaterialPcsItem(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("material_pcs_item.listMaterialPcsItem", param);
	}
	
	/**
	 * 구매자재 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveMaterialPcsItem(Map<String, Object> param) throws Exception{
		
		int result = insertMaterialPcsItem(param);
		fileService.saveImgInfo(param);
		
		/* 자재총액 update */
		materialPcsService.updateMaterialPcsSumPrice(param);
		
		return result;
	}
	
	/**
	 * 구매자재 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertMaterialPcsItem(Map<String, Object> param) throws Exception{
		int result = commonDao.insert("material_pcs_item.insertMaterialPcsItem", param);
		return result;
	}
	
	
	/**
	 * 구매자재 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteMaterialPcsItem(Map<String, Object> param) throws Exception{
		return commonDao.update("material_pcs_item.deleteMaterialPcsItem", param);
	}
	
	
	/**
	 * 구매자재 상태변경
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateMaterialPcsItemStat(Map<String, Object> param) throws Exception{
		
		String[] material_pcs_item_no_arr = StringUtil.split((String)param.get("material_pcs_item_no_str"), "^");
		
		int result = 0;
		for(String material_pcs_item_no : material_pcs_item_no_arr) {
			param.put("material_pcs_item_no", material_pcs_item_no);
			commonDao.update("material_pcs_item.updateMaterialPcsItemStat", param);
			
			/* 구매 */
			if(StringUtil.equals(Constants.REQ_STAT_PCS, (String)param.get("req_stat"))) {
				Map<String, Object> pcsMap = new HashMap<String, Object>();
				// 내일 여기부터!!!!!!!
				//materialPcsService.insertMaterialPcs(param);	
			}
			/* 출고 */
			else if(StringUtil.equals(Constants.REQ_STAT_PCS, (String)param.get("req_stat"))) {

			}
			
			result++;
		}
		return result;
	}
	
	
	/**
	 * 구매자재 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertMaterialPcsItemDoc(Map<String, Object> param) throws Exception{
		int result = commonDao.insert("material_pcs_item.insertMaterialPcsItem", param);
		return result;
	}	
}