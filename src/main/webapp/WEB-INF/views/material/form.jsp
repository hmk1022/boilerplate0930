<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE HTML ================== -->
    <ol class="breadcrumb float-xl-end">
        <li class="breadcrumb-item"><a href="javascript:;">Home</a></li>
        <li class="breadcrumb-item active">자재관리</li>
    </ol>

    <h1 class="page-header">자재등록 <span class="d-block small">자재관리</span></h1>
    <div class="card">
        <div class="card-header">
            <h3 class="mb-0">자재등록</h3>
        </div>
        <div class="card-body">
   			<form class="form-horizontal form-bordered" data-parsley-validate="true" name="saveForm" id="saveForm" novalidate="" enctype="multipart/form-data">
			<input type="hidden" id="material_no" name="material_no" value="${data.material_no }" >
            <div class="row">
				<div class="col-md-3 col-12 mt-3">
                    <label class="form-label">랙번호</label>
                    <input type="text" class="form-control" 
                    	placeholder="랙번호" 
                    	id="rack_id" 
                    	name="rack_id" 
                    	value="${data.rack_id }" 
                    	data-parsley-required="false" 
                    	data-parsley-error-message="랙번호를 정확히 입력하세요."
                    	/>
                </div>
                <div class="col-md-9 col-12 mt-3"></div>
                <div class="col-md-3 col-12 mt-3">
                    <label class="form-label">대분류 <span class="text-danger"></span></label>
                    <select class="form-select" id="cate1" name="cate1" data-parsley-required="false" 
                    data-parsley-error-message="대분류를 선택하세요.">
						<option value="">선택</option>
						<c:forEach items="${cate1 }" var="item">
						<option value="${item.category_id }">${item.name }</option>
						</c:forEach>
					</select>
                </div>
                <div class="col-md-3 col-12 mt-3">
                    <label class="form-label">중분류 <span class="text-danger"></span></label>
                    <select class="form-select" id="cate2" name="cate2" data-parsley-required="false"
                    data-parsley-error-message="중분류를 선택하세요.">
						<option value="">선택</option>
						<c:forEach items="${cate2 }" var="item">
						<option value="${item.category_id }">${item.name }</option>
						</c:forEach>						
					</select>
                </div>
                <div class="col-md-3 col-12 mt-3">
                    <label class="form-label">소분류 <span class="text-danger"></span></label>
                    <select class="form-select" id="cate3" name="category_no" data-parsley-required="false"
                    data-parsley-error-message="소분류를 선택하세요.">
						<option value="">선택</option>
						<c:forEach items="${cate3 }" var="item">
						<option value="${item.category_no }">${item.name }</option>
						</c:forEach>
					</select>
                </div>
				<div class="col-md-6 col-12 mt-3">
                    <label class="form-label">상품명  <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="관리명" 
                    	id="material_name" 
                    	name="material_name" 
                    	value="${data.material_name }" 
                    	data-parsley-required="true" 
                    	data-parsley-error-message="상품명을 정확히 입력하세요."/>
                </div>
                <div class="col-md-6 col-12 mt-3"></div>
				<div class="col-md-6 col-12 mt-3">
                    <label class="form-label">관리명  <span class="text-danger"></span></label>
                    <input type="text" class="form-control" 
                    	placeholder="관리명" 
                    	id="house_name" 
                    	name="house_name" 
                    	value="${data.house_name }" 
                    	data-parsley-required="false" 
                    	data-parsley-error-message="관리명을 정확히 입력하세요." />
                </div>                
                <div class="col-md-6 col-12 mt-3"></div>
                <div class="col-md-3 col-12 mt-3">
                    <label class="form-label">브랜드</label>
					<select class="form-select" name="brand_no" id="brand_no"
					data-parsley-required="false" 
					data-parsley-error-message="브랜드를 정확히 입력하세요." >
					</select>
                </div>
				<div class="col-md-3 col-12 mt-3">
                    <label class="form-label">모델명  <span class="text-danger"></span></label>
                    <input type="text" class="form-control" 
                    	placeholder="모델명" 
                    	id="model_name" 
                    	name="model_name" 
                    	value="${data.model_name }" 
                    	data-parsley-required="false" 
                    	/>
                </div>
                <div class="col-md-3 col-12 mt-3">
                    <label class="form-label">단위 <span class="text-danger">*</span></label>
                    <select class="form-select" id="unit_cd" name="unit_cd" data-parsley-required="true"
                     data-parsley-error-message="단위를 정확히 입력하세요.">
				        <tags:code-select
							codeList="${unit_cd }"
							selected="${data.unit_cd }"
							defaultValue="선택" />
					</select>
                </div>
                <div class="col-md-3 col-12 mt-3"></div>
				<div class="col-md-2 col-12 mt-3">
                    <label class="form-label">매입단가 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="매입단가" 
                    	id="purchased_price" 
                    	name="purchased_price" 
                    	value="${data.purchased_price }" 
                    	data-parsley-required="true" 
                    	data-parsley-error-message="매입단가를 정확히 입력하세요."
                    	comma
                    	/>
                </div>
				<div class="col-md-2 col-12 mt-3">
                    <label class="form-label">공급가 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="공급가" 
                    	id="workerman_price" 
                    	name="workerman_price" 
                    	value="${data.workerman_price }" 
                    	data-parsley-required="true" 
                    	data-parsley-error-message="공급가를 정확히 입력하세요."
                    	comma
                    	/>
                </div>
				<div class="col-md-2 col-12 mt-3">
                    <label class="form-label">복수시공 공급가 <span class="text-danger"></span></label>
                    <input type="text" class="form-control" 
                    	placeholder="복수시공 공급가" 
                    	id="multi_price" 
                    	name="multi_price" 
                    	value="${data.multi_price }" 
                    	data-parsley-required="false" 
                    	comma
                    	/>
                </div>
				<div class="col-md-2 col-12 mt-3">
                    <label class="form-label">시장가 <span class="text-danger"></span></label>
                    <input type="text" class="form-control" 
                    	placeholder="시장가" 
                    	id="sale_price" 
                    	name="sale_price" 
                    	value="${data.sale_price }" 
                    	data-parsley-required="false" 
                    	comma
                    	/>
                </div>
                
				<div class="col-md-6 col-12 mt-3">
                    <label class="form-label">링크1 <span class="text-danger"></span></label>
                    <input type="text" class="form-control" 
                    	placeholder="링크" 
                    	id="material_link" 
                    	name="material_link" 
                    	value="${data.material_link }" 
                    	data-parsley-error-message="링크1을 정확히 입력하세요."
                    	data-parsley-required="false"	
                    	/>
                </div>
                <div class="col-md-6 col-12 mt-3"></div>
				<div class="col-md-6 col-12 mt-3">
                    <label class="form-label">링크2 <span class="text-danger"></span></label>
                    <input type="text" class="form-control" 
                    	placeholder="링크" 
                    	id="material_link1" 
                    	name="material_link1" 
                    	value="${data.material_link2 }" 
                    	data-parsley-type="url"
                    	data-parsley-required="false" 
                    	/>
                </div>
                <div class="col-md-6 col-12 mt-3"></div>
				<div class="col-md-9 col-12 mt-3">
                    <label class="form-label">메모 <span class="text-danger"></span></label>
                    <input type="text" class="form-control" 
                    	placeholder="메모" 
                    	id="remarks" 
                    	name="remarks" 
                    	value="${data.remarks }" 
                    	data-parsley-required="false" 
                    	data-parsley-error-message="메모를 정확히 입력하세요."
                    	/>
                </div>
                <div class="col-md-9 col-12 mt-3">
                    <label class="form-label">자재 사진 <span class="text-danger"></span></label>
					<tags:image-upload 
						name="upLoadFile"
                        value="${imageList}"
                        maxFileCount = "5"
                        required = "false"
                        category = "IMG_TYPE_MATERIAL"
                        type="image"
                    />
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">고객노출<span class="text-danger"></span></label>
					<div class="is-valid">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="member_open_yn" name="member_open_yn" value="Y" ${data.member_open_yn eq 'Y' ? 'checked':'' }>
                            <label class="form-check-label" for="member_open_yn">체크시 고객에게 노출 됩니다.</label>
                        </div>
                    </div>
                </div>            
                <div class="col-md-6 col-12 mt-3">
                    <label class="form-label">사용사업부 <span class="text-danger"></span></label><br>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="work_targets1" name="work_targets" value="B2C" ${fn:indexOf(data.work_targets,'B2C') > -1 ? 'checked':'' }>
                        <label class="form-check-label" for="work_targets1">B2C</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="work_targets2" name="work_targets" value="B2B" ${fn:indexOf(data.work_targets,'B2B') > -1 ? 'checked':'' }>
                        <label class="form-check-label" for="work_targets2">B2B</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="work_targets3" name="work_targets" value="PRO" ${fn:indexOf(data.work_targets,'PRO') > -1 ? 'checked':'' }>
                        <label class="form-check-label" for="work_targets3">PROJECT</label>
                    </div>
                    
                </div>            
            </div>
            </form>
        </div>
    </div>
			
    <div class="d-flex justify-content-center mt-4">
<c:if test="${empty data.material_no }">
    <!-- <button class="btn btn-gray" name="_button_page_list" data-to_url="/material/list">list</button> -->
    <button class="btn btn-gray" onclick="javascript:backListPage()">list</button>
</c:if>
<c:if test="${!empty data.material_no }">
    <%-- <button class="btn btn-gray" name="_button_page_view" data-to_url="/material/view" data-to_param="material_no^${data.material_no}">cancel</button> --%>
	<button class="btn btn-gray" onclick="javascript:backViewPage()">cancel</button>    
</c:if>
        <button class="btn btn-primary ms-2" id="_dev-save">save</button>
    </div>                


<!-- ================== END PAGE LEVEL JS ================== -->
	
<script>
	var curPage;
	
	/* init page */
	$(function(){
		console.log('page script !!!! ');
		console.log('테스트!!!');
		
		/* save data */
		$("#_dev-save").on("click", function(e){
			const _name = "자재 저장";	// ajax name
			const _url = "/material/save/ajax";	// ajax url
			let _form = "saveForm";	// ajax param
			
			/* validate */
			let validate = $("#saveForm").parsley().validate();
			
			if(!validate) {
				console.log('# validate false !!!');
				return;
			}
			
			/* multi form insert */
			Utils.requestMultiAjax(_name, _url, _form, {
	            success:  function(data) {
		          	alert(Message.SAVE);
		          	//movePage("/material/list");
		          	backListPage();
	            },
	            complete:  function(response) {
	            	console.log('complete!!!');
	            }
			});

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
	    
	    
	    /* 브랜드목록 조회 */
	    listBrand();
	    
	    /* 수정 처리 */
	    if('${data.material_no}' != ''){
	    	$("#cate1").val('${data.cate1}');
	    	$("#cate2").val('${data.cate2}');
	    	$("#cate3").val('${data.category_no}');
	    	
	    	$("#brand_no").val('${data.brand_no}');
	    	$("#unit_cd").val('${data.unit_cd}');
	    }
	});

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
            	if('${data.brand_no}' !=''){
            		$("#brand_no").val('${data.brand_no}');
            	}
            }
		});
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
	          			
	          			if(category_level == '3') {
		          			temp_list += '<option value="'+ item.category_no +'" data-category_no="'+ item.category_no +'" >'+item.name+ '</option>';
	          			} else {
		          			temp_list += '<option value="'+ item.category_id +'" data-category_no="'+ item.category_no +'" >'+item.name+ '</option>';
	          			}
	          		});
	          		
	          		$("#cate"+category_level).html(temp_list);
	          	}
            },
            complete:  function(response) {
            	console.log('complete!!!');
            	//initCategory(category_level);
            }
		});
	}
	
</script>

