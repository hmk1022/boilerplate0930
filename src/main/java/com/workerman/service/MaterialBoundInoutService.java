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
 * 입/출고전표 관리
 * 
 */
@Service("materialBoundInoutService")
public class MaterialBoundInoutService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	@Autowired 
	private S3UploadService sSUploadService;

	@Autowired 
	private MaterialService materialService;
	
	/******************************************* 입/출고전표 *******************************************/
	
	/**
	 * 입/출고전표 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listMaterialBoundInout(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("material_bound_inout.listMaterialBoundInout", param);
	}
	
	/**
	 * 입/출고전표 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveMaterialBoundInout(Map<String, Object> param) throws Exception{
		
		int result = insertMaterialBoundInout(param);
		fileService.saveImgInfo(param);
		
		/* 자재 갯수 update */
		materialService.updateMaterialCnt(param);
		
		return result;
	}
	
	/**
	 * 입/출고전표 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertMaterialBoundInout(Map<String, Object> param) throws Exception{
		int result = commonDao.insert("material_bound_inout.insertMaterialBoundInout", param);
		
		/* 자재 갯수 update */
		materialService.updateMaterialCnt(param);
		
		return result;
	}
	
	
	/**
	 * 입/출고전표 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteMaterialBoundInout(Map<String, Object> param) throws Exception{
		
		int result = commonDao.update("material_bound_inout.deleteMaterialBoundInout", param);
		if(result > 0) {
			/* 자재총액 update */
			result = materialService.updateMaterialCnt(param);
		}
		
		return result;
	}
	
	
	/**
	 * 입/출고전표 상태변경
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateMaterialBoundInoutStat(Map<String, Object> param) throws Exception{
		
		String[] material_bound_inout_no_arr = StringUtil.split((String)param.get("material_bound_inout_no_str"), "^");
		
		int result = 0;
		for(String material_bound_inout_no : material_bound_inout_no_arr) {
			param.put("material_bound_inout_no", material_bound_inout_no);
			commonDao.update("material_bound_inout.updateMaterialBoundInoutStat", param);
			
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
	
	
}