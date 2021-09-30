package com.workerman.service;

import java.text.ParseException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import com.workerman.dao.CommonDao;
import com.workerman.utils.Utils;

@Service("adminScheduleService")
public class AdminScheduleService extends BaseService {

	@Autowired
	private CommonDao commonDao;

	/**
	 * 일정리스트 조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> scheduleList(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("adminSchedule.listAdminScheduleTime", param);
	}


	/**
	 * 일정 조회
	 * @param param
	 * @return
	 */
	public Map<String, Object> getSchedule(Map<String, Object> param){
		return (Map<String, Object>)commonDao.queryForObject("adminSchedule.selectSchedule", param);
	}

	/**
	 * 일정 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void saveSchdule(Map<String, Object> param) throws Exception{
		if(StringUtils.isEmpty( param.get("schedule_group_no") ) ) {
			List<Object> list = Utils.parseProfilesJson( String.valueOf( param.getOrDefault("admin_list","") )); // 체크한 정,부 리스트
			LocalDate startDate = LocalDate.parse(param.get("st_date_ymd").toString(), DateTimeFormatter.ISO_DATE);
			LocalDate endDate = LocalDate.parse(param.get("ed_date_ymd").toString(), DateTimeFormatter.ISO_DATE);
			long days = ChronoUnit.DAYS.between(startDate, endDate);
			LocalTime startTime = LocalTime.parse(param.get("st_date_h").toString()+":"+param.get("st_date_m").toString(), DateTimeFormatter.ISO_TIME);
			if(param.get("ed_date_h").toString().equals("24")) {
				param.put("ed_date_h","23");
				param.put("ed_date_m","59");
			}
			LocalTime endTime = LocalTime.parse(param.get("ed_date_h").toString()+":"+param.get("ed_date_m").toString(), DateTimeFormatter.ISO_TIME);
			long times = ChronoUnit.MINUTES.between(startTime, endTime);
			param.put("working_time", times);

			int idx = 0;
			for (Object tmp : list) {
				Map<String, Object> admin = (Map<String, Object>)tmp;
				param.put("admin_no", admin.get("admin_no"));
				param.put("workerman_type", admin.get("workerman_type"));
				//param.put("assignment_type", admin.get("assignment_type").toString());
				param.put("schedule_type", param.get("work_type").toString());

//				commonDao.insert("abc_work_assignment.insertWorkAssignment", param); // 배정 테이블에 인서트
				if(idx ==0) {
					param.put("schedule_stat", "01");
					commonDao.insert("adminScheduleGroup.insertAdminScheduleGroup", param); // 스케줄그룹등록
				}

		        Map<String, Object> scdMap = new HashMap<String, Object>();
		        scdMap.put("admin_no", param.get("admin_no"));
		        scdMap.put("workerman_type", admin.get("workerman_type"));
		        scdMap.put("schedule_group_no", param.get("schedule_group_no"));
		        scdMap.put("schedule_type", param.get("schedule_type"));
			    scdMap.put("st_date_h", param.get("st_date_h"));
			    scdMap.put("st_date_m", param.get("st_date_m"));
		    	scdMap.put("ed_date_h", param.get("ed_date_h"));
		    	scdMap.put("ed_date_m", param.get("ed_date_m"));
		    	scdMap.put("scd_text", param.get("scd_text"));
		    	scdMap.put("scd_content", param.get("scd_content"));

		        if(param.get("work_no") !=null) {
		        	scdMap.put("work_no", param.get("work_no"));
		        }
				for (int i = 0; i < days + 1; i++) {
					String strDate = startDate.plusDays(i).format(DateTimeFormatter.BASIC_ISO_DATE);
					scdMap.put("st_date_ymd", strDate);
					scdMap.put("ed_date_ymd", strDate);
					commonDao.insert("adminSchedule.insertAdminSchedule", scdMap); // 스케줄등록
				}

				idx++;
			}
		}else {
			param.put("schedule_type", param.get("work_type").toString());
			updateScheduleGroup(param);
			updateSchedule(param);
		}
	}


	/**
	 * 일정 종료
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void endSchdule(Map<String, Object> param) throws Exception{
			updateScheduleGroup(param);
	}

	/**
	 * 일정 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateScheduleGroup(Map<String, Object> param) throws Exception{
		if(param.get("schedule_group_no") != null && param.get("schedule_group_no") != "" ) {
			commonDao.update("adminScheduleGroup.updateAdminScheduleGroupByScheduleGroupNo", param);
		}else {
			commonDao.update("adminScheduleGroup.updateAdminScheduleGroupByWorkNo", param);
		}
	}

	public void updateSchedule(Map<String, Object> param) throws Exception{
		commonDao.update("adminSchedule.updateAdminSchedule", param);
	}


	/**
	 * 일정 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void insertMySchedule(Map<String, Object> param,int idx) throws DataIntegrityViolationException , ParseException{
        LocalDate startDate = LocalDate.parse(param.get("st_date_ymd").toString(), DateTimeFormatter.ISO_DATE);
        LocalDate endDate = LocalDate.parse(param.get("ed_date_ymd").toString(), DateTimeFormatter.ISO_DATE);
        long days = ChronoUnit.DAYS.between(startDate, endDate);
		if(idx ==0) {
			LocalTime startTime = LocalTime.parse(param.get("st_date_h").toString()+":"+param.get("st_date_m").toString(), DateTimeFormatter.ISO_TIME);
	        LocalTime endTime = LocalTime.parse(param.get("ed_date_h").toString()+":"+param.get("ed_date_m").toString(), DateTimeFormatter.ISO_TIME);
	        long times = ChronoUnit.MINUTES.between(startTime, endTime);
	        param.put("working_time", times);
			commonDao.insert("adminScheduleGroup.insertAdminScheduleGroup", param); // 스케줄그룹등록
		}else {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("work_no", param.get("work_no"));
			map.put("schedule_type",param.get("work_type"));
			Map<String, Object> groupInfo = commonDao.queryForObject("adminScheduleGroup.selectAdminScheduleGroupInfo", map);
			param.put("schedule_group_no",groupInfo.get("schedule_group_no"));
		}


        Map<String, Object> scdMap = new HashMap<String, Object>();
        scdMap.put("admin_no", param.get("admin_no"));
        scdMap.put("schedule_group_no", param.get("schedule_group_no"));
        scdMap.put("schedule_type", param.get("schedule_type"));
	    scdMap.put("st_date_h", param.get("st_date_h"));
	    scdMap.put("st_date_m", param.get("st_date_m"));
    	scdMap.put("ed_date_h", param.get("ed_date_h"));
    	scdMap.put("ed_date_m", param.get("ed_date_m"));

        if(param.get("work_no") !=null) {
        	scdMap.put("work_no", param.get("work_no"));
        }
		for (int i = 0; i < days + 1; i++) {
			String strDate = startDate.plusDays(i).format(DateTimeFormatter.BASIC_ISO_DATE);
			scdMap.put("st_date_ymd", strDate);
			scdMap.put("ed_date_ymd", strDate);
			commonDao.insert("adminSchedule.insertAdminSchedule", scdMap); // 스케줄등록
		}
	}


	/**
	 * 일정조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> subWorkScheduleList(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("adminSchedule.selectScheduleList", param);
	}
}
