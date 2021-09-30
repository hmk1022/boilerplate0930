<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<h1 class="page-header">
	<tags:code-name code_gb="work_target" value="${work_target}"/> 작업현황<small> 작업 관리</small>
</h1>
<div class="row">
	<div class="col-12 mb-3">
		<div class="card">
			<form id="frm_search" data-parsley-validate="true" name="searchFrm" id="searchFrm" novalidate="">
			<input type="hidden" name="work_target" value="${work_target }"/>
				<div class="card-body border border-primary">
					<div class="row justify-content-md-between">
						<div class="col-md-25 col-6">
							<label class="form-label mb-2">날짜검색</label>
							<div class="">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" id="date_type_req_dt" name="date_type" value="req_dt" checked>
									<label class="form-check-label" for="date_type_req_dt">접수일</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" id="date_type_assign_dt" name="date_type" value="assign_dt">
									<label class="form-check-label" for="date_type_assign_dt">작업일</label>
								</div>
							</div>
						</div>
						<div class="col-md-25 col-6 row align-items-end">
							<div class="input-group date daterange" data-date-format="yyyy-mm-dd" data-date-start-date="Date.default">
								<input type="text" class="form-control text-center" id="start_dt" name="start_dt" placeholder="연도. 월. 일." autocomplete='off' >
								<span class="input-group-append input-group-text px-1 my-0 pt-1 rounded-0 border-right-0"> ~ </span>
								<input type="text" class="form-control text-center" id="end_dt" name="end_dt" placeholder="연도. 월. 일." autocomplete='off' >
							</div>
						</div>
						<div class="col-md-25 col-4">
							<label class="form-label">고객구분</label>
							<select class="form-select" name="customer_type" id="customer_type">
								<option value="">선택</option>
								<option value="P">개인</option>
								<option value="C">법인</option>
							</select>
						</div>
						<div class="col-md-25 col-4">
							<label class="form-label">고객사</label>
							<select class="form-select" name="customer_no" id="customer_no">
								<option value="">고객사 선택</option>
								<c:forEach var="item" items="${customer}">
								<option value="${item.customer_no}">${item.customer_name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-25 col-4">
							<label class="form-label">지점</label>
							<select class="form-select" name="branch_no" id="branch_no">
								<option value="">지점 선택</option>
							</select>
						</div>
						<div class="col-md-25 col-4 mt-3">
							<label class="form-label">고객명</label>
							<input type="text" class="form-control" id="req_name" name="req_name">
							<div class="invalid-feedback">고객명을 입력하세요.</div>
						</div>
						<div class="col-md-25 col-4 mt-3">
							<label class="form-label">현장주소</label>
							<input type="text" class="form-control" id="addr" name="addr">
							<div class="invalid-feedback">현장주소를 입력하세요.</div>
						</div>
						<div class="col-md-25 col-4 mt-3">
							<label class="form-label">담당자</label>
							<input type="text" class="form-control" id="admin_name" name="admin_name">
							<div class="invalid-feedback">담당자를 입력하세요.</div>
						</div>
						<div class="col-md-25 col-4 mt-3">
							<label class="form-label">일련번호</label>
							<input type="text" class="form-control" id="work_id" name="work_id">
							<div class="invalid-feedback">일련번호을 입력하세요.</div>
						</div>
						<div class="col-md-25 col-4 mt-3">
							<label class="form-label">공사명</label>
							<input type="text" class="form-control" id="location_name" name="location_name">
							<div class="invalid-feedback">공사명을 입력하세요.</div>
						</div>

						<div class="row col-12">
							<div class="col-md-25 col-4 mt-3">
								<label class="form-label">견적서 승인여부</label>
								<select class="form-select" name="estimate_apply_yn">
									<option value="">선택</option>
									<option value="Y">승인</option>
									<option value="N">미승인</option>
								</select>
							</div>
							<div class="col-md-25 col-4 mt-3">
								<label class="form-label">접수경로</label>
								<select class="form-select" id="channel" name="channel" >
									<option value="">선택</option>
									<tags:code-select codeList="${channel }"/>
								</select>
							</div>
						</div>
					</div>
					<hr>
					<div class="d-flex justify-content-end">
						<button type="button" class="btn btn-outline-primary btn-reset">초기화</button>
						<button type="button" class="btn btn-primary ms-2 btn-search">검색</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="col-12">
		<div class="card">
			<div class="card-header">
				<div class="d-flex align-items-center justify-content-between">
					<div class="d-flex align-items-center"></div>
					<div class="d-flex align-items-center">
						<button class="btn btn-outline-success" name="movePage" data-url="/abc/work/form">등록버튼</button>
					</div>
				</div>
			</div>
			<div id="b2b_grid"></div>
			<div class="card-footer">
				<div class="d-flex align-items-center justify-content-between">
					<div class="pagination"></div>
					<div class="d-flex align-items-center">
						<button class="btn btn-outline-success" name="movePage" data-url="/abc/work/form">등록버튼</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- end panel -->
<!-- page script -->
<script>
	var grid;
	var branchList = ${customerBranchList};

	/* init page */
	$(function() {
		init();
		$("#customer_no").on("change",changeSelCustomerNo);
		$(".btn-search").on("click", search);
		$(".btn-reset").on("click", reset);
		$(".btn-excel").on("click", function(){
			Wgrid.excel(grid);
		});

	});

	function changeSelCustomerNo(){
		let customerNo = this.value;
		$("#branch_no").empty();
		$("#branch_no").append("<option value=\"\">지점 선택</option>");
		$.each(branchList,function(index,item){
		    if(item.customer_no == customerNo){
		        let option = $("<option value=\""+item.branch_no+"\">"+item.branch_name+"</option>");
		        $("#branch_no").append(option);
		    }
		})
	}
	function reset(){
		let url;
		if(${work_target} == '03'){
			movePage('/abc/work/project/list', {work_target:${work_target}})
		}else{
			movePage('/abc/work/b2b/list', {work_target:${work_target}})
		}
	}
	function init() {
		console.log("========== run init()");
		let _url = "/abc/work/list/ajax";
		let colModel = [ {
			title : "작업일련번호",
			width : 130,
			align : "center",
			dataType : "string",
			dataIndx : "",
			copy : true,
			exportRender : true,
			render : function(ui) {
				let row = ui.rowData;
				return {
					text : ""
							+ '<p style="margin-bottom: 0px; color: #348fe2; font-weight: bold; text-decoration: underline; underline; text-underline-offset: 3px; ">'
							+ row.work_id + '</p>',
				};
			}
		},{
			title : "고객(사)명",
			width : 180,
			dataType : "string",
			dataIndx : "customer_name",
			render : function(ui){
				let returnString = "";
				if(ui.rowData.customer_name != null){
					returnString=ui.rowData.customer_name+"/"+ui.rowData.branch_name;
				}else{
					returnString=ui.rowData.req_name;
				}
				return returnString;
			}
		}, {
			title : "작업명",
			width : 300,
			dataType : "string",
			dataIndx : "location_name",
			render : function(ui){
				let returnString = "";
				let boldCnt = 0;
				if(ui.rowData.location_name != null ){
					if(boldCnt === 0){
						returnString += '<div style="font-weight:bold">' + ui.rowData.location_name + '</div>';
					} else {
						returnString += ui.rowData.location_name;
					}
					boldCnt++
				}
				let idx = 1;
				let brCnt = 0;
				if(ui.rowData.sub_work_location_name != null){
					let sub_location_name_arr = (ui.rowData.sub_work_location_name).split(",");
					sub_location_name_arr.forEach(function(item){
						if (brCnt === 0) returnString += "&nbsp;"+idx+". "+item;
						returnString += "<br>&nbsp;"+idx+". "+item;

						idx ++;
						brCnt++;
					});
				}
				return returnString;
			}
		}, {
			title : "작업기간",
			width : 100,
			dataType : "string",
			align : "center",
			dataIndx : "st_working_date",
			render : function(ui){
				let returnString = "";
				if(ui.rowData.st_working_date != null){
					returnString += ui.rowData.st_working_date + '(' + Utils.getDayOfWeek(ui.rowData.st_working_date) + ')'
					+'<br>' + " ~ "+ '<br>' + ui.rowData.ed_working_date + '(' + Utils.getDayOfWeek(ui.rowData.ed_working_date) + ')';
				}
				return returnString;
			}
		}, {
			title : "공무",
			width : 70,
			align : "center",
			dataType : "string",
			dataIndx : "manager_admin_name"
		}, {
			title : "감리",
			width : 70,
			align : "center",
			dataType : "string",
			dataIndx : "supervisor_admin_name"
		}, {
			title : "워커맨",
			width : 70,
			dataType : "string",
			align : "center",
			dataIndx : "",
			render : function(ui){
				let returnString = "";
				if(ui.rowData.workerman_admin_name != null){
					let workerman_admin_name_arr = (ui.rowData.workerman_admin_name).split(",");
					workerman_admin_name_arr.forEach(function(item,idx){
						if(idx === 0 ) {
							returnString += item;
						}else {
							returnString += "<br/>"+item;
						}
					});
				}
				return returnString;
			}
		}, {
			title : "견적금액",
			width : 120,
			dataType : "string",
			align : "center",
            render : function(ui){
            	let returnString = "";
            	let row = ui.rowData

            	if(ui.rowData.apply_date != null){
            		returnString ='<div style="font-weight: bold">'+ new Intl.NumberFormat().format(ui.rowData.total_unit_price)+ '</div>'+ ui.rowData.apply_date;
            	}else{
            		returnString = "승인전";
            	}

            	return {
            		text : ""
					+ returnString
            	}


			}
		}, {
			title : "실행가",
			width : 120,
            dataType: "integer",
            format: "#,###",
			dataIndx : "excute_price"
		}, {
			title : "매출이익",
			width : 120,
            dataType: "integer",
            format: "#,###",
            render : function(ui){
            	let returnString = "";
            	if(ui.rowData.apply_date != null){
            		let option = {
            				   style: 'percent',
            				   minimumFractionDigits: 1,
            				   maximumFractionDigits: 1
            				};
	            	returnString = new Intl.NumberFormat().format(ui.rowData.total_unit_price - ui.rowData.excute_price);
	            	returnString += "<br/>";
	            	returnString += "(";
	            	returnString += new Intl.NumberFormat("en-US",option).format( ((ui.rowData.total_unit_price - ui.rowData.excute_price)/ui.rowData.total_unit_price) );
	            	returnString += ")";
            	}else{
            		returnString = "-";
            	}
				return returnString;
			}
		}, {
			title : "결제",
			width : 120,
            dataType: "integer",
            format: "#,###",
            render : function(ui){
            	let returnString = "";
            	if(ui.rowData.apply_date != null){
            		let option = {
            				   style: 'percent',
            				   minimumFractionDigits: 1,
            				   maximumFractionDigits: 1
            				};
	            	returnString = new Intl.NumberFormat().format(ui.rowData.paid_amount);
	            	returnString += "<br/>";
	            	returnString += "(";
	            	returnString += new Intl.NumberFormat("en-US",option).format(ui.rowData.paid_amount/ui.rowData.total_unit_price);
	            	returnString += ")";
            	}else{
            		returnString = "-";
            	}
				return returnString;
			}
		}, {
			title : "상태",
			width : 90,
			dataType : "string",
			align : "center",
			render : function(ui){
				let returnString = "";
				if(ui.rowData.work_stat == '99' || ui.rowData.work_stat == '19'){
					returnString = "<span style='color:red;'>"+getCodeNm('new_work_stat',ui.rowData.work_stat)+"</span>";
				}else{
					returnString = "<span>"+getCodeNm('new_work_stat',ui.rowData.work_stat)+"</span>";
				}
				return returnString
			}
		} ];

		let options = {
                title:"b2b_worke_list",
                cellDblClick: function( evt, ui ) {
                },
                rowDblClick: function( event, ui ) {
					event.preventDefault();
					let _param = {work_no : ui.rowData.work_no};
					let _url = "/abc/work/view";
					postPage(_url, _param);
					pushState(_url, _param,"postPage");
				}
		};
		/* 그리드 데이터 받는곳  */
		grid = Wgrid.draw("#b2b_grid", {"work_target":"${work_target}"}, _url, colModel, options);
	}

	function search() {
		console.log("========== run search()");
		let $form = $("#frm_search");
		_param = $form.serializeObject();
		console.log('search : ',_param);
		grid.option("dataModel.postData", _param);
	    grid.refreshDataAndView();
	    //_param.grid = grid;
	    pushState((location.hash).replace("#",""), _param,"grid");
	}

</script>