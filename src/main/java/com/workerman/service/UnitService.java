package com.workerman.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.workerman.commons.CommonCode;
import com.workerman.dao.CommonDao;
import com.workerman.utils.DateUtil;
import com.workerman.utils.StringUtil;
import com.workerman.utils.Utils;
import com.workerman.vo.AuthNumberDataVo;
import com.workerman.vo.AuthNumberReqVo;
import com.workerman.vo.AuthNumberResVo;
import com.workerman.vo.CaseListDataVo;
import com.workerman.vo.CaseListReqVo;
import com.workerman.vo.CaseListResVo;
import com.workerman.vo.CaseListVo;
import com.workerman.vo.CaseListWorkImgDataVo;
import com.workerman.vo.CaseMainListReqVo;
import com.workerman.vo.CaseMainListResVo;
import com.workerman.vo.CaseMainListVo;
import com.workerman.vo.ResultVo;
import com.workerman.vo.ReviewReqVo;
import com.workerman.vo.WorkCancelReqVo;
import com.workerman.vo.WorkDataVo;
import com.workerman.vo.WorkDetailDataVo;
import com.workerman.vo.WorkDetailReqVo;
import com.workerman.vo.WorkDetailResVo;
import com.workerman.vo.WorkDetailVo;
import com.workerman.vo.WorkListReqVo;
import com.workerman.vo.WorkListResVo;
import com.workerman.vo.WorkListVo;
import com.workerman.vo.WorkReqVo;
import com.workerman.vo.WorkResCategoryDataVo;
import com.workerman.vo.WorkResDataVo;
import com.workerman.vo.WorkResVo;

@Service("unitService")
public class UnitService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	
	/**
	 * 종료되지 않은 B2B, Project 작업 조회.
	 * @param param
	 * @return
	 */
	/*
	 * public List<Map<String, Object>> selectUnitList(Map<String, Object> param) {
	 * return commonDao.queryForList("brand.selectUnitList", param); }
	 */
	
	/**
	 * 단위 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listUnit(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("unit.listUnit", param);
	}
	
	/**
	 * 단위 상세조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectUnit(Map<String, Object> param) throws Exception{
		return (Map<String, Object>)commonDao.queryForObject("unit.selectUnit", param);
	}
	
	/**
	 * 단위 상세보기 count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int listUnitCnt(Map<String, Object> param) throws Exception{
		return (Integer)commonDao.queryForInt("unit.listUnitCnt", param);
	}
	
	/**
	 * 단위 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveUnit(Map<String, Object> param) throws Exception{
		if(StringUtils.isBlank((String)param.get("code_no"))){	// check pk-key
			return insertUnit(param);
		} else {
			return updateUnit(param);
		}
	}
	
	/**
	 * 단위 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertUnit(Map<String, Object> param) throws Exception{
		System.out.println("유닛 파람"+ param);
		int result = commonDao.insert("unit.insertUnit", param);
		return result;
	}
	
	/**
	 * 단위 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateUnit(Map<String, Object> param) throws Exception{
		System.out.println("유닛 수정"+ param);
		int result = commonDao.update("unit.updateUnit", param);
		return result;
	}
	
	/**
	 * 단위 상태 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateUnitStat(Map<String, Object> param) throws Exception{
		int result = commonDao.update("unit.updateUnitStat", param);
		return result;
	}
}
