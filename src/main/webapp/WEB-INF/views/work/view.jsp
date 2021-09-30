<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- begin page-header -->
<h1 class="page-header">
	작업마스터<span class="ms-3 fw-bold">${data.work_id }</span>
</h1>
<!-- end page-header -->
<div class="row">
	<div class="col-12 mb-3">
		<div class="card">
			<div class="card-body border border-primary">
				<form class="form-horizontal form-bordered"
					data-parsley-validate="true" name="viewFrm" id="frm" novalidate="">
					<div class="row">
						<div class="col-md-8 col-12">
							<label class="form-label text-muted">공사명</label>
							<h5>${data.location_name}</h5>
						</div>
						<div class="col-md-4 col-6 mt-md-0 mt-3">
							<label class="form-label text-muted">작업상태</label>
							<h5 class="text-danger"><tags:code-name code_gb="new_work_stat" value="${data.work_stat}"/>
							<c:if test="${data.work_stat ne '99' and data.work_stat ne '19' }">
							<button type="button" class="btn btn-danger ml-4"  data-work_no="${data.work_no}" onclick="popCancelWork();">작업취소</button>
							</c:if>
							</h5>

						</div>
						<c:if test="${data.work_stat == '99' or data.work_stat == '19' }">
						<div class="col-md-3 col-6 mt-3">
							<label class="form-label text-muted">취소사유</label>
							<h5 class="text-danger"><tags:code-name code_gb="est_reject_cd" value="${data.reject_cd}"/></h5>
						</div>
						<div class="col-md-9 col-12 mt-3">
							<label class="form-label text-muted">취소상세사유</label>
							<h5 class="text-danger">${ data.reject_content}</h5>
						</div>
						</c:if>
						<hr>
						<div class="col-md-3 col-6">
							<label class="form-label text-muted">고객구분</label>
							<h5>
								<tags:code-name code_gb="work_target" value="${data.work_target}"/> /
								<c:if test="${data.branch_name eq null}">개인</c:if>
								<c:if test="${data.branch_name ne null}">법인</c:if>
							</h5>
						</div>
						<div class="col-md-3 col-6">
							<label class="form-label text-muted">고객(사)명</label>
							<h5>${data.customer_name}/${data.branch_name }</h5>
						</div>
						<div class="col-md-3 col-12 mt-md-0 mt-3">
							<label class="form-label text-muted">담당자정보</label>
							<h5>${data.req_name}/${data.req_hp }</h5>
						</div>
						<div class="col-md-3 col-12 mt-md-0 mt-3">
							<label class="form-label text-muted">현장주소</label>
							<h5>${data.work_addr1}${data.work_addr2}</h5>
						</div>
						<div class="col-md-3 col-12 mt-3">
							<label class="form-label text-muted">작업기간</label>
							<h5>${data.st_working_date} ~ ${data.ed_working_date}</h5>
						</div>
						<div class="col-md-3 col-12 mt-3">
							<label class="form-label text-muted">공무</label>
							<h5>${data.manager_admin_name}</h5>
						</div>
						<div class="col-md-3 col-12 mt-3">
							<label class="form-label text-muted">감리</label>
							<h5>${ data.supervisor_admin_name}</h5>
						</div>
						<div class="col-md-3 col-12 mt-3">
							<label class="form-label text-muted">워커맨</label>
							<h5>${ data.workerman_admin_name}</h5>
						</div>
						<c:if test="${data.apply_date != null and data.apply_date != '' }">
						<hr>
						<div class="col-md-3 col-12">
							<label class="form-label text-muted">총 견적금액</label>
							<h5>
								<a href="#" class="text-danger"><tags:code-currency value="${data.total_unit_price}"/></a><span
									class="small ms-2 text-dark">(${ data.apply_date} / 버전${ data.version_no})</span>
							</h5>
						</div>
						<div class="col-md-3 col-12 mt-md-0 mt-3">
							<label class="form-label text-muted">예상실행가 및 마진율</label>
							<h5>
								<tags:code-currency value="${data.total_est_unit_price }"/><span class="small ms-2 text-primary">(<fmt:formatNumber value="${(1-(data.total_est_unit_price/data.total_unit_price))}" type="percent" pattern="0.0%"/>)</span>
							</h5>
						</div>
						<div class="col-md-3 col-12 mt-md-0 mt-3">
							<label class="form-label text-muted">실 실행가 합계</label>
							<h5>
								<tags:code-currency value="${data.excute_price }"/><span class="small ms-2 text-primary">(<fmt:formatNumber var="excuteP" value="${data.excute_price /data.total_unit_price}" type="percent" pattern="0.0%"/>${excuteP })</span>
							</h5>
							<div class="progress">
								<div class="progress-bar fs-10px fw-bold" style="width: ${excuteP}">${excuteP }</div>
							</div>
						</div>
						<div class="col-md-3 col-12 mt-md-0 mt-3">
							<label class="form-label text-muted">결제완료금액</label>
							<h5>
								<tags:code-currency value="${data.paid_amount }"/><span class="small ms-2 text-primary">(<fmt:formatNumber value="${((data.paid_amount/data.total_unit_price))}" type="percent"  pattern="0.0%"/>)</span>
							</h5>
						</div>
						</c:if>
					</div>
				</form>
			</div>
		</div>

		<div class="card mt-4">
			<div class="card-body table-responsive">
				<ul class="nav nav-pills">
				    <li class="nav-item">
				        <a href="#memo_view" data-toggle="tab" data-url="/abc/work/memo/view" class="nav-link">요청사항 메모</a>
				    </li>
				    <li class="nav-item">
				        <a href="#schedule_view" data-toggle="tab" data-url="/abc/work/schedule/view" class="nav-link">작업일정</a>
				    </li>
				    <li class="nav-item">
				        <a href="#estimate_view" data-toggle="tab" data-url="/abc/work/estimate/view" class="nav-link">견적서</a>
				    </li>
				    <li class="nav-item">
				        <a href="#daily_view" data-toggle="tab" data-url="/abc/work/daily/view" class="nav-link">작업일지</a>
				    </li>
				    <li class="nav-item">
				        <a href="#excute_price_view" data-toggle="tab" data-url="/abc/work/excute_price/view" class="nav-link">실행가</a>
				    </li>
				    <li class="nav-item">
				        <a href="#material_view" data-toggle="tab" data-url="/abc/work/material/view" class="nav-link">자재요청</a>
				    </li>
				    <li class="nav-item">
				        <a href="#payment_view" data-toggle="tab" data-url="/abc/work/payment/view" class="nav-link">결제</a>
				    </li>
				    <li class="nav-item">
				        <a href="#report_view" data-toggle="tab" data-url="/abc/work/report/view" class="nav-link">완료보고서</a>
				    </li>
				</ul>
				<div class="tab-content bg-white p-3">
					<div class="tab-pane fade" id="memo_view"></div>
					<div class="tab-pane fade" id="schedule_view"></div>
					<div class="tab-pane fade" id="estimate_view"></div>
					<div class="tab-pane fade" id="daily_view"></div>
					<div class="tab-pane fade" id="excute_price_view"></div>
					<div class="tab-pane fade" id="material_view"></div>
					<div class="tab-pane fade" id="payment_view"></div>
					<div class="tab-pane fade" id="report_view"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<form name="frm_cancel" id="frm_cancel" target="_cancel" action="/popup/cancel/form" method="POST">
	<input type="hidden" name="work_no" value="${param.work_no}">
</form>
<!-- page script -->
<script>
	var curPage;
	/* init page */

    function popCancelWork() {
		let _form = $("#frm_cancel");	// form name
        var popup = window.open('', '_cancel', 'width=400,height=735,scrollbars=no');
        _form.submit();
    }
	$(function(){
		//$('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
		$('a[data-toggle="tab"]').on('click', function (e) {
			let $this = $(e.target);
			let _id = $this.attr("href");
			let _url = $this.data("url");
			let _param = {work_no : ${data.work_no}};
			postTabPage(_url, _param, _id);
			_param.id = _id;
		    pushState(_url, _param,"postTabPage");
		});
		$('a[href="#memo_view"]').trigger("click");

		if("${param.tab}" != ""){
			console.log("tab : 1111","${param.tab}");
			$('a[href="${param.tab}"]').trigger('click');
		}
	});

</script>