<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- begin page-header -->
<h1 class="page-header">비용 집행 목록</h1>
<!-- content area -->
<div class="row">
	<!-- Begin area search -->
	<div class="col-12 mb-3">
		<div class="card">
			<form id="frm_search" data-parsley-validate="true" name="frm"  novalidate="">
			<div class="card-body border border-primary">
				<div class="row justify-content-md-between">
					<div class="col-md-3 col-6 mt-3">
                        <label class="form-label mb-2">날짜검색</label>
                        <div class="">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" id="inlineRadio1" name="req_date_yn" value="REQ" checked>
                                <label class="form-check-label" for="inlineRadio1">결제요청일</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" id="inlineRadio2" name="req_date_yn" value="COMP">
                                <label class="form-check-label" for="inlineRadio2">결제완료일</label>
                            </div>
                        </div>
                    </div>
					<div class="col-md-3 col-6 mt-3">
						<label class="form-label">요청일/완료일</label>
						<div class="input-group date " data-date-start-date="Date.default">
							<input type="text" class="form-control text-center" id="start_dt" name="start_dt" placeholder="연도-월-일" datepicker autocomplete='off'>
							<span class="input-group-append input-group-text px-1 my-0 pt-1 rounded-0 border-right-0"> ~ </span>
							<input type="text" class="form-control text-center" id="end_dt" name="end_dt" placeholder="연도-월-일" datepicker autocomplete='off'>
						</div>
					</div>
					<div class="col-md-2 col-4 mt-3">
						<label class="form-label">고객명</label>
						<input type="text" name="req_name" class="form-control" placeholder="고객명를 입력하세요.">
					</div>
					<div class="col-md-2 col-4 mt-3">
						<label class="form-label">작업일련번호</label>
						<input type="text" name="work_id" class="form-control" placeholder="작업일련번호를 입력하세요.">
					</div>
					<div class="col-md-2 col-4 mt-3">
						<label class="form-label">요청자</label>
						<input type="text" name="create_name" class="form-control" placeholder="요청자을 입력하세요.">
					</div>
					<div class="col-md-2 col-4 mt-3">
						<label class="form-label">결제상태</label>
						<select class="form-select" id="exp_stat" name="exp_stat">
					        <tags:code-select
								codeList="${exp_stat }"
								selected=""
								defaultValue="선택" />
						</select>
					</div>
					<div class="col-md-2 col-4 mt-3">
						<label class="form-label">사업구분</label>
						<select class="form-select" id="work_target" name="work_target">
					        <tags:code-select
								codeList="${work_target }"
								selected=""
								defaultValue="선택" />
						</select>
					</div>
					<div class="col-md-2 col-4 mt-3">
						<label class="form-label">비용분류</label>
						<select class="form-select" id="exp_type" name="exp_type">
					        <tags:code-select
								codeList="${exp_type }"
								selected=""
								defaultValue="선택" />
						</select>
					</div>
					<div class="col-md-6 col-4 mt-3"></div>
				</div>
				<hr>
				<div class="d-flex justify-content-end">
					<button type="button" class="btn btn-outline-primary" id="search_init">초기화</button>
					<button type="button" class="btn-search btn btn-primary ms-2">검색</button>
				</div>
			</div>
			</form>
		</div>
	</div>

	<!-- End area search -->
	<div class="col-12">
		<div class="card">
<!-- 			<div class="card-header">
				<div class="d-flex align-items-center justify-content-between">
					<div class="d-flex align-items-center"></div>
					<div class="d-flex align-items-center">
						<button class="btn btn-outline-success" name="movePage"
							data-url="/account/expenses/form">등록버튼</button>
					</div>
				</div>
			</div> -->
			<div class="card-header">
				<div class="d-flex align-items-center justify-content-between">
					<div class="d-flex align-items-center"></div>
					<div class="d-flex align-items-center">
						<button class="btn btn-outline-success btn-excel">엑셀버튼</button>
					</div>
				</div>
			</div>
			<div id="grid_json"></div>
		</div>
		<div class="card-footer">
<!-- 			<div class="d-flex align-items-center justify-content-between">
				<div class="pagination"></div>
				<div class="d-flex align-items-center">
					<button class="btn btn-outline-success" name="movePage"
						data-url="/account/expenses/form">등록버튼</button>
				</div>
			</div> -->
		</div>
	</div>
</div>




<!-- begin modal -->
<!-- 자재 추가 -->
<div class="modal fade" id="modal-dialog-reject">
	<input type="hidden" id="exp_no" />
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">반려사유</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
			</div>
			<div class="modal-body">
				<!-- <input type="hidden" id="ware_house_cnt" name="ware_house_cnt" > -->
				<div class="form-row">
					<div class="col-md-12 mb-3">
						<label class="form-label mb-2">반려사유</label>
						<div class="col-md-12 pt-2">
							<tags:code-radio codeList="${exp_reject }" checked=""
								name="exp_reject" required="true" initValue="01" />
						</div>
					</div>
					<div class="col-md-12 mb-3">
						<label class="form-label mb-2">반려상세사유</label>
						<div class="col-md-12 pt-2">
							<input type="text" class="form-control " placeholder="반려상세사유"
							name="remarks" id="remarks"
							/>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<a href="javascript:;" class="btn btn-white" data-dismiss="modal">닫기</a>
				<a href="javascript:;" class="btn btn-success" id="_btn_exp_reject">저장</a>
			</div>

		</div>
	</div>
</div>


<div class="modal fade" id="modal-dialog-confirm">
	<form class="form-horizontal form-bordered"	data-parsley-validate="false" name="paySaveForm" id="paySaveForm" novalidate="">
	<input type="hidden" id="exp_no" />
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">결제확인</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
			</div>
			<div class="modal-body">
				<!-- <input type="hidden" id="ware_house_cnt" name="ware_house_cnt" > -->
				<div class="form-row">
					<div class="col-md-12 mb-3">
						<label class="form-label mb-2">결제범위</label>
						<div class="col-md-12 pt-2">
							<tags:code-radio codeList="${pay_scope}" checked=""
								name="pay_scope" required="false" initValue="03" />
						</div>
					</div>
				</div>

				<div class="col-md-12 col-12 mt-3">
					<label class="form-label">결제완료금액<span class="text-danger">*</span>
						&nbsp;&nbsp;<span id="validation_error"></span></label>
					<div class="form-group form-inline">
						<input type="text" class="form-control"
							data-parsley-required="true"
							data-parsley-error-message="결제완료금액을 정확히 입력하세요."
							placeholder="결제완료금액"
							data-parsley-errors-container="#validation_error"
							id="pay_price"
							name="pay_price"
							comma readonly/> &nbsp;/&nbsp;
						<input
							type="text"
							class="form-control"
							placeholder="총결제금액"
							id="pay_req_amt"
							name="pay_req_amt"
							readonly />
					</div>
				</div>
				<div class="col-md-3 col-12 mt-3" id="_div_pay_scope"
					style="display: none">
						<label class="form-label">다음 결제일자<span class="text-danger">*</span></label>
						<input type="text" class="form-control" placeholder="연도-월-일"
							id="pay_next_date" name="pay_next_date" value=""
							data-parsley-error-message="다음 결제일자를 정확히 입력하세요."
							data-parsley-required="false" datepicker />
					</div>
				</div>
				<div class="modal-footer">
					<a href="javascript:;" class="btn btn-white" data-dismiss="modal">닫기</a>
					<a href="javascript:;" class="btn btn-success"
						id="_btn_exp_confirm">저장</a>
				</div>
			</div>
		</div>
</form>
	</div>

<!-- begin modal -->
<!-- 자재 추가 -->
<%--
<div class="modal fade" id="modal-dialog-reject">
	<input type="hidden" id="exp_no" />
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">반려사유</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
			</div>
			<div class="modal-body">
				<!-- <input type="hidden" id="ware_house_cnt" name="ware_house_cnt" > -->
				<div class="form-row">
					<div class="col-md-12 mb-3">
						<label class="form-label mb-2">반려사유</label>
						<div class="col-md-12 pt-2">
							<tags:code-radio codeList="${exp_reject }" checked=""
								name="exp_reject" required="false" initValue="01" />
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<a href="javascript:;" class="btn btn-white" data-dismiss="modal">닫기</a>
				<a href="javascript:;" class="btn btn-success" id="_btn_exp_reject">저장</a>
			</div>

		</div>
	</div>
</div>
 --%>

<div class="modal fade" id="modal-dialog-confirm">
	<input type="hidden" id="exp_no" />
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">결제확인</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
			</div>
			<div class="modal-body">
				<!-- <input type="hidden" id="ware_house_cnt" name="ware_house_cnt" > -->
				<div class="form-row">
					<div class="col-md-12 mb-3">
						<label class="form-label mb-2">결제범위</label>
						<div class="col-md-12 pt-2">
							<tags:code-radio codeList="${pay_scope}" checked=""
								name="pay_scope" required="false" initValue="03" />
						</div>
					</div>
				</div>

				<div class="col-md-12 col-12 mt-3">
					<label class="form-label">결제완료금액<span class="text-danger">*</span></label>
					<div class="form-group form-inline">
						<input type="text" class="form-control" placeholder="결제완료금액"
							id="pay_price" name="pay_price" value=""
							data-parsley-required="false" comma /> &nbsp;/&nbsp; <input
							type="text" class="form-control" placeholder="총결제금액"
							id="pay_req_amt" name="pay_req_amt" value=""
							data-parsley-required="false" readonly />
					</div>
				</div>
				<div class="col-md-3 col-12 mt-3" id="_div_pay_scope"
					style="display: none">
					<label class="form-label">다음 결제일자<span class="text-danger">*</span></label>
					<input type="text" class="form-control" placeholder="연도-월-일"
						id="pay_next_date" name="pay_next_date" value=""
						data-parsley-required="true" datepicker />
				</div>
				<div class="modal-footer">
					<a href="javascript:;" class="btn btn-white" data-dismiss="modal">닫기</a>
					<a href="javascript:;" class="btn btn-success"
						id="_btn_exp_confirm">저장</a>
				</div>

			</div>
		</div>
	</div>

	<!-- end modal -->



	<!-- begin modal -->
	<!-- 자재 추가 -->
	<%--
	<div class="modal fade" id="modal-dialog-reject">
		<input type="hidden" id="exp_no" />
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">반려사유</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
					<!-- <input type="hidden" id="ware_house_cnt" name="ware_house_cnt" > -->
					<div class="form-row">
						<div class="col-md-12 mb-3">
							<label class="form-label mb-2">반려사유</label>
							<div class="col-md-12 pt-2">
								<tags:code-radio codeList="${exp_reject }" checked=""
									name="exp_reject" required="false" initValue="01" />
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<a href="javascript:;" class="btn btn-white" data-dismiss="modal">닫기</a>
					<a href="javascript:;" class="btn btn-success" id="_btn_exp_reject">저장</a>
				</div>

			</div>
		</div>
	</div>
	 --%>


	<div class="modal fade" id="modal-dialog-confirm">
		<input type="hidden" id="exp_no" />
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">결제확인</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
					<!-- <input type="hidden" id="ware_house_cnt" name="ware_house_cnt" > -->
					<div class="form-row">
						<div class="col-md-12 mb-3">
							<label class="form-label mb-2">결제범위</label>
							<div class="col-md-12 pt-2">
								<tags:code-radio codeList="${pay_scope }" checked=""
									name="pay_scope" required="false" initValue="03" />
							</div>
						</div>
					</div>

					<div class="col-md-12 col-12 mt-3">
						<label class="form-label">결제완료금액<span class="text-danger">*</span></label>
						<div class="form-group form-inline">
							<input type="text" class="form-control" placeholder="결제완료금액"
								id="pay_price" name="pay_price" value=""
								data-parsley-required="false" comma readonly/> &nbsp;/&nbsp; <input
								type="text" class="form-control" placeholder="총결제금액"
								id="pay_req_amt" name="pay_req_amt" value=""
								data-parsley-required="true" readonly />
						</div>
					</div>
					<div class="col-md-3 col-12 mt-3" id="_div_pay_scope"
						style="display: none">
						<label class="form-label">다음 결제일자<span class="text-danger">*</span></label>
						<input type="text" class="form-control" placeholder="연도-월-일"
							id="pay_next_date" name="pay_next_date" value=""
							data-parsley-required="true" datepicker />
					</div>
				</div>
				<div class="modal-footer">
					<a href="javascript:;" class="btn btn-white" data-dismiss="modal">닫기</a>
					<a href="javascript:;" class="btn btn-success"
						id="_btn_exp_confirm">저장</a>
				</div>

			</div>
		</div>
	</div>

	<!-- end modal -->
	<!-- ================== BEGIN Jandi SCRIPT ================== -->
	<script type="text/javascript" src="/assets/js/Jandi.js"></script>
	<!-- ================== END Jandi SCRIPT ================== -->

	<script>
		var curPage;
		var gridTmp;

		/* init page */
		$(function() {
			console.log('page script !!!! ');

			$(".btn-search").on("click", search);

			$("#dev_button_form").on("click", function(e) {
				e.preventDefault()
				window.location.href = "";
			});

			var colModel = [
					{
						title : "사업구분",
						width : 80,
						dataType : "string",
						dataIndx : "work_target",
						align : "center",
						format : function(val) {
							return getCodeNm('work_target', val);
						}
					},
					{
						title : "문서번호",
						width : 100,
						dataType : "string",
						align : "center",
						dataIndx : "exp_id",
						render : function(ui) {
							let row = ui.rowData;
							return {
								text : ""
										+ '<p style="margin-bottom: 0px; color: #00acac; text-decoration: underline; text-underline-offset: 3px; ">'
										+ row.exp_id + '</p>',
							};
						}
					},
					{
						title : "작업일련번호",
						width : 140,
						dataType : "string",
						align : "center",
						dataIndx : "work_id",
						render : function(ui) {
							let row = ui.rowData;
							let _customer = row.req_name;
							let _work_id = row.work_id;
							if(Utils.isEmpty(_work_id)){
								_customer ='-';
							} else {
								if(!Utils.isEmpty(row.branch_name)){
									_customer = row.customer_name +"/"+row.branch_name +"<br>"+ row.work_id ;
								} else {
									_customer = row.req_name + "<br>"+ row.work_id ;
								}
							}
							return {
								text : _customer
							};
						}
					},
					{
						title : "비용집행내역",
						colModel : [ {
							title : "비용분류",
							width : 80,
							dataType : "string",
							dataIndx : "exp_type",
							align : "center",
							format : function(val) {
								return getCodeNm('exp_type', val);
							}
						}, {
							title : "비용용도",
							width : 220,
							dataType : "string",
							dataIndx : "exp_usage",
							render : function(ui) {
								let row = ui.rowData;
								return {
									text : row.exp_usage + getCodeNm('pcs_reason', row.pcs_reason) + (Utils.isEmpty(row.doc_admin_name)?'': " ("+row.doc_admin_name+")")
								};
							}
						}, {
							title : "사용처",
							width : 100,
							align : "center",
							dataType : "string",
							dataIndx : "partner_name",
							render : function(ui) {
								let row = ui.rowData;
								let _name = "";
								if(row.exp_type == '01'||row.exp_type == '02'){
									_name = row.partner_name;
								}
								else if(row.exp_type == '03'){
									_name = row.vendor_name;
								}
								else if(row.exp_type == '04'){
									_name = row.exp_target;
								}
								return {
									text : _name
								};
							}
						}, {
							title : "사용일",
							width : 100,
							dataType : "date",
							dataIndx : "st_date",
							align : "center",
							format : function(val) {
								return Utils.getDate(val) + '(' + Utils.getDayOfWeek(Utils.getDate(val)) + ')'
							}
						}, {
							title : "결제대상금액",
							width : 100,
							dataType : "integer",
							format : "#,###",
							style:"font-weight: bold",
							dataIndx : "pay_req_amt",
						}, {
							title : "거래명세서",
							width : 80,
							align : "center",
							dataType : "string",
							render : function(ui) {
								let row = ui.rowData;
								let _botton = '<button class="btn btn-xs btn-primary _button_img_pop" onclick="getImagePop(\'IMG_TYPE_EXPENSES\', \''+row.exp_no+'\', \'거래명세서\');" >확인</button>';
								return {
									text : _botton,
								};
							}
						}, ]
					},
					{
						title : "결제 및 증빙",
						colModel : [
								{
									title : "결제정보",
									width : 150,
									dataType : "string",
									align : "center",
									render : function(ui) {
										let row = ui.rowData;
										return {
											text : getCodeNm('vacct_bank_code',	row.bank_code)	+ '<br>' + row.acct
										};
									}
								},
								{
									title : "지출증빙",
									width : 110,
									align : "center",
									dataType : "string",
									dataIndx : "evidence",
								},
								{
									title : "결제요청일",
									width : 100,
									dataType : "string",
									align : "center",
									dataIndx : "pay_req_date",
									format : function(val) {
										return Utils.getDate(val) + '(' + Utils.getDayOfWeek(Utils.getDate(val)) + ')';
									}
								},
								{
									title : "결제완료금액",
									width : 120,
									dataType : "string",
									align : "center",
									//style:"font-weight: bold",
									render : function(ui) {
										let row = ui.rowData;
										let _paid_amt = Utils.comma(row.paid_amt);
										let _confirm_admin_name = row.confirm_admin_name;
										let _botton = '<button class="btn btn-xs btn-primary" name="_modal_exp_confirm" data-exp_no="'+row.exp_no+'" data-unsett_amt="'+row.unsett_amt+'" data-pay_req_amt="'+row.pay_req_amt+'">결제</button>';
										let _text = '';

										if (row.exp_stat == '01') {
											if(!Utils.isEmpty(_confirm_admin_name)){
												_text = _paid_amt + '<br>' + _confirm_admin_name + '<br>' + _botton;
											}else{
												_text = _paid_amt + '<br>' + _botton;
											}
										}
										else if (row.exp_stat == '02') {
											if(!Utils.isEmpty(_confirm_admin_name)){
												_text = '<div style = "font-weight: bold" >' + _paid_amt+ '</div>' + _confirm_admin_name + '<br>' 
												 + Utils.getDatetime(row.confirm_date).substr(0,10) + '('+ Utils.getDayOfWeek(Utils.getDatetime(row.confirm_date).substr(0,10))+')'
												 + '<br>' + Utils.getDatetime(row.confirm_date).substr(10,12) + '<br>'
												 + _botton;
											}else{
												_text ='<div style = "font-weight: bold">' +  _paid_amt + '</div>'+ '<br>' + _botton;
											}
										} else if (row.exp_stat == '03') {
											_text ='<div style = "font-weight: bold">' +  _paid_amt + '</div>' + _confirm_admin_name+ '<br>'  +Utils.getDate(row.paid_date) + '(' + Utils.getDayOfWeek(Utils.getDate(row.paid_date)) + ')' ;
										}
										return {
											text : _text,
										};
									}
								},
								{
									title : "미결제금액",
									width : 100,
									dataType : "integer",
									dataIndx : "unsett_amt",
									render : function(ui) {
										let row = ui.rowData;
										return {
											text : Utils.comma(row.unsett_amt),
											style : "text-align:right; font-weight : bold"
										};
									}
								},
								{
									title : "상태",
									width : 150,
									dataType : "string",
									align : "center",
									dataIndx : "exp_stat",
									render : function(ui) {
										let row = ui.rowData;
										let _exp_stat = getCodeNm('exp_stat', row.exp_stat);
										let _botton = '<br><button class="btn btn-xs btn-primary" name="_modal_exp_reject" data-exp_no="'+row.exp_no+'">반려</button>';
										let _text = '';
										if (row.exp_stat == '01') {
											_text = _exp_stat + _botton;
										} else if (row.exp_stat == '99') {
											_text = _exp_stat +"<br>"+ getCodeNm('exp_reject',	row.exp_reject) ;
										} else {
											_text = _exp_stat;
										}
										return {
											text : _text,
										};
									}
								}, ]
					},

					{
						title : "등록일",
						width : 100,
						align : "center",
						dataType : "string",
						format : "yy-mm-dd",
						dataIndx : "create_date",
						render : function (ui) {
							let row = ui.rowData;
							
							return row.create_date.substr(0,10) + '(' + Utils.getDayOfWeek(row.create_date.substr(0,10)) + ')'
						}
					}, {
						title : "등록자",
						width : 120,
						width : 100,
						align : "center",
						dataType : "string",
						dataIndx : "admin_name"
					}, ];

			const _desc = "고객사 지점 목록 조회"; // ajax name
			const _url = "/account/expenses/list/ajax"; // ajax url
			let _param = {}; // ajax param
			var data;

			// draw grind
			let options = {
/* 				rowDblClick : function(event, ui) {
					event.preventDefault();
					let param = {
						exp_no : ui.rowData.exp_no
					}
					postPage("/account/expenses/view", param);
				} */
			};

			gridTmp = Wgrid.draw("#grid_json", _param, _url, colModel, options,	_desc);

			/* 반려 modal*/
			$("#grid_json").on("click", "[name=_modal_exp_reject]", function(e) {
				console.log("exp_no:", $(this).data("exp_no"));
				$('#modal-dialog-reject').modal({
					backdrop : 'static',
					keyboard : false
				});
				$("#modal-dialog-reject").modal("show");
				$("#modal-dialog-reject #exp_no").val($(this).data("exp_no"));
				$("[name=exp_reject][value='01']").prop("checked", true);
			});

			/* 반려 저장*/
			$("#modal-dialog-reject").on("click", "#_btn_exp_reject", function(e) {
				let _param = {};
				_param.exp_no = $("#modal-dialog-reject #exp_no").val();
				_param.exp_reject = $("[name=exp_reject]:checked").val();
				_param.remarks = $("[name=remarks]").val();
				_param.exp_stat = "99"; // 상태 반려

				if(Utils.isEmpty(_param.exp_reject)){
					alert('반려 사유를 선택하세요.');
					return;
				}
				saveExpReject(_param);
			});

			/* 결제확인 modal*/
			$("#grid_json").on("click",	"[name=_modal_exp_confirm]", function(e) {
				console.log("exp_no:", $(this).data());
				$('#modal-dialog-confirm').modal({
					backdrop : 'static',
					keyboard : false
				});
				$("#modal-dialog-confirm").modal("show");

				$("#modal-dialog-confirm #exp_no").val('');
				$("#modal-dialog-confirm #pay_next_date").val('');

				$("#modal-dialog-confirm #exp_no").val($(this).data("exp_no"));
				$("#modal-dialog-confirm #pay_price").val(Utils.comma($(this).data("unsett_amt"))); // 결제할금액
				$("#modal-dialog-confirm #pay_req_amt").val(Utils.comma($(this).data("unsett_amt"))); // 남은결제금액
				$("[name=pay_scope][value='03']").prop("checked", true);	// 전액

				$("[name=pay_scope]").trigger("change");
			});

			/* 결제확인 저장*/
			$("#modal-dialog-confirm").on("click", "#_btn_exp_confirm",	function(e) {

				/* validate */
				let validate = $("[name=paySaveForm]").parsley().validate();

				if (!validate) {
					console.log('# validate false !!!');
					return;
				}

				if(!confirm("저장하시겠습니까?")){ return; }

				let _payDate = $("#pay_next_date").val();

				let _param = {};
				_param.exp_no = $("#modal-dialog-confirm #exp_no").val();
				_param.pay_scope = $("[name=pay_scope]:checked").val();

				_param.pay_next_date = $("#pay_next_date").val();
				_param.pay_price = Utils.remove($("#pay_price").val(),',');
				_param.pay_req_amt = Utils.remove($("#pay_req_amt").val(), ',');

				if (_param.pay_scope == '03') {
					if (_param.pay_price == _param.pay_req_amt) {
					}
					if (_param.pay_price != _param.pay_req_amt) {
						alert("금액을 확인하세요!");
						$("#pay_price").select();
						return;
					}
				}

				if (_param.pay_scope == '02') {
					/* 결제금액이 남은 결제 금액보다 크거나 같다면 경고창 */
					if (_param.pay_price*1 > _param.pay_req_amt*1) {
						alert("금액을 확인하세요!");
						$("#pay_price").select();
						return;
					};
				}

				// 결제할금액과 결제금액이 같은경우 전액 결제처리.
				if(_param.pay_price == _param.pay_req_amt) {
					_param.pay_scope = '03';
				}

				saveExpConfirm(_param);
			});

			/* 결제확인 저장*/
			/* 결제 scope에 따라 validation에 조건을 주었다. */
			$("[name=pay_scope]").on("change", function(e) {
				let _pay_scope = $(this).filter(":checked").val();
				if (_pay_scope == '03') { // 전액
					$("#pay_next_date").attr('data-parsley-required','false');
					$("#_div_pay_scope").hide();

					// 전액일 경우 전체 남은 금액 입력
					$("#modal-dialog-confirm #pay_price").val($("#modal-dialog-confirm #pay_req_amt").val());
					$("#modal-dialog-confirm #pay_price").attr("readonly", true);
				} else if (_pay_scope == '02') { // 일부
					$("#pay_next_date").attr('data-parsley-required','true');
					$("#_div_pay_scope").show();
					$("#modal-dialog-confirm #pay_price").attr("readonly", false);
				}
			});

			$(".btn-excel").on("click", function(){
				let _excelColModel = [
					{
						title : "문서번호",
						width : 120,
						dataType : "string",
						align : "center",
						dataIndx : "exp_id"
					},
					{
						title : "작업일련번호",
						width : 120,
						dataType : "string",
						align : "center",
						dataIndx : "work_id"
					},
					{
						title : "고객(사)명",
						width : 120,
						dataType : "string",
						align : "center",
						dataIndx : "work_id",
						render : function(ui) {
							let row = ui.rowData;
							let _customer = row.req_name;
							let _work_id = row.work_id;
							if(Utils.isEmpty(_work_id)){
								_customer ='-';
							} else {
								if(!Utils.isEmpty(row.branch_name)){
									_customer = row.customer_name +"/"+row.branch_name;
								} else {
									_customer = row.req_name ;
								}
							}
							return {
								text : _customer
							};
						}
					},
					{
						title : "비용분류",
						width : 120,
						dataType : "string",
						dataIndx : "exp_type",
						align : "center",
						format : function(val) {
							return getCodeNm('exp_type', val);
						}
					},
					{
						title : "비용용도",
						width : 200,
						dataType : "string",
						dataIndx : "exp_usage",
						render : function(ui) {
							let row = ui.rowData;
							return {
								text : row.exp_usage + getCodeNm('pcs_reason', row.pcs_reason)
							};
						}
					},
					{
						title : "사용처",
						width : 200,
						dataType : "string",
						align : "center",
						dataIndx : "partner_name",
						render : function(ui) {
							let row = ui.rowData;
							let _name = "";
							if(row.exp_type == '01'||row.exp_type == '02'){
								_name = row.partner_name;
							}
							else if(row.exp_type == '03'){
								_name = row.vendor_name;
							}
							else if(row.exp_type == '04'){
								_name = row.exp_target;
							}
							return {
								text : _name
							};
						}
					},
					{
						title : "결제금액",
						width : 120,
						dataType : "integer",
						dataIndx : "unsett_amt",
						render : function(ui) {
							let row = ui.rowData;
							return {
								text : Utils.comma(row.unsett_amt),
								style : "text-align:right"
							};
						}
					},
					{
						title : "결제요청일",
						width : 120,
						dataType : "string",
						align : "center",
						dataIndx : "pay_req_date",
						format : function(val) {
							return Utils.getDate(val);
						}
					},
					{
						title : "결제정보",
						width : 200,
						dataType : "string",
						align : "center",
						render : function(ui) {
							let row = ui.rowData;
							return {
								text : getCodeNm('vacct_bank_code',	row.bank_code)	+ ' / ' + row.acct
							};
						}
					}
				 ];
				let _excelParam = $("#frm_search").serializeObject();
				let _excelUrl = _url;
				let _excelOptions = {
						colModel : _excelColModel,
						title : "비용처리리스트"
				};
				Wgrid.excel(_excelParam, _excelUrl,_excelOptions);
			});
		});

		function saveExpReject(_param) {
			const _name = "반려사유저장 저장"; // ajax name
			const _url = "/account/expenses/reject/save/ajax"; // ajax url

			/* multi form insert */
			Utils.requestAjax(_name, _url, _param, {
				success : function(data) {
					alert(Message.SAVE);
					$("#modal-dialog-reject").modal("hide");
					//$("#grid_json").pqGrid("refresh");
					gridTmp.refreshDataAndView();

		          	// sending jandi message...
		          	gridTmp.one("complete", function(event, ui){
		          		console.log('grid complete');
			          	// JANDI Webhook
			          	let _data = {};
			          	for(const arg of gridTmp.getData()){
			          		if(_param.exp_no == arg.exp_no){
			          			_data = arg;
			          			break;
			          		}
			          	}
			          	Jandi.sendWebHookExp(_data);
		          	});
				},
				complete : function(response) {
					console.log('complete!!!');
				}
			});
		}

		function saveExpConfirm(_param) {
			const _name = "비용처리 확인 저장"; // ajax name
			const _url = "/account/expenses/confirm/save/ajax"; // ajax url
			/* multi form insert */
			Utils.requestAjax(_name, _url, _param, {
				success : function(data) {
					alert(Message.SAVE);
					$("#modal-dialog-confirm").modal("hide");
					gridTmp.refreshDataAndView();

		          	// sending jandi message...
		          	gridTmp.one("complete", function(event, ui){
		          		console.log('grid complete');
			          	// JANDI Webhook
			          	let _data = {};
			          	for(const arg of gridTmp.getData()){
			          		if(_param.exp_no == arg.exp_no){
			          			_data = arg;
			          			break;
			          		}
			          	}
			          	Jandi.sendWebHookExp(_data);
		          	});

				},
				complete : function(response) {
					console.log('complete!!!');
				}
			});
		}

		function search() {
			console.log("========== run search()");
			let $form = $("#frm_search");
			param = $form.serializeObject();
			console.log('search : ', param);
			gridTmp.option("dataModel.postData", param);
			gridTmp.refreshDataAndView();
		}
	</script>