<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- begin page-header -->
<h1 class="page-header">물류센터 자재 현황</h1>
<!-- content area -->
<div class="row">
	<!-- Begin area search -->
	<div class="col-12 mb-3">
		<div class="card">
			<form id="frm_search" data-parsley-validate="true" name="frm" novalidate="">
				<div class="card-body border border-primary">
					<div class="row justify-content-md-between">
						<div class="col-md-25 col-4 mt-3">
							<label class="form-label">자재명</label>
							<input type="text" class="form-control" id="s_material_name" name="s_material_name" placeholder="자재명을 입력하세요.">
							<div class="invalid-feedback">자재명을 입력하세요.</div>
						</div>
		                <div class="col-md-3 col-12 mt-3">
		                    <label class="form-label">대분류 <span class="text-danger"></span></label>
		                    <select class="form-select" id="s_cate1" name="s_cate1">
								<option value="">선택</option>
							</select>
		                </div>
		                <div class="col-md-3 col-12 mt-3">
		                    <label class="form-label">중분류 <span class="text-danger"></span></label>
		                    <select class="form-select" id="s_cate2" name="s_cate2">
								<option value="">선택</option>
							</select>
		                </div>
		                <div class="col-md-3 col-12 mt-3">
		                    <label class="form-label">소분류 <span class="text-danger"></span></label>
		                    <select class="form-select" id="s_cate3" name="s_cate3">
								<option value="">선택</option>
							</select>
		                </div>

					</div>
					<hr>
					<div class="d-flex justify-content-end">
						<button type="button" class="btn btn-outline-primary _btn_init_srch">초기화</button>
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
						<button class="btn btn-outline-success" name="movePage"
							data-url="/material/bound/in/form">입고등록</button>
						&nbsp;
						<button class="btn btn-outline-success" name="movePage"
							data-url="/material/bound/out/form">출고등록</button>
						&nbsp;
						<button class="btn btn-success" name="movePage"
							data-url="/material/form">자재신규등록</button>
					</div>
				</div>
			</div>
			<div id="grid_json"></div>
		</div>
		<div class="card-footer">
			<div class="d-flex align-items-center justify-content-between">
				<div class="pagination"></div>
				<div class="d-flex align-items-center">
					<button class="btn btn-outline-success" name="movePage"
						data-url="/material/bound/in/form">입고등록</button>
					&nbsp;
					<button class="btn btn-outline-success" name="movePage"
						data-url="/material/bound/out/form">출고등록</button>
					&nbsp;
					<button class="btn btn-success" name="movePage"
						data-url="/material/form">자재신규등록</button>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- page script -->
<script>
	var curPage;
	var tempGrid;

	/* init page */
	$(function() {

		init();

		//debugger;
		console.log('page script !!!! ');

		$(".btn-search").on("click", search);
		$("#dev_button_form").on("click", function(e) {
			e.preventDefault()
			window.location.href = "";
		});

		// category list
	    /* 카테고리 조회 */
	    listCategory("1", "");

	    $("#s_cate1").on("change", function(){
	    	listCategory("2", $(this).val());
	    	$("#s_cate3").html('<option value="">선택</option>');
	    	$("#material_list").html('<option value="">선택</option>');
	    });

	    $("#s_cate2").on("change", function(){
	    	listCategory("3", $(this).val());
	    });

	});

	function init() {
		var colModel = [
				{
					title : "제품ID",
					width : 150,
					dataType : "string",
					align : "center",
					dataIndx : "material_id",
					render : function(ui) {
						let row = ui.rowData;
						return {
							text : ""
									+ '<p style="margin-bottom: 0px; color: #00acac; text-decoration: underline; text-underline-offset: 3px; ">'
									+ row.material_id + '</p>',
						};
					}
				},
				{
					title : "제품명",
					width : 350,
					dataType : "string",
					dataIndx : "material_name",
					render : function(ui) {
						let row = ui.rowData;
						return {
							text : row.material_name
									+ '<br>'
									+ '<p class="text-danger" style="margin-bottom: 0px;">'
									+ row.house_name + '</p>',
						};
					}
				},
				{
					title : "브랜드",
					width : 100,
					dataType : "string",
					align : "center",
					dataIndx : "brand_name"
				},
				{
					title : "모델명",
					width : 120,
					dataType : "string",
					dataIndx : "model_name"
				},
				{
					title : "물류센터",
					width : 90,
					dataType : "integer",
					format : "#,###",
					dataIndx : "house_cnt",
					style:"font-weight: bold"
				},
				{
					title : "성수SBA",
					width : 90,
					dataType : "integer",
					format : "#,###",
					dataIndx : "sba_cnt",
					style:"font-weight: bold"
				},
				{
					title : "르노(마포)",
					width : 90,
					dataType : "integer",
					format : "#,###",
					dataIndx : "vehicle_cnt",
					style:"font-weight: bold"
				},
				{
					title : "단위",
					width : 100,
					dataType : "string",
					align : "center",
					dataIndx : "unit_cd",
					format : function(val) {
						return getCodeNm('unit_cd', val);
					}
				},
				{
					title : "매입단가",
					width : 120,
					dataType : "integer",
					format : "#,###",
					dataIndx : "purchased_price",
					style:"font-weight: bold"
				},
				{
					title : "워커맨공급가",
					width : 120,
					dataType : "integer",
					format : "#,###",
					dataIndx : "workerman_price",
					style:"font-weight: bold"
				},
				{
					title : "복수시공단가",
					width : 120,
					dataType : "integer",
					format : "#,###",
					dataIndx : "multi_price",
				},
				{
					title : "시장가",
					width : 120,
					dataType : "integer",
					format : "#,###",
					dataIndx : "sale_price",
				},
				{
					title : "랙번호",
					width : 100,
					dataType : "string",
					align : "center",
					dataIndx : "rack_id"
				},
				{
					title : "대분류",
					width : 100,
					dataType : "string",
					align : "center",
					dataIndx : "cate1_name"
				},
				{
					title : "중분류",
					width : 100,
					dataType : "string",
					align : "center",
					dataIndx : "cate2_name",
				},
				{
					title : "소분류",
					width : 100,
					dataType : "string",
					align : "center",
					dataIndx : "category_name"
				},
				// 더미 컬럼 우측에 여백을 위해추가함.
				{
					title : "",
					width : 3,
				},
				/*{
					title : "입고/출고",
					width : 120,
					dataType : "string",
					align : "center",
					render : function(ui) {
						let row = ui.rowData;
						return {
							text : '<button class="btn btn-xs btn-primary">입고</button> <button class="btn btn-xs btn-success">출고</button>',
						};
					}
				},
				*/
				{
					title : "제품번호",
					dataIndx : "material_no",
					hidden : true
				},

		];

		const _desc = "자재 목록 조회"; // ajax name
		const _url = "/material/list/ajax"; // ajax url

		let _param = {
			s_material_name : $("#s_material_name").val(),
			s_category_id : $("#s_cate3").val() != ''? $("#s_cate3").val() : $("#s_cate2").val() != ''? $("#s_cate2").val()	: $("#s_cate1").val()
		}; // ajax param
		var data;

		// draw grind
		let options = {
			rowDblClick : function(event, ui) {
				event.preventDefault();
				console.log("ui", ui.rowData.material_no);
				let param = {
					material_no : ui.rowData.material_no
				}
				//postPage("/material/view", param);
				goViewPage("/material/view", param);
			}
		};

		tempGrid = Wgrid.draw("#grid_json", _param, _url, colModel, options, _desc);
	}

	function search() {
		console.log("========== run search()");
		let $form = $("#frm_search");
		param = $form.serializeObject();
		param.s_category_id = $("#s_cate3").val() != ''? $("#s_cate3").val() : $("#s_cate2").val() != ''? $("#s_cate2").val()	: $("#s_cate1").val();
		//console.log('search : ', param);
		tempGrid.option("dataModel.postData", param);
		tempGrid.refreshDataAndView();
	}

	// 카테고리 목록조회.
	function listCategory(category_level, p_category_id){

		const _name = "카테고리조회 조회";	// ajax name
		const _url = "/material/category/list/ajax";	// ajax url
		let _param = {};	// ajax param

		_param.category_level = category_level;
		_param.p_category_id = p_category_id;

		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {

	          	if(data != undefined){
	          		let temp_list = '<option value="">선택</option>';
	          		$.each(data.data, function(index, item){
	          			temp_list += '<option value="'+ item.category_id +'" data-category_no="'+ item.category_no +'" >'+item.name+ '</option>';
	          		});

	          		$("#s_cate"+category_level).html(temp_list);
	          	}
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
</script>