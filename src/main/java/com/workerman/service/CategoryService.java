package com.workerman.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.dao.CommonDao;
import com.workerman.utils.Utils;
import com.workerman.vo.CategoryInfoReqVo;
import com.workerman.vo.CategoryInfoResVo;
import com.workerman.vo.CategoryInfoVo;
import com.workerman.vo.CategoryListReqVo;
import com.workerman.vo.CategoryListResVo;
import com.workerman.vo.CategoryListVo;
import com.workerman.vo.WorkResCategoryDataVo;

@Service("categoryService")
public class CategoryService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	/**
	 * 카테고리목록조회
	 * @param categoryListReqVo
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public CategoryListResVo categoryList(CategoryListReqVo categoryListReqVo) throws Exception{
		
		CategoryListResVo categoryListResVo = new CategoryListResVo();
		
		CategoryListVo categoryListVo = new CategoryListVo();
		
		categoryListVo.setList(commonDao.queryForList("category.selectCategorySubList", Utils.objectToMap(categoryListReqVo)));
		
		categoryListResVo.setResult_data(categoryListVo);
		
		categoryListResVo.setErrorNone();
		
		return categoryListResVo;
	}
	
	/**
	 * 카테고리정보조회
	 * @param categoryInfoReqVo
	 * @return
	 * @throws Exception
	 */
	public CategoryInfoResVo categoryInfo(CategoryInfoReqVo categoryInfoReqVo) throws Exception{
		
		CategoryInfoResVo categoryInfoResVo = new CategoryInfoResVo();
		
		CategoryInfoVo categoryInfoVo = new CategoryInfoVo();
		
		categoryInfoVo.setInfo((WorkResCategoryDataVo)commonDao.queryForObjectNoCast("category.selectCategoryPathInfo", Utils.objectToMap(categoryInfoReqVo)));
		
		categoryInfoResVo.setResult_data(categoryInfoVo);
		
		categoryInfoResVo.setErrorNone();
		
		return categoryInfoResVo;
	}
	
}
