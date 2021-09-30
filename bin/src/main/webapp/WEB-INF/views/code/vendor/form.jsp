<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE HTML ================== -->
    <ol class="breadcrumb float-xl-end">
        <li class="breadcrumb-item"><a href="javascript:;">Home</a></li>
        <li class="breadcrumb-item active">코드관리</li>
    </ol>

    <h1 class="page-header">구매거래처 <span class="d-block small">코드관리</span></h1>
    <div class="card">
        <div class="card-header">
            <h3 class="mb-0">구매거래처  등록</h3>
        </div>
        <div class="card-body">
   			<form class="form-horizontal form-bordered" data-parsley-validate="true" name="saveForm" id="saveForm" novalidate="" enctype="multipart/form-data">
			<input type="hidden" id="vendor_no" name="vendor_no" value="${data.vendor_no }" >
            <div class="row">
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">거래처명 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="거래처" 
                    	id="vendor_name" 
                    	name="vendor_name" 
                    	value="${data.vendor_name }" 
                    	data-parsley-required="true"
						data-parsley-error-message="거래처명을 정확히 입력하세요."
                    	/>
                </div>
                <div class="col-md-8 col-12 mt-3">
                </div>            
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">분야1 <span class="text-danger">*</span></label>
                    <select class="form-select" id="work_cate1" name="work_cate1" 
                    	data-parsley-required="true"
                    	data-parsley-error-message="분야1을 정확히 입력하세요."
                    	>
				        <tags:code-select
							codeList="${work_cate }"
							selected="${data.work_cate1 }"
							defaultValue="선택"
						/>
					</select>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">분야2 <span class="text-danger"></span></label>
                    <select class="form-select" id="work_cate2" name="work_cate2" >
				        <tags:code-select
							codeList="${work_cate }"
							selected="${data.work_cate2 }"
							defaultValue="선택"
						/>
					</select>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">분야3 <span class="text-danger"></span></label>
                    <select class="form-select" id="work_cate3" name="work_cate3" >
				        <tags:code-select
							codeList="${work_cate }"
							selected="${data.work_cate3 }"
							defaultValue="선택"
						/>
					</select>
                </div>            
            
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">연락처 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="연락처 " 
                    	id="vendor_hp1" 
                    	name="vendor_hp1" 
                    	value="${data.vendor_hp1 }" 
                    	data-parsley-required="true"
                    	data-parsley-error-message="연락처를 정확히 입력하세요."
                    	phone
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">연락처2 <span class="text-danger"></span></label>
                    <input type="text" class="form-control" 
                    	placeholder="연락처2" 
                    	id="vendor_hp2" 
                    	name="vendor_hp2" 
                    	value="${data.vendor_hp2 }" 
                    	data-parsley-required="false"
                    	phone
                    	/>
                </div>                            
                <div class="col-md-4 col-12 mt-3">
                </div>              
                <div class="col-md-4 col-12 mt-3" name="partner_type_02">
                    <label class="form-label">사업자번호 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="사업자번호 " 
                    	id="comp_number" 
                    	name="comp_number" 
                    	value="${data.comp_number }" 
                    	data-parsley-required="true"
                    	data-parsley-error-message="사업자번호를 정확히 입력하세요."
                    	busno
                    	/>
                </div>                
                <div class="col-md-4 col-12 mt-3" name="partner_type_02">
                    <label class="form-label">세금계산서 발행 이메일 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="세금계산서 발행 이메일 " 
                    	id="tax_email" 
                    	name="tax_email" 
                    	value="${data.tax_email }" 
                  		data-parsley-type="email" 
                  		data-parsley-error-message="세금계산서 발행 이메일을 정확히 입력하세요."
                    	data-parsley-required="true" 
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3" name="partner_type_02">
                </div>    
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">은행 <span class="text-danger"></span></label>
                    <select class="form-select" id="bank_code" name="bank_code"
                    data-parsley-required="true"
                    data-parsley-error-message="은행을 선택하세요."
                     >
				        <tags:code-select
							codeList="${vacct_bank_code }"
							selected="${data.bank_code }"
							defaultValue="선택"
						/>
					</select>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">계좌번호<span class="text-danger"></span></label>
                    <input type="text" class="form-control" 
                    	placeholder="계좌번호" 
                    	id="acct" 
                    	name="acct" 
                    	value="${data.acct }" 
                    	data-parsley-required="true" 
                    	data-parsley-error-message="계좌번호를 정확히 입력하세요."
                    	data-parsley-type="number"
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">통장 사본<span class="text-danger"></span></label>
					<div class="is-valid">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="acct_fin_yn" name="acct_fin_yn" value="Y" ${data.acct_fin_yn eq 'Y' ? 'checked':'' }>
                            <label class="form-check-label" for="acct_fin_yn">재무/회계팀에 사본 전달 완료 후 체크하세요</label>
                        </div>
                    </div>
                </div>            
                <div class="col-md-12 col-12 mt-3">
                    <label class="form-label">사업자등록증 사본 <span class="text-danger">*</span></label>
					<tags:image-upload 
						name="upLoadFile1"
                        value="${imageList1}"
                        maxFileCount = "1"
                        required = "false"
                        category = "IMG_TYPE_VENDOR_BUSS"
                        type="image"
                    />
                </div>   
 			</div>
            </form>
        </div>
    </div>
			
    <div class="d-flex justify-content-center mt-4">
    	<c:if test="${empty data.vendor_no }">
        <button class="btn btn-gray" name="_button_page_list" data-to_url="/code/vendor/list">list</button>
    	</c:if>
    	<c:if test="${!empty data.vendor_no }">
    	<button class="btn btn-gray" name="_button_page_view" data-to_url="/code/vendor/view" data-to_param="vendor_no^${data.vendor_no}">cancel</button>
    	</c:if>
        <button class="btn btn-primary ms-2" id="_dev-save">save</button>
    </div>                    
                
<!-- ================== END PAGE HTML ================== -->

<!-- ================== END PAGE LEVEL JS ================== -->
	
<script>
	var curPage;
	
	/* init page */
	$(function(){
		console.log('page script !!!! ');
		console.log('테스트!!!');
		
		/* save data */
		$("#_dev-save").on("click", function(e){
			const _name = "외주용역 및 업체 저장";	// ajax name
			const _url = "/code/vendor/save/ajax";	// ajax url
			const _form = "saveForm";	// form name
			
			$("#id_no").val($("#id_no1").val()+""+$("#id_no2").val());
			
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
		          	movePage("/code/vendor/list");
	            },
	            complete:  function(response) {
	            	console.log('complete!!!');
	            }
			});
		});
		
		/* set mask optional */
	    setInputMask();
	});

</script>

