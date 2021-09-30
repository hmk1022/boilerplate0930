<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE HTML ================== -->
    <ol class="breadcrumb float-xl-end">
        <li class="breadcrumb-item"><a href="javascript:;">Home</a></li>
        <li class="breadcrumb-item active">코드관리</li>
    </ol>

    <h1 class="page-header">브랜드 및 업체 <span class="d-block small">코드관리</span></h1>
    <div class="card">
        <div class="card-header">
            <h3 class="mb-0">브랜드 및 업체 등록</h3>
        </div>
        <div class="card-body">
   			<form class="form-horizontal form-bordered" data-parsley-validate="true" name="saveFrm" id="saveForm" novalidate="" enctype="multipart/form-data">
			<input type="hidden" id="brand_no" name="brand_no" value="${data.brand_no }" >
            <div class="row">
                <div class="col-md-6 col-12 mt-3">
                    <label class="form-label">이름/업체명 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="브랜드명" 
                    	id="brand_name" 
                    	name="brand_name" 
                    	value="${data.brand_name }" 
                    	data-parsley-required="true" 
                    	data-parsley-error-message="브랜드명을 정확히 입력하세요."
                    	/>
                </div>
                <div class="col-md-6 col-12 mt-3 custom-type-p">
						<label class="form-label" for="branch_no">사용여부<span class="text-danger">*</span></label>
					    <select name="del_yn" class="form-control" placeholder="지점명" data-parsley-required="true" data-parsley-id="8" aria-describedby="parsley-id-8" data-parsley-error-message="사용여부를 선택하세요">
							<option value="">선택</option>
							<option class= "del_y" value="Y">사용</option>
							<option class= "del_n" value="N">미사용</option>
					</select>
				</div>
                <div class="col-md-12 col-12 mt-3">
                    <label class="form-label">설명 <span class="text-danger"></span></label>
                    <input type="text" class="form-control" 
                    	placeholder="설명 " 
                    	id="remarks" 
                    	name="remarks" 
                    	value="${data.remarks }" 
                    	data-parsley-required="false"
                    	data-parsley-error-message="브랜드 설명을 입력하세요." 
                    	/>
                </div>
   
                <div class="col-md-12 col-12 mt-3">
                    <label class="form-label">URL <span class="text-danger"></span></label>
                    <input type="text" class="form-control" 
                    	placeholder="URL " 
                    	id="brand_url" 
                    	name="brand_url" 
                    	value="${data.brand_url }" 
                    	data-parsley-required="false"
                    	data-parsley-error-message="브랜드 URL을 입력하세요." 
                    	/>
                </div>
            </div>
            </form>
        </div>
    </div>
			
    <div class="d-flex justify-content-center mt-4">
<c:if test="${empty data.brand_no }">
    <button class="btn btn-gray" name="_button_page_list" data-to_url="/code/brand/list">list</button>
 </c:if>
 <c:if test="${!empty data.brand_no }">
    <button class="btn btn-gray" name="_button_page_view" data-to_url="/code/brand/view" data-to_param="brand_no^${data.brand_no}">cancel</button>
</c:if>
        <button class="btn btn-primary ms-2" id="_dev-save">save</button>
    </div>    
    
	<!-- end panel -->

<!-- ================== END PAGE LEVEL JS ================== -->
	
<script>
	var curPage;
	
	/* init page */
	$(function(){
		console.log('page script !!!! ');
		console.log('테스트!!!');
		
		if('${data.del_yn}' =='Y') {
			$('.del_y').attr('selected',true);
		} else {
			$('.del_n').attr('selected',true);
		}
		
		/* save data */
		$("#_dev-save").on("click", function(e){
			const _name = "브랜드 및 업체 저장";	// ajax name
			const _url = "/code/brand/save/ajax";	// ajax url
			const _form = "saveForm";	// form name
			
			/* validate */
			let validate = $("[name=saveFrm]").parsley().validate();
			
			if(!validate) {
				console.log('# validate false !!!');
				return;
			}
			
			/* multi form insert */
			Utils.requestMultiAjax(_name, _url, _form, {
	            success:  function(data) {
		          	alert(Message.SAVE);
		            movePage("/code/brand/list");
	            },
	            complete:  function(response) {
	            	console.log('complete!!!');
	            }
			});
			
		});
		
	});

</script>

