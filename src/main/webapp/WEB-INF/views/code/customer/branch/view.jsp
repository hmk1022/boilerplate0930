<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

<!-- ================== BEGIN PAGE LEVEL HTML ================== -->
<h1 class="page-header">고객사/지점<span class="ms-3 fw-bold">정보</span></h1>

<div class="row">
    <div class="col-12 mb-3">
        <div class="card">
            <div class="card-body ">
                <div class="row">

					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">지점ID</label>
						<h5>${data.branch_id }</h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">지점명</label>
						<h5>${data.branch_name }</h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">주소</label>
						<h5>${data.work_zip } ${data.comp_addr1 } ${data.comp_addr2 }</h5>
					</div>
					<hr>					
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">사업자번호</label>
						<h5 busno>${data.comp_number } </h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">세금계산서 발행 이메일</label>
						<h5>${data.tax_email } </h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
					</div>					
					<hr>					
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">담당자</label>
						<h5>${data.manager_name } </h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">이메일</label>
						<h5>${data.manager_email } </h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">이메일</label>
						<h5>${data.manager_email } </h5>
					</div>
					<hr>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">연락처</label>
						<h5 phone>${data.manager_hp1 } </h5>
					</div>
					<hr>
					<div class="col-md-12 col-12 mt-3">
						<label class="form-label text-muted">사업자등록증 사본</label>
						<h5><tags:image imageList="${imageList}"/></h5>
					</div>
				</div>
			</div>
		</div>
		
		<div class="d-flex justify-content-center mt-4">
        	<div class="d-flex justify-content-center mt-4">
			    <button 
			    type="button" 
			    class="btn btn-secondary" 
			    name="_button_page_list" 
			    data-to_url="/code/customer/branch/list">list</button>
            <button class="btn btn-primary ms-2" id="move_edit" data-branch_no="${data.branch_no }">edit</button>
        </div>
	</div>
</div>
<!-- ================== END PAGE LEVEL HTML ================== -->
	
	
<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<script>
	
/* 	App.setPageTitle('코드관리 | 고객사/지점');
	App.restartGlobalFunction();

	$.when(
		$.getScript('/assets/plugins/parsleyjs/dist/parsley.min.js'),
		$.getScript('/assets/plugins/highlight.js/highlight.min.js'),
		$.Deferred(function( deferred ){
			$(deferred.resolve);
		})
	).done(function() {
		$.getScript('/assets/js/demo/render.highlight.js'),
		$.Deferred(function( deferred ){
			$(deferred.resolve);
		})
	}); */
	
	/* set mask optional */
	setDivMask();
	
</script>
<!-- ================== END PAGE LEVEL JS ================== -->
	
<script>
	var curPage;
	
	/* init page */
	$(function(){
		
		/* save data */
		$("#move_edit").on("click", function(e){
			let param = {branch_no: $(this).data("branch_no")}
			postPage("/code/customer/branch/form", param);
		});
		
	});

</script>