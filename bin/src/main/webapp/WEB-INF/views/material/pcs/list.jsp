<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- page title -->
<h1 class="page-header">구매 리스트</h1>
<!-- content area -->
<div class="row">
	<!-- Begin area search -->
	<div class="col-12 mb-3">
		<div class="card">
			<form id="frm_search" data-parsley-validate="true" name="frm"  novalidate="">
				<div class="card-body border border-primary">
					<div class="row justify-content-md-between">
						<div class="col-md-3 col-4 mt-3">
							<label class="form-label">요청서번호</label>
							<input type="text" name="s_material_pcs_id"	class="form-control">
							<div class="invalid-feedback">요청서번호를 입력하세요.</div>
						</div>
						<div class="col-md-3 col-4 mt-3">
							<label class="form-label">담당자명</label>
							<input type="text" name="s_material_doc_admin_name" class="form-control">
							<div class="invalid-feedback">요청자/담당자명을 입력하세요.</div>
						</div>
						<div class="col-md-3 col-4 mt-3">
							<label class="form-label">구매사유</label>
							<select class="form-select" id="pcs_reason" name="s_pcs_reason">
						        <tags:code-select
									codeList="${pcs_reason }"
									selected=""
									defaultValue="선택" />
							</select>
						</div>
						<div class="col-md-3 col-4 mt-3">
							<label class="form-label">상태</label>
							<select class="form-select" id="doc_stat" name="s_pcs_stat">
						        <tags:code-select
									codeList="${pcs_stat }"
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
						<button class="btn btn-outline-success" name="movePage"
							data-url="/material/pcs/form">등록버튼</button>
					</div>
				</div>
			</div>
			<!-- area grid -->
			<div class="card-body table-responsive" id="grid_json"
				style="margin: auto;"></div>
			<div class="card-footer">
				<div class="d-flex align-items-center justify-content-between">
					<div class="pagination"></div>
					<div class="d-flex align-items-center">
						<button class="btn btn-outline-success" name="movePage"
							data-url="/material/pcs/form">등록버튼</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End area content -->
</div>

<!-- page script -->
<script>
	/* var curPage; */
	var grid;

	$(function () {
		init();

		$(".btn-search").on("click", search);

		/* $("#dev_button_form").on("click", function(e) {
			e.preventDefault()
			 window.location.href = "";
		}); */
	})
	/* init page */
	function init() {

		var colModel = [ {
			title : "구매전표",
			width : 100,
			align : "center",
			dataType : "string",
			dataIndx : "material_pcs_id",
			render : function(ui) {
				let row = ui.rowData;
				return {
					text : ""
							+ '<p style="margin-bottom: 0px; color: #00acac; text-decoration: underline; text-underline-offset: 3px; ">'
							+ row.material_pcs_id + '</p>',
				};
			}
		}, {
			title : "구매사유",
			width : 120,
			dataType : "string",
			dataIndx : "pcs_reason",
			align : "center",
			format : function(val) {
				return getCodeNm('pcs_reason', val);
			}
		}, {
			title : "구매목록/메모",
			width : 300,
			dataType : "string",
			render : function(ui) {
				let row = ui.rowData;
				let _text = "";
				if(!Utils.isEmpty(row.material_name)){
					_text = row.material_name + (row.item_cnt > 0?" 외 "+row.item_cnt+"건":"")
					+ '<span style="color:red"><br>[메모]<br>'+row.remarks+"</span>";

				} else {
					_text = row.remarks;
				}
				return {
					text : _text
				}
			}
		}, {
			title : "총결제금액",
			width : 100,
			dataType : "integer",
			format : "#,###",
			style:"font-weight: bold",
			dataIndx : "sum_item_amt",
		}, {
			title : "거래처",
			width : 100,
			dataType : "string",
			align : "center",
			dataIndx : "vendor_name",
		}
		, {
			title : "거래명세서",
			width : 80,
			align : "center",
			dataType : "string",
			render : function(ui) {
				let row = ui.rowData;
				let _botton = '<button class="btn btn-xs btn-primary _button_img_pop" onclick="getImagePop(\'IMG_TYPE_MATERIAL_PCS\', \''+row.material_pcs_no+'\', \'거래명세서\');" >확인</button>';
				return {
					text : _botton,
				};
			}
		 }
		, 
		/* {
			title : "결제예정일",
			width : 100,
			align : "center",
			dataType : "string",
			dataIndx : "pay_req_date",
			format : function(val) {
				
				return Utils.getDate(val)
			}
		}, */ 
		{
			title : "결제예정일",
			width : 100,
			align : "center",
			dataType : "string",
			dataIndx : "pay_req_date",
			render : function(ui) {
				let row = ui.rowData;
				let _text =  Utils.getDate( row.pay_req_date) + '('+ Utils.getDayOfWeek(Utils.getDate(row.pay_req_date)) + ')';
				
				if (!Utils.getDayOfWeek(Utils.getDate(row.pay_req_date))) _text = ""
							
				return _text
			}
		}, 
		
		{
			title : "결제완료일",
			width : 100,
			dataType : "string",
			align : "center",
			render : function(ui) {
				let row = ui.rowData;
				let _text = "";
				if(!Utils.isEmpty(row.confirm_date)){
					_text = row.confirm_date + '(' + Utils.getDayOfWeek(row.confirm_date) + ')' + '<br>' + row.confirm_admin_name
				}
				return {
					text : _text
				};
			}
		}, {
			title : "상태",
			width : 80,
			dataType : "string",
			dataIndx : "pcs_stat",
			align : "center",
			format : function(val) {
				return getCodeNm('pcs_stat', val);
			}
		}, {
			title : "등록일",
			width : 140,
			dataType : "string",
			align : "center",
			dataIndx : "create_date",
			render : function(ui) {
				let row = ui.rowData;
				let _text = Utils.getDatetime(row.create_date).substr(0,10)+ '(' +Utils.getDayOfWeek( Utils.getDatetime(row.create_date).substr(0,10)) + ')' 
				+ '<br>' + Utils.getDatetime(row.create_date).substr(11,13)
				return {
					text : _text
				};
			}
		},
		{
			title : "요청자",
			width : 80,
			dataType : "string",
			align : "center",
			dataIndx : "create_date",
			render : function(ui) {
				let row = ui.rowData;
				let _text = row.create_name
				return {
					text : _text
				};
			}
		},
		
		{
			title : "구매번호",
			dataIndx : "material_pcs_no",
			hidden : true
		},
		];

		const _desc = "구매 목록 조회"; // ajax name
		const _url = "/material/pcs/list/ajax"; // ajax url
		let _param = {}; // ajax param
		var data;

		// draw grind
		let options = {
			rowDblClick : function(event, ui) {
				event.preventDefault();
				console.log("ui", ui.rowData.material_pcs_no);
				let param = {
					material_pcs_no : ui.rowData.material_pcs_no
				}
				postPage("material/pcs/view", param);
			}
		};

		grid = Wgrid.draw("#grid_json", _param , _url, colModel, options,  _desc);

		console.log('테스트!!!');

	}

	function search() {
		console.log("========== run search()");
		let $form = $("#frm_search");
	    param = $form.serializeObject();
		console.log('search : ',param);
		console.log('param2:', param)
		grid.option("dataModel.postData", param);
	    grid.refreshDataAndView();
	}


</script>