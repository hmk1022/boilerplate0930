package com.workerman.controller.page;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.workerman.service.AdminScheduleService;
import com.workerman.service.AdminService;
import com.workerman.service.B2bWorkService;
import com.workerman.service.CodeService;
import com.workerman.service.CompanyService;
import com.workerman.service.CustomerService;
import com.workerman.service.EstimateService;
import com.workerman.service.FileService;
import com.workerman.utils.Utils;

@Controller
public class AbcWorkController extends BaseController{

	@Autowired
	private B2bWorkService b2bWorkService;

	@Autowired
	private CompanyService companyService;

	@Autowired
	private AdminService adminService;

	@Autowired
	private AdminScheduleService adminScheduleService;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private EstimateService estimateService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private FileService fileService;

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 21.
	 * @Method Name : index
	 * @return : String
	 * @note :
	 */
	@GetMapping(path="/abc/work/b2b/list")
	public String b2bList(
			@RequestParam Map<String, Object> param,
			ModelMap model
			) throws Exception {
		model.put("work_target", "04");
		model.put("company", companyService.selectCompanyList());
		model.put("customer", customerService.listCustomer(param));
		model.put("channel", codeService.selectCodeByGb("channel"));

		List<Map<String, Object>> customerBranchList = customerService.listCustomerBranch(param);
		model.put("customerBranchList",  Utils.objectToJson(customerBranchList)); // 워커맨
		return "work/list";
	}

	@GetMapping(path="/abc/work/project/list")
	public String proejctList(
			@RequestParam Map<String, Object> param,
			ModelMap model
			) throws Exception {
		model.put("work_target", "03");
		model.put("company", companyService.selectCompanyList());
		model.put("customer", customerService.listCustomer(param));
		model.put("channel", codeService.selectCodeByGb("channel"));

		List<Map<String, Object>> customerBranchList = customerService.listCustomerBranch(param);
		model.put("customerBranchList",  Utils.objectToJson(customerBranchList)); // 워커맨
		return "work/list";
	}
	@GetMapping(path="/abc/work/form")
	public String form(
			@RequestParam Map<String, Object> param,
			ModelMap model
			) throws Exception {
		param.put("admin_type", "01");
		param.put("stat", "00");
		List<Map<String, Object>> adminList = adminService.adminList(param);
		List<Map<String, Object>> customerList = customerService.listCustomer(param);
		List<Map<String, Object>> customerBranchList = customerService.listCustomerBranch(param);
		model.put("adminList", adminList); // 워커맨
		model.put("customerList", customerList); // 워커맨
		model.put("channel", codeService.selectCodeByGb("channel")); // 워커맨
		model.put("customerBranchList",  Utils.objectToJson(customerBranchList)); // 워커맨
		return "work/form";
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note :작업등록
	 */
	@PostMapping(path="/abc/work/save/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String save(
			@RequestParam Map<String, Object> param,
			@RequestParam(value="upLoadFile",required=false) MultipartFile[] files, // upload file
			Model model
			) throws Exception {
		param.put("update_no", getAdminNo());
		System.out.println("param:" + param);
		param.put("files", files); // file
		b2bWorkService.saveWork(param);
		return Constants.EVENT_SAVE_SUCCESS;
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 09. 27.
	 * @Method Name :
	 * @return : String
	 * @note :작업취소
	 */
	@PostMapping(path="/abc/work/cancel/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String cancel(
			@RequestBody Map<String, Object> param,
			Model model
			) throws Exception {
		param.put("update_no", getAdminNo());
		System.out.println("param:" + param);
		b2bWorkService.cancelWork(param);
		return Constants.EVENT_SAVE_SUCCESS;
	}
	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note :작업등록
	 */
	@PostMapping(path="/abc/work/reqContent/save/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String reqContentSave(
			@RequestBody Map<String, Object> param,
			Model model
			) throws Exception {
		param.put("update_no", getAdminNo());
		System.out.println("param:" + param);
		b2bWorkService.reqContentSave(param);
		return Constants.EVENT_SAVE_SUCCESS;
	}
	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 21.
	 * @Method Name : list
	 * @return : String
	 * @note :
	 */
	@PostMapping(path="/abc/work/list/ajax")
	public ResponseEntity<Map<String, Object>> list(@RequestParam Map<String, Object> param) throws Exception {
		Map<String,Object> returnMap = new HashMap<String, Object>();
		int pqCurpage = Integer.valueOf(  (String) param.getOrDefault("pq_curpage","0") );
		int pqRpp = Integer.valueOf(  (String) param.getOrDefault("pq_rpp","50") );
		if(pqCurpage > 0) {
			int pageFirst = (pqCurpage-1) * pqRpp  ;
			int pageLast = pqRpp ;
//			int pageLast = pqCurpage * (pqRpp -1) ;
			param.put("pageFirst", pageFirst);
			param.put("pageLast", pageLast);
		}
		List<Map<String, Object>> list = b2bWorkService.workList(param);
		int totalRecords = b2bWorkService.workListCnt(param);
		returnMap.put("data", list);
		returnMap.put("curPage", String.valueOf(param.get("pq_curpage")));
		returnMap.put("totalRecords", totalRecords);
		return new ResponseEntity<Map<String, Object>>(returnMap, HttpStatus.OK);
	}


	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 21.
	 * @Method Name : view
	 * @return : String
	 * @note : view
	 */
	@PostMapping(path="/abc/work/view")
	public String view(
			@RequestParam Map<String, Object> param,
			Model model
			) throws Exception {

		if(StringUtils.isBlank((String)param.get("work_no"))){
			throw new Exception(Constants.ERROR_EMPTY_KEY);
		}
		model.addAttribute("data", b2bWorkService.selectWork(param));


		return "work/view";
	}
	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note :요청사항메모 조회
	 */
	@PostMapping(path="/abc/work/memo/view")
	public String memoView(
			@RequestParam Map<String, Object> param,
			Model model
			) throws Exception {

		if(StringUtils.isBlank((String)param.get("work_no"))){
			throw new Exception(Constants.ERROR_EMPTY_KEY);
		}

		model.addAttribute("workList", b2bWorkService.selectWork(param));
		param.put("memo_type", "2");
		model.addAttribute("adminMemoList", b2bWorkService.selectWorkMemoList(param));
		param.put("memo_type", "1");
		model.addAttribute("workermanMemoList", b2bWorkService.selectWorkMemoList(param));

		Map<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("img_type", Constants.IMG_TYPE_WORK_REG);
		fileMap.put("key_no", param.get("work_no"));
		model.addAttribute("imageList", fileService.listImgInfo(fileMap));

		return "work/memo/view";
	}
	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note : 요청사항메모 수정 - ??
	 */
	@PostMapping(path="/abc/work/memo/save/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String memoSave(
			@RequestBody Map<String, Object> param,
			Model model
			) throws Exception {

		System.out.println("param:" + param);
		param.put("memo_type", "02");
		param.put("admin_no", getAdminNo());
		b2bWorkService.saveWorkMemo(param);
		return Constants.EVENT_SAVE_SUCCESS;
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note :작업일정 조회
	 */
	@PostMapping(path="/abc/work/schedule/view")
	public String scheduleView(
			@RequestParam Map<String, Object> param,
			Model model
			) throws Exception {

		if(StringUtils.isBlank((String)param.get("work_no"))){
			throw new Exception(Constants.ERROR_EMPTY_KEY);
		}

		model.addAttribute("workData", b2bWorkService.selectWork(param));
		param.put("p_work_no", param.get("work_no") );
		model.addAttribute("subWorkList", b2bWorkService.subWorkList(param));

		return "work/schedule/view";
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note :일정관리 관리자 조회
	 */
	@PostMapping(path="/abc/work/admin/list/ajax")
	public  ResponseEntity<Map<String, Object>> scheduleAdminList(
			@RequestBody Map<String, Object> param,
			Model model
			) throws Exception {
		Map<String,Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = adminService.scheduleAdminList(param);
		returnMap.put("data", list);
		return new ResponseEntity<Map<String, Object>>(returnMap, HttpStatus.OK);
	}
	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note :일정조회
	 */
	@PostMapping(path="/abc/work/schedule/list/ajax")
	public  ResponseEntity<Map<String, Object>> scheduleList(
			@RequestBody Map<String, Object> param,
			Model model
			) throws Exception {
		Map<String,Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = adminScheduleService.scheduleList(param);
		returnMap.put("data", list);
		return new ResponseEntity<Map<String, Object>>(returnMap, HttpStatus.OK);
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note :하위일정조회
	 */
	@PostMapping(path="/abc/work/sub/schedule/list/ajax")
	public  ResponseEntity<Map<String, Object>> subWorkScheduleList(
			@RequestBody Map<String, Object> param,
			Model model
			) throws Exception {
		Map<String,Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = adminScheduleService.subWorkScheduleList(param);
		returnMap.put("data", list);
		return new ResponseEntity<Map<String, Object>>(returnMap, HttpStatus.OK);
	}



	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note :작업일정 등록
	 */
	@PostMapping(path="/abc/work/schedule/save/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String scheduleSave(
			@RequestBody Map<String, Object> param,
			Model model
			) throws Exception {

		System.out.println("param:" + param);
		adminScheduleService.saveSchdule(param);
		return Constants.EVENT_SAVE_SUCCESS;
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note :작업일정 종료
	 */
	@PostMapping(path="/abc/work/schedule/end/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String scheduleEnd(
			@RequestBody Map<String, Object> param,
			Model model
			) throws Exception {

		System.out.println("param:" + param);
		param.put("memo_type", 1);
		param.put("admin_no", getAdminNo());
		if(param.get("schedule_group_no") != null) {
			b2bWorkService.saveWorkMemo(param);
			adminScheduleService.endSchdule(param);
		}
		return Constants.EVENT_SAVE_SUCCESS;
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note :작업일정 종료
	 */
	@PostMapping(path="/abc/work/schedule/delete/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String scheduleDelete(
			@RequestBody Map<String, Object> param,
			Model model
			) throws Exception {

		System.out.println("param:" + param);
		param.put("memo_type", 1);
		param.put("admin_no", getAdminNo());
		param.put("schedule_stat","99");
		if(param.get("schedule_group_no") != null) {
			adminScheduleService.endSchdule(param);
		}
		return Constants.EVENT_SAVE_SUCCESS;
	}
	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note :하위작업등록 ( 수기접수 방식 )
	 */
	@PostMapping(path="/abc/work/sub/save/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String subSave(
			@RequestBody Map<String, Object> param,
			Model model
			) throws Exception {

		System.out.println("param:" + param);
		b2bWorkService.saveSubWork(param);
		return Constants.EVENT_SAVE_SUCCESS;
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note :작업일지 조회
	 */



	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note : 견적서 탭
	 */
	@PostMapping(path="/abc/work/estimate/view")
	public String estimateView(
			@RequestParam Map<String, Object> param,
			Model model
			) throws Exception {

		if(StringUtils.isBlank((String)param.get("work_no"))){
			throw new Exception(Constants.ERROR_EMPTY_KEY);
		}

		model.addAttribute("workData", b2bWorkService.selectWork(param));
		model.addAttribute("estimateVersionList", estimateService.selectEstimateVersionList(param));

		return "work/estimate/view";
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note : 견적서 탭
	 */
	@PostMapping(path="/abc/work/estimate/apply/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String estimateSave(
			@RequestBody Map<String, Object> param,
			Model model
			) throws Exception {


		System.out.println("param:" + param);
		param.put("update_no", getAdminNo());
		param.put("apply_admin_no", getAdminNo());
		b2bWorkService.applyEstimate(param);

		return Constants.EVENT_SAVE_SUCCESS;
	}
	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note : 견적서 탭
	 */
	@PostMapping(path="/abc/work/estimate/applyCancel/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String estimateApplyCancel(
			@RequestBody Map<String, Object> param,
			Model model
			) throws Exception {


		System.out.println("param:" + param);
		param.put("update_no", getAdminNo());
		param.put("apply_admin_no", getAdminNo());
		b2bWorkService.applyCancelEstimate(param);

		return Constants.EVENT_SAVE_SUCCESS;
	}
	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note : 작업일지 탭
	 */
	@PostMapping(path="/abc/work/daily/view")
	public String dailyView(
			@RequestParam Map<String, Object> param,
			Model model
			) throws Exception {

		if(StringUtils.isBlank((String)param.get("work_no"))){
			throw new Exception(Constants.ERROR_EMPTY_KEY);
		}
		model.addAttribute("dailyReportList", b2bWorkService.dailyReportList(param));

		return "work/daily/view";
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note : 실행가 탭
	 */
	@PostMapping(path="/abc/work/excute_price/view")
	public String excute_priceView(
			@RequestParam Map<String, Object> param,
			Model model
			) throws Exception {

		List<Map<String, Object>> excutePriceDailyList = b2bWorkService.dailyReportList(param);

		for(Map<String, Object> excutePriceData : excutePriceDailyList) {
			String workDate = String.valueOf( excutePriceData.get("st_date_ymd") ).replaceAll("-", "");
			Map<String, Object> expenseParam = new HashMap();
			expenseParam.put("work_no", param.get("work_no"));
			expenseParam.put("report_date", workDate);
			List<Map<String, Object>> expenseList =  b2bWorkService.selectExpenseList(expenseParam);
			double total_price = 0;
			double total_price_01 = 0;
			double total_price_02 = 0;
			double total_price_03 = 0;
			double total_price_04 = 0;
			for(Map<String, Object> expenseData : expenseList) {
				if( (!String.valueOf(expenseData.get("stat")).equals("99") && !String.valueOf(expenseData.get("exp_category")).equals("자재요청"))
						|| (!String.valueOf(expenseData.get("stat")).equals("06") && String.valueOf(expenseData.get("exp_category")).equals("자재요청")) ) {
					double price = Double.valueOf( String.valueOf(expenseData.get("price")) );
					total_price += price;
					if(expenseData.get("exp_type").equals("01") ) {
						total_price_01 += price;
					}else if(expenseData.get("exp_type").equals("02") ) {
						total_price_02 += price;
					}else if(expenseData.get("exp_type").equals("03") ) {
						total_price_03 += price;
					}else if(expenseData.get("exp_type").equals("04") ) {
						total_price_04 += price;
					}else if(expenseData.get("exp_type").equals("09") ) {
						total_price_03 += price;
					}
				}
			}
			excutePriceData.put("total_price", total_price);
			excutePriceData.put("total_price_01", total_price_01);
			excutePriceData.put("total_price_02", total_price_02);
			excutePriceData.put("total_price_03", total_price_03);
			excutePriceData.put("total_price_04", total_price_04);
		}

		model.addAttribute("workData", b2bWorkService.selectWork(param));
		model.addAttribute("excutePriceDailyList", excutePriceDailyList);
		model.addAttribute("estimateData", b2bWorkService.selectEstimateTotalAmount(param));
		model.addAttribute("excutePriceList", b2bWorkService.selectExcutePriceList(param));
		return "work/excute_price/view";
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note : 자재 탭
	 */
	@PostMapping(path="/abc/work/material/view")
	public String materialView(
			@RequestParam Map<String, Object> param,
			Model model
			) throws Exception {

		model.addAttribute("workData", b2bWorkService.selectWork(param));
		model.addAttribute("materialDocList", b2bWorkService.selectMaterialDocList(param));
		model.addAttribute("materialReqList", b2bWorkService.selectMaterialReqList(param));
		return "work/material/view";
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note : 결제 탭
	 */
	@PostMapping(path="/abc/work/payment/view")
	public String paymentView(
			@RequestParam Map<String, Object> param,
			Model model
			) throws Exception {

		if(StringUtils.isBlank((String)param.get("work_no"))){
			throw new Exception(Constants.ERROR_EMPTY_KEY);
		}

		model.addAttribute("workData", b2bWorkService.selectWork(param));
		model.addAttribute("estimateData", b2bWorkService.selectEstimateTotalAmount(param));
		model.addAttribute("amount_type", codeService.selectCodeByGb("amount_type"));
		model.addAttribute("pay_type", codeService.selectCodeByGb("pay_abc_type"));
		model.addAttribute("pay_bill_type", codeService.selectCodeByGb("pay_bill_type"));
		model.addAttribute("paymentList", b2bWorkService.paymentList(param));

		return "work/payment/view";
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note : 결제등록
	 */
	@PostMapping(path="/abc/work/payment/save/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody

	public String paymentSave(
			@RequestParam Map<String, Object> param,
			@RequestParam("upLoadFile") MultipartFile[] files, // upload file
			Model model
			) throws Exception {

		param.put("files", files); // file
		System.out.println("param:" + param);
		param.put("admin_no", getAdminNo());
		param.put("del_yn", Constants.NOT_DELETED); // 상태
		param.put("create_no", getAdminNo()); // 상태
		param.put("update_no", getAdminNo()); // 상태
		param.put("stat", "01"); // 상태
		//param.put("paid_amount", param.get("total_pay_price"));
		b2bWorkService.savePaymenet(param);

		return Constants.EVENT_SAVE_SUCCESS;
	}
	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note :결제 삭제
	 */
	@PostMapping(path="/abc/work/payment/delete/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String paymentDelete(
			@RequestBody Map<String, Object> param,
			Model model
			) throws Exception {

		System.out.println("param:" + param);
		param.put("update_no", getAdminNo()); // 상태
		param.put("del_yn", Constants.DELETED); // 상태
		b2bWorkService.deletePaymenet(param);
		return Constants.EVENT_SAVE_SUCCESS;
	}
	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note : 보고서 탭
	 */
	@PostMapping(path="/abc/work/report/view")
	public String reportView(
			@RequestParam Map<String, Object> param,
			Model model
			) throws Exception {

		if(StringUtils.isBlank((String)param.get("work_no"))){
			throw new Exception(Constants.ERROR_EMPTY_KEY);
		}

		model.addAttribute("workData", b2bWorkService.selectWork(param));
		param.put("p_work_no", param.get("work_no") );
		model.addAttribute("subWorkList", b2bWorkService.subWorkList(param));
		// 내부보고서 정보와 작성여부
		model.addAttribute("exp_memo", b2bWorkService.selectReport(param));
		// 완료보고서 정보와 작성여부
		model.addAttribute("clientReport",b2bWorkService.reportClient(param));
		model.addAttribute("data", b2bWorkService.selectWork(param));

		return "work/report/view";
	}

	/**
	 * @Author : sbahn
	 * @Date	: 2021. 06. 10.
	 * @Method Name :
	 * @return : String
	 * @note : 작업일지 저장
	 */
	@PostMapping(path="/abc/work/daily/save/ajax")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public String dailySave(
			@RequestParam Map<String, Object> param,
			@RequestParam("upLoadFile") MultipartFile[] files, // upload file
			Model model
			) throws Exception {

		System.out.println("param:" + param);
		param.put("admin_no", getAdminNo());
		param.put("del_yn", "N");
		param.put("files", files);
		b2bWorkService.saveDailyReport(param);
		return Constants.EVENT_SAVE_SUCCESS;
	}

}
