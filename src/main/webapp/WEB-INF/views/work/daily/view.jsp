<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
                                    <div class="d-flex align-items-center justify-content-between mb-3">
                                        <h4 class="mb-0">작업일지</h4>
                                    </div>
									<c:choose>
										<c:when test="${!empty dailyReportList }">
											<c:forEach var="dailyReportData" items="${dailyReportList }" varStatus="cnt">
			                                    <div class="card mb-2">
			                                        <div class="card-body">
			                                            <div class="row">
			                                                <div class="col-md-3 col-6">
			                                                    <label class="form-label text-muted">날짜</label>
			                                                    <h5>${dailyReportData.st_date_ymd } (${dailyReportData.day_of_week })</h5>
			                                                </div>
			                                                <div class="col-md-3 col-6">
			                                                    <label class="form-label text-muted">집행비용</label>
			                                                    <h5><c:if test="${dailyReportData.admin_name ne null}"><tags:code-currency value="${dailyReportData.excute_price }"/></c:if></h5>
			                                                </div>
			                                                <div class="col-md-3 col-6">
			                                                    <label class="form-label text-muted">작성자</label>
			                                                    <h5>${dailyReportData.admin_name }</h5>
			                                                </div>
			                                            </div>
			                                        </div>
			                                        <div class="card-footer d-flex justify-content-end">
			                                            <button class="btn btn-gray" onclick="popDailyReport('${dailyReportData.st_date_ymd }','(${dailyReportData.day_of_week })','${dailyReportData.daily_report_no}');">작성</button>
			                                        </div>
			                                    </div>
											</c:forEach>
										</c:when>
										<c:otherwise>
												<div class="border p-2 rounded my-3 bg-default">일정이 존재 하지않습니다.</div>
										</c:otherwise>
									</c:choose>


                                    <hr>
                                    <h5>
                                        <i class="fas fa-lg fa-fw fa-info-circle"></i>
                                        사용 가이드</h5>
                                    <ul class="mb-0">
                                        <li>[하위작업 및 일정관리] 탭에서 일정을 등록한 날짜만 작업일지를 작성 및 수정할 수 있습니다.</li>
                                        <li>비용등록, 자재요청서, 지출결의서 등록 시 입력한 일정에 자동으로 집행 비용이 산정됩니다.</li>
                                        <li>각 날짜별로 누락된 금액이 있을 경우 [비용등록] 또는 [지출결의서] 등록을 통해 비용을 추가하세요.</li>
                                    </ul>
<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<form name="frm_daily_report" id="frm_daily_report" target="_dailyReport" action="/popup/dailyReport/form" method="POST">
	<input type="hidden" name="work_no" value="${param.work_no}">
	<input type="hidden" name="report_date" id="report_date" value="">
	<input type="hidden" name="day_of_week" id="day_of_week" value="">
	<input type="hidden" name="daily_report_no" id="daily_report_no" value="">
</form>
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

<script>
	var curPage;
    function popDailyReport(report_date,day_of_week,daily_report_no) {
    	const _url = "/popup/dailyReport/form";	// ajax url
		let _form = $("#frm_daily_report");	// form name
		$("#report_date").val(report_date);
		$("#day_of_week").val(day_of_week);
		$("#daily_report_no").val(daily_report_no);
        var popup = window.open('', '_dailyReport', 'width=1400px,height=max,scrollbars=yes');
        _form.submit();
    }
	/* init page */
	$(function(){


	});

</script>