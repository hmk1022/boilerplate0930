<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
	<!-- page title -->
	<h1 class="page-header">구매 요청 관리</h1>
	<!-- content area -->
	<div class="row">
		<!-- Begin area search -->
		<div class="col-12 mb-3">
            <div class="card">
                <div class="card-body border border-primary">
                    <div class="row justify-content-md-between">
                        <div class="col-md-25 col-6">
                            <label class="form-label mb-2">날짜검색</label>
                            <div class="">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" id="inlineRadio1" name="inlineRadio">
                                    <label class="form-check-label" for="inlineRadio1">접수일</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" id="inlineRadio2" name="inlineRadio">
                                    <label class="form-check-label" for="inlineRadio2">작업일</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-25 col-6 row align-items-end">
                            <div class="input-group">
                                <input type="text" class="form-control text-center" id="reg_date_from" placeholder="연도. 월. 일.">
                                <span class="input-group-append input-group-text px-1 my-0 pt-1 rounded-0 border-right-0"> ~ </span>
                                <input type="text" class="form-control text-center" id="reg_date_to" placeholder="연도. 월. 일.">
                            </div>
                        </div>
                        <div class="col-md-25 col-4">
                            <label class="form-label">고객구분</label>
                            <select class="form-select">
                                <option value="">선택</option>
                            </select>
                        </div>
                        <div class="col-md-25 col-4">
                            <label class="form-label">고객사</label>
                            <select class="form-select">
                                <option value="">선택</option>
                            </select>
                        </div>
                        <div class="col-md-25 col-4">
                            <label class="form-label">지점</label>
                            <select class="form-select">
                                <option value="">선택</option>
                            </select>
                        </div>
                        <div class="col-md-25 col-4 mt-3">
                            <label class="form-label">고객명</label>
                            <input type="text" class="form-control">
                            <div class="invalid-feedback">고객명을 입력하세요.</div>
                        </div>
                        <div class="col-md-25 col-4 mt-3">
                            <label class="form-label">현장주소</label>
                            <input type="text" class="form-control">
                            <div class="invalid-feedback">현장주소를 입력하세요.</div>
                        </div>
                        <div class="col-md-25 col-4 mt-3">
                            <label class="form-label">담당자</label>
                            <input type="text" class="form-control">
                            <div class="invalid-feedback">담당자를 입력하세요.</div>
                        </div>
                        <div class="col-md-25 col-4 mt-3">
                            <label class="form-label">일련번호</label>
                            <input type="text" class="form-control">
                            <div class="invalid-feedback">일련번호을 입력하세요.</div>
                        </div>
                        <div class="col-md-25 col-4 mt-3">
                            <label class="form-label">공사명</label>
                            <input type="text" class="form-control">
                            <div class="invalid-feedback">공사명을 입력하세요.</div>
                        </div>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-end">
                        <button class="btn btn-outline-primary">초기화</button>
                        <button class="btn btn-primary ms-2">검색</button>
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
                        <div class="d-flex align-items-center">
                        </div>
                        <div class="d-flex align-items-center">
                            <button class="btn btn-outline-success" name="movePage" data-url="/material/bound/form">등록버튼</button>
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
                            <button class="btn btn-outline-success" name="movePage" data-url="/material/bound/form">등록버튼</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<!-- End area content -->
	</div>
	
	<!-- page script -->
	<script>
	var curPage;
	
	/* init page */
	$(function(){
		console.log('page script !!!! ');

		$("#dev_button_form").on("click", function(e){
			e.preventDefault()
			window.location.href="";
		});
		
		var colModel = [
	        {
	            title: "구매전표", 
	            width: 150, 
	            align: "center",
	            dataType: "string", 
	            dataIndx: "material_bound_id" 
	        },	        
	        {
	            title: "구매사유", 
	            width: 200, 
	            dataType: "string", 
	            dataIndx: "bound_reason",
	            format: function(val){
	            	return getCodeNm('bound_reason', val);
	            }
	        },	        
	        {
	            title: "구매목록/메모",
	            width: 180,
	            dataType: "string",
	            align : "center",
	            render: function(ui){
	            	let row = ui.rowData;
	            	return {
	            		text : row.remarks
	            	}
	            }
	        },
	        {
	            title: "총결제금액", 
	            width: 150, 
	            dataType: "integer",
	            format: "#,###", 
	            dataIndx: "bound_sum_price",
	        },
	        {
	            title: "거래처", 
	            width: 150, 
	            dataType: "string", 
	            dataIndx: "receive_type",
	            format: function(val){
	            	//return getCodeNm('receive_type', val);
	            	return '거래처명'
	            }
	        },	        
	        {
	            title: "거래명세서", 
	            width: 150, 
	            dataType: "string", 
	            dataIndx: "manager_name",
	            format: function(val){
	            	//return getCodeNm('receive_type', val);
	            	return '거래명세서'
	            }
	        },
	        {
	            title: "결제예정일", 
	            width: 120, 
	            align: "center",
	            dataType: "string", 
	            dataIndx: "pay_req_date",
	            format: function(val){
	            	return Utils.getDate(val);
	            }
	        },	        
	        {
	            title: "결제완료일", 
	            width: 100, 
	            dataType: "string",
	            align: "center",
	            dataIndx: "bound_admin_name",
	            format: function(val){
	            	//return getCodeNm('receive_type', val);
	            	return '-'
	            }
	        },	        
	        {
	            title: "상태", 
	            width: 100, 
	            dataType: "string", 
	            dataIndx: "bound_stat",
	            align: "center",
	            format: function(val){
	            	return getCodeNm('bound_stat', val);
	            }
	        },	        
	        {
	            title: "등록일", 
	            width: 120, 
	            dataType: "string", 
	            align: "center",
	            dataIndx: "create_date",
	            format: function(val){
	            	return Utils.getDatetime(val);
	            }
	        },
	        {
	            title: "구매번호",
	            dataIndx: "material_bound_no",
	            hidden: true
	        },
	    ];


		const _desc = "구매 목록 조회";	// ajax name
		const _url = "material/bound/list/ajax";	// ajax url
		let _param = {};	// ajax param
		var data;
		
	    // draw grind 
		let options = {
			rowDblClick: function( event, ui ) {
				event.preventDefault();
				console.log("ui", ui.rowData.material_bound_no);
				let param = {material_bound_no : ui.rowData.material_bound_no}
				postPage("material/bound/view", param);
			}
	    };
		
	    
		Wgrid.draw("#grid_json", _param, _url, colModel, options, _desc);
		
		console.log('테스트!!!');
	});

	</script>