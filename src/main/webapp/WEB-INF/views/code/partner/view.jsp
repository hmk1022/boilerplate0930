<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE LEVEL HTML ================== -->
<h1 class="page-header">외주용역 및 업체<span class="ms-3 fw-bold">코드관리</span></h1>

<div class="row">
    <div class="col-12 mb-3">
    ${imageList}
        <div class="card">
            <div class="card-body ">
                <div class="row">

					<div class="col-md-4 col-12">
						<label class="form-label text-muted">이름/업체명</label>
						<h5>${data.partner_name }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">파트너 구분</label>
						<h5><tags:code-name code_gb="partner_type" value="${data.partner_type}"/></h5>
					</div>
					<div class="col-md-4 col-12">
					</div>
<hr>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">분야1</label>
						<h5><tags:code-name code_gb="work_cate" value="${data.work_cate1}"/></h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">분야2</label>
						<h5><tags:code-name code_gb="work_cate" value="${data.work_cate2}"/></h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">분야3</label>
						<h5><tags:code-name code_gb="work_cate" value="${data.work_cate3}"/></h5>
					</div>
<hr>
<c:choose>
	<c:when test="${data.partner_type eq '01'}">
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">주민번호</label>
						<div class="form-inline"><h5 idno>${data.id_no }</h5><span>******</span></div>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">연락처</label>
						<h5 phone>${data.partner_hp1 }</h5>
					</div>
	</c:when>
	<c:otherwise>

					<div class="col-md-4 col-12">
						<label class="form-label text-muted">담당자명</label>
						<h5>${data.manager_name }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">담당자 이메일</label>
						<h5>${data.manager_email }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">연락처</label>
						<h5 phone>${data.partner_hp1 }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">연락처</label>
						<h5 phone>${data.partner_hp2 }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">사업자번호</label>
						<h5>${data.comp_number }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">세금계산서 발행 이메일</label>
						<h5>${data.tax_email }</h5>
					</div>	
	</c:otherwise>
</c:choose>
					
<hr>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">은행</label>
						<h5><tags:code-name code_gb="vacct_bank_code" value="${data.bank_code}"/></h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">계좌번호</label>
						<h5>${data.acct }</h5>
					</div>
<hr>					
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">신분증 사본 (주민등록증, 운전면허증, 여권 등) 확인여부</label>
						<h5>${data.id_no_fin_yn eq 'Y' ? '확인':'미확인' }</h5>
					</div>					
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">통장 사본 확인여부</label>
						<h5>${data.acct_fin_yn eq 'Y' ? '확인':'미확인' }</h5>
					</div>					
<hr>
					<div class="col-md-12 col-12">
						<label class="form-label text-muted">사업자등록증 사본</label>
						<h5><tags:image imageList="${imageList}"/></h5>
					</div>					
															

				</div>
			</div>
		</div>
		
		<div class="d-flex justify-content-center mt-4">
        	<button 
			    type="button" 
			    class="btn btn-secondary" 
			    name="_button_page_list" 
			    data-to_url="/code/partner/list"
			    >list</button>
            <button class="btn btn-primary ms-2" id="move_edit" data-partner_no="${data.partner_no }">edit</button>
        </div>
	</div>
</div>
<!-- ================== END PAGE LEVEL HTML ================== -->
	
<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<!-- ================== END PAGE LEVEL JS ================== -->
	
<script>
	/* init page */
	$(function(){
		console.log('page script !!!! ');
		console.log('테스트!!!');
		/* save data */
		$("#move_edit").on("click", function(e){
			let param = {partner_no: $(this).data("partner_no")}
			postPage("/code/partner/form", param);
		});
		
	});
</script>