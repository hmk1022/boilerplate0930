package com.workerman.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.workerman.dao.CommonDao;
import com.workerman.utils.StringUtil;
import com.workerman.utils.Utils;

@Service("workermanService")
public class WorkermanService extends BaseService {

	@Autowired
	private CommonDao commonDao;

	@Autowired
	private FileService fileService;

	@Autowired
	private BCryptPasswordEncoder bcryptEncoder;

	/**
	 * 관리자목록조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> workermanList(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("admin.selectAdminList", param);
	}
	/**
	 * workerman list 조회
	 * @param param
	 * @return
	 */
	public int workermanListCnt(Map<String, Object> param){
		return (int)commonDao.queryForInt("admin.selectAdminListCnt", param);
	}


	/**
	 * workerman 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveAdmin(Map<String, Object> param) throws Exception{
		if(StringUtils.isBlank((String)param.get("admin_no"))){	// check pk-key
			return insertAdmin(param);
		} else {
			return updateAdmin(param);
		}
	}
	/**
	 * admin 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED, rollbackFor=Exception.class)
	public int insertAdmin(Map<String, Object> param) throws Exception{

		if(commonDao.queryForObject("admin.selectAdminById", param) != null) { // 아이디중복
			//return returnResult("D");
			throw new Exception("D");
		}
		param.put("profile_url", "");
		//param.put("admin_type", "02");
		param.put("admin_group_no", 1);
		param.put("password", bcryptEncoder.encode(param.get("password")+""));
		int result = commonDao.insert("admin.insertAdmin", param);  // 관리자정보등록

		if(result == 1) {
			MultipartFile[] files = (MultipartFile[]) param.get("files");
			if(files.length > 1) {
				throw new Exception("이미지는 하나만");
			} else if (files.length == 1) {
				/* upload file */
				List<Map<String, Object>> uploadFileList = fileService.saveImgInfo(param);
				Map<String, Object> uploadFile = new HashMap<String, Object>();
				uploadFile = uploadFileList.get(0);
				String profileImgUrl = String.valueOf( uploadFile.get("img_url") );
				param.put("profile_url", profileImgUrl);
				// update admin
				commonDao.update("admin.updateAdminInfo", param);
			}
			if(param.get("admin_cates") != null) { //전문 분야

//				List<Object> list = Utils.parseProfilesJson(param.get("admin_cates").toString());
//
//				for (Object special_cd : list) {
//					param.put("special_cd", special_cd);
//					commonDao.insert("adminSpecial.insertAdminSpecial", param); // 전문분야등록
//				}
				
				String[] list = (String[]) param.get("admin_cates");
				
				for (String tmp : list) {
					param.put("special_cd", tmp);
					commonDao.insert("adminSpecial.insertAdminSpecial", param.get("special_cd"));
				}
				
				
			}
		}else {
			throw new Exception("계정등록실패");
		}


		return result;
	}

	/**
	 * admin 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateAdmin(Map<String, Object> param) throws Exception{

		if(commonDao.queryForObject("admin.selectAdminById", param) != null) { // 아이디중복
			//return returnResult("D");
			throw new Exception("D");
		}
		param.put("password", StringUtil.stringToMd5(param.get("password")+""));
		param.put("admin_group_no", 1);
		int result = commonDao.insert("admin.insertAdmin", param);  // 관리자정보등록
		if(result == 1) {
			/* upload file */
			List<Map<String, Object>> uploadFileList = fileService.saveImgInfo(param);
			Map<String, Object> uploadFile = new HashMap<String, Object>();
			if(uploadFileList.size() > 1) {
				throw new Exception("이미지는 하나만");
			}else {
				uploadFile = uploadFileList.get(0);
			}
			String profileImgUrl = String.valueOf( uploadFile.get("img_url") );
			param.put("profile_url", profileImgUrl);
			commonDao.update("admin.updateAdmin", param);  // 관리자정보등록
		}

		return result;
	}
	/**
	 * admin 상태갱신
	 * @param param
	 * @return
	 */
	public int updateAdminStat(Map<String, Object> param){
		int result = commonDao.update("admin.updateAdminStat", param);
		return result;
	}

}
