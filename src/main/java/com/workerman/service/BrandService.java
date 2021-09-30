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

@Service("brandService")
public class BrandService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	
	/**
	 * 종료되지 않은 B2B, Project 작업 조회.
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectBrandList(Map<String, Object> param) {
		return commonDao.queryForList("brand.selectBrandList", param);
	}
	
	

	/**
	 * 브랜드 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listBrand(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)commonDao.queryForList("brand.listBrand", param);
	}
	
	/**
	 * 브랜드 조회 count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int listBrandCnt(Map<String, Object> param) throws Exception{
		return (Integer)commonDao.queryForInt("brand.listBrandCnt", param);
	}
	
	/**
	 * 브랜드 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveBrand(Map<String, Object> param) throws Exception{
		if(StringUtils.isBlank((String)param.get("brand_no"))){	// check pk-key
			return insertBrand(param);
		} else {
			return updateBrand(param);
		}
	}
	
	/**
	 * 브랜드 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertBrand(Map<String, Object> param) throws Exception{
		int result = commonDao.insert("brand.insertBrand", param);
		return result;
	}
	
	/**
	 * 브랜드 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateBrand(Map<String, Object> param) throws Exception{
		int result = commonDao.update("brand.updateBrand", param);
		return result;
	}
	
	/**
	 * 브랜드 상태 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateBrandStat(Map<String, Object> param) throws Exception{
		int result = commonDao.update("brand.updateBrandStat", param);
		return result;
	}
	
	/**
	 * 브랜드 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteBrand(Map<String, Object> param) throws Exception{
		return commonDao.update("brand.deleteBrand", param);
	}
	
	/**
	 * 브랜드 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectBrand(Map<String, Object> param) throws Exception{
		return commonDao.queryForObject("brand.selectBrand", param);
	}
	
}
