<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<div class="d-flex align-items-center justify-content-between mb-3">
	<h4 class="mb-0">결제</h4>
	<c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
	<button class="btn btn-primary btn-modal-save-payment">결제생성</button>
	</c:if>
</div>

<c:set var="paymentAmount" />
<c:forEach var="data" items="${paymentList }" varStatus="cnt">
	<c:set var="paymentAmount" value="${paymentAmount+data.total_pay_price }" />
	<c:set var="paymentPaidAmount" value="${paymentPaidAmount+data.paid_amount}" />
	<c:set var="paymentNotPaidAmount" value="${data.paid_date eq null ? paymentNotPaidAmount+data.paid_amount : paymentNotPaidAmount}" />
</c:forEach>
<div class="card mb-2">
	<div class="card-body card-primary">
		<div class="row">
			<div class="col-md-3 col-6">
				<label class="form-label text-muted">총 견적금액</label>
				<h5>
					<tags:code-currency value="${estimateData.total_unit_price }" />
				</h5>
			</div>
			<div class="col-md-3 col-6">
				<label class="form-label text-muted">결제 생성 금액</label>
				<h5>
					<tags:code-currency value="${paymentAmount }" />
				</h5>
			</div>
			<div class="col-md-3 col-6">
				<label class="form-label text-muted">미수금액</label>
				<h5 class="text-primary">
					<tags:code-currency value="${paymentAmount-paymentPaidAmount }" />
				</h5>
			</div>
			<div class="col-md-3 col-6">
				<label class="form-label text-muted">결제완료</label>
				<h5 class="text-primary">
					<tags:code-currency value="${paymentPaidAmount }" />
				</h5>
			</div>
		</div>
	</div>
</div>
<c:choose>
	<c:when test="${!empty paymentList }">
		<c:forEach var="data" items="${paymentList }" varStatus="cnt">
			<div class="card mb-2">
				<div class="card-body">
					<div class="row">
						<div class="col-md-2 col-6">
							<label class="form-label text-muted">결제종류</label>
							<h5>
								<tags:code-name code_gb="amount_type" value="${data.amount_type }" />
							</h5>
						</div>
						<div class="col-md-2 col-6">
							<label class="form-label text-muted">결제예정일</label>
							<h5>
								<tags:str-date value="${data.pay_date }" />
							</h5>
						</div>
						<div class="col-md-2 col-6">
							<label class="form-label text-muted">결제대상금액</label>
							<h5>
								<tags:code-currency value="${data.total_pay_price }" />
							</h5>
						</div>
						<div class="col-md-2 col-6">
							<label class="form-label text-muted">결제방식</label>
							<h5>
								<tags:code-name code_gb="pay_abc_type" value="${data.pay_type}" />
								<c:if test="${data.pay_type ne 02}"> /<tags:code-name code_gb="pay_bill_type" value="${data.pay_bill_type }" />
								</c:if>
							</h5>
						</div>
						<div class="col-md-2 col-6">
							<label class="form-label text-muted">결제완료일</label>
							<h5>
								<tags:str-date value="${data.paid_date }" />
							</h5>
						</div>
						<div class="col-md-2 col-6">
							<label class="form-label text-muted">매출일</label>
							<h5>
								<tags:str-date value="${data.pay_bill_yymmdd }" />
							</h5>
						</div>
					</div>
				</div>
				<div class="card-footer">
					<h5 class="mb-0 text-primary">
						<tags:code-name code_gb="pay_stat" value="${data.stat }" />
					</h5>
					<c:if test="${data.stat == 01 }">
						<c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
						<button type="button" class="float-end btn btn-danger btn-delete" data-pay_no="${data.pay_no }">삭제</button>
						</c:if>
					</c:if>
				</div>
			</div>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<div class="border p-2 rounded my-3 bg-default">목록이 존재 하지않습니다.</div>
	</c:otherwise>
</c:choose>
<hr>
<h5>
	<i class="fas fa-lg fa-fw fa-info-circle"></i> 사용 가이드
</h5>
<ul class="mb-0">
	<li>결제는 최종 승인된 견적서의 총 견적금액 이하로 생성할 수 있습니다. 총 견적금액을 초과하여 결제를 생성하고자 할 경우, 새 버전의 견적서를 작성하여 견적금액을 변경한 후 결제를 생성하세요.</li>
</ul>
<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<script>

	App.setPageTitle('');
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
	});

	/* set mask optional */
	setDivMask();

</script>
<!-- ================== END PAGE LEVEL JS ================== -->

<script id="save_payment_form" type="text/x-handlebars-template">
<%@ include file="payment_form.jsp" %>
</script>
<script>
	var curPage;
	/* init page */
	$(function(){
		$(".btn-modal-save-payment").on("click", function(e){
			let total_amount = ${estimateData.total_unit_price-paymentAmount };
			let total_amount_view = maskCurrency(total_amount);
			if(total_amount == 0) {
				alert("생성할 수 있는 결제금액이 없습니다.");
				return;
			}
			let source = $("#save_payment_form").html();
			console.log("${paymentAmount}");
			let template = Handlebars.compile(source);
			let data = {
					work_no:${workData.work_no} ,
					total_amount : total_amount ,
					total_amount_view:total_amount_view ,
					comp_number:'${workData.comp_number}' ,
					tax_email:'${workData.tax_email}'
					};
			let content = template(data);

			let modalOptions = {
					title : "결제 생성",
					description:"총 결제금액을 기준으로 결제를 나누어 생성할 수 있습니다.",
					content : content,
					size : "modal-lg",
					callback:"",
					callbackParam:""
				}
			Modal.popup(modalOptions);
		});
		$(".btn-delete").on("click", deletePayment);
	});

	function deletePayment(){
		console.log("=== deletePayment");
		if(!confirm(Message.CONFIRM.DELETE)) return;
		const _name = "일정 삭제";	// ajax name
		const _url = "/abc/work/payment/delete/ajax";	// ajax url
		let _param = {pay_no : $(this).data("pay_no")};
		Utils.requestAjax(_name, _url, _param, {
			beforeSend: function(){},
            success:  function(data) {
	          	alert(Message.SAVE);
        		$('a[href="#payment_view"]').trigger("click");
            },
            complete:  function(response) {
            }
		});
	}
</script>