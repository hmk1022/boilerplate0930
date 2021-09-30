<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<body class="p-3">
    <div class="card">
        <div class="card-header">
            <h3>완료보고서 작성 - 내부 보고용 <span class="text-muted small d-block">내부 보고용 완료보고서를 작성할 수 있습니다</span></h3>
        </div>
        <div class="card-body">

        <form class="" data-parsley-validate="true" name="frm" id="frm" novalidate="" enctype="multipart/form-data">
         	<input type="hidden" name="customer_name" class="form-control" value="${reportForm.req_name}">  
            <div class="row">
	                <div class="col-6">
	                    <div class="form-group">
	                        <label class="form-label">고객(사) 및 지점명</label>
	                        <input type="text" class="form-control customer" value="${reportForm.customer_name} / ${reportForm.branch_name}"disabled>
	                    </div>
	                </div>
	               	<div class="col-6">
	                    <div class="form-group">
	                        <label class="form-label">공사기간</label>
	                        <input type="text" class="form-control customer" value="${data.st_working_date } ~ ${data.ed_working_date }" disabled>
	                    </div>
	                </div>
	                <div class="col-12 mt-3">
	                    <div class="form-group">
	                        <label class="form-label">현장주소</label>
	                        <input type="text" class="form-control" value="${reportForm.work_addr1} ${reportForm.work_addr2}" disabled>
	                    </div>
	                </div>
	                <div class="col-12 mt-3">
	                    <div class="form-group">
	                        <label class="form-label">공사명 <span class="text-danger">*</span></label>
	                        <input type="text" name="report_name1" class="form-control" value="${reportForm.location_name }"
	                         data-parsley-error-message="공사명을 정확히 입력하세요."
							 data-parsley-required="true" disabled>
	                    </div>
	                </div>
	                <div class="col-12 mt-3">
	                    <div class="form-group">
	                        <label class="form-label">특이사항 <span class="text-danger">*</span></label>
	                        <textarea class="form-control" name="report_memo" rows="6"
	                         data-parsley-error-message="특이사항을 정확히 입력하세요."
							 data-parsley-required="true">${postData.report_memo}</textarea>
	                    </div>
	            	</div>    	
        	</div>
        	<!-- display-none -->
        	 <input type="hidden" name="report_name" class="form-control" value="${reportForm.location_name }">
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
	             <label class="form-label">supervisor_admin_no <span class="text-danger">*</span></label>
	             <input type="text" name="supervisor_admin_no"class="form-control" value="${data.supervisor_admin_name }">
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
	             <input type="text" name="create_no"class="form-control" value="${postData.create_no }">
	        </div>
	         <div class="form-group dispaly_none">
	             <label class="form-label">update_no <span class="text-danger">*</span></label>
	             <input type="text" name="update_no"class="form-control" value="${reportForm.update_no }">
	        </div>
	           <div class="form-group dispaly_none">
	             <label class="form-label">create_date <span class="text-danger">*</span></label>
	             <input type="text" name="create_date"class="form-control" value="${postData.create_date }">
	        </div>
        </form>
        <div class="form-group dispaly_none">
	             <label class="form-label">update_form <span class="text-danger">*</span></label>
	             <input type="text" class="update_form" value="${postData}">
	        </div>
	        <div class="form-group dispaly_none">
	             <label class="form-label">customer <span class="text-danger">*</span></label>
	             <input type="text" class="req_name" value="${data.req_name}">
	        </div>
        <div class="card-footer">
            <button class="btn btn-primary btn-block" id="_dev-save">등록</button>
        </div>
    </div>
</body>


<!-- ================== END PAGE LEVEL HTML ================== -->

<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<!-- ================== END PAGE LEVEL JS ================== -->

<script>
	/* init page */	
	$(function() {
		$('.dispaly_none').css('display','none');
		/* 등록 or 수정 구분자 */
		let postformat = $('.update_form').val()
	
		/* 개인고객일 경우 고객(사) 및 지점명 수정  */
		if($('.customer').val().trim() == '/') {
			$('.customer').val($('.req_name').val());
		};
		
		/* save data */
		$("#_dev-save").on("click", function(e){
			console.log('등록 or 수정',postformat);
			const _name = "";	// ajax name
			const _url = postformat ? "/reportin/post/ajax" : "/reportin/save/ajax";	
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
		          	pageRefresh("/abc/work/view",{"work_no":"${param.work_no}","tab":"#report_view"})
		      		window.close();
	            },
	            complete:  function(response) {
	            },
	            error: function (e) {
	                alert('중복된 아이디 입니다');
	            }
			});
		});
		
		$('#download_pdf').click(function() {
			  window.print();
		});	
	});
	

</script>