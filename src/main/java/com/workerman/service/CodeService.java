package com.workerman.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.dao.CommonDao;
import com.workerman.utils.Utils;
import com.workerman.vo.AppVersionDataVo;
import com.workerman.vo.AppVersionReqVo;
import com.workerman.vo.AppVersionResVo;

@Service("codeService")
public class CodeService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	/**
	 * 앱버전정보조회
	 * @param appVersionReqVo
	 * @return
	 */
	public AppVersionResVo appInfo(AppVersionReqVo appVersionReqVo) {

		AppVersionResVo appVersionResVo = new AppVersionResVo();

		if(appVersionReqVo.getOs_type().equals("android")) {
			appVersionReqVo.setCode_gb("android_app_v");
		}else {
			appVersionReqVo.setCode_gb("ios_app_v");
		}

		Map<String, Object> code = commonDao.queryForObject("code.selectCodeByCodeGb", Utils.objectToMap(appVersionReqVo));

		AppVersionDataVo appVersionDataVo= new AppVersionDataVo();
		appVersionDataVo.setApp_v(code.get("code_name").toString());

		appVersionResVo.setErrorNone();
		appVersionResVo.setResult_data(appVersionDataVo);

		return appVersionResVo;

	}
	/**
	 * 하위코드목록조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCodeByGb(String codeGb){
		return commonDao.queryForList("code.selectCodeByGb", codeGb);
	}
	/**
	 * 하위코드목록조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectCodeByGbString(String code_gb){
		return commonDao.queryForList("code.selectCodeByGbString", code_gb);
	}
	/**
	 * 코드목록 전체조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectCodeAllList(){
		return commonDao.queryForList("code.selectCodeAllList");
	}
}
