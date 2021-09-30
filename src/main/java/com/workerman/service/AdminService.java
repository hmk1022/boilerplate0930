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

@Service("adminService")
public class AdminService extends BaseService {

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
	public List<Map<String, Object>> adminList(Map<String, Object> param){
		System.out.println("리스트 파람"+param);
		return (List<Map<String, Object>>)commonDao.queryForList("admin.selectAdminList", param);
	}
	
	/**
	 * 관리자 상세보기
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectAdmin(Map<String, Object> param){
		System.out.println("여기까지가"+ param);
		return (Map<String, Object>)commonDao.queryForObject("admin.selectAdmin", param);
	}
	/**
	 * 관리자 상세보기
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectAdminProfile(Map<String, Object> param){
		return (Map<String, Object>)commonDao.queryForObject("admin.selectAdminProfile", param);
	}
	
	
	/**
	 * 프로필 사진정보 보기
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public  List<Map<String, Object>> selectAdminSpecialByAdminNo(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("adminSpecial.selectAdminSpecialByAdminNo", param);
	}
	
	
	/**
	 * 워커맨 전문분야 보기
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectAdminImg(Map<String, Object> param){
		return (Map<String, Object>)commonDao.queryForObject("admin.selectAdminImg", param);
	}

	/**
	 * admin list 조회
	 * @param param
	 * @return
	 */
	public int adminListCnt(Map<String, Object> param){
		return (int)commonDao.queryForInt("admin.selectAdminListCnt", param);
	}


	/**
	 * admin 저장
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
		System.out.println("중복검사전"+param);
		if(commonDao.queryForObject("admin.selectAdminById", param) != null) { // 아이디중복 체크
			
			System.out.println("insert"+ param);
			
			throw new Exception("중복된 아이디입니다");
		}
		param.put("profile_url", "");
		 
		param.put("admin_group_no", 1);
		param.put("password", StringUtil.stringToMd5(param.get("password")+""));
		int result = commonDao.insert("admin.insertAdmin", param);  // 관리자정보등록 // 여기서 에러??
		System.out.println("result"+result);
		
		if(result == 1) {
			MultipartFile[] files = (MultipartFile[]) param.get("files");
			if(files.length > 1) {
				throw new Exception("이미지는 하나만");
			} else if (files.length == 1) {
				System.out.println("파람"+param);
				/* upload file */
				param.put("key_no", param.get("admin_no"));
				List<Map<String, Object>> uploadFileList = fileService.saveImgInfo(param); //여기서 멈춤
				Map<String, Object> uploadFile = new HashMap<String, Object>();
				uploadFile = uploadFileList.get(0);
				String profileImgUrl = String.valueOf( uploadFile.get("img_url") );
				param.put("profile_url", profileImgUrl);
				// update admin
				
				commonDao.update("admin.updateAdminInfo", param); // 해당 admin에 profile 사진을 넣어주기 위해 업데이트?
			}
			// 전문분야
			
			if(param.get("admin_cates") != null) { //전문 분야
				List<String> list = (List<String>) param.get("admin_cates");// 여기서에러
				System.out.println("special"+param);
				for (String special_cd : list) { param.put("special_cd", special_cd);
				commonDao.insert("adminSpecial.insertAdminSpecial", param); // 전문분야등록 } 	
				
//		    List<Object> list = Utils.parseProfilesJson(param.get("admin_cates").toString()); // 여기서에러
//			  
//			for (Object special_cd : list) { param.put("special_cd", special_cd);
//			commonDao.insert("adminSpecial.insertAdminSpecial", param); // 전문분야등록 } }
				}
			}
		} else {
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
		// param에 workerman_type이 빠졌냐?
		System.out.println("확인"+param);
//		if(commonDao.queryForObject("admin.selectAdminById", param) != null) {
//			//return returnResult("D");
//			System.out.println("paramss"+param);
//			throw new Exception("updateAdmin");
//		}
		if(!isEmpty(param.get("password"))) {
			param.put("password", StringUtil.stringToMd5(param.get("password")+""));
		}
		param.put("admin_group_no", 1);
		param.put("key_no", param.get("admin_no"));
		//int result = commonDao.insert("admin.insertAdmin", param);  // 관리자정보등록
		
			/* upload file */
			List<Map<String, Object>> uploadFileList = fileService.saveImgInfo(param);
			Map<String, Object> uploadFile = new HashMap<String, Object>();
			if(uploadFileList.size() > 1) {
				throw new Exception("이미지는 하나만");
			} else if(uploadFileList.size() == 1) {
				uploadFile = uploadFileList.get(0);
			}
			
			if(param.get("admin_cates") != null) { 
				
				commonDao.delete("adminSpecial.deleteAdminSpecial", param); // 전문분야 삭제
				
				List<String> list = (List<String>) param.get("admin_cates");// 여기서에러
				System.out.println("special"+param);
				for (String special_cd : list) { param.put("special_cd", special_cd);
				commonDao.insert("adminSpecial.insertAdminSpecial", param); // 전문분야등록
				}
			}
			
			String profileImgUrl = String.valueOf( uploadFile.get("img_url") );
			param.put("profile_url", profileImgUrl);
			commonDao.update("admin.updateAdminInfo", param);  // 관리자정보등록
			

		return commonDao.update("admin.updateAdminInfo", param);  // 관리자정보등록
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


	/**
	 * 일정관리 관리자목록조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> scheduleAdminList(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("admin.selectScheduleAdminList", param);
	}

	/**
	 * 권한에따른 접속가능 메뉴전체목록
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> selectMenuTree(Map<String, Object> param){
		return commonDao.queryForList("admin.selectAdminMenuList", param);
	}
}
