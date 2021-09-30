package com.workerman.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.workerman.dao.CommonDao;

@Service("b2bWorkService")
public class B2bWorkService extends BaseService {
/*
 * 추후 workService 로 통합필요
 */
	@Autowired
	private CommonDao commonDao;

	@Autowired
	private FileService fileService;

	/**
	 * 목록조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> workList(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("b2bWork.selectB2bWorkList", param);
	}
	/**
	 * 목록cnt
	 * @param param
	 * @return
	 */
	public int workListCnt(Map<String, Object> param){
		return (int)commonDao.queryForInt("b2bWork.selectB2bWorkListCnt", param);
	}
	/**
	 * work 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectWork(Map<String, Object> param){
		return (Map<String, Object>)commonDao.queryForObject("b2bWork.selectB2bWork", param);
	}

	/**
	 * 완료보고서work 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectB2bWorkReport(Map<String, Object> param){
		return (Map<String, Object>)commonDao.queryForObject("reportIn.selectB2bWorkReport", param);
	}
	/**
	 * 완료보고서 특이사항
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> reportClientImg(Map<String, Object> param){
		return (List<Map<String, Object>>) commonDao.queryForList("reportIn.reportClientImg", param);
	}
	/**
	 * 완료보고서 내용
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> reportClient(Map<String, Object> param){
		return (Map<String, Object>) commonDao.queryForObject("reportIn.reportClient", param);
	}
	/**
	 * 완료보고서 이미지
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectReport(Map<String, Object> param){
		return (Map<String, Object>) commonDao.queryForObject("reportIn.selectReport", param);
	}
	/**
	 * 내부 완료보고서 수정 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> reportInPost(Map<String, Object> param){
		return (Map<String, Object>) commonDao.queryForObject("reportIn.reportInPost", param);
	}
	/**
	 * 내부 완료보고서 수정
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> updateReportIn(Map<String, Object> param){
		return (Map<String, Object>) commonDao.queryForObject("reportIn.updateReportIn", param);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> expPriceSum(Map<String, Object> param){
		return (Map<String, Object>) commonDao.queryForObject("reportIn.expPriceSum", param);
	}
	/**
	 * 내부 완료보고서 수정 이미지
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> reportPostImg(Map<String, Object> param){
		return (List<Map<String, Object>>) commonDao.queryForList("reportIn.reportPostImg", param);
	}
	/**
	 * 고객전송용 완료보고서 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int updateReportClient(Map<String, Object> param) throws Exception{

		int result = commonDao.update("reportIn.updateReportClient", param);

		param.put("key_no", param.get("report_no"));

		for(int i=1; i<4; i++) {
			param.put("files",param.get("files"+ String.valueOf(i)));
			fileService.saveImgInfo(param);
		}

		/*
		 * param.put("files",param.get("files1")); fileService.saveImgInfo(param);
		 * param.put("files",param.get("files2")); fileService.saveImgInfo(param);
		 * param.put("files",param.get("files3")); fileService.saveImgInfo(param);
		 */

		return result;
	}
	/**
	 * 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void saveWork(Map<String, Object> param) throws Exception{
		if(StringUtils.isEmpty( param.get("work_no") ) ) {
			insertWork(param);
			SimpleDateFormat format = new SimpleDateFormat("yyMMdd");
			Calendar cal = Calendar.getInstance();
			String today = format.format(cal.getTime());
			String work_id = null;
			new HashMap<Object, Object>();
			String workIdPrefix = "";
			if( String.valueOf( param.get("work_target") ).equals("04")) {
				workIdPrefix = "BIZ_";
			}else {
				workIdPrefix = "PRJ_";
			}
			work_id = workIdPrefix + today + "" + param.get("work_no");
			param.put("work_id", work_id);
			updateWork(param);
		}else {
			updateWork(param);
		}
		param.put("key_no", param.get("work_no"));
		fileService.saveImgInfo(param);

	}
	/**
	 * 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void reqContentSave(Map<String, Object> param) throws Exception{
			updateWork(param);
	}

	/**
	 * 작업 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED, rollbackFor=Exception.class)
	public int insertWork(Map<String, Object> param) throws Exception{
		return commonDao.insert("b2bWork.insertWork", param);
	}
	/**
	 * 작업 취소
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void cancelWork(Map<String, Object> param) throws Exception{
		param.put("work_stat", "99");
 		commonDao.insert("b2bWork.insertWorkReject", param);
		commonDao.update("b2bWork.cancelWork", param);
	}

	/**
	 * 작업 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateWork(Map<String, Object> param) throws Exception{
		return commonDao.update("b2bWork.updateWork", param);
	}


	/**
	 * 작업 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveWorkMemo(Map<String, Object> param) throws Exception{
			return insertWorkMemo(param);
	}
	/**
	 * 내부용 완료보고서 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertReportIn(Map<String, Object> param) throws Exception{
		return commonDao.insert("reportIn.insertReportIn", param);
	}
	/**
	 * 고객용 완료보고서 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertReportClient(Map<String, Object> param) throws Exception{
		System.out.println("report_no :" + param);
		int result =  commonDao.insert("reportIn.insertReportClient", param);

		/* upload file */
		param.put("key_no", param.get("report_no"));

		for(int i=1; i<4; i++) {
			System.out.println("param 비교"+param);
			param.put("files",param.get("files"+ String.valueOf(i)));
			fileService.saveImgInfo(param);
		}

		/*
		 * param.put("files",param.get("files1")); fileService.saveImgInfo(param);
		 * param.put("files",param.get("files2")); fileService.saveImgInfo(param);
		 * param.put("files",param.get("files3")); fileService.saveImgInfo(param);
		 */

		return result;
	}
	/**
	 * 메모 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertWorkMemo(Map<String, Object> param) throws Exception{
		return commonDao.insert("b2bWorkMemo.insertWorkMemo", param);
	}

	/**
	 * 메모 리스트
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectWorkMemoList(Map<String, Object> param){
			return (List<Map<String, Object>>)commonDao.queryForList("b2bWorkMemo.selectWorkMemoList", param);

	}

	/**
	 * 하위 작업 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void saveSubWork(Map<String, Object> param) throws Exception{
		if(StringUtils.isEmpty( param.get("work_no") ) ) {
			param.put("work_no", param.get("p_work_no"));
			Map<String, Object> subWorkParam = selectWork(param);
			subWorkParam.put("p_work_no", param.get("work_no"));
			subWorkParam.put("admin_memo",  param.get("admin_memo"));
			subWorkParam.put("location_name",  param.get("location_name"));
			insertWork(subWorkParam);

			SimpleDateFormat format = new SimpleDateFormat("yyMMdd");
			Calendar cal = Calendar.getInstance();
			String today = format.format(cal.getTime());
			String work_id = null;
			new HashMap<Object, Object>();
			String workIdPrefix = "";
			if( String.valueOf( subWorkParam.get("work_target") ).equals("04")) {
				workIdPrefix = "BIZ_";
			}else {
				workIdPrefix = "PRJ_";
			}
			work_id = workIdPrefix + today + "" + subWorkParam.get("work_no");
			subWorkParam.put("work_id", work_id);
			updateWork(subWorkParam);
		}else {
			Map<String, Object> subWorkParam = new HashMap<String, Object>();
			subWorkParam.put("work_no", param.get("work_no"));
			subWorkParam.put("req_content",  param.get("req_content"));
			subWorkParam.put("location_name",  param.get("location_name"));
			updateWork(param);
		}
	}

	/**
	 * subwork목록조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> subWorkList(Map<String, Object> param){
		List<Map<String, Object>> subWorkList = (List<Map<String, Object>>)commonDao.queryForList("b2bWork.selectB2bSubWorkList", param);

		for(Map<String,Object> item : subWorkList) {
			Map<String, Object> scheduleParam = new HashMap<String, Object>();
			scheduleParam.put("work_no", item.get("work_no"));
			item.put("scheduleList", (List<Map<String, Object>>)commonDao.queryForList("adminSchedule.selectScheduleList", scheduleParam));
		}

		return subWorkList;
	}

	/**
	 * subwork목록조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> paymentList(Map<String, Object> param){
		List<Map<String, Object>> paymentList = (List<Map<String, Object>>)commonDao.queryForList("abc_payment.selectPaymentListByWorkNo", param);
		return paymentList;
	}


	/**
	 * 결제 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void savePaymenet(Map<String, Object> param) throws Exception{
		insertPayment(param);
		fileService.saveImgInfo(param);
	}

	public int insertPayment(Map<String, Object> param) throws Exception{
		return commonDao.insert("abc_payment.insertPayment", param);
	}
	/**
	 * 결제 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deletePaymenet(Map<String, Object> param) throws Exception{
		return commonDao.insert("abc_payment.deletePayment", param);
	}

	/**
	 * 하위 작업 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void saveSchedule(Map<String, Object> param) throws Exception{
		if(StringUtils.isEmpty( param.get("work_no") ) ) {
			param.put("work_no", param.get("p_work_no"));
			Map<String, Object> subWorkParam = selectWork(param);
			subWorkParam.put("p_work_no", param.get("work_no"));
			subWorkParam.put("req_content",  param.get("req_content"));
			subWorkParam.put("location_name",  param.get("location_name"));
			insertWork(subWorkParam);
		}else {
			Map<String, Object> subWorkParam = new HashMap<String, Object>();
			subWorkParam.put("work_no", param.get("work_no"));
			subWorkParam.put("req_content",  param.get("req_content"));
			subWorkParam.put("location_name",  param.get("location_name"));
			updateWork(param);
		}
	}


	/**
	 * 견적서 승인
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void applyEstimate(Map<String, Object> param) throws Exception{
			//Map<String, Object> estimateParam = selectEstimate(param);
			commonDao.update("estimate.initApplyEstimate", param);
			commonDao.update("estimate.applyEstimate", param);
	}
	/**
	 * 견적서 승인취소
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void applyCancelEstimate(Map<String, Object> param) throws Exception{
			commonDao.update("estimate.initApplyEstimate", param);
	}

	/**
	 * 견적서 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectEstimate(Map<String, Object> param){
		return (Map<String, Object>)commonDao.queryForObject("estimate.selectEstimate", param);
	}


	/**
	 * 작업일지 작업일수 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> dailyReportList(Map<String, Object> param){
		List<Map<String, Object>> dailyReportList = (List<Map<String, Object>>)commonDao.queryForList("b2bWork.selectDailyReportList", param);
		return dailyReportList;
	}


	/**
	 * 작업일지 작업일수 work_no 기준 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDailyWorkList(Map<String, Object> param){
		List<Map<String, Object>> dailyReportList = (List<Map<String, Object>>)commonDao.queryForList("b2bWork.selectDailyWorkList", param);
		return dailyReportList;
	}

	/**
	 * 완료보고서 작업일수 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> ReportList(Map<String, Object> param){
		List<Map<String, Object>> dailyReportList = (List<Map<String, Object>>)commonDao.queryForList("reportIn.DailyReportList", param);
		return dailyReportList;
	}
	/**
	 * B2b작업건별 일수
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> workDayList(Map<String, Object> param){
		List<Map<String, Object>> dailyReportList = (List<Map<String, Object>>)commonDao.queryForList("b2bWork.selectWorkDayList", param);
		return dailyReportList;
	}
	/**
	 * estimate total amount 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectEstimateTotalAmount(Map<String, Object> param){
		return (Map<String, Object>)commonDao.queryForObject("estimate.selectEstimateTotalAmount", param);
	}

	/**
	 * estimate total amount 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> reportInForm(Map<String, Object> param){
		return (Map<String, Object>)commonDao.queryForObject("reportIn.reportInForm", param);
	}
	/**
	 * 작업일지 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDailyReport(Map<String, Object> param){
		return (Map<String, Object>)commonDao.queryForObject("b2bWork.selectDailyReport", param);
	}
	/**
	 * 작업일지 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectExpenseList(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("b2bWork.selectExpenseList", param);
	}
	/**
	 * 완료보고서 집행 비용 및 매출 이익 요약
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> reportInPay(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("reportIn.reportInPay", param);
	}
	/**
	 * used amount 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDailyReportUsedAmount(Map<String, Object> param){
		return (Map<String, Object>)commonDao.queryForObject("b2bWork.selectDailyReportUsedAmount", param);
	}

	/**
	 * 작업일지 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void saveDailyReport(Map<String, Object> param) throws Exception{
		if(StringUtils.isEmpty( param.get("daily_report_no") ) ) {
			insertDailyReport(param);
		}else {
			updateDailyReport(param);
		}
		/* upload file */
		param.put("files", param.get("files"));
		fileService.saveImgInfo(param);
	}
	/**
	 * 작업일지 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertDailyReport(Map<String, Object> param) throws Exception{
		return commonDao.insert("b2bWork.insertDailyReport", param);
	}

	/**
	 * 작업일지 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateDailyReport(Map<String, Object> param) throws Exception{
		return commonDao.insert("b2bWork.updateDailyReport", param);
	}
	/**
	 * 실행가 목록 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectExcutePriceList(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("b2bWork.selectExcutePriceList", param);
	}
	/**
	 * 실행가 총금액 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> totalexcutePrice(Map<String, Object> param){
		return (Map<String, Object>) commonDao.queryForObject("reportIn.totalexcutePrice", param);
	}

	/**
	 * 자재요청내역 목록 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMaterialDocList(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("b2bWork.selectMaterialDocList", param);
	}

	/**
	 * 자재사용 목록 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMaterialReqList(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("b2bWork.selectMaterialReqList", param);
	}
}
