package com.workerman.controller.page;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;

import com.workerman.config.Constants;
import com.workerman.controller.BaseController;
import com.workerman.service.BrandService;
import com.workerman.service.CodeService;
import com.workerman.service.FileService;
import com.workerman.utils.StringUtil;

@Controller
public class BrandController extends BaseController{

	@Autowired
	private BrandService brandService;

	@Autowired
	private FileService fileService;

	@Autowired
	private CodeService codeService;


	/**
	 * @Author : dw.kwon
	 * @Date	: 2021. 03. 24.
	 * @Method Name : listAjax
	 * @return : String
	 * @note :브랜드목록 list ajax
	 */
	@RequestMapping(path="/brand/list/ajax")
	public ResponseEntity<Map<String, Object>> selectCategoryList(
			@RequestBody Map<String, Object> param) throws Exception {

		/* return map */
		Map<String,Object> returnMap = new HashMap<String,Object>();

		/* get list */
		returnMap.put("data", brandService.selectBrandList(param));

		return new ResponseEntity<Map<String, Object>>(returnMap, HttpStatus.OK);
	}

	/**
	 * @Author : dw.kwon
	 * @Date	: 2021. 03. 24.
	 * @Method Name : list
	 * @return : String
	 * @note :브랜드 리스트
	 */
	@GetMapping(path="/code/brand/list")
	public String list(
			@RequestParam Map<String, Object> param,
			Model model
			) throws Exception {

		return "code/brand/list";
	}

	/**
	 * @Author : dw.kwon
	 * @Date	: 2021. 03. 24.
	 * @Method Name : listAjax
	 * @return : String
	 * @note :고객사지점
	 */
	@RequestMapping(path="/code/brand/list/ajax")
	public ResponseEntity<Map<String, Object>> listAjax(@RequestParam Map<String, Object> param) throws Exception {

		/* return map */
		Map<String,Object> returnMap = new HashMap<String,Object>();

		/* pagination */
		if( param.get("pq_rpp") != null) {
			int pageFirst = (Integer.parseInt( String.valueOf(param.get("pq_curpage")))-1) * Integer.parseInt( String.valueOf(param.get("pq_rpp")))  ;
			int pageLast = Integer.parseInt( String.valueOf(param.get("pq_rpp"))) ;
			param.put("pageFirst", pageFirst);
			param.put("pageLast", pageLast);

			returnMap.put("curPage", String.valueOf(param.get("pq_curpage")));
			/* get count */
			returnMap.put("totalRecords", brandService.listBrandCnt(param));
		}

		/* get list */
		returnMap.put("data", brandService.listBrand(param));

		return new ResponseEntity<Map<String, Object>>(returnMap, HttpStatus.OK);
	}

	/**
	 * @Author : dw.kwon
	 * @Date	: 2021. 03. 24.
	 * @Method Name : form
	 * @return : String
	 * @note :브랜드 등록 폼
	 */
	@RequestMapping(path="/code/brand/form")
	public String form(
			@RequestParam Map<String, Object> param,
			Model model
			) throws Exception {

		/* case modify */
		if(StringUtil.isNoneBlank((String)param.get("brand_no"))){
			model.addAttribute("data", brandService.selectBrand(param));
		}

		return "code/brand/form";
	}

	/**
	 * @Author : dw.kwon
	 * @Date	: 2021. 03. 24.
	 * @Method Name : form
	 * @return : String
	 * @note :브랜드 등록 폼
	 */
	@PostMapping(path="/code/brand/save/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String save(
			@RequestParam Map<String, Object> param,
			@RequestParam("upLoadFile") MultipartFile[] files, // upload file
			Model model
			) throws Exception {

//		Map<String, Object> param = getQueryMap();

		//param.put("del_yn", Constants.NOT_DELETED); // 상태

		param.put("create_no", getAdminNo()); // admin_no
		param.put("update_no", getAdminNo()); // admin_no

		brandService.saveBrand(param);

		return Constants.EVENT_SAVE_SUCCESS;
	}

	/**
	 * @Author : dw.kwon
	 * @Date	: 2021. 03. 24.
	 * @Method Name : form
	 * @return : String
	 * @note :브랜드 삭제
	 */
	@GetMapping(path="/code/brand/delete")
	public ResponseEntity<Map<String, Object>> delete(
			@RequestBody Map<String, Object> param,
			Model model
			) throws Exception {
		/* return map */
		Map<String,Object> returnMap = new HashMap<String,Object>();

		brandService.deleteBrand(param);

		return new ResponseEntity<Map<String, Object>>(returnMap, HttpStatus.OK);
	}


	/**
	 * @Author : dw.kwon
	 * @Date	: 2021. 03. 24.
	 * @Method Name : form
	 * @return : String
	 * @note :브랜드 등록 폼
	 */
	@PostMapping(path="/code/brand/view")
	public String view(
			@RequestParam Map<String, Object> param,
			Model model
			) throws Exception {

		if(StringUtil.isBlank((String)param.get("brand_no"))){
			throw new Exception(Constants.ERROR_EMPTY_KEY);
		}

		model.addAttribute("data", brandService.selectBrand(param));

		return "code/brand/view";
	}


	/**
	 * 브랜드상태갱신
	 * @param param
	 * @return
	 * @throws Exception
	 */
	 @PostMapping(value="/brand/updateBrandStat")
	 @ResponseStatus(HttpStatus.CREATED)
	 @ResponseBody public String updateAdminStat(@RequestBody Map<String, Object>
	 param) throws Exception{
		 System.out.println("브랜드 상태"+param);
		 brandService.updateBrandStat(param); return
	 Constants.EVENT_SAVE_SUCCESS; }


	//updateBrandStat
}
