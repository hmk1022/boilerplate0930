<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

<body class="p-3">
    <div class="card">
        <div class="card-header">
            <h3>완료보고서 작성 - 고객 전송용<span class="text-muted small d-block">고객 전송용 완료보고서를 작성할 수 있습니다</span></h3>
        </div>
        <div class="card-body">
        	<form class="" data-parsley-validate="true" name="frm" id="frm" novalidate="" enctype="multipart/form-data">
	            <div class="row">
	                <div class="col-6">
	                    <div class="form-group">
	                        <label class="form-label">고객(사) 및 지점명</label>
	                        	<input type="text" class="form-control customer-name" value="${reportForm.customer_name} / ${reportForm.branch_name}" disabled>
	                    </div>
	                </div>
	                <div class="col-6">
	                    <div class="form-group form">
	                        <label class="form-label">수신인 <span class="text-danger">*</span></label>
	                        <input type="text" name="customer_name" class="form-control" value="${reportForm.req_name}"
	                         data-parsley-error-message="수신일을 정확히 입력하세요."
							 data-parsley-required="true"
	                        >
	                    </div>
	                    <div class="form-group post">
	                        <label class="form-label">수신인 <span class="text-danger">*</span></label>
	                        <input type="text" name="customer_name" class="form-control" value="${clientReport.customer_name}"
	                         data-parsley-error-message="수신일을 정확히 입력하세요."
							 data-parsley-required="true"
	                        >
	                    </div>
	                </div>
	                <div class="col-12 mt-3">
	                    <div class="form-group">
	                        <label class="form-label">현장주소</label>
	                        <input type="text" class="form-control" value="${reportForm.work_addr1} ${reportForm.work_addr2}" disabled>
	                    </div>
	                </div>
	                <div class="col-12 mt-3">
	                    <div class="form-group form">
	                        <label class="form-label ">공사명 <span class="text-danger">*</span></label>
	                        <input type="text" name="report_name" class="form-control" value="${reportForm.location_name }" 
	                         data-parsley-error-message="공사명을 정확히 입력하세요."
							 data-parsley-required="true">
	                    </div>
	                    <div class="form-group post">
	                        <label class="form-label">공사명 <span class="text-danger">*</span></label>
	                        <input type="text" name="report_name" class="form-control" value="${clientReport.report_name }" 
	                         data-parsley-error-message="공사명을 정확히 입력하세요."
							 data-parsley-required="true">
	                    </div>
	                </div>
	                <div class="col-6 mt-3">
	                    <div class="form-group form">
	                        <label class="form-label mb-2">현장책임자 <span class="text-danger">*</span></label>
	                        <input type="text" name="supervisor_admin_no" class="form-control" value="${data.supervisor_admin_name}" 
	                         data-parsley-error-message="현장책임자를 정확히 입력하세요."
							 data-parsley-required="true"
	                        >
	                    </div>
	                    <div class="form-group post">
	                        <label class="form-label mb-2">현장책임자 <span class="text-danger">*</span></label>
	                        <input type="text" name="supervisor_admin_no" class="form-control" value="${clientReport.supervisor_admin_no}" 
	                         data-parsley-error-message="현장책임자를 정확히 입력하세요."
							 data-parsley-required="true"
	                        >
	                    </div>
	                </div>
	                <div class="col-6 mt-3">
	                    <div class="form-group form">
	                        <label class="form-label mb-2">시공담당자 <span class="text-danger">*</span></label>
	                        <input type="text" class="form-control" name="workerman_admin_name" value="${data.workerman_admin_name }" 
	                         data-parsley-error-message="시공담당자를 정확히 입력하세요."
							 data-parsley-required="true">
	                    </div>
	                    <div class="form-group post">
	                        <label class="form-label mb-2">시공담당자 <span class="text-danger">*</span></label>
	                        <input type="text" class="form-control" name="workerman_admin_name" value="${clientReport.workerman_admin_name }" 
	                         data-parsley-error-message="시공담당자를 정확히 입력하세요."
							 data-parsley-required="true">
	                    </div>
	                </div>
	                <div class="col-12 mt-3">
	                    <div class="form-group">
	                        <label class="form-label">공사기간</label>
	                        <input type="text" name = "ed_working_date" class="form-control" value="${data.st_working_date } ~ ${data.ed_working_date }" readonly>
	                    </div>
	                </div>
	                <div class="col-12 mt-3">
	                    <div class="form-group">
	                        <label class="form-label">공사내역 <span class="text-danger">*</span></label>	                        
	                        <textarea name="report_memo" class="form-control" rows="6"
	                         placeholder="고객에게 안내할 공사 내역을 입력하세요."
	                         data-parsley-error-message="공사내역을 정확히 입력하세요."
							 data-parsley-required="true">${clientReport.report_memo }</textarea>
	                    </div>
	                </div>
	                <div class="col-12 mt-3">
	                    <div class="form-group">
	                        <label class="form-label">공사전 사진 <span class="text-danger">*</span></label>          
	                            <tags:image-upload3	                            	
									name="upLoadFile1"
			                        value="${beforeImg}"
			                        maxFileCount = "4"
			    					required = "true"
			                        category = "IMG_TYPE_REPORT_BEFORE"
			                        type="image"   
			                    />		                    
	                    </div>
	                </div> 
	         		<div class="col-12 mt-3">
	                    <div class="form-group">
	                        <label class="form-label">공사중 사진 <span class="text-danger">*</span></label>          
	                            <tags:image-upload3                            	
									name="upLoadFile2"
			                        value="${ingImg }"
			                        maxFileCount = "4"
			                        required = "true"
			                        category = "IMG_TYPE_REPORT_ING"
			                        type="image"
			                    />
	                    </div>
	                </div>
	                <div class="col-12 mt-3">
	                    <div class="form-group">
	                        <label class="form-label">공사후 사진 <span class="text-danger">*</span></label>          
	                            <tags:image-upload3
									name="upLoadFile3"
			                        value="${imageList}"
			                        maxFileCount = "4"
			                        required = "true"
			                        category = "IMG_TYPE_REPORT_AFTER"
			                        type="image"
			                    />
	                    </div>
	                </div>  	            
	                <!-- display-none -->
	                	<input type="hidden" id="report_no" name="report_no" value="${clientReport.report_no}" > 
	                	<input type="hidden" id="req_name" value="${reportForm.req_name}" > 
			        	<div class="form-group dispaly_none">
				             <label class="form-label">report_id <span class="text-danger">*</span></label>
				             <input type="text" name="report_id" class="form-control" value="${reportForm.work_id}">
				        </div>
			        	<div class="form-group dispaly_none">
				             <label class="form-label">work_no <span class="text-danger">*</span></label>
				             <input type="text" name="work_no" class="form-control" value="${reportForm.work_no }">
				        </div>
				        <div class="form-group dispaly_none">
				             <label class="form-label">del_yn <span class="text-danger">*</span></label>
				             <input type="text" name="del_yn"class="form-control" value="${reportForm.delete_yn }">
				        </div>
				        <div class="form-group dispaly_none">
				             <label class="form-label">manager_admin_no <span class="text-danger">*</span></label>
				             <input type="text" name="manager_admin_no"class="form-control" value="${data.manager_admin_no }">
				        </div>
				         <div class="form-group dispaly_none">
				             <label class="form-label">delete_yn <span class="text-danger">*</span></label>
				             <input type="text" name="delete_yn"class="form-control" value="${reportForm.delete_yn }">
				        </div>
				        <div class="form-group dispaly_none">
				             <label class="form-label">create_no <span class="text-danger">*</span></label>
				             <input type="text" name="create_no"class="form-control" value="${clientReport.create_no }">
				        </div>
				         </div>
				         <div class="form-group dispaly_none">
				             <label class="form-label">create_date <span class="text-danger">*</span></label>
				             <input type="text" name="create_date"class="form-control" value="${clientReport.create_date }">
				        </div>
				         <div class="form-group dispaly_none">
				             <label class="form-label">update_form <span class="text-danger">*</span></label>
				             <input type="text" class="update_form" value="${clientReport}">
				        </div>
				     	<div class="form-group dispaly_none">
				             <label class="form-label">update_no <span class="text-danger">*</span></label>
				             <input type="text" name="update_no" class="form-control" value="${clientReport.update_no }">
				        </div>   
	            </div>
	        </div>
         </form>
        <div class="card-footer">
            <button class="btn btn-primary btn-block" id="_dev-save">등록</button>
        </div>
    </div>
</body>
<script>
$(function() {
	$('.dispaly_none').css('display','none');
	/* 등록 or 수정 구분자 clientReport*/
	let postformat = $('.update_form').val();
	
	let data = '${reportImg}' 
	let parseData = JSON.parse(data);
	
	let insTag
	
	let customerName = $('.customer-name').val();
	console.log('customerName',customerName.trim().length);
	
	
	if(customerName.trim().length === 1) {
		 $('.customer-name').val($('#req_name').val());
	} 
	
	if (postformat) {
		$('.form').remove();
		console.log('수정');
	} else {
		
		$('.post').remove();
		console.log('등록');
	}

	
	/* save data */
	$("#_dev-save").on("click", function(e){
		console.log('등록 or 수정',postformat);

		const _name = "";	// ajax name
		const _url = postformat ? "/report-client/post/ajax" : "/report-client/save/ajax";	
		const _form = "frm";	// form name

		/* validate */
		var validate = $("[name=frm]").parsley().validate();
		if(!validate) {
			console.log('# validate false !!!');
			return;
		}

		/* multi form insert */
		Utils.requestMultiAjax(_name, _url, _form, {
            success:  function(data) {
	          	alert(Message.SAVE);
	          	console.log('수정완료');
	          	pageRefresh("/abc/work/view",{"work_no":"${param.work_no}","tab":"#report_view"})
	      		window.close();
            },
            complete:  function(response) {
            }
		});
	});
	
	$('#download_pdf').click(function() {
		  window.print();
	});	
});


</script>