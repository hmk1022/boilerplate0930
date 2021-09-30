<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<!-- page title -->
	<h1 class="page-header">고객사 관리</h1>
	<!-- content area -->
	<div class="row">
		<!-- Begin area search -->
		<div class="col-12 mb-3">
            <div class="card">
            	<form id="frm_search" name="frm"  novalidate="">
                <div class="card-body border border-primary">
                    <div class="row justify-content-md-between">
                        <div class="col-md-2 col-4 mt-3">
                            <label class="form-label">고객사명</label>
                            <input type="text" class="form-control" name="customer_name">
                            <div class="invalid-feedback">고객사명을 입력하세요.</div>
                        </div>
                        <div class="col-md-2 col-4 mt-3">
                            <label class="form-label">담당자명</label>
                            <input type="text" class="form-control" name="manager_name">
                            <div class="invalid-feedback">담당자명을 입력하세요.</div>
                        </div>
                        <div class="col-md-8 col-4 mt-3">
                        </div>
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
		<!-- Begin area content -->
		<div class="col-12">
            <div class="card">
                <div class="card-header">
                    <div class="d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center">
                        </div>
                        <div class="d-flex align-items-center">
                            <!-- <button class="btn btn-outline-success" name="movePage" data-url="/code/customer/form">등록버튼</button> -->
                            <button class="btn btn-outline-success" onclick="javascript:goEditPage('/code/customer/form');">등록버튼</button>
                        </div>
                    </div>
                </div>
                <!-- area grid -->
                <div class="card-body table-responsive" id="grid_json" style="margin:auto;">
                </div>
                <div class="card-footer">
                    <div class="d-flex align-items-center justify-content-between">
                        <div class="pagination">
                        </div>
                        <div class="d-flex align-items-center">
                            <!-- <button class="btn btn-outline-success" name="movePage" data-url="/code/customer/form">등록버튼</button> -->
                            <button class="btn btn-outline-success" onclick="javascript:goEditPage('/code/customer/form');">등록버튼</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<!-- End area content -->
	</div>
	
<!-- 	<input type="text" id="ttt1" name="ttt" value="111" disabled/>
	<input type="text" id="ttt2" name="ttt" value="222"/> -->
	
	<!-- page script -->
	<script>
	var curPage;
	var gridTmp;
	
	/* init page */
	$(function(){
		console.log('page script !!!! ');
		
		$(".btn-search").on("click", search);
		
		$("#dev_button_form").on("click", function(e){
			e.preventDefault()
			window.location.href="";
		});
		
		var colModel = [
	        {
	            title: "고객ID", //title of column.
	            width: 150, //initial width of column
	            height: 50,
	            align: "center",
	            dataType: "string", //data type of column
	            dataIndx: "customer_id", //should match one of the keys in row data.
            	render : function(ui) {
				let row = ui.rowData;
					return {
						text : ""
								+ '<p style="margin-bottom: 0px; color: #00acac; text-decoration: underline; text-underline-offset: 3px; ">'
								+ row.customer_id + '</p>',
					};
				}
	        },	        
	        {
	            title: "고객사명", //title of column.
	            width: 200, //initial width of column
	            dataType: "string", //data type of column
	            align : "center",
	            dataIndx: "customer_name" //should match one of the keys in row data.
	        },
	        {
	            title: "사업자번호", //title of column.
	            width: 120, //initial width of column
	            dataType: "string", //data type of column
	            align: "center",
	            dataIndx: "comp_number", //should match one of the keys in row data.
	            format: function(val){
	            	return Utils.bussNo(val);
	            }
	        },
	        {
	            title: "담당자명", //title of column.
	            width: 100, //initial width of column
	            align : "center",
	            dataType: "string", //data type of column
	            dataIndx: "manager_name" //should match one of the keys in row data.
	        },
	        {
	            title: "연락처",
	            width: 150,
	            dataType: "string",
	            align : "center",
	            dataIndx: "manager_hp",
	            format: function(val){
	            	return Utils.phone(val);
	            }
	        },
	        {
	            title: "e-mail",
	            width: 200,
	            dataType: "string",
	            dataIndx: "manager_email"
	        },
	        {
	            title: "상태",
	            width: 80,
	            dataType: "string",
	            align: "center",
	            dataIndx: "stat",
	            format: function(val){
	            	return getCodeNm('stat', val);
	            }
	        },
	        {
	            title: "등록자",
	            width: 100,
	            dataType: "string",
	            align : "center",
	            dataIndx: "create_name"
	        },
	        {
	            title: "등록일시",
	            width: 100,
	            dataType: "string",
	            dataIndx: "create_date",
	            align: "center",
	            format: "yy-mm-dd"
	        },
	        {
	            title: "수정자",
	            width: 100,
	            dataType: "string",
	            align : "center",
	            dataIndx: "update_name"
	        },
	        {
	            title: "수정일시",
	            width: 100,
	            dataType: "string",
	            dataIndx: "update_date",
	            align: "center",
	            format: "yy-mm-dd"
	        },
	        {
	            title: "고객번호",
	            dataIndx: "customer_no",
	            hidden: true
	        },

	    ];


		const _desc = "고객사 지점 목록 조회";	// ajax name
		const _url = "/code/customer/list/ajax";	// ajax url
		let _param = {};	// ajax param
		var data;
		
	    // draw grind 
		let options = {
			rowDblClick: function( event, ui ) {
				event.preventDefault();
				console.log("ui", ui.rowData.customer_no);
				let param = {customer_no : ui.rowData.customer_no}
				//postPage("/code/customer/view", param);
				goViewPage("/code/customer/view", param);
			},
			rowHeight: 50
	    };
		
	    
		gridTmp = Wgrid.draw("#grid_json", _param, _url, colModel, options, _desc);
		
	});

	function search() {
		console.log("========== run search()");
		let $form = $("#frm_search");
		param = $form.serializeObject();
		console.log('search : ', param);
		gridTmp.option("dataModel.postData", param);
		gridTmp.refreshDataAndView();
	}
	</script>
	
	<style>
			.ui-jqgrid .ui-jqgrid-htable th div {
		    height:auto;
		    overflow:hidden;
		    padding-right:4px;
		    padding-top:2px;
		    position:relative;
		    vertical-align:text-top;
		    white-space:normal !important;
		}
	</style>