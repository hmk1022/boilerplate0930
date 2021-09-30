package com.workerman.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.workerman.aws.S3UploadService;
import com.workerman.config.Constants;
import com.workerman.dao.CommonDao;
import com.workerman.utils.DateUtil;
import com.workerman.utils.StringUtil;


/**
 * @author dwkwon
 * 구매요청 관리
 * 
 */
@Service("materialPcsService")
public class MaterialPcsService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	@Autowired 
	private S3UploadService sSUploadService;
	
	@Autowired
	private MaterialPcsItemService materialPcsItemService;
	
	@Autowired
	private ExpensesService expensesService;

	@Autowired
	private MaterialBoundService materialBoundService;
	
	/******************************************* 구매요청 *******************************************/
	
	/**
	 * 구매요청 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listMaterialPcs(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("material_pcs.listMaterialPcs", param);
	}
	
	/**
	 * 구매요청 조회 count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int listMaterialPcsCnt(Map<String, Object> param) throws Exception{
		return (Integer)commonDao.queryForInt("material_pcs.listMaterialPcsCnt", param);
	}
	
	/**
	 * 구매요청 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> saveMaterialPcs(Map<String, Object> param) throws Exception{
		if(StringUtils.isBlank((String)param.get("material_pcs_no"))){	// check pk-key
			insertMaterialPcs(param);
		} else {
			updateMaterialPcs(param);
		}
		return param;
	}
	
	/**
	 * 구매요청 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertMaterialPcs(Map<String, Object> param) throws Exception{
		
		/* get material_pcs_id */
		String material_pcs_id = commonDao.queryForString("material_pcs.getMaterialPcsId", param);
		param.put("material_pcs_id", material_pcs_id);

		int result = commonDao.insert("material_pcs.insertMaterialPcs", param);
		param.put("material_pcs_no", param.get("key_no"));		
		fileService.saveImgInfo(param);
		
		return result;
	}
	
	
	/**
	 * 구매요청 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateMaterialPcs(Map<String, Object> param) throws Exception{
		int result = commonDao.insert("material_pcs.updateMaterialPcs", param);
		param.put("key_no", param.get("material_pcs_no"));
		fileService.saveImgInfo(param);
		return result;
	}
	
	/**
	 * 구매상태 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int updateMaterialPcsStat(Map<String, Object> param) throws Exception{
		/* 상태변경 */
		int result = commonDao.update("material_pcs.updateMaterialPcsStat", param);
		
		if(result > 0) {
			/* 결제요청*/ 
			String pcs_stat = String.valueOf(param.get("pcs_stat"));
			
			Long _admin_no = StringUtil.toLong(param.get("create_no"));
			
			// 구매 --> 비용
			if(StringUtils.equals(Constants.PCS_STAT_REQ_PAY, pcs_stat)) {
				param.put("exp_stat", "01");
				param.put("exp_type", "03");	// 자재비
				param.put("exp_unit_cd", "02");	// 자재코드(식)
				param.put("exp_usage", "[구매처리]");	// 비용용도
				param.put("st_date", DateUtil.getCurrentDateStr());	// 결재요청일, 사용시작일
				
				expensesService.insertExpensesPcs(param);
			}
			// 구매 --> 입고전표생성
			else if (StringUtils.equals(Constants.PCS_STAT_INCOME, pcs_stat)) {
			
				List<Map<String, Object>> list = commonDao.queryForList("material_pcs_item.listMaterialPcsItem", param);
				
				for(Map<String, Object> tmpMap: list) {
					tmpMap.put("bound_date", DateUtil.getCurrentDateStr()); // 입고/출고일
					tmpMap.put("bound_type", "01");	// 입/출고 구분
					
					tmpMap.put("inout_cnt", tmpMap.get("item_cnt"));	//갯수
					tmpMap.put("inout_stat", "01");	//상태
					tmpMap.put("create_no", _admin_no);
					tmpMap.put("update_no", _admin_no);

					// 구매사유/입고사유
					tmpMap.put("income_type", tmpMap.get("pcs_reason"));
					
					// 수령위치
					tmpMap.put("bound_locate", tmpMap.get("receive_type"));
					
					materialBoundService.insertMaterialBoundPcs(tmpMap);
				}
				
			} 
		}
		
		return result;
	}
	
	/**
	 * 구매요청 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteMaterialPcs(Map<String, Object> param) throws Exception{
		return commonDao.update("material_pcs.deleteMaterialPcs", param);
	}
	
	/**
	 * 구매요청 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMaterialPcs(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("material_pcs.selectMaterialPcs", param);
	}
	
	/**
	 * 구매 총금액 update
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updateMaterialPcsSumPrice(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("material_pcs.updateMaterialPcsSumPrice", param);
	}
	
	/**
	 * 구매요청 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertMaterialPcsDoc(Map<String, Object> param) throws Exception{
		
		/* get material_pcs_id */
		String material_pcs_id = commonDao.queryForString("material_pcs.getMaterialPcsId", param);
		param.put("material_pcs_id", material_pcs_id);
		
		int result = commonDao.insert("material_pcs.insertMaterialPcs", param);
		
		//fileService.saveImgInfo(param);
		
		/* insert image information */
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("add_img_type", Constants.IMG_TYPE_MATERIAL_PCS); // image
		imgMap.put("add_key_no", param.get("key_no"));
		imgMap.put("img_type", Constants.IMG_TYPE_MATERIAL_REQ); // image
		imgMap.put("key_no", param.get("key_no"));
		imgMap.put("create_no", param.get("material_req_no"));

		commonDao.insert("imgInfo.insertImgInfoDoc", imgMap);

		param.put("material_pcs_no", param.get("key_no")); // 구매번호
		
		return result;
	}
	
	
}