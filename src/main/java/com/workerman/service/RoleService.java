package com.workerman.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.workerman.dao.CommonDao;

@Service("roleService")
public class RoleService extends BaseService {

	@Autowired
	private CommonDao commonDao;

	/**
	 * 권한목록
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRoleList(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("role.selectRoleList", param);
	}
	/**
	 * abc권한목록
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAbcRoleList(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("role.selectAbcRoleList", param);
	}
	/**
	 * 권한명목록
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRoleName(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("role.selectRoleName", param);
	}
	/**
	 * 권한없는 id목록
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNoRole(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("role.selectNoRole", param);
	}
	/**
	 * 권한목록cnt
	 * @param param
	 * @return
	 */
	public int selectRoleListCnt(Map<String, Object> param){
		return (int)commonDao.queryForInt("role.selectRoleListCnt", param);
	}
	/**
	 * abc권한목록cnt
	 * @param param
	 * @return
	 */
	public int selectAbcRoleListCnt(Map<String, Object> param){
		return (int)commonDao.queryForInt("role.selectAbcRoleListCnt", param);
	}
	/**
	 * 권한선택
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectRole(Map<String, Object> param){
		return (Map<String, Object>)commonDao.queryForObject("role.selectRole", param);
	}
	/**
	 * 권한추가
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int insertRole(Map<String, Object> param){
		int result = commonDao.insert("role.insertRole", param);
		return result;
	}
	/**
	 * 관리자 권한추가
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int insertRoleAdmin(Map<String, Object> param){
		System.out.println("롤노"+param);
		int result = commonDao.insert("role.insertRoleAdmin", param);
		return result;
	}
	/**
	 * 권한수정
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int updateRole(Map<String, Object> param){
		int result = commonDao.update("role.updateRole", param);
		return result;
	}
	
	/**
	 * 권한삭제
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int deleteRole(Map<String, Object> param){
		System.out.println("삭제 데이터?"+param);
		int result = commonDao.delete("role.deleteRole", param);
		return result;
	}
}
