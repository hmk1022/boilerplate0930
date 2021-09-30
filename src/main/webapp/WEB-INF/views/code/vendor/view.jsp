<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE LEVEL HTML ================== -->
<h1 class="page-header">구매거래처 <span class="ms-3 fw-bold">코드관리</span></h1>

<div class="row">
    <div class="col-12 mb-3">
        <div class="card">
            <div class="card-body ">
                <div class="row">
                
                	<div class="col-md-3 col-12">
						<label class="form-label text-muted">거래처명</label>
						<h5>${data.vendor_name }</h5>
					</div>
					<div class="col-md-3 col-12">
						<label class="form-label text-muted">분야1</label>
						<h5><tags:code-name code_gb="work_cate" value="${data.work_cate1}"/></h5>
					</div>
					<div class="col-md-3 col-12">
						<label class="form-label text-muted">분야2</label>
						<h5><tags:code-name code_gb="work_cate" value="${data.work_cate2}"/></h5>
					</div>
					<div class="col-md-3 col-12">
						<label class="form-label text-muted">분야2</label>
						<h5><tags:code-name code_gb="work_cate" value="${data.work_cate3}"/></h5>
					</div>
					<hr>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">연락처1</label>
						<h5 phone>${data.vendor_hp1 }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">연락처2</label>
						<h5 phone>${data.vendor_hp1 }</h5>
					</div>
					<hr>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">사업자번호</label>
						<h5>${data.comp_number }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">세금계산서 발행 이메일</label>
						<h5>${data.tax_email }</h5>
					</div>
					<hr>	                
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">은행</label>
						<h5><tags:code-name code_gb="vacct_bank_code" value="${data.bank_code}"/></h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">계좌번호</label>
						<h5>${data.acct }</h5>
					</div>                
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">통장 사본 확인여부</label>
						<h5>${data.acct_fin_yn eq 'Y' ? '확인':'미확인' }</h5>
					</div>
					<hr>                
					<div class="col-md-12 col-12">
						<label class="form-label text-muted">사업자등록증 사본</label>
						<h5>
						<tags:image imageList="${imageList1}"
							emptyMsg="등록된 이미지가 없습니다."
						/>
						</h5>
					</div>                
				</div>
			</div>
		</div>
		
		<div class="d-flex justify-content-center mt-4">
			<button 
				type="button" 
				class="btn btn-secondary" 
				name="_button_page_list" 
				data-to_url="/code/vendor/list">list</button>
            <button class="btn btn-primary ms-2" id="move_edit" data-vendor_no="${data.vendor_no }">edit</button>
        </div>
	</div>
</div>
<!-- ================== END PAGE LEVEL HTML ================== -->

	
<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<!-- ================== END PAGE LEVEL JS ================== -->
	
<script>
	/* init page */
	$(function(){
		/* save data */
		$("#move_edit").on("click", function(e){
			let param = {vendor_no: $(this).data("vendor_no")}
			postPage("/code/vendor/form", param);
		});
	});

</script>