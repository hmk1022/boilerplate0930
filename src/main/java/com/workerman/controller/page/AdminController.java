package com.workerman.controller.page;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
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
import com.workerman.service.AdminGpsHistService;
import com.workerman.service.AdminService;
import com.workerman.service.B2bWorkService;
import com.workerman.service.CodeService;
import com.workerman.service.CompanyService;
import com.workerman.service.CustomerService;
import com.workerman.service.FileService;

@Controller
@RequestMapping(value = "/operation/admin/*")
public class AdminController extends BaseController{

	@Autowired
	private AdminService adminService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private CompanyService companyService;

	@Autowired
	private B2bWorkService b2bWorkService;

	@Autowired
	private FileService fileService;

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 05. 27.
	 * @Method Name : list
	 * @return : String
	 * @note : Admin 계정관리
	 */
	@GetMapping(path="index")
	public String index(
			@RequestParam Map<String, Object> param,
			ModelMap model
			) throws Exception {

		 model.put("admin_cd", codeService.selectCodeByGbString("admin_cd")); // 관리자코드
		 model.put("stat_cd", codeService.selectCodeByGbString("stat_cd")); // 상태코드
		 model.put("admin_cate", codeService.selectCodeByGbString("admin_cate")); //
		 model.put("department", codeService.selectCodeByGbString("department"));
		 model.put("position", codeService.selectCodeByGbString("position")); //
		 model.put("company", companyService.selectCompanyList()); // 업체


		return "operation/admin/index";
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 05. 27.
	 * @Method Name : list
	 * @return : String
	 * @note : Admin 계정관리 리스트
	 */
	@PostMapping(path="list/ajax")
	public ResponseEntity<Map<String, Object>> list(@RequestParam Map<String, Object> param,
			ModelMap model
			) throws Exception {
		Map<String,Object> returnMap = new HashMap<String, Object>();
		System.out.println("파람"+param);
		int pqCurpage = Integer.valueOf(  (String) param.getOrDefault("pq_curpage","0") );
		int pqRpp = Integer.valueOf(  (String) param.getOrDefault("pq_rpp","50") );
		if(pqCurpage > 0) {
			int pageFirst = (pqCurpage-1) * pqRpp  ;
			int pageLast = pqRpp ;
			param.put("pageFirst", pageFirst);
			param.put("pageLast", pageLast);
		}
		param.put("admin_type", "01");
		List<Map<String, Object>> list = adminService.adminList(param);

		model.addAttribute("special_name",adminService.adminList(param));
		int totalRecords = adminService.adminListCnt(param);
		returnMap.put("data", list);
		returnMap.put("curPage", String.valueOf(param.get("pq_curpage")));
		returnMap.put("totalRecords", totalRecords);
		return new ResponseEntity<Map<String, Object>>(returnMap, HttpStatus.OK);
	}


	/**
	 * @Author : sbahn
	 * @Date	: 2021. 05. 27.
	 * @Method Name : excel
	 * @return : String
	 * @note : Admin 계정관리 리스트 엑셀다운
	 */
	@PostMapping(path="list/excel")
	public String excel(String pq_data, String pq_ext, Boolean pq_decode, String pq_filename, HttpServletRequest request) throws Exception {
		  String[] arr = new String[] {"csv", "xlsx", "htm", "zip", "json"};
	        String filename = pq_filename + "." + pq_ext;

	        if(Arrays.asList(arr).contains(pq_ext)){
	            HttpSession ses = request.getSession(true);
	            ses.setAttribute("pq_data", pq_data);
	            ses.setAttribute("pq_decode", pq_decode);
	            ses.setAttribute("pq_filename", filename);
	        }
	        return filename;
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 05. 27.
	 * @Method Name : excel
	 * @return : void
	 * @note : Admin 계정관리 리스트 엑셀다운
	 */
	@GetMapping(path="list/excel")
	public void excel(String pq_filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession ses = request.getSession(true);
        if ( ((String)ses.getAttribute("pq_filename")).equals(pq_filename) ) {

            String contents = (String) ses.getAttribute("pq_data");
            Boolean pq_decode = (Boolean) ses.getAttribute("pq_decode");

            byte[] bytes =  contents.getBytes(Charset.forName("UTF-8"));

            response.setContentType("application/octet-stream");

            response.setHeader("Content-Disposition",
                    "attachment;filename=" + pq_filename);
            response.setContentLength(bytes.length);
            ServletOutputStream out = response.getOutputStream();
            out.write(bytes);

            out.flush();
            out.close();
        }
	}


	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name : form
	 * @return : String
	 * @note :계정 등록 폼
	 */
	@RequestMapping(path="form")
	public String form(
			@RequestParam Map<String, Object> param,
			ModelMap model
			) throws Exception {


		 Map<String, Object> image_map = new HashMap<String,Object>();


		 model.put("admin_cd", codeService.selectCodeByGbString("admin_cd")); // 관리자코드
		 model.put("stat_cd", codeService.selectCodeByGbString("stat_cd")); // 상태코드
		 model.put("admin_cate", codeService.selectCodeByGbString("admin_cate")); //
		 model.put("department", codeService.selectCodeByGbString("department"));
		 model.put("position", codeService.selectCodeByGbString("position")); //
		 model.put("company", companyService.selectCompanyList()); // 업체

		 System.out.println("param4"+param);

		/* case modify */

		if(StringUtils.isNoneBlank((String)param.get("admin_no"))){
			model.addAttribute("data",adminService.selectAdmin(param));

			List<Map<String, Object>> imageList = new ArrayList<Map<String, Object>>();

			/* select file info */
			Map<String, Object> fileMap = new HashMap<String, Object>();
			fileMap.put("img_type", Constants.IMG_TYPE_ADMIN);
			fileMap.put("key_no", param.get("admin_no").toString());
			model.addAttribute("imageList", fileService.listImgInfo(fileMap));

			//model.addAttribute("imageList",imageList);
		}

		return "operation/admin/form";
	}


	/**
	 * @Author : hm.kim
	 * @Date	: 2021. 08. 30.
	 * @Method Name : form
	 * @return : String
	 * @note :계정 등록 폼
	 */
	@RequestMapping(path="/workerman/form")
	public String wform(
			@RequestParam Map<String, Object> param,
			ModelMap model
			) throws Exception {


		 Map<String, Object> image_map = new HashMap<String,Object>();


		 model.put("admin_cd", codeService.selectCodeByGbString("admin_cd")); // 관리자코드
		 model.put("stat_cd", codeService.selectCodeByGbString("stat_cd")); // 상태코드
		 model.put("admin_cate", codeService.selectCodeByGbString("admin_cate")); //
		 model.put("department", codeService.selectCodeByGbString("department"));
		 model.put("position", codeService.selectCodeByGbString("position")); //
		 model.put("company", companyService.selectCompanyList()); // 업체

		 System.out.println("parammm"+param);


		if(StringUtils.isNoneBlank((String)param.get("admin_no"))){
			model.addAttribute("data",adminService.selectAdmin(param));
			 image_map.put("img_url",(String)
			 adminService.selectAdmin(param).get("profile_url"));

//			 List<Map<String, Object>> imageList = new ArrayList<Map<String, Object>>();
//
//			 imageList.add(image_map);
//
//			 model.addAttribute("imageList",imageList);

			 /* select file info */
			 Map<String, Object> fileMap = new HashMap<String, Object>();
			 fileMap.put("img_type", Constants.IMG_TYPE_ADMIN);
			 fileMap.put("key_no", param.get("admin_no").toString());
			 model.addAttribute("imageList", fileService.listImgInfo(fileMap));
		}

		return "operation/workerman/form";
	}
	/**
	 * @Author : hm.kim
	 * @Date	: 2021. 08. 25.
	 * @Method Name : form
	 * @return : String
	 * @note :계정 상세보기
	 */
	@RequestMapping(path="view")
	public String view(
			@RequestParam Map<String, Object> param,
			ModelMap model
			) throws Exception {

			Map<String, Object> image_map = new HashMap<String,Object>();

			param.put("w_admin","01");
			//image_map.put("img_url",(String) adminService.selectAdmin(param).get("profile_url"));
			//image_map.put("img_url",(String) adminService.selectAdmin(param).get("profile_url"));
			System.out.println("ㄹㄹㄹㄹ"+param);
			Map<String, Object> fileMap = new HashMap<String, Object>();
			fileMap.put("img_type", Constants.IMG_TYPE_ADMIN);
			fileMap.put("key_no", param.get("admin_no").toString());
			model.addAttribute("imageList", fileService.listImgInfo(fileMap));

			//List<Map<String, Object>> imageList = new ArrayList<Map<String, Object>>();

			//imageList.add(image_map);
			System.out.println("view"+param);
			model.addAttribute("data",adminService.selectAdmin(param));
			//model.addAttribute("imageList",imageList);

		return "operation/admin/view";
	}
	/**
	 * @Author : hm.kim
	 * @Date	: 2021. 08. 25.
	 * @Method Name : form
	 * @return : String
	 * @note :워커맨계정 상세보기
	 */
	@RequestMapping(path="wview")
	public String w_view(
			@RequestParam Map<String, Object> param,
			ModelMap model
			) throws Exception {

		Map<String, Object> image_map = new HashMap<String,Object>();

		param.put("w_admin","02");
		image_map.put("img_url",(String) adminService.selectAdmin(param).get("profile_url"));


		Map<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("img_type", Constants.IMG_TYPE_ADMIN);
		fileMap.put("key_no", param.get("admin_no").toString());
		model.addAttribute("imageList", fileService.listImgInfo(fileMap));
		//List<Map<String, Object>> imageList = new ArrayList<Map<String, Object>>();

		//imageList.add(image_map);
		System.out.println("wview"+param);
		model.addAttribute("data",adminService.selectAdmin(param));

		//model.addAttribute("imageList",imageList);

		/*
		 * Map<String, Object> image_map = new HashMap<String,Object>();
		 *
		 * param.put("w_admin","02"); image_map.put("img_url",(String)
		 * adminService.selectAdmin(param).get("profile_url"));
		 *
		 * List<Map<String, Object>> imageList = new ArrayList<Map<String, Object>>();
		 *
		 * imageList.add(image_map); System.out.println("view"+param);
		 * model.addAttribute("data",adminService.selectAdmin(param));
		 * model.addAttribute("imageList",imageList);
		 */

		return "operation/workerman/view";
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name : form
	 * @return : String
	 * @note :계정 등록 폼
	 */
	@PostMapping(path="save/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String save(
			@RequestParam Map<String, Object> param,
			@RequestParam("upLoadFile") MultipartFile[] files, // upload file
			Model model,
			Error error
			) throws Exception {
		/* return map */
		Map<String,Object> returnMap = new HashMap<String,Object>();
		param.put("stat", "00");
		param.put("admin_type", "01");
		System.out.println("save param:" + param);
		param.put("files", files); // file
		adminService.saveAdmin(param);
		System.out.println("type확인"+param);
		return Constants.EVENT_SAVE_SUCCESS;
	}
	/**
	 * @Author : hm.kim
	 * @Date	: 2021. 08. 26.
	 * @Method Name : form
	 * @return : String
	 * @note :워커맨계정 등록 폼
	 */
	@PostMapping(path="wsave/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String wsave(
			@RequestParam Map<String, Object> param,
			@RequestParam("upLoadFile") MultipartFile[] files, // upload file
			Model model
			) throws Exception {
		/* return map */
		Map<String,Object> returnMap = new HashMap<String,Object>();
		param.put("admin_type", "02");
		System.out.println("워커맨 등록 param :" + param);

		List<String> categoryList = new ArrayList<String>();

		// 전문분야 다중 선택
		for (int i = 1; i < 17; i++ ) {
			if ( param.get("admin_cate_" + i) != null) {
				categoryList.add((String) param.get("admin_cate_" + i));
			}
		}

		param.put("admin_cates", categoryList);
		param.put("stat", "00");
		System.out.println("admin_cates"+ param.get("admin_cates"));

		param.put("files", files); // file
		adminService.saveAdmin(param);
		System.out.println("전문분야"+param);
		return Constants.EVENT_SAVE_SUCCESS;
	}

	/**
	 * 계정상태갱신
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="updateAdminStat")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String updateAdminStat(@RequestBody Map<String, Object> param) throws Exception{
		adminService.updateAdminStat(param);
		return Constants.EVENT_SAVE_SUCCESS;
	}

}
