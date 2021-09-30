<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
	<!-- page title -->
	<h1 class="page-header">단위 관리</h1>
	<!-- content area -->
	<div class="row">
		<!-- Begin area search -->
		<!-- <div class="col-12 mb-3">
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

        </div> -->
		<!-- End area search -->
		<!-- Begin area content -->
		<div class="col-12">
            <div class="card">
                <div class="card-header">
                    <div class="d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center">
                        </div>
                        <div class="d-flex align-items-center">
                            <button class="btn btn-outline-success" name="movePage" data-url="/code/unit/form"">등록버튼</button>
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
                            <button class="btn btn-outline-success" name="movePage" data-url="/code/unit/form">등록버튼</button>
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
	            title: "단위명", //title of column.
	            width: 150, //initial width of column
	            dataType: "string", //data type of column
	            align : "center",
	            dataIndx: "unit_name" //should match one of the keys in row data.
	        },	        
	        {
				title : "단위 메모", 
				width : 300, 
				dataType : "string", 
				dataIndx : "unit_memo",
	        },
	        {
				title : "사용여부", 
				width : 100, 
				dataType : "string", 
				dataIndx : "use_yn",
				align: "center",
				render: function(ui){
					//makeGridBtn(ui.rowData.del_yn);
					var btnString;
					console.log(this);
					if(ui.rowData.use_yn == 'Y'){
						btnString = "<button class=\"btn btn-info btn-sm waves-effect block_btn\" onclick=\"blocUnit(this)\" data-no=\""+ui.rowData.code_value+"\" data-name=\""+ui.rowData.unit_name+"\">사용</button>";
					}else{
						btnString = "<button class=\"btn btn-danger btn-sm waves-effect unblock_btn\" onclick=\"unblocUnit(this)\" data-no=\""+ui.rowData.code_value+"\" data-name=\""+ui.rowData.unit_name+"\">미사용</button>";
					}
					console.log("btnString ",btnString);
					return{
						text: btnString,
						style: "text-align:center"
					}
				}
        	},
	     
	    ];


		const _desc = "단위 목록 조회";	// ajax name
		const _url = "/code/unit/list/ajax";	// ajax url
		let _param = {};	// ajax param
		var data;
		
	    // draw grind 
		let options = {
			rowDblClick: function( event, ui ) {
				event.preventDefault();
				console.log("ui", ui.rowData.code_value);
				let param = {code_value : ui.rowData.code_value}
				postPage("/code/unit/view", param);
			}
	    };
		
	    
		Wgrid.draw("#grid_json", _param, _url, colModel, options, _desc);
		
		console.log('테스트!!!');
		
		
		
	});
	
	
	function blocUnit(obj){
		var unit_value = $(obj).attr('data-no');
		var unit_name = $(obj).attr('data-name');

		if(confirm('"'+unit_name+'"단위를 사용하지 않겠습니끼?', "주의하세요!")){
				var _param = {
						unit_value : unit_value,
						use_yn : 'N'
				};
				//_param = Object.entries(_param).map(e => e.join('=')).join('&');
				console.log("_param",JSON.stringify(_param));
				Utils.requestAjax("유닛 차단", "/unit/updateUnitStat", _param, {
					beforeSend: function(){
						//console.log("before !!!");
		            },
		            success:  function(data) {
		            	console.log("data",data);
						/* if(data.result == 'Y'){
							toast('정상 처리되었습니다.', 'success');
							list('${rv.nowPage}');
						}else{
							toast('처리중 오류가 발생하였습니다.', 'error');
						} */
		            	movePage("/code/unit/list");
		            },
		            complete:  function(response) {
						//console.log("complete !!!", response);
		            }
				});
		};

	}
	
	function unblocUnit(obj){
		var unit_value = $(obj).attr('data-no');
		var unit_name = $(obj).attr('data-name');

		if(confirm('"'+unit_name+'"단위를 사용 하시겠습니까?', "주의하세요!")){
				var _param = {
						unit_value : unit_value,
						use_yn : 'Y'
				};
				//_param = Object.entries(_param).map(e => e.join('=')).join('&');
				console.log("_param",JSON.stringify(_param));
				Utils.requestAjax("단위 차단", "/unit/updateUnitStat", _param, {
					beforeSend: function(){
						//console.log("before !!!");
		            },
		            success:  function(data) {
		            	console.log("data",data);
						/* if(data.result == 'Y'){
							toast('정상 처리되었습니다.', 'success');
							list('${rv.nowPage}');
						}else{
							toast('처리중 오류가 발생하였습니다.', 'error');
						} */
						movePage("/code/unit/list");
		            },
		            complete:  function(response) {
						//console.log("complete !!!", response);
		            }
				});
		};
	}

	</script>