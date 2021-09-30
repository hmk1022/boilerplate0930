<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE HTML ================== -->
    <ol class="breadcrumb float-xl-end">
        <li class="breadcrumb-item"><a href="javascript:;">Home</a></li>
        <li class="breadcrumb-item active">코드관리</li>
    </ol>

    <h1 class="page-header">고객사 <span class="d-block small">코드관리</span></h1>

    <div class="card">
        <div class="card-header">
            <h3 class="mb-0">고객사 등록</h3>
        </div>
        <div class="card-body">
   			<form class="form-horizontal form-bordered" data-parsley-validate="true" name="saveForm" id="saveForm" novalidate="" enctype="multipart/form-data">
			<input type="hidden" id="customer_no" name="customer_no" value="${data.customer_no }" >
            <div class="row">
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">고객사ID</label>
                    <input type="text" class="form-control" id="customer_id" name="customer_id" value="${data.customer_id }" placeholder="고객사ID" readonly>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">고객사명 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="고객사명" 
                    	id="customer_name" 
                    	name="customer_name" 
                    	value="${data.customer_name }" 
                    	placeholder="고객사명" 
                    	data-parsley-required="true" 
                    	data-parsley-error-message="고객사명을 정확히 입력하세요."
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">사업자번호 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="사업자번호" 
                    	id="comp_number" 
                    	name="comp_number" 
                    	value="${data.comp_number }" 
                    	placeholder="사업자번호" 
                    	data-parsley-required="true"
                    	data-parsley-error-message="사업자번호를 정확히 입력하세요."
                    	busno
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">담당자 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="담당자" 
                    	id="manager_name" 
                    	name="manager_name" 
                    	value="${data.manager_name }" 
                    	placeholder="담당자" 
                    	data-parsley-required="true" 
                    	data-parsley-error-message="담당자를 정확히 입력하세요."
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">직책 <span class="text-danger">*</span></label>
                    <select class="form-select" id="manager_rank" name="manager_rank" >	
                    <tags:code-select
					                codeList="${position }"
					                selected="${data.manager_rank }"
					                defaultValue="선택"
					        />
					</select>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">이메일 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="이메일" 
                    	id="manager_email" 
                    	name="manager_email" 
                    	value="${data.manager_email }" 
                    	placeholder="이메일" 
                    	data-parsley-type="email"
                    	data-parsley-required="true" 
                    	data-parsley-error-message="이메일을 정확히 입력하세요."
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">연락처 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="연락처" 
                    	id="manager_hp email" 
                    	name="manager_hp" 
                    	value="${data.manager_hp }" 
                    	placeholder="연락처" 
                    	data-parsley-required="true" 
                    	data-parsley-error-message="연락처를 정확히 입력하세요."
                    	phone/>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">세금계산서 이메일 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="세금계산서 이메일" 
                    	id="tax_email" 
                    	name="tax_email" 
                    	value="${data.tax_email }" 
                    	data-parsley-type="email"
                    	placeholder="세금계산서 이메일" 
                    	data-parsley-required="true" 
                    	data-parsley-error-message="세금계산서 이메일을 정확히 입력하세요."
                    	/>
                </div>
             	<div class="col-md-4 col-12 mt-3">
                    <label class="form-label">거래시작일 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="거래시작일" 
                    	id="deal_start_date" 
                    	name="deal_start_date" 
                    	value="${data.deal_start_date }" 
                    	placeholder="거래시작일" 
                    	data-parsley-required="true"
                    	data-parsley-error-message="거래시작일을 정확히 입력하세요."
                    	datepicker 
                    	/>
                </div>   
                <div class="col-md-12 col-12 mt-3">
                    <label class="form-label">사업자등록증 사본 <span class="text-danger">*</span></label>
					<tags:image-upload 
						name="upLoadFile"
                        value="${imageList}"
                        maxFileCount = "1"
                        required = "true"
                        category = "IMG_TYPE_CUSTOMER_BUSS"
                        type="image"
                    />
                </div>
            </div>
            </form>
        </div>
    </div>
			
    <div class="d-flex justify-content-center mt-4">
<c:if test="${empty data.customer_no }">
    <!-- <button class="btn btn-gray" name="_button_page_list" data-to_url="/code/customer/list">list</button> -->
    	<button class="btn btn-gray" onclick="javascript:backListPage()">list</button>
 </c:if>
 <c:if test="${!empty data.customer_no }">
    <%-- <button class="btn btn-gray" name="_button_page_view" data-to_url="/code/customer/view" data-to_param="customer_no^${data.customer_no}">cancel</button> --%>
    <button class="btn btn-gray" onclick="javascript:backViewPage()">cancel</button>
</c:if>
        <button  class="btn btn-primary ms-2" id="_dev-save">save</button>
    </div>


<!-- ================== END PAGE HTML ================== -->

<!-- ================== Start PAGE LEVEL JS ================== -->
<!-- ================== END PAGE LEVEL JS ================== -->
	
<script>
	var curPage;
	
	/* init page */
	$(function(){
		console.log('page script !!!! ');
		console.log('테스트!!!');
		
		/* save data */
		$("#_dev-save").on("click", function(e){
			const _name = "고객사-지점 저장";	// ajax name
			const _url = "/code/customer/save/ajax";	// ajax url
			const _form = "saveForm";	// form name
			
			/* validate */
			var validate = $("[name=saveForm]").parsley().validate();
			if(!validate) {
				console.log('# validate false !!!');
				return;
			}
			
			/* multi form insert */
			Utils.requestMultiAjax(_name, _url, _form, {
	            success:  function(data) {
		          	alert(Message.SAVE);
		          	//movePage("/code/customer/list");
		          	backListPage();
	            },
	            complete:  function(response) {}
			});

		});
		
		/* set mask optional */
	    setInputMask();
	});

</script>

