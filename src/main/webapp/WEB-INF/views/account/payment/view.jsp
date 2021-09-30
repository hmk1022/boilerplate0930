<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE LEVEL HTML ================== -->
<h1 class="page-header">결제/매출<span class="ms-3 fw-bold">회계관리</span></h1>

<div class="row">
    <div class="col-12 mb-3">
        <div class="card">
            <div class="card-body ">
                <div class="row">
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">결제종류 </label>
						<h5><tags:code-name code_gb="amount_type" value="${data.amount_type}"/></h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">결제예정일 </label>
						<h5>${data.pay_date}</h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">결제대상금액 </label>
						<h5>${data.total_pay_price}</h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">결제금액 </label>
						<h5>${data.paid_amount}</h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">결제수단 </label>
						<h5><tags:code-name code_gb="pay_type" value="${data.pay_type}"/></h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">지출증빙 </label>
						<h5><tags:code-name code_gb="pay_bill_type" value="${data.pay_bill_type}"/></h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">사업자번호 </label>
						<h5><tags:code-name code_gb="pay_bill_comp_number" value="${data.pay_bill_comp_number}"/></h5>
					</div>
					<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">세금계산서 발행 이메일 </label>
						<h5><tags:code-name code_gb="pay_bill_email" value="${data.pay_bill_email}"/></h5>
					</div>										

				</div>
			</div>
		</div>
		<div class="d-flex justify-content-center mt-4">
			<button type="button" class="btn btn-primary" id="move_edit" data-pay_no="${data.pay_no }" >edit</button>
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
			let param = {pay_no: $(this).data("pay_no")}
			postPage("/account/payment/form", param);
		});
		
	});
</script>