package com.workerman.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.dao.CommonDao;
import com.workerman.utils.Utils;
import com.workerman.vo.ActivityListReqVo;
import com.workerman.vo.ActivityListResVo;
import com.workerman.vo.ActivityListVo;

@Service("activityService")
public class ActivityService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	/**
	 * 알림목록조회
	 * @param activityListReqVo
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public ActivityListResVo activityList(ActivityListReqVo activityListReqVo, HttpServletRequest request) {
		
		activityListReqVo.setMember_no(Long.parseLong(request.getAttribute("member_no").toString())); // 회원번호주입
		
		ActivityListResVo activityListResVo = new ActivityListResVo();
		
		ActivityListVo activityListVo = new ActivityListVo();
		
		activityListVo.setList(commonDao.queryForList("activity.selectActivityList", Utils.objectToMap(activityListReqVo)));
		
		activityListResVo.setResult_data(activityListVo);
		
		commonDao.update("activity.updateActivityReadYn", Utils.objectToMap(activityListReqVo));
		
		activityListResVo.setErrorNone();
		
		return activityListResVo;
	}
	
}
