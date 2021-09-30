<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
	<!-- end breadcrumb -->
	<!-- begin page-header -->
	<h1 class="page-header">admin <small>계정관리</small></h1>
	<!-- end page-header -->
	<!-- begin panel -->
	<div class="row">
		<!-- Begin area search -->
	<div class="col-12 mb-3">
		<div class="card">
			<form id="frm_search" data-parsley-validate="true" name="frm" novalidate="">
				<div class="card-body border border-primary">
					<div class="row justify-content-md-between">
						<div class="col-md-3 col-4 mt-3">
							<label class="form-label">이름</label>
							<input type="text" class="form-control" id="admin_name" name="admin_name" placeholder="이름을 입력하세요.">
							<div class="invalid-feedback">이름을 입력하세요.</div>
						</div>
		                <div class="col-md-3 col-4 mt-3">
							<label class="form-label">아이디</label>
							<input type="text" class="form-control" id="admin_id" name="admin_id" placeholder="아이디를 입력하세요.">
							<div class="invalid-feedback">아이디를 입력하세요.</div>
						</div>
		                <div class="col-md-3 col-12 mt-3">
		                    <label class="form-label">부서 <span class="text-danger"></span></label>
		                    <select class="form-select" id="department_cd" name="department_cd">
								<!-- <option value="">선택</option> -->
								<tags:code-select
									codeList="${department }"
									selected=""
									defaultValue="선택"
								/>
							</select>
		                </div>
		                <div class="col-md-3 col-12 mt-3">
		                    <label class="form-label">상태 <span class="text-danger"></span></label>
		                    <select class="form-select" id="stat" name="stat">
								<tags:code-select
									codeList="${stat_cd }"
									selected=""
									defaultValue="선택"
								/>
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





		<!-- <div class="col-12">
			<form class="search_form" >
			<div class="card">
				<div class="col-12 mb-3">
					<div class="card-header">

							<div class="d-flex align-items-center justify-content-between">
				                        <div class="d-flex align-items-center">
				                        </div>
				                        <div class="d-flex align-items-center">
				                            <button type="button" class="btn btn-outline-success" name="movePage" data-url="/operation/admin/form">등록버튼</button>
				                        </div>
				            </div>
			            </div>
			            </form>
					<div class="card-body table-responsive" id="grid_json" style="margin:auto;" ></div>
					<div class="card-footer">
		                    <div class="d-flex align-items-center justify-content-between">
		                        <div class="pagination">
		                        </div>
		                        <div class="d-flex align-items-center">
		                            <button type="button" class="btn btn-outline-success" name="movePage" data-url="/operation/admin/form">등록버튼</button>
		                        </div>
		                    </div>
		                </div>
			</div>
		</div> -->
		<div class="col-12">
			<div class="card">
				<form class="search_form" >
					<div class="card-header">
						<div class="form-row">
						<div class="col">
						<div class="d-flex align-items-center justify-content-between">
			                        <div class="d-flex align-items-center">
			                        </div>
			                        <div class="d-flex align-items-center">
			                            <button type="button" class="btn btn-outline-success" name="movePage" data-url="/operation/admin/form">등록버튼</button>
			                        </div>
			            </div>
					</div>
					</div>
				</div>
				</form>
				<div id="grid_json"></div>
			</div>
		</div>
	</div>
	<!-- end panel. -->
<!-- page script -->
	<script>
		var _url = "/operation/admin/list/ajax";
		var grid;
		var param = {};
		var options = {}
		var colModel = [ {
			title : "구분",
			width : 70,
			dataType : "string",
			align : "center",
			dataIndx : "admin_type"
		}, {
			title : "이름",
			width : 120,
			dataType : "string",
			align : "center",
			dataIndx : "",
			render : function(ui){

				return {
					text : ""
						+ '<div style=" font-weight: bold; ">'
						+ ui.rowData.admin_name + '</div>'
				};
			}
		}, {
			title : "아이디",
			width : 120,
			dataType : "string",
			align : "center",
			dataIndx : "admin_id"
		}, {
			title : "지점명",
			width : 70,
			dataType : "string",
			align : "center",
			dataIndx : "company_nm"
		}, {
			title : "부서",
			width : 150,
			dataType : "string",
			align : "center",
			dataIndx : "department_name"
		}, {
			title : "직책",
			width : 70,
			dataType : "string",
			align : "center",
			dataIndx : "position_cd"
		}, {
			title : "연락처",
			width : 100,
			align : "center",
			dataType : "string",
			dataIndx : "mobile"
		},
		/* 	{
				title : "상태",
				width : 100,
				dataType : "string",
				dataIndx : "stat"
			},   */
			{
			title : "카드번호",
			width : 70,
			dataType : "string",
			align : "center",
			dataIndx : "card_no"
		},  {
			title : "차량번호",
			width : 80,
			dataType : "string",
			align : "center",
			dataIndx : "car_no"
		},
		/* {
			title : "잔디ID",
			width : 200,
			dataType : "string",
			dataIndx : "jandi_id"
		},  */
		{
			title : "상태",
			width : 60,
			dataType : "string",
			align : "center",
			dataIndx : "stat",
			render : function(ui){
				let row = ui.rowData.stat_cd;
				let staeName

				if(row == '00'){
					staeName = "<div style=" + "color:#348fe2" + ">정상</div>"
				}else {
					staeName = "<div style=" + "color:#ff0000" + ">차단</div>"
				}
				return staeName;
			}
		},
		{
			title : "계정차단",
			width : 80,
			dataType : "string",
			align : "center",
			dataIndx : "stat",
			render: function(ui){
				makeGridBtn(ui.rowData.stat);
				var btnString;
				console.log(this);
				let aaa = ui.rowData;
				if(ui.rowData.stat_cd == '00'){
					console.log('00',ui.rowData.stat);
					btnString = "<button class=\"btn btn-danger btn-sm waves-effect block_btn\" onclick=\"blockProc(this)\" data-no=\""+ui.rowData.admin_no+"\" data-name=\""+ui.rowData.admin_name+"\">차단</button>";
				}else{
					console.log('01',ui.rowData.stat);
					btnString = "<button class=\"btn btn-info btn-sm waves-effect unblock_btn\" onclick=\"unblockProc(this)\" data-no=\""+ui.rowData.admin_no+"\" data-name=\""+ui.rowData.admin_name+"\">해제</button>";
				}
				console.log("btnString ",btnString);
				return{
					text: btnString,
					style: "text-align:center"
				}
			}

		},

		/* {
			title : "비번초기화",
			width : 150,
			dataType : "string",
			align : "center",
			align : "right",
			dataIndx : "<button>"
		}  */
		];

		/* init page */
		$(function() {
			init();
			$(".btn-search").on("click", search);

			$(".btn-excel").on("click", function(){
				Wgrid.excel(grid);
			});

			/* btn-modal 클래스 클릭시 modal 호출, data-size="[modal-lg|modal-sm]"  */
			$(".btn-modal").on("click", function() {
				makeModal();
			});
		});

		function makeGridBtn(stat){
			var btnString;
			if(stat == '00'){
				btnString = "<button class=\"btn btn-danger btn-sm waves-effect block_btn\" data-no=\"${data.admin_no}\" data-name=\"${data.admin_name}\">차단</button>";
			}else{
				btnString = "<button clcass=\"btn btn-info btn-sm waves-effect unblock_btn\" data-no=\"${data.admin_no}\" data-name=\"${data.admin_name}\">해제</button>";
			}
			console.log(btnString);
			return{
				text: btnString
			}
		}

		/* 수정중 */

		/*
		let options = {
			rowDblClick: function( event, ui ) {
				event.preventDefault();
				console.log("ui", ui.rowData.customer_no);
				let param = {customer_no : ui.rowData.customer_no}
				postPage("/code/customer/view", param);
			},
			rowHeight: 50
	    }; */


		/* let content = template */

		function makeModal(callbackParam){
			let modalOptions = {
				title : "admin 계정 상세보기",
				description:"",
				/* content:content, */
				content : "<div id=\"modal_grid\"></div>",
				size : "modal-lg",
				callback:popupGrid,
				callbackParam:callbackParam
			}
			Modal.popup(modalOptions);
		}
		/*  */

		/* 모달에 표시 할 내용 */
		function popupGrid(param){
			let modalGrid;
			let _modalGridOptions;
			let _modalGridParams;
			let _modalGridColModel;
			let _modalGridUrl;

			/* TEST SETTING START*/
			_modalGridUrl = _url;
			_modalGridColModel = colModel;
			_modalGridParams = param;
			/* TEST SET/TING END */
			if(modalGrid != null || modalGrid != undefined){
				modalGrid.destroy();
			}
			modalGrid = Wgrid.draw("#modal_grid", _modalGridParams, _modalGridUrl, _modalGridColModel, _modalGridOptions);
		}


		function init() {
			console.log("========== run init()");
			let options = {
	                title:"admin_list",
	                cellDblClick: function( evt, ui ) {
	                	let callbackParam = {
	                			admin_id : ui.rowData.admin_id,
	                			admin_no : ui.rowData.admin_no
	                	}
	                	postPage("/operation/admin/view",callbackParam);// admin_name 기준으로 상세보기
	                	console.log("ui.rowData",ui.rowData);
	                	console.log("callbackParam",callbackParam);
	                	/* makeModal(callbackParam); */
	                }
			};
			param.admin_name = $("#admin_name").val();
			grid = Wgrid.draw("#grid_json", param, _url, colModel, options);
		}
		function search() {
			console.log("========== run search()");
			let $form = $("#frm_search");
			//let $form = $(this).closest("form");
			console.log('search : ', param);
			param = $form.serializeObject();
			grid.option("dataModel.postData", param);
			grid.refreshDataAndView();
		}

		function blockProc(obj){
			var admin_no = $(obj).attr('data-no');
			var admin_name = $(obj).attr('data-name');

			if(confirm('"'+admin_name+'"님을 차단하시겠습니까?', "주의하세요!")){
					var _param = {
							admin_no : admin_no,
							stat : '99'
					};
					//_param = Object.entries(_param).map(e => e.join('=')).join('&');
					console.log("_param",JSON.stringify(_param));
					Utils.requestAjax("계정 차단", "operation/admin/updateAdminStat", _param, {
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
			            	movePage("/operation/admin/index");
			            },
			            complete:  function(response) {
							//console.log("complete !!!", response);
			            }
					});
			};
		}

		function unblockProc(obj){
			var admin_no = $(obj).attr('data-no');
			var admin_name = $(obj).attr('data-name');

			if(confirm('"'+admin_name+'"님을 차단 해제 하시겠습니까?', "주의하세요!")){
					var _param = {
							admin_no : admin_no,
							stat : '00'
					};
					//_param = Object.entries(_param).map(e => e.join('=')).join('&');
					console.log("_param",JSON.stringify(_param));
					Utils.requestAjax("계정 차단", "operation/admin/updateAdminStat", _param, {
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
							movePage("/operation/admin/index");
			            },
			            complete:  function(response) {
							//console.log("complete !!!", response);
			            }
					});
			};
		}

	</script>