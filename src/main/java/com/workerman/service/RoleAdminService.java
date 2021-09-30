package com.workerman.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.workerman.dao.CommonDao;

@Service("roleAdminService")
public class RoleAdminService extends BaseService {

	@Autowired
	private CommonDao commonDao;

	/**
	 * 권한목록
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRoleAdminList(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("roleAdmin.selectRoleAdminList", param);
	}
	/**
	 * abc권한목록
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRoleAbcAdminList(Map<String, Object> param){
		return (List<Map<String, Object>>)commonDao.queryForList("roleAdmin.selectRoleAbcAdminList", param);
	}
	/**
	 * anc권한목록cnt
	 * @param param
	 * @return
	 */
	public int selectRoleAbcAdminListCnt(Map<String, Object> param){
		return (int)commonDao.queryForInt("roleAdmin.selectRoleAbcAdminListCnt", param);
	}
	
	/**
	 * 권한목록cnt
	 * @param param
	 * @return
	 */
	public int selectRoleAdminListCnt(Map<String, Object> param){
		return (int)commonDao.queryForInt("roleAdmin.selectRoleAdminListCnt", param);
	}
	
	public int deleteRoleAdmin(Map<String, Object> param){
		int result = commonDao.delete("roleAdmin.deleteRoleAdmin", param);
		return result;
	}
	
}
