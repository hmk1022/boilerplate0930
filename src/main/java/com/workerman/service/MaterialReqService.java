package com.workerman.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
 * 요청자재 관리
 * 
 */
@Service("materialReqService")
public class MaterialReqService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private FileService fileService;
	
	@Autowired 
	private S3UploadService sSUploadService;

	@Autowired 
	private MaterialPcsService materialPcsService;

	@Autowired 
	private MaterialPcsItemService materialPcsItemService;

	@Autowired 
	private MaterialService materialService;
	
	@Autowired 
	private MaterialBoundService materialBoundService;
	
	@Autowired 
	private MaterialBoundInoutService materialBoundInoutService;
	
	
	/******************************************* 요청자재 *******************************************/
	
	/**
	 * 요청자재 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listMaterialReq(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("material_req.listMaterialReq", param);
	}
	
	
	/**
	 * 요청자재 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMaterialReq(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("material_req.selectMaterialReq", param);
	}
	
	/**
	 * 요청자재 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveMaterialReq(Map<String, Object> param) throws Exception{
		
		int result = insertMaterialReq(param);
		fileService.saveImgInfo(param);
		
		return result;
	}
	
	/**
	 * 요청자재 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertMaterialReq(Map<String, Object> param) throws Exception{
		int result = commonDao.insert("material_req.insertMaterialReq", param);
		return result;
	}
	
	
	/**
	 * 요청자재 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteMaterialReq(Map<String, Object> param) throws Exception{
		return commonDao.update("material_req.deleteMaterialReq", param);
	}
	
	
	/**
	 * 요청자재 상태변경
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int updateMaterialReqStat(Map<String, Object> param) throws Exception{
		
		String[] material_req_no_arr = StringUtil.split((String)param.get("material_req_no_str"), "^");
		
		int result = 0;

		int idx = 0;
		
		Long material_pcs_no = null ;

		Long material_bound_no = null ;
		
		for(String material_req_no : material_req_no_arr) {
			idx++;
			param.put("material_req_no", material_req_no);
			
			result = commonDao.update("material_req.updateMaterialReqStat", param);
			
			String _req_stat = (String)param.get("req_stat");


			/* 요청자재 조회 */
			Map<String, Object> materialMap = selectMaterialReq(param);
			//
			materialMap.put("create_no", param.get("create_no")); // admin
			materialMap.put("update_no", param.get("update_no")); // admin
			
			/* * 
			 * 등록  
			 * 1. 자재마스터로 입력(자재 이미지 생성)
			 * 2. 자재번호 입력
			 * 3. 입고전표 데이터 입력 ==> 입고 없음.(20210803)
			 * */
			
			if(StringUtil.equals(Constants.REQ_STAT_REG, _req_stat)) {
				// 1.
				if(param.get("category_no") == null) {
					param.put("category_no", 152);	// 운영 category_no 기타.
				}
				materialService.insertMaterialDoc(param);
				// 2.
				Long material_no = (StringUtil.toLong(param.get("key_no")));
				param.put("material_no", material_no);
				commonDao.update("material_req.updateMaterialReqNo", param);
				// 3.
				
				// 입고 없음.(20210803)
//				if(materialMap.get("material_no") == null) {
//					materialMap.put("material_no", param.get("material_no"));
//				}
//				
//				String _receive_type = (String)materialMap.get("receive_type"); // 수령방법
//				String _bound_locate = "";
//				
//				// 물류센터 or SBA
//				if(StringUtil.equals(_receive_type, "01") || StringUtil.equals(_receive_type, "02")) {
//					_bound_locate = _receive_type;
//				} else {
//					_bound_locate = "99"; // 기타
//				}
//				
//				// insert bound
//				materialMap.put("bound_locate", _bound_locate);	// 입고위치 (과천물류센터/성수동SBA/현장) ==> 과천물류센터
//				
//				if(materialMap.get("work_no") == null) {
//					materialMap.put("income_type", "02");   // 작업시공자재/재고추가/반품/기타 ==> 재고추가
//				}
//				else {
//					materialMap.put("income_type", "01");   // 작업시공자재/재고추가/반품/기타 ==> 작업시공자재
//				}
//				
//				materialMap.put("out_type", null);		// 출고사유
//				materialMap.put("out_admin_no", null);	// 출고워커맨
//				materialMap.put("material_pcs_no", null);	// 구매번호
//				
//				materialMap.put("bound_stat", "01");	// 입출고상태
//				materialMap.put("etc_remarks", "[자재요청]");	// 기타사유
//				
//				materialMap.put("bound_date", DateUtil.getCurrentDateStr()); // 입/출고일
//				materialMap.put("bound_locate", Constants.BOUND_TYPE_IN); // 입/출고타입
//				
//				// insert inout
//				materialMap.put("inout_cnt", materialMap.get("material_cnt")); // 입/출고타입
//				materialMap.put("inout_stat", "01"); // 상태
//				materialMap.put("bound_type", "01"); // 입고
//				
//				materialBoundService.insertMaterialBoundDoc(materialMap);
				
			}
			/* 구매 : 자재마스터로 입력 */
			else if(StringUtil.equals(Constants.REQ_STAT_PCS, _req_stat)) {
				Map<String, Object> pcsMap = new HashMap<String, Object>();
				
				if(materialMap.get("work_no") == null) {
					materialMap.put("pcs_reason", "02");   // 구매사유 ==> 재고추가
				}
				else {
					materialMap.put("pcs_reason", "01");   // 구매사유 ==> 작업시공자재
				}
				
				materialMap.put("material_doc_admin_no", materialMap.get("manager_no")); // 자재요청자
				materialMap.put("remarks", "[자재요청]"); // 
				materialMap.put("pcs_stat", "01"); // 
				
				if(idx == 1) {
					materialPcsService.insertMaterialPcsDoc(materialMap);	
					material_pcs_no = StringUtil.toLong(materialMap.get("material_pcs_no"));
					param.put("material_pcs_no", material_pcs_no);
				}
				
				materialMap.put("material_pcs_no", material_pcs_no);
				materialMap.put("item_stat", "01");
				materialMap.put("item_cnt", materialMap.get("material_cnt")); // 입/출고타입
				
				materialPcsItemService.insertMaterialPcsItemDoc(materialMap);
				
			}
			/* 출고 : 
			 * 1. 출고전표 입력 
			 * */
			else if(StringUtil.equals(Constants.REQ_STAT_OUT, _req_stat)) {
				
				String _receive_type = (String)materialMap.get("receive_type"); // 수령방법
				String _bound_locate = "";
				
				// 물류센터 or SBA
//				if(StringUtil.equals(_receive_type, "01") || StringUtil.equals(_receive_type, "02")) {
//					_bound_locate = _receive_type;
//				} else {
//					_bound_locate = "99"; // 기타
//				}
				
				if(StringUtil.isEmpty(_receive_type)) {
					_bound_locate = "99"; // 기타
				} else {
					_bound_locate = _receive_type;
				}
				
				// insert bound
				materialMap.put("bound_locate", _bound_locate);	// 입고위치 (과천물류센터/성수동SBA/현장) ==> 과천물류센터
				
				if(materialMap.get("work_no") == null) {
					materialMap.put("out_type", "99");   // 작업시공자재/재고추가/반품/기타 ==> 재고추가
				}
				else {
					materialMap.put("out_type", "01");   // 작업시공자재/재고추가/반품/기타 ==> 작업시공자재
				}
				//param.put("material_no", "");   // 자재번호
				//param.put("work_no", "");		// 작업번호
				//param.put("vendor_no", "");		// 매입거래처
				materialMap.put("income_type", null);		// 출고사유
				materialMap.put("out_admin_no", materialMap.get("manager_no"));	// 출고워커맨
				//materialMap.put("material_pcs_no", null);	// 구매번호
				//param.put("material_doc_no", "");	// 자재요청서
				materialMap.put("bound_stat", "02");	// 입출고상태
				materialMap.put("etc_remarks", "[자재요청]");	// 기타사유
				
				materialMap.put("bound_date", DateUtil.getCurrentDateStr()); // 입/출고일
				//materialMap.put("bound_locate", Constants.BOUND_TYPE_IN); // 입/출고타입
				
				// insert inout
				materialMap.put("inout_cnt", materialMap.get("material_cnt")); // 입/출고타입
				materialMap.put("inout_stat", "01"); // 상태

				materialMap.put("bound_type", Constants.BOUND_TYPE_OUT); //  입/출고타입
				
				//materialBoundService.insertMaterialBoundDoc(materialMap);
				
				// 출고전표등록
				if(idx == 1) {
					materialBoundService.insertMaterialBound(materialMap);
					material_bound_no = StringUtil.toLong(materialMap.get("key_no"));
				}
				materialMap.put("material_bound_no", material_bound_no);
				// 출고자재 등록
				materialBoundInoutService.insertMaterialBoundInout(materialMap);
				
			}
			/* 준비완료 :  */
			else if(StringUtil.equals(Constants.REQ_STAT_READY, _req_stat)) {

			}
			
			result++;
		}
		return result;
	}
	
	
}