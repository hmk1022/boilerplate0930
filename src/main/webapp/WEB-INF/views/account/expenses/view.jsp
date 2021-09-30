<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE LEVEL HTML ================== -->
<h1 class="page-header">비용처리<span class="ms-3 fw-bold">회계관리</span></h1>

<div class="row">
    <div class="col-12 mb-3">
        <div class="card">
            <div class="card-body ">
                <div class="row">
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">비용용도 </label>
						<h5>${data.exp_usage }</h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">작업선택 </label>
						<h5>${data.work_id }</h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">비용분류 </label>
						<h5><tags:code-name code_gb="exp_type" value="${data.exp_type}"/></h5>
					</div>
<hr>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">품의번호 </label>
						<h5>${data.exp_id }</h5>
					</div>
					
<c:if test="${data.exp_type eq '01'}">					
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">외주용역 </label>
						<h5>${data.partner_name }</h5>
					</div>
</c:if>
<c:if test="${data.exp_type eq '03'}">
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">매입거래처 </label>
						<h5>${data.vendor_name }</h5>
					</div>
</c:if>
<c:if test="${data.exp_type eq '04'}">					
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">사용처 </label>
						<h5>${data.exp_target }</h5>
					</div>
</c:if>
<hr>					
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">사용일(시작일) </label>
						<h5 date>${data.st_date }</h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">사용일(종료일) </label>
						<h5 date>${data.ed_date }</h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">비용단위 </label>
						<h5><tags:code-name code_gb="unit_cd" value="${data.exp_unit_cd}"/></h5>
					</div>
<hr>					
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">갯수 </label>
						<h5 comma>${data.exp_cnt }</h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">단가 </label>
						<h5 comma>${data.exp_price }</h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">결제수단 </label>
						<h5>${data.pay_type eq 'ACCT'?'계좌이체':''}${data.pay_type eq 'CARD'?'카드':''}</h5>
					</div>
<hr>					
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">지출증빙 </label>
						<h5>${data.evidence }</h5>
					</div>
<hr>				
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted" >증빙 영수증</label>
						<!-- image tag -->
						<div class="media media-lg">
							<tags:image imageList="${imageList}"/>
						</div>
					</div>
			
				</div>
			</div>
		</div>
		
		<div class="d-flex justify-content-center mt-4">
			<button type="button" class="btn btn-primary" id="move_edit" data-exp_no="${data.exp_no }" >edit</button>
			<button type="button" class="btn btn-grey" name="moveBack">list</button>
        </div>
	</div>
</div>			

	<!-- end panel -->
	
	<!-- page script -->
	
<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<!-- ================== END PAGE LEVEL JS ================== -->
	
<script>
	/* init page */
	$(function(){
		console.log('page script !!!! ');
		console.log('테스트!!!');
		/* save data */
		$("#move_edit").on("click", function(e){
			let param = {exp_no: $(this).data("exp_no")}
			postPage("/account/expenses/form", param);
		});
		
	});
</script>