<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE HTML ================== -->
    <ol class="breadcrumb float-xl-end">
        <li class="breadcrumb-item"><a href="javascript:;">Home</a></li>
        <li class="breadcrumb-item active">자재관리</li>
    </ol>

    <h1 class="page-header">자재요청서 <span class="d-block small">자재관리</span></h1>
    <div class="card">
        <div class="card-header">
            <h3 class="mb-0">자재요청서 등록</h3>
        </div>
        <div class="card-body">
   			<form class="form-horizontal form-bordered" data-parsley-validate="true" name="saveForm" id="saveForm" >
			<input type="hidden" id="material_doc_no" name="material_doc_no" value="${data.material_doc_no }" >
            <div class="row">
				<div class="col-md-4 col-12 ">
					<div class = "form-group">
						<label class="form-label">작업선택 <span class="text-danger">*</span></label>
						<!-- 
						<select class="form-select" name="work_no" 
						id="work_no" 
						data-parsley-required="true" data-parsley-error-message="작업을 선택하세요.">
						</select>
						 -->
						 <input class="form-control" 
						 	type="text" 
						 	id="work_name" 
						 	name="work_name" 
						 	value="${data.work_id }${not empty data.material_doc_no?' | ':''}${not empty data.branch_name? data.customer_name.concat(' / ').concat(data.branch_name):data.req_name}${not empty data.material_doc_no?' | ':''}${data.location_name }" 
						 	placeholder="작업일련번호,고객명,작업명을 2자이상 입력하세요." 
						 	data-parsley-required="true" 
						 	data-parsley-error-message="작업명을 입력하세요."
						 	>
						 <input 
						 	type="hidden" 
						 	id="work_no" 
						 	name="work_no" 
						 	value="${data.work_no }" 
						 	data-parsley-required="true" 
						 	data-parsley-error-message="고객(사)명을 입력하세요."
						 	class="d-none"
						 	>
					</div>
				</div>	

				<div class="col-4">
					<label class="form-label">사용일(수령일)<span class="text-danger">*</span></label>
					<div class ="input-group">
						<input type="text" class="form-control" id="use_date" name="use_date" value="${data.use_date }" placeholder="연도-월-일" data-parsley-required="true" data-parsley-errors-container="#validation_error"  data-parsley-error-message="사용일(수령일)을 입력하세요" datepicker/>
						<select class="form-select" id="use_hh" name="use_hh" data-parsley-required="true" >
						<c:forEach items="${TMP_HH}" var="hh" >
							<option value="${hh }" ${data.use_hh eq hh ?'selected':'' }">${hh } 시</option>
						</c:forEach>
						</select>
						<select class="form-select" id="use_mm" name="use_mm" data-parsley-required="true" >
						<c:forEach items="${TMP_MM}" var="mm" >
							<option value="${mm }" ${data.use_mm eq mm ?'selected':'' }>${mm } 분</option>
						</c:forEach>
						</select>
					</div>
					<div id="validation_error"></div>
				</div>
				<div class="col-4"></div>
				<div class="col-md-4 col-12 mt-3">
					<label class="form-label">고객(사) 명<span class="text-danger">*</span></label>
					<input class="form-control" type="text" id="req_name" name="req_name" value="${data.req_name }" placeholder="100자 이내" readonly>
				</div>
				<div class="col-md-6 col-12 mt-3">
					<label class="form-label">현장주소<span class="text-danger">*</span></label>
					<input class="form-control" type="text" id="work_addr" name="work_addr" value="${data.work_addr }" placeholder="주소검색" readonly>
				</div>
				<div class="col-md-2 col-12 mt-3">
				</div>	
				<div class="col-md-2 col-12 mt-3">
					<label class="form-label">담장자명<span class="text-danger">*</span></label>
					<select class="form-select" id="manager_no" name="manager_no" data-parsley-required="true" data-parsley-error-message="담장자명을 선택하세요.">
					<option value="">선택</option>
					</select>
				</div>
                <div class="col-md-12 col-12 mt-3">
                    <label class="form-label">수령방법 <span class="text-danger">*</span></label>
					<tags:code-radio
						codeList="${receive_type }"
						checked="${data.receive_type }"
						name="receive_type"
						required="true"
						initValue="01"
					/>
                </div>
			</div>
            </form>
        </div>
    </div>
			
    <div class="d-flex justify-content-center mt-4">
	<c:if test="${empty data.material_doc_no }">
	    <button class="btn btn-gray" name="_button_page_list" data-to_url="/material/doc/list">list</button>
	 </c:if>
	 <c:if test="${!empty data.material_doc_no }">
	    <button class="btn btn-gray" name="_button_page_view" data-to_url="/material/doc/view" data-to_param="material_doc_no^${data.material_doc_no}">cancel</button>
	</c:if>
        <button class="btn btn-primary ms-2" id="_dev-save">save</button>
    </div>    
	<!-- end panel -->

	<!-- begin 자재 목록 -->
	<div class="card mt-4" >
		<div class="card-header">
			<div class="d-flex align-item-center justify-content-between">
				<h3 class = "m-0">자재 요청 목록</h3>
				<a href="#" class="btn btn-sm btn-success" id="addMaterial">추가 하기</a>
		 	</div>
		</div>
		<div class="card-body" id = "searchText">
			<div class="border rounded p-3" id="empty_material_doc_list">등록된 자재가 없습니다. [추가하기] 버튼을 눌러 자재를 추가해보세요.</div>
			<table class="table table-striped m-b-0">
			<thead>
				<tr>
					<th>품번</th>
					<th>품명</th>
					<th>브랜드</th>
					<th>수량</th>
					<th>단가</th>
					<th>총금액</th>
					<th width="1%"></th>
				</tr>
			</thead>
			<tbody id="material_doc_list">
				<tr>
					<td colspan="7">등록된 자재가 없습니다.</td>
				</tr>
			</tbody>
		</table>
		</div>
	</div>
	

			
<!-- begin modal -->
	<!-- 자재 추가 -->
	<div class="modal fade" id="modal-dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">자재 추가하기</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<div style="margin-top: 10px; margin-left: 10px;">
					<ul class="nav nav-pills">
					    <li class="nav-item active">
					        <a href="#SEARCH" data-toggle="tab" data-url="SEARCH" class="nav-link active" aria-expanded="true" name="material_add_type" SEARCH>자재검색</a>
					    </li>
					    <li class="nav-item">
					        <a href="#ADD" data-toggle="tab" data-url="ADD" class="nav-link" aria-expanded="false" name="material_add_type" ADD>자재추가</a>
					    </li>
					</ul>
				</div>
				<div class="modal-body">
					<!--  -->
					<form class="form-horizontal form-bordered" data-parsley-validate="true" name="materialFrm" id="materialFrm" novalidate="">

					<!-- <input type="hidden" id="material_no" name="material_no" > -->
					<input type="hidden" id="material_id" name="material_id" >
					<input type="hidden" name="material_doc_no" value="${data.material_doc_no }">
					
					<input type="hidden" id="req_stat" name="01" >
					<input type="hidden" id="category_no" name="category_no" >
					
					<!-- <input type="hidden" id="ware_house_cnt" name="ware_house_cnt" > -->
					<!-- 
					<div class="form-row">
					    <div class="col-md-4 mb-3">
					      <label for="cate1">분야</label>
					      <div class="">
					        <select class="form-select" name="cate1" id="cate1" data-parsley-required="true">
					        	<option value="">선택</option>
							</select>
					      </div>
					    </div>
					    <div class="col-md-4 mb-3">
					      <label for="cate2">중분류</label>
					      <div class="">
					        <select class="form-select" name="cate2" id="cate2" data-parsley-required="true">
					        	<option value="">선택</option>
							</select>
					      </div>
					    </div>
					    <div class="col-md-4 mb-3">
					      <label for="cate3">소분류</label>
					      <div class="">
					        <select class="form-select" name="cate3" id="cate3" data-parsley-required="true">
					        	<option value="">선택</option>
							</select>
					      </div>
					    </div>
				  	</div>
				  	 -->
				  	 <!-- 
					<div class="form-row">
					    <div class="col-md-8 mb-3">
					      <label for="material_list">자재선택</label>
					      <div class="validationTooltip01">
					        <select class="form-select" name="material_no" id="material_list" data-parsley-validate="true" data-parsley-required="true">
					        	<option value="">선택</option>
							</select>
					      </div>
					    </div>
				  	</div>
				  	 -->	
				  	<div class="form-row">
					    <div class="col-md-8 mb-3">
					      <label for="material_name_tmp">자재명 <span class="text-danger">*</span></label>
					      <input type="text" class="form-control" name="material_name" id="material_name" placeholder="자재명" 
					      	data-parsley-required="true"
					      	data-parsley-error-message="자재를 선택해주세요."
							data-parsley-errors-container="#validation_material_name_error"
					      >
					      <input type="hidden" class="form-control" name="material_no" id="material_no" 
					      	data-parsley-required="true"
					   		data-parsley-error-message="자재를 선택해주세요."
							data-parsley-errors-container="#validation_material_name_error"
					      >
					      <div id="validation_material_name_error"></div>
					    </div>
				  	</div>
				  	<div class="form-row">
					    <div class="col-md-8 mb-3">
					      <label for="material_name_tmp">모델명</label>
					      <input type="text" class="form-control" name="model_name" id="model_name" placeholder="모델명" >
					    </div>
				  	</div>				  	
				  	<div class="form-row">
					    <div class="col-md-6 mb-3">
					      <label for="brand_no">브랜드</label>
					      <div class="validationTooltip01">
					        <select class="form-select" name="brand_no" id="brand_no">
							</select>
					      </div>
					    </div>
					    <div class="col-md-3 mb-3">
					      <label for="unit_cd">단위 <span class="text-danger">*</span></label>
					      <div class="validationTooltip01">
					        <select class="form-select" id="unit_cd" name="unit_cd" data-parsley-required="true">
					        <option value="">선택</option>
					        <tags:code-select
								codeList="${unit_cd }" 
								selected="${data.unit_cd }"
							/>
							</select>
					      </div>
					    </div>
					    <div class="col-md-3 mb-3">
					      <label for="purchased_price">단가 <span class="text-danger">*</span></label>
					      <input type="text" class="form-control" id="purchased_price" name="purchased_price" placeholder="단가" data-parsley-required="true" comma>
					    </div>
				  	</div>

					<!-- 자재갯수 -->	
					<div class="form-row" id="div_reserve_cnt">
						<div class="col-md-3 mb-3">
							<label for="house_cnt">물류센터</label>
							<input type="text" class="form-control" id="house_cnt" placeholder="0" comma readonly>
						</div>
						<div class="col-md-3 mb-3">
							<label for="sba_cnt">성수SBA</label>
							<input type="text" class="form-control" id="sba_cnt" placeholder="0" comma readonly>
						</div>
						<div class="col-md-3 mb-3">
							<label for="vehicle_cnt">르노(마포)</label>
							<input type="text" class="form-control" id="vehicle_cnt" placeholder="0" comma readonly>
						</div>
						<div class="col-md-3 mb-3">
						</div>
					</div>
					<!-- 자재갯수 -->	
					
				  	<div class="form-row" name="div_add_material" style="display:none">
					    <div class="col-md-12 mb-3">
					      <label for="material_name_tmp">자재 url</label>
					      <input type="text" class="form-control" name="material_link" placeholder="자재 url">
					    </div>
				  	</div>
				  	
					<div class="form-row" name="div_add_material" style="display:none">
						<label for="unit_cd">요청 자재 사진</label>
						<div class="col-md-12 col-sm-8">
							<tags:image-upload name="upLoadFile"
		                                       value="${imageList1}"
		                                       maxFileCount = "4"
		                                       required = "false"
		                                       category = "IMG_TYPE_MATERIAL_REQ"
		                                       type="image"
		                    />
						</div>
					</div>
					
					<div class="form-row mt-3">
					    <div class="col-md-3 mb-3">
					      <label for="material_cnt">수량 <span class="text-danger">*</span></label>
					      <input type="text" class="form-control" id="material_cnt" name="material_cnt" value="0" placeholder="수량" 
					      	min="0" max="10000"
					      	data-parsley-required="true" 
					      	data-parsley-min="1"
					      	data-parsley-error-message="수량을 선택해주세요."
							data-parsley-errors-container="#validation_material_cnt_error"
					      >
					      <div id="validation_material_cnt_error"></div>
					    </div>
					    <div class="col-md-3 mb-3">
					      <label for="total_material_price">금액</label>
					      <input type="text" class="form-control" id="total_material_price" name="total_material_price" value="0" placeholder="금액" readonly comma>
					    </div>
				  	</div>
				  	
					</form>
			
				</div>
				<div class="modal-footer">
					<a href="javascript:;" class="btn btn-white" data-dismiss="modal" id="close_material">닫기</a>
					<a href="javascript:;" class="btn btn-success" id="add_material">저장</a>
				</div>
			</div>
		</div>
	</div>
	
<!-- end modal -->


<!-- ================== END PAGE LEVEL JS ================== -->
	
<script>

	$("#material_cnt").inputSpinner(); // spinner.

	var curPage;
	
	/* init page */
	$(function(){
		
		/* 수정 화면일 경우 처리 */
		if(!Utils.isEmpty($("#material_doc_no").val())){
			$("#work_no").prop("disabled", true);
		} else {
			$("#work_no").prop("disabled", false);
		}
		
		/* 자재삭제 */
		$("#material_doc_list").on("click", "#del-material", function (event) {
			removeMaterialReq($(this).data("material_req_no"));
		});
		
		/* 추가하기 */
		$("#addMaterial").on("click", function (event) {
			
			if(Utils.isEmpty($("#material_doc_no").val())) {
				alert("기본정보 등록 후 제품등록을 추가 하세요.");
				return;
			}
			
			resetForm();	// reset material form
			
			$('#modal-dialog').modal({backdrop: 'static', keyboard: false}) ;
			$("[name=material_add_type][SEARCH]").trigger("click"); // click first tab
			$("#modal-dialog").modal("show");
		});
		
		$("#material_cnt").on("change", function (event) {
		    let material_cnt = 0;
		    let purchased_price = 0;
		    let total_material_price = 0;
		    
		    material_cnt = Utils.remove($("#material_cnt").val(),',') ;
		    purchased_price = Utils.remove($("#purchased_price").val(),',') ;
		    total_material_price = material_cnt * purchased_price;
		    
		    $("#total_material_price").val(total_material_price);
		});
		
		/* save data */
		$("#_dev-save").on("click", function(e){
			/* validate */
			let validate = $("#saveForm").parsley().validate();
			if(!validate) {
				console.log('# validate false !!!');
				return;
			} else {
				saveMaterialDoc();
			}
		});
		
		/* set mask optional */
	    setInputMask();
		
	    /* 작업목록 조회 */
	    //listWork();
	    
	    /* 작업선택 */
	    $("#work_no").on("change", function(){
	    	let data = $("#work_no > option:selected").data("item");
			$("#req_name").val(data.req_name);
			//$("#director_no").val(data.director_no); 이런인풋없음.
			$("#work_addr").val(data.work_addr1 +" "+ data.work_addr2);
	    });
	    
	    /* 자재 추가 */
	    $("#add_material").on("click", function(){
			saveMaterialReq();
	    });	    

	    $("#close_material").on("click", function(){
	    	listMaterialReq();
	    });	    
	    
	    
	    /* 카테고리 조회 */
	    //listCategory("1", "");
	    
	    $("#cate1").on("change", function(){
	    	listCategory("2", $(this).val());
	    	$("#cate3").html('<option value="">선택</option>');
	    	$("#material_list").html('<option value="">선택</option>');
	    });
	    $("#cate2").on("change", function(){
	    	listCategory("3", $(this).val());
	    });

	    /* 자재조회 */
	    $("#cate3").on("change", function(){
	    	listMaterial($(this).val());
	    });
	    
	    /* 자재선택 */
	    $("#material_list").on("change", function(){
				
	    	if($(this).val() == 'ADD'){ // 상품요청.
	    		initMaterialFrom('ADD');	// init form
	    	}
	    	else {	// 상품선택.
		    	let data = $("#material_list > option:selected").data("item");
	    		initMaterialFrom('SELECT', data);	// init form
	    	}
	    	$("#material_cnt").val("0");
	    	$("#total_material_price").val("0");
	    });

	    /* 작업선택 */
	    $("#work_no").on("change", function(){
	    	listAdminWork();
	    });
	    
	    /* 브랜드목록 조회 */
	    listBrand();
	    
	    /* 자재목록 조회 */
	    listMaterialReq();
	    
	    //수정시 처리
	    if('${data.material_doc_no}' != ''){
	    	$("#manager_no").val('${data.manager_no}');
	    	$("#use_hh").val('${data.use_hh}');
	    	$("#use_mm").val('${data.use_mm}');
	    }
	    
		/* 자재 검색 */
	    $("#material_name").autocomplete({
	        source: function( request, response ) {
	        	let param = {};
	        	param.s_material_name = $("#material_name").val();
                $.ajax({
                    type: 'POST',
                    url: "/material/list/ajax",
                    data: param,
//                    dataType: "json",
//                    data: JSON.stringify(param),
//                    contentType: "application/json",
    		    	beforeSend : function(xhr){
    		    		xhr.setRequestHeader("Authorization", getAuthToken());
    		    		// 신규일경우 autocomplete false
    		    		if($("[name=material_add_type][ADD]").hasClass('active')){
    		    			console.log("autocomplete stop");
    		    			return false;
    		    		}
    		    	},
                    success: function(data) {
                        response(
                            $.map(data.data, function(item) {    //json[i] 번째 에 있는게 item 임.
                            	let _material_name = item.material_name;
                            		if(item.brand_name != '' && item.brand_name != undefined){
                            			_material_name += "("+item.brand_name+")";
                            		}
                                return {
                                	label: _material_name,    //UI 에서 보여지는 글자, 실제 검색어랑 비교 대상
                                    value: item.material_name,    //사용자 설정값
                                    model_name : item.model_name,
                                    brand_name : item.brand_name,
                                    purchased_price : item.purchased_price,
                                    unit_name : item.unit_name,
                                    unit_cd : item.unit_cd,
                                    brand_no : item.brand_no,
                                    material_no : item.material_no,
                                    house_cnt : item.house_cnt,
                                    sba_cnt : item.sba_cnt,
                                    vehicle_cnt : item.vehicle_cnt
                                }
                            })
                        );
                    },
               });
            },
	        select: function(event, ui) {
	        	console.log("SELECT:", ui.item);
	        	let _form = $("#materialFrm");
	        	let _data = ui.item;
	        	_form.find("[name=brand_no]").val(_data.brand_no);
	        	_form.find("[name=model_name]").val(_data.model_name);
	        	_form.find("[name=unit_cd]").val(_data.unit_cd);
	        	_form.find("[name=purchased_price]").val(Utils.comma(_data.purchased_price));
	        	_form.find("[name=material_no]").val(_data.material_no);

	        	// 자재수량표시.
	        	_form.find("#house_cnt").val(_data.house_cnt);
	        	_form.find("#sba_cnt").val(_data.sba_cnt);
	        	_form.find("#vehicle_cnt").val(_data.vehicle_cnt);
	        	
	        },
	        minLength: 2,
	        autoFocus: true,
	        classes: {"ui-autocomplete": "highlight"},
	        delay: 150,
	        focus: function(event, ui) {
	            return false;
	        },
	        close : function(event){
            }
	    });
		
		// init form
/* 	    $("#material_name").on("change", function(e){
	    	let _form = $("#materialFrm");
        	_form.find("[name=brand_no]").val('');
        	_form.find("[name=model_name]").val('');
        	_form.find("[name=unit_cd]").val('');
        	_form.find("[name=purchased_price]").val('');
        	_form.find("[name=material_no]").val('');
        	_form.find("[name=total_material_price]").val('');
	    }); */
		
		// click tab init value
		$("[name=material_add_type]").on("click", function(e){
			let _type = $(this).data("url");
			if(_type =='ADD'){
				$("[name=div_add_material]").show();
				//$("#brand_no, #unit_cd, #purchased_price").attr("readonly", true);
				$("#brand_no, #unit_cd, #purchased_price").attr("readonly", false);
				$("#brand_no, #unit_cd").attr("disabled", false);
				$("#div_reserve_cnt").hide();	// 자재수량
			} else {
				$("[name=div_add_material]").hide();
				$("#brand_no, #unit_cd, #purchased_price").attr("readonly", true);
				$("#brand_no, #unit_cd").attr("disabled", true);
				$("#div_reserve_cnt").show();	// 자재수량
			}
			$("#material_name").val('');
			//$("#material_name").trigger("change");
			resetMaterialReq();
		});
		
	    
		// 작업선택
	    $("#work_name").autocomplete({
	        source: function( request, response ) {
	        	let param = {};
	        	param.s_work_name = $("#work_name").val();
                $.ajax({
                    type: 'POST',
                    url: "/work/list/auto/ajax",
                    data: param,
    		    	beforeSend : function(xhr){
    		    		xhr.setRequestHeader("Authorization", getAuthToken());
    		    	},
                    success: function(data) {
                        response(
                            $.map(data.data, function(item) {    //json[i] 번째 에 있는게 item 임.
                            	let _work_name = item.work_id;
                            		if(!Utils.isEmpty(item.branch_name)){
                            			_work_name += " | "+item.customer_name+" / "+item.branch_name+" | "+Utils.nvl(item.location_name);
                            		} else {
                            			_work_name += " | "+item.req_name+" | "+Utils.nvl(item.location_name);
                            		}
                                return {
                                	label: _work_name,    //UI 에서 보여지는 글자, 실제 검색어랑 비교 대상
                                    value: _work_name,    //사용자 설정값
                                    work_no : item.work_no,
                                    work_id : item.work_id,
                                    location_name : item.location_name,
                                    req_name : item.req_name,
                                    customer_name : item.customer_name,
                                    branch_name : item.branch_name,
                                    work_addr1 : item.work_addr1,
                                    work_addr2 : item.work_addr2
                                }
                            })
                        );
                    },
               });
            },
	        select: function(event, ui) {
	        	console.log("SELECT:", ui.item);
	        	let _data = ui.item;
	        	$("#work_no").val(_data.work_no);
	        	$("#req_name").val(_data.req_name);
	        	$("#work_addr").val(_data.work_addr1 +" "+ _data.work_addr2);
	        	listAdminWork();	// 담당자명.
	        },
	        minLength: 2,
	        autoFocus: true,
	        classes: {"ui-autocomplete": "highlight"},
	        delay: 150,
	        focus: function(event, ui) {
	            return false;
	        },
	        close : function(event){
            }
	    });
	    
		
	    listAdminWork(); // 담당자 조회
		if('${data.manager_no}' !=''){
			$("#manager_no").val('${data.manager_no}');
		}
	});
	
	function resetMaterialReq(){
    	let _form = $("#materialFrm");
    	_form.find("[name=brand_no]").val('');
    	_form.find("[name=model_name]").val('');
    	_form.find("[name=unit_cd]").val('');
    	_form.find("[name=purchased_price]").val('');
    	_form.find("[name=material_no]").val('');
    	_form.find("[name=total_material_price]").val('');
	}	
	
	// 자재 선택에 따른 form init
	function initMaterialFrom(str, data){
		console.log("form:", str);

		$('#category_no').val($("#cate3 option:selected").data('category_no'));
		
		$("#total_material_price").prop("readonly", true);
		
		if(str === 'ADD'){	// 자재추가 form 
			$('[name="material_name"]').attr('data-parsley-required', 'true');
			$('[name="unit_cd"]').attr('data-parsley-required', 'true');
			
			$("[name=div_add_material]").show();
			$("[name=div_add_material] input, [name=div_all_material] select").prop("disabled", false);
			$("#purchased_price").prop("readonly", false);
			
		}
		else if(str === 'SELECT'){	// 자재선택 form
			
			$('[name="material_name"]').attr('data-parsley-required', 'false');
		
			$("[name=div_add_material]").hide();
			$("[name=div_all_material] select").prop("disabled", true);
			$("#purchased_price").prop("readonly", true);
			
			if(Utils.isEmpty(data)) {
				resetMaterialFrom();
				return;
			}
		
			$("#material_id").val(data.material_id);
			$("#material_name").val(data.material_name);
			$("#brand_no").val(data.brand_no);
			$("#unit_cd").val(data.unit_cd);
			$("#purchased_price").val(data.purchased_price);
			
			// 상품수
			let material_cnt = 0;
			if($("[name='receive_type']:checked").val() =='01'){
				material_cnt = data.ware_house_cnt;
			} else if($("[name='receive_type']:checked").val() =='02'){
				material_cnt = data.company_cnt;
			} else if($("[name='receive_type']:checked").val() =='03'){
				material_cnt = data.sba_cnt_cnt;
			} else {
				material_cnt = 0;
			}
			
			$("#material_cnt").val(material_cnt);
			
			$("#material_cnt").trigger("change");
		}
	}

	function resetMaterialFrom(){
		$("#material_id").val('');
		$("#material_name").val('');
		$("#brand_no").val('');
		$("#unit_cd").val('');
		$("#purchased_price").val('');
		$("#material_cnt").val('');
		
		// 선택폼으로 변경
		$("[name=div_add_material]").hide();
		$("[name=div_add_material] input, [name=div_add_material] select").prop("disabled", true);
		// remove class parsley-success
		$("select, input").removeClass("parsley-success");
		
		$('[name="material_name"]').attr('data-parsley-required', 'false');
	}
	
	/* 작업 목록 */
	function listWork(){

		const _name = "작업목록 조회";	// ajax name
		const _url = "/work/list/ajax";	// ajax url
		
		/* multi form insert */
		Utils.requestAjax(_name, _url, {}, {
            success:  function(data) {
	          	
	          	if(data != undefined){
	          		let work_list = '<option value="">작업 선택</option>';
	          		$.each(data.data, function(index, item){
	          			//console.log("item >>>> ", (item));
	          			
	          			let temp = {};
	          			//TODO : 데이터 없음.
	          			//temp['manager_admin_no'] = item.manager_admin_no;
	          			//temp['director_no'] = '104';
	          			temp['work_addr1'] 	= item.work_addr1;
	          			temp['work_addr2'] 	= item.work_addr2;
	          			temp['work_zip'] 	= item.work_zip;
	          			temp['req_name'] 	= item.req_name;
	          			// B2B 기업구분
	          			let _req_name = item.req_name;
	          			if(item.work_target == '04'){
	          				_req_name = item.customer_name+"/"+item.branch_name;
	          				temp['req_name'] 	= _req_name;
	          			}
	          			
	          			work_list += '<option value="'+item.work_no+'" data-item=\''+JSON.stringify(temp)+'\' >'+item.work_id+' | '+_req_name+' | '+item.location_name+'</option>';
	          		});
	          		$("#work_no").html(work_list);
	          	}
	          	/* selected work_no */
	    		if('${data.work_no}' != '') {
	    			$("#work_no").val('${data.work_no}');
	    		}
	          	
	    		listAdminWork();
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
	
	/* 작업자 목록 */
	function listAdminWork(){

		const _name = "작업자목록 조회";	// ajax name
		const _url = "/work/admin/list/ajax";	// ajax url
		
		let _param = {};
		_param.work_no = $("#work_no").val();
		
		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	
	          	if(data != undefined){
	          		let work_list = '<option value="">선택</option>';
	          		$.each(data.data, function(index, item){
	          			let temp = {};
	          			work_list += '<option value="'+item.admin_no+'" >'+item.admin_name+'</option>';
	          		});
	          		$("#manager_no").html(work_list);
	          	}
	          	/* selected work_no */
	    		if('${data.manager_no}' != '') {
	    			$("#manager_no").val('${data.manager_no}');
	    		}
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		}, false);
	}
	
	/* 카테고리 목록 */
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
	          		
	          		$("#cate"+category_level).html(temp_list);
	          	}
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
	
	/* 브랜드 목록 */
	function listBrand(){

		const _name = "브랜드목록 조회";	// ajax name
		const _url = "/brand/list/ajax";	// ajax url
		let _param = {};	// ajax param
		
		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	
	          	if(data != undefined){
	          		let temp_list = '<option value="">선택</option>';
	          		$.each(data.data, function(index, item){
	          			temp_list += '<option value="'+ item.brand_no +'" >'+item.brand_name+ '</option>';
	          		});
	          		
	          		$("#brand_no").html(temp_list);
	          	}
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}

	/* 자재 목록 */
	function listMaterial(){

		const _name = "자재목록 조회";	// ajax name
		const _url = "/material/select/list/ajax";	// ajax url
		let _param = {};	// ajax param
		
		_param['category_no'] = $("#cate3 option:selected").data('category_no');
		
		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	
	          	if(data != undefined){
	          		let temp_list = '<option value="">선택</option>';
	          		$.each(data.data, function(index, item){
	          			let temp = {};
	          			// add brand_name
	          			let _materila_name = item.material_name;
	          			if(!Utils.isEmpty(item.brand_name)){
	          				_materila_name += '(' + item.brand_name +')';
	          			}
	          			temp['material_no'] = item.material_no;
	          			temp['material_name'] = item.material_name;
	          			temp['material_id'] = item.material_id;
	          			temp['brand_no'] = item.brand_no;
	          			temp['unit_cd'] = item.unit_cd;
	          			temp['ware_house_cnt'] = item.ware_house_cnt;
	          			temp['company_cnt'] = item.company_cnt;
	          			temp['sba_cnt'] = item.sba_cnt;
	          			temp['purchased_price'] 	= item.purchased_price;
	          			temp_list += '<option value="'+item.material_no+'" data-item=\''+JSON.stringify(temp)+'\' >'+_materila_name+'</option>';
	          			//temp_list += '<option value="'+ item.material_no +'" >'+item.material_name+ '</option>';
	          		});
	          		
	          		temp_list += '<option value="ADD">[상품추가]</option>';
	          		
	          		$("#material_list").html(temp_list);
	          	}
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
	
	function resetForm(){
		$('#materialFrm')[0].reset();
		$("#cate2").html('<option value="">선택</option>');
		$("#cate3").html('<option value="">선택</option>');
		$("select , input").removeClass("parsley-success");
		$("#material_cnt").val(0);
		
		$("[name=div_add_material]").hide();
		$("[name=div_all_material] select").prop("disabled", true);
		$("#total_material_price").prop("readonly", true);
	}

	function saveMaterialReq(){
		const _name = "자재구매요청 저장";	// ajax name
		const _url = "/material/req/save/ajax";	// ajax url
		
		let _form = "materialFrm";	// ajax param
		
		//$("#materialFrm #material_doc_no").val($("#material_doc_no").val());
		
		//_param['material_doc_no'] = $("#material_doc_no").val();
		
		/* validate */
		let validate = $("#materialFrm").parsley().validate();
		
		if(!validate) {
			console.log('# validate false !!!');
			return;
		}
		
		/* multi form insert */
		Utils.requestMultiAjax(_name, _url, _form, {
            success:  function(data) {
	          	alert(Message.SAVE);
	          	resetForm();	// reset material form
	          	$("#close_material").trigger("click");
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
	
	function listMaterialReq(){
		
		if(Utils.isEmpty($("#material_doc_no").val())) return ;
		
		const _name = "자재구매요청 조회";	// ajax name
		const _url = "/material/req/list/ajax";	// ajax url
		let _param = {};	// ajax param
		_param['material_doc_no'] = $("#material_doc_no").val();
		
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	
	          	let tmp = '';
	          	if(Utils.isEmpty(data.data)){
	          		//tmp = '<tr><td colspan="7">등록된 데이터가 없습니다.</td></tr>';
	          		$("#empty_material_doc_list").show();
	          	} else {
	          		$.each(data.data, function(idx, item){
	          			tmp += '<tr>'+ 
	    				'<td>'+Utils.nvl(item.material_id)+'</td>'+
	    				'<td style="text-align:left">'+Utils.nvl(item.material_name)+'</td>'+
	    				'<td>'+Utils.nvl(item.brand_name)+'</td>'+
	    				'<td style="text-align:right">'+Utils.nvl(item.material_cnt)+' '+getCodeNm('unit_cd',item.unit_cd)+'</td>'+
	    				'<td style="text-align:right">'+Utils.comma(Utils.nvl(item.purchased_price))+'</td>'+
	    				'<td style="text-align:right">'+Utils.comma(Utils.nvl(item.material_cnt*item.purchased_price))+'</td>'+
	    				'<td class="with-btn" nowrap=""><a href="#" class="btn btn-sm btn-white width-60" id="del-material" data-material_req_no="'+item.material_req_no+'">삭제</a></td>'+
	    				'</tr>';
	          		});
	          	}
	          	
	          	$("#empty_material_doc_list").hide();
    			$("#material_doc_list").html(tmp);
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}

	function saveMaterialDoc(){
		const _name = "자재구매요청 저장";	// ajax name
		const _url = "/material/doc/save/ajax";	// ajax url
		let _param = {};	// ajax param
		
		_param['work_no'] = $("#work_no").val();
		_param['use_date'] = Utils.remove($("#use_date").val(), "-");
		_param['use_hh'] = $("#use_hh").val();
		_param['use_mm'] = $("#use_mm").val();
		_param['receive_type'] = $("[name=receive_type]:checked").val();
		_param['manager_no'] = $("[name=manager_no]").val();
		_param['material_doc_no'] = $("[name=material_doc_no]").val();

		/* validate */
		let validate = $("#saveForm").parsley().validate();
		
		if(!validate) {
			console.log('# validate false !!!');
			return;
		}
		
		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	alert(Message.SAVE);
	          	$("[name=material_doc_no]").val(data.material_doc_no);
	          	// TODO: readonly 처리
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}

	function removeMaterialReq(material_req_no){
		if(!confirm(Message.CONFIRM.DELETE)){
			return;
		}
		const _name = "자재구매요청 삭제";	// ajax name
		const _url = "/material/req/delete/ajax";	// ajax url
		let _param = {};	// ajax param
		
		_param['material_req_no'] = material_req_no;
		
		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	//alert(Message.DELETE);
	          	listMaterialReq();
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
	
	function saveMaterial(){
		const _name = "자재마스터 저장";	// ajax name
		const _url = "/material/save/ajax";	// ajax url
		let _param = $("#materialFrm").serializeObject();	// ajax param
		
		_param['work_no'] = $("#work_no").val();
		_param['use_date'] = Utils.remove($("#use_date").val(), "-");
		_param['use_hh'] = $("#use_hh").val();
		_param['use_mm'] = $("#use_mm").val();
		_param['receive_type'] = $("[name=receive_type]:checked").val();
		_param['material_doc_no'] = $("#material_doc_no").val();
		
		/* validate */
		let validate1 = $("[name=saveForm]").parsley().validate();
		let validate2 = $("[name=materialFrm]").parsley().validate();
		
		if(!validate1 || !validate2) {
			console.log('# validate false !!!');
			return;
		}
		
		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	alert(Message.SAVE);
	          	resetForm();	// reset material form
	          	listMaterialReq();
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
</script>
