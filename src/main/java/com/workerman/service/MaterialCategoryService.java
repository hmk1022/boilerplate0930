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

@Service("materialCategoryService")
public class MaterialCategoryService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private S3Service s3Service;
	
	
	/**
	 * 카테고리 정보 조회.
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectCategoryList(Map<String, Object> param) {
		return commonDao.queryForList("material_category.selectCategoryList", param);
	}
	
	
	
}
