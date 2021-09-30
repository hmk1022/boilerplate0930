<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
	<!-- end breadcrumb -->
	<!-- begin page-header -->
	<h1 class="page-header">권한 <small>관리</small></h1>
	<!-- end page-header -->
	<!-- begin panel -->
	<div class="card">
		<div class="card-body">
		 	<h3 class="mb-0">권한 목록</h3>
			<form name="frm_role" class="search_form" >
			<!-- <div class="form-row">
					<div class="form-group col-6 mr-3 pr-3">
						<label class="col-form-label">권한명</label>
						<input type="text" class="form-control" id="role_keyword" name="role_keyword" placeHolder="권한명으로 검색가능합니다.">
					</div>
					<div class="col">
					<div class="form-group m-l-10 m-b-10  float-right">
						<button type="button" class="btn btn-primary btn-role-search">검색</button>
					</div>
					<div class="form-group m-b-10  float-right">
						<button type="button" name="movePage" class="btn btn-success" data-url="/operation/role/roleForm">권한 등록</button>
					</div>
					<div class="form-group m-b-10  float-right">
						<button type="button" name="movePage" class="btn btn-success" id="role_save" >권한 등록</button>
					</div>
				</div>
			</div> -->
			</form>
			<!-- <div class="form-group m-b-10  float-right">
					<button type="button" name="movePage" class="btn btn-success" id="role_save" >권한 등록</button>
			</div> -->
			<form name="w_role" id="w_role" class="w_role"  data-parsley-validate="true" novalidate="" enctype="multipart/form-data">
				<!-- <label class="form-label" for="req_hp">권한명 등록</label> -->
				<div class="form-row" id="add-admin-role">
					<div class="col-md-6 col-12 mt-3">
						<label class="form-label" for="req_hp">새로운 권한 추가<span class="text-danger">*</span></label>
						<div class="d-flex">
							<input class="form-control " type="text" id="name" name="name" value="${data.name }" placeholder="권한명을 입력해주세요" data-parsley-required="true"  data-parsley-error-message="권한명을 정확히 입력하세요." data-parsley-errors-container="#name_validation">
							<button type="button" name="movePage" class="btn btn-success" style="margin-left: 10px; width: 70px;" id="role_save" >추가</button>
						</div>
					</div>			
				</div>
				<div id="name_validation"></div>			
			</form>
			<br>
			<div id="grid_role"></div>
			<div class="m-b-20"></div>
			<hr>
			<h3 class="mb-0"><span class="selected_admin_name"></span> 사용자 목록</h3>
			<form id="frm_search" name="frm_role_admin" class="_search_form" >
			<input type="hidden" name="role_no" id="role_no">
			<div class="form-row">
				<!-- <div class="form-group col-6 mr-3 pr-3">
					<label class="col-form-label">관리자명</label>
					<input type="text" class="form-control" id="role_admin_keyword" name="role_admin_keyword" placeHolder="관리자명으로 검색가능합니다.">
				</div> -->
				
				<div class="col">
					<!-- <div class="form-group m-l-10 m-b-10  float-right">
						<button type="button" class="btn btn-primary btn-search">검색</button>
					</div> -->
					<!-- <div class="form-group m-b-10  float-right">
						<button type="button" name="movePage" class="btn btn-success" data-url="/operation/role/roleAdminForm">관리자 등록</button>
					</div> -->
					<!-- <div class="form-group m-b-10  float-right" id="admin_role_savaBtn">
						<button type="button" name="" class="btn btn-success" id="_dev-save">관리자 등록</button>
					</div> -->
				</div>
			</div>
			</form>
			
			<form name="_frm_admin_role" id="_frm_admin_role" class="_frm_admin_role"  data-parsley-validate="true" novalidate="" enctype="multipart/form-data">
				<!-- <label class="form-label" for="req_hp">관리자 등록</label> -->
				<div class="form-row" id="add-admin-role">
					<%-- <div class="col-md-6 col-12 mt-3">
						<label class="form-label" for="req_hp">권한명 <span class="text-danger">*</span></label>				
						<select class="form-select" id="_role_no" name="_role_no" data-parsley-required="true" placeholder="권한명을 선택해주세요" data-parsley-required="true"  data-parsley-error-message="권한명을 정확히 입력하세요.">
								<option value="">선택</option>
								<c:forEach var="item" items="${roleName}">
								<option value="${item.role_no}">${item.name}</option>
								</c:forEach>
						</select>
					</div>	 --%>
					<input type="hidden" class="form-control" id="selcted_role_no" name="selcted_role_no" >
					<div class="col-md-6 col-12 mt-3">
						<label class="form-label" for="req_hp">권한 관리자명 <span class="text-danger">*</span></label>	
						
						<div class="d-flex">		
							<select class="form-select" id="_admin_no" name="_admin_no" data-parsley-required="true" placeholder="권한 관리자명을 선택해주세요" data-parsley-required="true"  data-parsley-error-message="권한 관리자명을 선택해주세요." data-parsley-errors-container="#admin_no_validation">
									<option value="">선택</option>
									<c:forEach var="item" items="${adminId}">
									<option value="${item.admin_no}">${item.admin_id} / ${item.admin_name}</option>
									</c:forEach>
							</select>
							<button type="button" name="" class="btn btn-success" style="margin-left:10px; width: 70px;" id="_dev-save">추가</button>	
						</div>					
					</div>			
				</div> 
				<div id="admin_no_validation"></div>
			</form>
			<br>
			<div id="grid_role_admin"></div>
		</div>
	</div>
	<!-- end panel -->
<!-- page script -->
	<script>

		/* grid_role  */
		var grid_role;
		var grid_role_options = {}
		var grid_role_colModel = [{
			title : "key",
			width : 80,
			dataType : "string",
			dataIndx : "role_no",
			align: "center"
		}, {
			title : "권한명",
			width : 200,
			dataType : "string",
			dataIndx : "name"
		},{
			title : "등록자",
			width : 100,
			dataType : "string",
			dataIndx : "create_nm",
			align: "center"
		}, {
			title : "등록일자",
			width : 200,
			dataType : "string",
			dataIndx : "create_date",
			align: "center",
			render : function(ui) {
				let row = ui.rowData;
				let returnString = "";
				returnString = returnString + row.create_date.substr(0,10) 
				+"("+ Utils.getDayOfWeek(
							row.create_date.substr(0,4) + 
							row.create_date.substr(4,4).substr(0,2) +
							row.create_date.substr(4,4).substr(2,4)) + ")"
				
				return returnString					
			}
		}, {
			title : "선택",
			width : 150,
			align : "center",
			dataType : "string",
			dataIndx : "",
			render : makeGridBtn
		}];

		/* grid_role_admin  */
		var grid_role_admin;
		var grid_role_admin_options = {}
		var grid_role_admin_colModel = [ {
			title : "관리자명",
			width : 150,
			dataType : "string",
			dataIndx : "admin_name",
			align:"center"
		}, {
			title : "ID",
			width : 150,
			dataType : "string",
			dataIndx : "admin_id",
			align:"center"
		}, {
			title : "등록자",
			width : 150,
			dataType : "string",
			dataIndx : "create_nm",
			align:"center"
		}, {
			title : "등록일자",
			width : 200,
			dataType : "string",
			dataIndx : "create_date",
			align:"center",
			render : function(ui) {
				let row = ui.rowData;
				let returnString = "";
				returnString = returnString + row.create_date.substr(0,10) 
				+"("+ Utils.getDayOfWeek(
							row.create_date.substr(0,4) + 
							row.create_date.substr(4,4).substr(0,2) +
							row.create_date.substr(4,4).substr(2,4)) + ")"
				
				return returnString					
			}
		}, {
			title : "선택",
			width : 150,
			dataType : "string",
			align : "center",
			dataIndx : "",
			render : makeGridBtn2
		}, 
		/* {
			title : "권한",
			width : 150,
			dataType : "string",
			align : "center",
			dataIndx : "",
			render : function(ui) {
				let row = ui.rowData;
				let returnString = "";
				returnString += row.role_no;
				returnString += row.admin_id;
				returnString += row.admin_no;
				
				return returnString					
			}
		} */
		];

		/* init page */
		$(function() {
			init();
			let register_admin; // 관리자 등록 버튼 숨김유무
			
			//$('._frm_admin_role').css('display', 'none');
			//$('#admin_role_savaBtn').css('display', 'none');
			//$(".btn-role-search").on("click", roleSearch);
			/* $(".btn-role-admin-search").on("click", function search() {
				console.log("========== run search()");
				let $form = $(this).closest("form");
				param = $form.serializeObject();
				console.log('search param',param)
				grid.option("dataModel.postData", param);
				grid.refreshDataAndView(); 
			}); */
			
			$(".btn-search").on("click", roleAdminSearch);
			
			$(".btn-excel").on("click", function(){
				Wgrid.excel(grid_role);
			});

			/* btn-modal 클래스 클릭시 modal 호출, data-size="[modal-lg|modal-sm]"  */
			$(".btn-modal").on("click", function() {
				makeModal();
			});
			
			$("#_dev-save").on("click", function(e){
				const _name = "admin role 저장";	// ajax name
				const _url = "/operation/role/saveAdminRole/ajax";	// ajax url
				const _form = "_frm_admin_role";	// form name
				
				if(!$('#selcted_role_no').val()) {
					alert("권한을 선택해 주세요");
					return;
				}
				
				/* validate */
				var validate = $("[name=_frm_admin_role]").parsley().validate();
				if(!validate) {
					console.log('# validate false !!!');
					return;
				}

				/* multi form insert */
				Utils.requestMultiAjax(_name, _url, _form, {
		            success:  function(data) {
			          	alert(Message.SAVE);
			          	movePage("/operation/role/index");
		            },
		            complete:  function(response) {}
				});

			});
			
			$("#role_save").on("click", function(e){
				const _name = "admin role 저장";	// ajax name
				const _url = "/operation/role/save/ajax";	// ajax url
				const _form = "w_role";	// form name

				/* validate */
				var validate = $("[name=w_role]").parsley().validate();
				if(!validate) {
					console.log('# validate false !!!');
					return;
				}

				/* multi form insert */
				Utils.requestMultiAjax(_name, _url, _form, {
		            success:  function(data) {
			          	alert(Message.SAVE);
			          	movePage("/operation/role/index");
		            },
		            complete:  function(response) {}
				});

			});
			
		});
		
		function makeGridBtn(ui){
			var btnString;
				btnString = "<button class=\"btn btn-info btn-sm waves-effect unblock_btn\" onclick=\"modifyProc(this)\" data-no=\""+ui.rowData.role_no+"\" data-name=\""+ui.rowData.name+"\">수정</button>";
				btnString += " <button class=\"btn btn-danger btn-sm waves-effect block_btn\" onclick=\"deleteProc(this)\" data-no=\""+ui.rowData.role_no+"\" data-name=\""+ui.rowData.name+"\">삭제</button>";
			return{
				text: btnString
			}
		};
		function makeGridBtn2(ui){
			var btnString = ""
				//btnString = "<button class=\"btn btn-info btn-sm waves-effect unblock_btn\" onclick=\"modifyProc(this)\" data-no=\""+ui.rowData.role_no+"\" data-name=\""+ui.rowData.name+"\">수정</button>";
				btnString = btnString + " <button class=\"btn btn-danger btn-sm waves-effect block_btn\" onclick=\"deleteAdminRoll(this)\"  data-name=\""+ui.rowData.admin_name +"\" data-no=\""+ui.rowData.role_no+"\" data-admin-no=\""+ui.rowData.admin_no+"\">삭제</button>";
			return{
				text: btnString
			}
		};
		function makeModal(callbackParam){
			let modalOptions = {
				title : "모달창",
				content : "<div id=\"modal_grid\"></div>",
				size : "modal-lg",
				callback:popupGrid,
				callbackParam:callbackParam
			}
			Modal.popup(modalOptions);
		}
		/* 모달에 표시 할 내용 */
		function popupGrid(param){
			let modalGrid;
			let _modalGridOptions;
			let _modalGridParams;
			let _modalGridColModel;
			let _modalGridUrl;

			/* TEST SETTING START*/
			_modalGridUrl = "/operation/workerman/list/ajax";
			_modalGridColModel = grid_role_colModel;
			_modalGridParams = param;
			/* TEST SET/TING END */
			if(modalGrid != null || modalGrid != undefined){
				modalGrid.destroy();
			}
			modalGrid = Wgrid.draw("#modal_grid", _modalGridParams, _modalGridUrl, _modalGridColModel, _modalGridOptions);
		}
		function init() {
			console.log("========== run init()");
			let grid_role_url = "/operation/role/roleList/ajax";
			let grid_role_options = {
	                title:"role_list",
	                height: 200,
	                selectionModel: {type:"row",mode:"single"},
	                cellDblClick: function( evt, ui ) {
	                	let callbackParam = {
	                			admin_name : ui.rowData.admin_name
	                	}
	                	console.log("ui.rowData",ui.rowData);
	                	console.log("callbackParam",callbackParam);
	                	/* makeModal(callbackParam); */
	                },
	    	        rowSelect: function (evt, ui) {
	                    console.log('rowSelect', ui.addList[0].rowData.role_no);
	                    console.log('선택이름',ui.addList[0].rowData.name);
	                    $(".selected_admin_name").text(ui.addList[0].rowData.name);
	                    $("#selcted_role_no").val(ui.addList[0].rowData.role_no);
 	                    var jsonStr = JSON.stringify(ui, function(key, value){
	                            return value;
	                    }, 2)
	                    console.log("jsonStr",jsonStr);
	                    $("#role_no").val(ui.addList[0].rowData.role_no);
	                    roleAdminSearch();
	                }
			};
			let grid_role_param = {}
			grid_role = Wgrid.draw("#grid_role", grid_role_param, grid_role_url, grid_role_colModel, grid_role_options);


			let grid_role_admin_url = "/operation/role/roleAdminList/ajax";
			let grid_role_admin_options = {
	                title:"role_admin_list",
	                height: 500,
	                cellDblClick: function( evt, ui ) {
	                	let callbackParam = {
	                			admin_name : ui.rowData.admin_name
	                	}
	                	// postPage("/operation/admin/wview",callbackParam);// admin_no 기준으로 상세보기
	                	console.log("ui.rowData",ui.rowData);
	                	console.log("callbackParam",callbackParam);
	                	/* makeModal(callbackParam); */
	                }
			};
			let grid_role_admin_param = {}
			grid_role_admin = Wgrid.draw("#grid_role_admin", grid_role_admin_param, grid_role_admin_url, grid_role_admin_colModel, grid_role_admin_options);
		}
		function roleSearch() {
			console.log("========== run roleSearch()");
			let $form = $("form[name=frm_role]");
			let param = $form.serializeObject();
			param.pq_curpage = 1;
			grid_role.option("dataModel.postData", param);
			grid_role.refreshDataAndView();
		}

		function roleAdminSearch() {
			console.log("========== run roleAdminSearch()");
			//let $form = $("form[name=frm_role_admin]");
			let $form = $("#frm_search");
			let param = $form.serializeObject();
			param.pq_curpage = 1;
			$('._frm_admin_role').css('display', 'block');
			$('#admin_role_savaBtn').css('display','block');
			console.log("frm_role_admin param",param);
			grid_role_admin.option("dataModel.postData", param);
			grid_role_admin.refreshDataAndView();
		}
		
		function search() {
			console.log("========== run search()");
			let $form = $(this).closest(".search_form");
			param = $form.serializeObject();
			grid.option("dataModel.postData", param);
			grid.refreshDataAndView();
		}
		
		function deleteProc(obj) {
			
				let role_no = $(obj).attr('data-no');
				let role_name = $(obj).attr('data-name');
				
				if(confirm('"'+role_name+'"권한을 삭제하시겠습니까?', "주의하세요!")){
					var _param = {
							role_no : role_no,
							
					};
					//_param = Object.entries(_param).map(e => e.join('=')).join('&');
					console.log("삭제 파람",JSON.stringify(_param));
					Utils.requestAjax("권한 삭제", "/operation/role/delete", _param, {
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
			            	movePage("/operation/role/index");
			            },
			            complete:  function(response) {
							//console.log("complete !!!", response);
			            }
					});
			};
		};
		
		function modifyProc(obj) {
			
			let role_no = $(obj).attr('data-no');
			let role_name = $(obj).attr('data-name');
			
			
			
			var _param = {
					role_no : role_no,		
			};
			
			movePage("/operation/role/roleForm", _param);
		};
		
		function deleteAdminRoll(obj) {
			
			let role_no = $(obj).attr('data-no');
			let role_admin_no = $(obj).attr('data-admin-no'); 
			let name = $(obj).attr('data-name');
			
			let role_name;
			
			if (role_no == 3) role_name = '슈퍼관리자'
			else if (role_no == 4) role_name = '일반관리자'
			else if (role_no == 5) role_name = '워커맨위치조회권환'
			else if (role_no == 6) role_name = '배정자권한'
				
			if(confirm(''+name+"님을"+" "+role_name+""+'에서 삭제하시겠습니까?', "주의하세요!")){
				var _param = {
						role_no : role_no,
						admin_no : role_admin_no
						
				};
				//_param = Object.entries(_param).map(e => e.join('=')).join('&');
				console.log("삭제 파람",JSON.stringify(_param));
				Utils.requestAjax("권한 삭제", "/operation/role/deleteAdmin", _param, {
					beforeSend: function(){
						
		            },
		            success:  function(data) {
		            	console.log("data",data);
						
		            	movePage("/operation/role/index");
		            },
		            complete:  function(response) {
						
		            }
				});
			};
		};
	</script>
	<script id="entry-template" type="text/x-handlebars-template">
			<div class="pagination">
				<div class="row row-space-10">
					<div class="col">
						<ul class="pagination float-right">
							<li class="paginate_button page-item previous disabled" id="data-table-default_previous">
								<a href="#" aria-controls="data-table-default" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
							</li>
							<li class="paginate_button page-item active">
								<a href="#" aria-controls="data-table-default" data-dt-idx="1" tabindex="0" class="page-link">1</a>
							</li>
							<li class="paginate_button page-item ">
								<a href="#" aria-controls="data-table-default" data-dt-idx="2" tabindex="0" class="page-link">2</a>
							</li>
							<li class="paginate_button page-item ">
								<a href="#" aria-controls="data-table-default" data-dt-idx="3" tabindex="0" class="page-link">3</a>
							</li>
							<li class="paginate_button page-item ">
								<a href="#" aria-controls="data-table-default" data-dt-idx="4" tabindex="0" class="page-link">4</a>
							</li>
							<li class="paginate_button page-item ">
								<a href="#" aria-controls="data-table-default" data-dt-idx="5" tabindex="0" class="page-link">5</a>
							</li>
							<li class="paginate_button page-item ">
								<a href="#" aria-controls="data-table-default" data-dt-idx="6" tabindex="0" class="page-link">6</a>
							</li>
							<li class="paginate_button page-item next" id="data-table-default_next">
								<a href="#" aria-controls="data-table-default" data-dt-idx="7" tabindex="0" class="page-link">Next</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
	</script>