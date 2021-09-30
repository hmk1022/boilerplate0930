<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- page title -->
<h1 class="page-header">자재 요청 관리</h1>
<!-- content area -->
<div class="row">
	<!-- Begin area search -->
	<div class="col-12 mb-3">
		<div class="card">
			<form id="frm_search" data-parsley-validate="true" name="frm"  novalidate="">
				<div class="card-body border border-primary">
					<div class="row justify-content-md-between">
						<div class="col-md-3 col-6 mt-3">
							<label class="form-label">요청일</label>
							<div class="input-group date input-daterange"
								data-date-format="yyyy-mm-dd"
								data-date-start-date="Date.default">
								<input type="text" class="form-control text-center" id="s_start_dt" name="s_start_dt" placeholder="연도-월-일">
								<span
									class="input-group-append input-group-text px-1 my-0 pt-1 rounded-0 border-right-0">
									~ </span> <input type="text" class="form-control text-center"
									id="s_end_dt" name="s_end_dt" placeholder="연도-월-일">
							</div>
						</div>
						<div class="col-md-3 col-4 mt-3">
							<label class="form-label">요청서번호</label>
							<input type="text" name="s_material_doc_id"	class="form-control">
							<div class="invalid-feedback">요청서번호를 입력하세요.</div>
						</div>
						<div class="col-md-3 col-4 mt-3">
							<label class="form-label">요청자/담당자명</label>
							<input type="text" name="s_manager_name" class="form-control">
							<div class="invalid-feedback">요청자/담당자명을 입력하세요.</div>
						</div>
						<div class="col-md-3 col-4 mt-3"></div>
						<div class="col-md-3 col-4 mt-3">
							<label class="form-label">수령방법</label>
							<select class="form-select" id="receive_type" name="s_receive_type">
						        <tags:code-select
									codeList="${receive_type }"
									selected=""
									defaultValue="선택" />
							</select>
						</div>
						<div class="col-md-3 col-4 mt-3">
							<label class="form-label">상태</label>
							<select class="form-select" id="doc_stat" name="s_doc_stat">
						        <tags:code-select
									codeList="${doc_stat }"
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
		</div>

	</div>
	<!-- End area search -->
	<!-- Begin area content -->
	<div class="col-12">
		<div class="card">
			<div class="card-header">
				<div class="d-flex align-items-center justify-content-between">
					<div class="d-flex align-items-center"></div>
					<div class="d-flex align-items-center">
						<button class="btn btn-outline-success" name="movePage" data-url="/material/doc/form">등록버튼</button>
					</div>
				</div>
			</div>
			<!-- area grid -->
			<div class="card-body table-responsive" id="grid_json" style="margin: auto;"></div>
			<div class="card-footer">
				<div class="d-flex align-items-center justify-content-between">
					<div class="pagination"></div>
					<div class="d-flex align-items-center">
						<button class="btn btn-outline-success" name="movePage" data-url="/material/doc/form">등록버튼</button>
					</div>
				</div>
			</div>
			</form>
		</div>
	</div>
	<!-- End area content -->
</div>

<!-- page script -->
<script>
	var curPage;
	var grid;

	/* init page */
	$(function() {
		init();

		$(".btn-search").on("click", search);
		$("#dev_button_form").on("click", function(e) {
			e.preventDefault()
			/* window.location.href = ""; */
		});
	});

	function init() {

		var colModel = [
				{
					title : "요청서번호",
					width : 120,
					dataType : "string",
					align: "center",
					dataIndx : "material_doc_id",
					render : function(ui) {
						let row = ui.rowData;
						return {
							text : ""
									+ '<p style="margin-bottom: 0px; color: #00acac;  text-decoration: underline; text-underline-offset: 3px; ">'
									+ row.material_doc_id + '</p>',
						};
					}
				},
				{
					title : "용도",
					width : 150,
					dataType : "string",
					align : "center",
					dataIndx : "req_usage",
				},
				{
					title : "작업일련번호",
					width : 150,
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
					title : "요청자재목록 메모",
					width : 300,
					dataType : "string",
					dataIndx : "work_id",
					render : function(ui) {
						let row = ui.rowData;
						let _text = row.material_name;
						if(row.material_cnt > 0){
							_text += ' 외 '+row.material_cnt+'건';
						}
						if(!Utils.isEmpty(row.remarks)){
							_text += '<span style="color:red"><br>[메모]<br>'+row.remarks+"</span>";
						}
						return {
							text : _text
						}
					}
				},
				{
					title : "총금액",
					width : 100,
					dataType : "integer",
					format : "#,###",
					style: "font-weight: bold" , 
					dataIndx : "total_amt"
				},
				{
					title : "수령일시",
					width : 130,
					dataType : "string",
					align: "center",
					dataIndx : "use_date",
					render : function(ui) {
						let row = ui.rowData;
						let returnString = "";
						returnString = returnString +
						/* 날짜 */
						row.use_date.substr(0,4) + "-" + row.use_date.substr(4,4).substr(0,2) + "-"
						+ row.use_date.substr(4,4).substr(2,4) 
						/* 요일 */
						+"("+ Utils.getDayOfWeek(
							row.use_date.substr(0,4) + "-"+ 
							row.use_date.substr(4,4).substr(0,2) + "-"
							+ row.use_date.substr(4,4).substr(2,4)) + ")" + '<br>'	
						/* 시간 */
						+ Utils.getDate(row.use_date + row.use_hh + row.use_mm).substr(10,12)
						
						return returnString					
					}
				},
				{
					title : "수령방법",
					width : 110,
					dataType : "string",
					align : "center",
					dataIndx : "receive_type",
					format : function(val) {
						return getCodeNm('receive_type', val);
					}
				},
				{
					title : "담당자",
					width : 80,
					dataType : "string",
					align : "center",
					dataIndx : "manager_name"
				}, 
				{
					title : "요청일",
					width : 120,
					dataType : "string",
					dataIndx : "doc_date",
					align : "center",
					render : function(ui) {
						let row = ui.rowData;
						let returnString = "";
						
						returnString = returnString 
							+ Utils.getDatetime(row.doc_date).substr(0,10)
							+ '(' + Utils.getDayOfWeek(Utils.getDatetime(row.doc_date).substr(0,10)) + ')'
							+ '<br>'
							+ Utils.getDatetime(row.doc_date).substr(10,12)

						return returnString					
					}
				}, 
				{

					title : "요청자",
					width : 80,
					dataType : "string",
					align : "center",
					dataIndx : "doc_admin_name"
				},
				/* {
					title : "상태",
					width : 80,
					dataType : "string",
					dataIndx : "doc_stat",
					align: "center",
					render : function(ui) {
						let row = ui.rowData;
						let _text = getCodeNm('doc_stat', row.doc_stat);
						if(row.doc_stat == '04'){ // 배송예정
							_text  += "<br>" + row.delivery_name;
						}
						return {
							text : _text
						}
					} 
				}, */
				{
					title : "상태",
					width : 80,
					dataType : "string",
					dataIndx : "doc_stat_name",
					align: "center",
					render : function(ui) {
						let row = ui.rowData;
						let _text = row.doc_stat_name

						if (_text == '수령가능') {
							_text = '<div style="color: #32a932">' + row.doc_stat_name + '</div>'							
						} else if (_text == '준비중') {
							_text = '<div style="color: #8753de">' + row.doc_stat_name + '</div>'
						} else if (_text == '반려') {
							_text = '<div style="color: #ff5b57">' + row.doc_stat_name + '</div>'
						} else if (_text == '배송예정') {
							_text = '<div style="color: #32a932">' + row.doc_stat_name + '</div>' +  row.delivery_name;
						} 
												
						return {
							text : _text
						}
					} 
				},
				{
					title : "처리일",
					width : 120,
					dataType : "string",
					dataIndx : "confirm_date",
					align : "center",
					/*  format : function(val) {
						return Utils.getDatetime(val);
					}, */ 
					 render : function(ui) {
						let row = ui.rowData;
						
						let _text = Utils.getDatetime(row.confirm_date).substr(0,10)
						+ '(' + Utils.getDayOfWeek(Utils.getDatetime(row.confirm_date).substr(0,10)) + ')'
						+ '<br>' + Utils.getDatetime(row.confirm_date).substr(10,12)
						if (!Utils.getDayOfWeek(Utils.getDatetime(row.confirm_date).substr(0,10))) _text = ""
									
						return _text
					} 
				},
				{
					title : "처리자",
					width : 80,
					dataType : "string",
					align : "center",
					dataIndx : "confirm_admin_name"
				},
				{
					title : "요청번호",
					dataIndx : "material_doc_no",
					hidden : true
				},
				{
					title : "",
					width : 5,
					dataType : "string",
				},
			];

		const _desc = "자재구매 지점 목록 조회"; // ajax name
		const _url = "material/doc/list/ajax"; // ajax url
		let _param = {}; // ajax param
		var data;

		// draw grind
		let options = {
			rowDblClick : function(event, ui) {
				event.preventDefault();
				// console.log("ui", ui.rowData.material_doc_no);
				let param = {
					material_doc_no : ui.rowData.material_doc_no
				}
				postPage("material/doc/view", param);
			}
		};

		grid = Wgrid.draw("#grid_json", _param, _url, colModel, options, _desc);
	}


	function search() {
		console.log("========== run search()");
		let $form = $("#frm_search");
		param = $form.serializeObject();
		console.log('search : ', param);
		grid.option("dataModel.postData", param);
		grid.refreshDataAndView();
	}
</script>