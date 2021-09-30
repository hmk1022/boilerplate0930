<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<style>
	/* pdf 출력 */
	@media print {
	   	#download_pdf,#save_daily_report, .file-caption-main {
	   		display: none;
	   	}
	   	.print-a4 {
	   		/* 프린트 */
	   		height:371mm
	   	}
	}
</style>
<div class="card">
	<form class="form-horizontal form-bordered" data-parsley-validate="true" name="frm_daily_report" id="frm_daily_report">
		<input type="hidden" name="work_no" value="${param.work_no}">
		<input type="hidden" name="report_date" value="${param.report_date}">
		<input type="hidden" name="daily_report_no" value="${param.daily_report_no}"">
		<div class="card-header">
			<div class="d-flex align-items-center justify-content-between">
				<h3>
					작업일지 작성<span class="text-primary ms-3">${workData.work_id }</span><span class="text-dark small ms-3">${param.report_date} ${param.day_of_week }</span>
				</h3>
				<div class="btn-box mt-24">
					<button type="button" class="btn btn-primary" id="download_pdf">출력</button>
					<button type="button" class="btn btn-primary" id="save_daily_report">
						<span>등록</span>
					</button>
				</div>
			</div>
		</div>
		<div class="card-body">
			<h4>오늘의 작업내역</h4>
			<div class="input-group">
				<textarea rows="5" class="form-control" name="schedule_memo" id="schedule_memo" placeholder="작업 내용 입력 (100자 이내)">${dailyReportData.schedule_memo }</textarea>
			</div>
			<hr>
			<h4>다음 일정 예정 작업</h4>
			<div class="input-group">
				<textarea rows="5" class="form-control" name="next_schedule_memo" id="next_schedule_memo" placeholder="작업 내용 입력 (100자 이내)">${dailyReportData.next_schedule_memo }</textarea>
			</div>
			<c:choose>
				<c:when test="${!empty dailyReportExpenseList }">
					<c:forEach var="dailyReportExpense" items="${dailyReportExpenseList }">
						<c:set var="price" value="${dailyReportExpense.exp_price*dailyReportExpense.exp_cnt }" />
						<c:set var="total_price" value="${total_price+price }" />
						<c:if test="${dailyReportExpense.exp_type eq '01' }">
							<c:set var="total_price_01" value="${total_price_01+price }" />
						</c:if>
						<c:if test="${dailyReportExpense.exp_type eq '02' }">
							<c:set var="total_price_02" value="${total_price_02+price }" />
						</c:if>
						<c:if test="${dailyReportExpense.exp_type eq '03' }">
							<c:set var="total_price_03" value="${total_price_03+price }" />
						</c:if>
						<c:if test="${dailyReportExpense.exp_type eq '04' }">
							<c:set var="total_price_04" value="${total_price_04+price }" />
						</c:if>
					</c:forEach>
				</c:when>
			</c:choose>
			<hr>
			<h4>오늘의 비용 투입 현황</h4>
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
								<tags:code-currency value="${estimateData.total_unit_price-dailyReportUsedAmountData.used_amount}" />
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
			<h5>인력 투입 현황</h5>
			<div class="table-responsive">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>No.</th>
							<th>구분</th>
							<th>문서번호</th>
							<th>용도</th>
							<th>사용인력</th>
							<th>인원</th>
							<th>단가</th>
							<th>금액</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${!empty dailyReportExpenseList }">
								<c:set var="loopCnt" value="0" />
								<c:forEach var="dailyReportExpense" items="${dailyReportExpenseList }" varStatus="status">
									<c:if test="${dailyReportExpense.exp_type eq '01' }">
										<c:set var="loopCnt" value="loopCnt+1" />
										<tr>
											<td>${status.index }</td>
											<td>${dailyReportExpense.exp_category }</td>
											<td>${dailyReportExpense.exp_id}</td>
											<td class="text-start">${dailyReportExpense.exp_usage }</td>
											<td class="text-start">${dailyReportExpense.partner_name }</td>
											<td>${dailyReportExpense.exp_cnt }</td>
											<td class="text-end">
												<tags:code-currency value="${dailyReportExpense.exp_price }" />
											</td>
											<td class="text-end">
												<tags:code-currency value="${dailyReportExpense.exp_price*dailyReportExpense.exp_cnt }" />
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:when>
						</c:choose>
						<tr class="table-success">
							<td colspan="7" class="fw-bold">소계</td>
							<td class="text-end fw-bold">
								<tags:code-currency value="${total_price_01 }" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<h5>턴키 업체 투입 현황</h5>
			<div class="table-responsive">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>No.</th>
							<th>구분</th>
							<th>문서번호</th>
							<th>용도</th>
							<th>업체명</th>
							<th>수량</th>
							<th>단가</th>
							<th>금액</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${!empty dailyReportExpenseList }">
								<c:set var="loopCnt" value="0" />
								<c:forEach var="dailyReportExpense" items="${dailyReportExpenseList }" varStatus="status">
									<c:if test="${dailyReportExpense.exp_type eq '02' }">
										<c:set var="loopCnt" value="loopCnt+1" />
										<tr>
											<td>${loopCnt}</td>
											<td>${dailyReportExpense.exp_category }</td>
											<td>${dailyReportExpense.exp_id}</td>
											<td class="text-start">${dailyReportExpense.exp_usage }</td>
											<td class="text-start">${dailyReportExpense.vendor_name }</td>
											<td>${dailyReportExpense.exp_cnt }</td>
											<td class="text-end">
												<tags:code-currency value="${dailyReportExpense.exp_price }" />
											</td>
											<td class="text-end">
												<tags:code-currency value="${dailyReportExpense.exp_price*dailyReportExpense.exp_cnt }" />
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:when>
						</c:choose>
						<tr class="table-success">
							<td colspan="7" class="fw-bold">소계</td>
							<td class="text-end fw-bold">
								<tags:code-currency value="${total_price_02 }" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<h5>자재 투입 현황</h5>
			<div class="table-responsive">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>No.</th>
							<th>구분</th>
							<th>문서번호</th>
							<th>품명</th>
							<th>수량</th>
							<th>단가</th>
							<th>금액</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${!empty dailyReportExpenseList }">
								<c:forEach var="dailyReportExpense" items="${dailyReportExpenseList }" varStatus="status">
									<c:if test="${dailyReportExpense.exp_type eq '03' }">
										<tr>
											<td>${status.index}</td>
											<td>${dailyReportExpense.exp_category }</td>
											<td>${dailyReportExpense.exp_id}</td>
											<td class="text-start">${dailyReportExpense.exp_usage }</td>
											<td>${dailyReportExpense.exp_cnt }</td>
											<td class="text-end">
												<tags:code-currency value="${dailyReportExpense.exp_price }" />
											</td>
											<td class="text-end">
												<tags:code-currency value="${dailyReportExpense.price }" />
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:when>
						</c:choose>
						<tr class="table-success">
							<td colspan="6" class="fw-bold">소계</td>
							<td class="text-end fw-bold">
								<tags:code-currency value="${total_price_03 }" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<h5>경비 투입 현황</h5>
			<div class="table-responsive">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>No.</th>
							<th>구분</th>
							<th>문서번호</th>
							<th>용도</th>
							<th>수량</th>
							<th>단가</th>
							<th>금액</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${!empty dailyReportExpenseList }">
								<c:forEach var="dailyReportExpense" items="${dailyReportExpenseList }" varStatus="status">
									<c:if test="${dailyReportExpense.exp_type eq '04' }">
										<tr>
											<td>${status.index}</td>
											<td>${dailyReportExpense.exp_category }</td>
											<td>${dailyReportExpense.exp_id}</td>
											<td class="text-start">${dailyReportExpense.exp_usage }</td>
											<td>${dailyReportExpense.exp_cnt }</td>
											<td class="text-end">
												<tags:code-currency value="${dailyReportExpense.exp_price }" />
											</td>
											<td class="text-end">
												<tags:code-currency value="${dailyReportExpense.exp_price*dailyReportExpense.exp_cnt }" />
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:when>
						</c:choose>
						<tr class="table-success">
							<td colspan="6" class="fw-bold">소계</td>
							<td class="text-end fw-bold">
								<tags:code-currency value="${total_price_04 }" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<h5>작업 현장 사진</h5>
			<div class="border p-3 mb-3">
				<tags:image-upload name="upLoadFile" value="${imageList}" maxFileCount="10" required="true" category="IMG_TYPE_DAILY_REPORT" type="image" />
			</div>
		</div>
		<a href="javascript:;" class="btn btn-icon btn-circle btn-success btn-scroll-to-top" data-toggle="scroll-to-top">
			<i class="fa fa-angle-up"></i>
		</a>
	</form>
</div>

<!-- ================== END PAGE LEVEL JS ================== -->

<script>
	var curPage;
	/* init page */
	function init() {
		App.restartGlobalFunction();
	}

	function saveDailyReport() {
		console.log("=== saveDailyReport");
		const _name = "일정 저장"; // ajax name
		const _url = "/abc/work/daily/save/ajax"; // ajax url
		const _form = "frm_daily_report"; // form name
		let _$form = $("#" + _form);
		let validate = _$form.parsley().validate();
		if (!validate) {
			console.log('# validate false !!!');
			return;
		}
		Utils.requestMultiAjax(_name, _url, _form, {
			success : function(data) {
				alert(Message.SAVE);
			},
			complete : function(response) {
			}
		});
	}

	$(function() {
		init();
		$("#save_daily_report").on("click", saveDailyReport);
		/* 프린트 출력 */
		$('#download_pdf').click(function() {
			  window.print();
		});
	});
</script>

