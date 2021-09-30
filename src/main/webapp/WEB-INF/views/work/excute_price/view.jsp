<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<c:choose>
	<c:when test="${!empty excutePriceDailyList }">
		<c:forEach var="expenseData" items="${excutePriceDailyList }" varStatus="cnt">
			<c:set var="total_price" value="${total_price+expenseData.total_price }" />
				<c:set var="total_price_01" value="${total_price_01+expenseData.total_price_01 }" />
				<c:set var="total_price_02" value="${total_price_02+expenseData.total_price_02 }" />
				<c:set var="total_price_03" value="${total_price_03+expenseData.total_price_03 }" />
				<c:set var="total_price_04" value="${total_price_04+expenseData.total_price_04 }" />
		</c:forEach>
	</c:when>
</c:choose>
<div class="mb-5">
	<div class="d-flex align-items-center justify-content-between mb-3">
		<h4 class="mb-3">실행가 요약</h4>
		<c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
		<button class="btn btn-outline-primary" onclick="popExpense();">비용등록</button>
		</c:if>
	</div>
	<div class="card mb-2">
		<div class="card-body card-primary">
			<div class="row">
				<div class="col-md-3 col-6">
					<label class="form-label text-muted">공사 가용액</label>
					<h5>
						<tags:code-currency value="${estimateData.total_unit_price}" />
					</h5>
				</div>
				<div class="col-md-3 col-6">
					<label class="form-label text-muted">총 사용 금액</label>
					<h5>
						<tags:code-currency value="${total_price}" />
					</h5>
				</div>
				<div class="col-md-3 col-6 mt-md-0 mt-3">
					<label class="form-label text-muted">잔액</label>
					<h5 class="text-primary">
						<tags:code-currency value="${estimateData.total_unit_price-total_price}" />
					</h5>
				</div>
				<div class="col-md-3 col-6 mt-md-0 mt-3">
					<label class="form-label text-muted">외주업체비용</label>
					<h5>
						<tags:code-currency value="${total_price_02 }" />
					</h5>
				</div>
				<div class="col-md-3 col-6 mt-3">
					<label class="form-label text-muted">인건비</label>
					<h5>
						<tags:code-currency value="${total_price_01 }" />
					</h5>
				</div>
				<div class="col-md-3 col-6 mt-3">
					<label class="form-label text-muted">자재비</label>
					<h5>
						<tags:code-currency value="${total_price_03 }" />
					</h5>
				</div>
				<div class="col-md-3 col-6 mt-3">
					<label class="form-label text-muted">공과잡비</label>
					<h5>
						<tags:code-currency value="${total_price_04 }" />
					</h5>
				</div>
			</div>
		</div>
	</div>
	<div class="table-responsive">
		<table class="table table-striped ">
			<thead>
				<tr>
					<th>작업일</th>
					<th>인건비</th>
					<th>외주업체비</th>
					<th>자재비</th>
					<th>공과잡비</th>
					<th>합계</th>
					<th>잔액</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="remainAmount" value="${estimateData.total_unit_price}" />
				<c:choose>
					<c:when test="${!empty excutePriceDailyList }">
						<c:forEach var="excutePriceDailyData" items="${excutePriceDailyList }" varStatus="cnt">
							<c:set var="remainAmount" value="${remainAmount-excutePriceDailyData.total_price }" />
							<tr>
								<td>${excutePriceDailyData.st_date_ymd }(${excutePriceDailyData.day_of_week })</td>
								<td class="text-end">
									<tags:code-currency value="${excutePriceDailyData.total_price_01 }" />
								</td>
								<td class="text-end">
									<tags:code-currency value="${excutePriceDailyData.total_price_02 }" />
								</td>
								<td class="text-end">
									<tags:code-currency value="${excutePriceDailyData.total_price_03 }" />
								</td>
								<td class="text-end">
									<tags:code-currency value="${excutePriceDailyData.total_price_04 }" />
								</td>
								<td class="text-end text-success">
									<tags:code-currency value="${excutePriceDailyData.total_price }" />
								</td>
								<td class="text-end">
									<tags:code-currency value="${remainAmount }" />
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="border p-2 rounded my-3 bg-default">일정이 존재 하지않습니다.</div>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
</div>

<div class="">
	<div class="d-flex align-items-center justify-content-between mb-3">
		<h4 class="mb-0">실행가 목록</h4>
		<c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
		<button class="btn btn-outline-primary" onclick="popExpense();">비용등록</button>
		</c:if>
	</div>
	<div class="table-responsive">
		<table class="table table-striped ">
			<thead>
				<tr>
					<th>No.</th>
					<th>문서구분</th>
					<th>문서번호</th>
					<th>비용구분</th>
					<th>용도</th>
					<th>사용일</th>
					<th>금액</th>
					<th>결제일</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${!empty excutePriceList }">
						<c:forEach var="excutePriceData" items="${excutePriceList }" varStatus="cnt">
							<tr>
								<td>${cnt.count }</td>
								<td>${excutePriceData.exp_category}</td>
								<td>
									${excutePriceData.exp_id}
								</td>
								<td>
									<tags:code-name code_gb="exp_type" value="${excutePriceData.exp_type}" />
								</td>
								<c:choose>
									<c:when test="${excutePriceData.exp_cate_code eq '03' }">
										<td class="text-start">${excutePriceData.exp_usage eq null ? '작업 시공 자재' : excutePriceData.exp_usage }</td>
									</c:when>
									<c:otherwise>
										<td class="text-start">${excutePriceData.exp_usage} / ${excutePriceData.exp_target}${excutePriceData.partner_name}${excutePriceData.vendor_name}</td>
									</c:otherwise>
								</c:choose>
								<td><tags:str-date value="${excutePriceData.st_date}" hasDayOfWeek="true"/></td>
								<td>
									<tags:code-currency value="${excutePriceData.price}" />
								</td>
								<td><tags:str-date value="${excutePriceData.pay_date}"/><br>
									<c:choose>
										<c:when test="${excutePriceData.exp_cate_code eq '01'}">
											<tags:code-name code_gb="exp_stat" value="${excutePriceData.exp_stat}" />
										</c:when>
										<c:when test="${excutePriceData.exp_cate_code eq '02'}">
											<tags:code-name code_gb="disb_stat" value="${excutePriceData.exp_stat}" />
										</c:when>
										<c:otherwise>
											<tags:code-name code_gb="doc_stat" value="${excutePriceData.exp_stat}" />
										</c:otherwise>
									</c:choose>
								</td>
								<td><tags:str-datetime value="${excutePriceData.update_date}"/><br>${excutePriceData.update_name}</td>
							</tr>
						</c:forEach>
					</c:when>
				</c:choose>
			</tbody>
		</table>
	</div>
</div>
<div class="d-flex align-items-center justify-content-between mb-3">
	<h4 class="mb-0"></h4>
	<c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
	<button class="btn btn-outline-primary" onclick="popExpense();">비용등록</button>
	</c:if>
</div>
<form name="frm_expense" id="frm_expense" target="_expense" action="/popup/expenses/form" method="POST">
	<input type="hidden" name="work_no" value="${param.work_no}">
</form>
<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<script>
	App.setPageTitle('');
	App.restartGlobalFunction();

	$.when($.getScript('/assets/plugins/parsleyjs/dist/parsley.min.js'),
			$.getScript('/assets/plugins/highlight.js/highlight.min.js'),
			$.Deferred(function(deferred) {
				$(deferred.resolve);
			})).done(
			function() {
				$.getScript('/assets/js/demo/render.highlight.js'), $
						.Deferred(function(deferred) {
							$(deferred.resolve);
						})
			});

	/* set mask optional */
	setDivMask();
</script>
<!-- ================== END PAGE LEVEL JS ================== -->

<script>
	var curPage;

	function popExpense() {
		let _form = $("#frm_expense"); // form name
		var popup = window.open('', '_expense',
				'width=1000px,height=1000px,scrollbars=yes');
		_form.submit();
	}

	/* init page */
	$(function() {

	});
</script>