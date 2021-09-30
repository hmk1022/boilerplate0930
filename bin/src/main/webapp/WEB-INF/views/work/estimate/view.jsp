<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
									<c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
                                    <div class="d-flex align-items-center justify-content-between mb-3">
                                        <h4 class="mb-0">견적서 및 예상실행가</h4>
                                        <button class="btn btn-primary" onclick="popEstimate('');">견적서등록</button>
                                    </div>
                                    </c:if>
									<c:choose>
										<c:when test="${!empty estimateVersionList }">
											<c:forEach var="estimateData" items="${estimateVersionList }" varStatus="cnt">
		                                    <div class="card mb-2">
		                                        <div class="card-body">
		                                            <div class="row">
		                                                <div class="col-md-2 col-6">
		                                                    <label class="form-label text-muted">문서번호</label>
		                                                    <h5>${estimateData.work_id}_${estimateData.version_no}</h5>
		                                                </div>
		                                                <div class="col-md-2 col-6">
		                                                    <label class="form-label text-muted">버전</label>
		                                                    <h5>버전 ${estimateData.version_no}</h5>
		                                                </div>
		                                                <div class="col-md-2 col-6">
		                                                    <label class="form-label text-muted">총 견적금액</label>
		                                                    <h5><tags:code-currency value="${estimateData.total_unit_price}"/></h5>
		                                                </div>
		                                                <%-- <div class="col-md-2 col-6">
		                                                    <label class="form-label text-muted">작성자</label>
		                                                    <h5>${estimateData.version_no}</h5>
		                                                </div> --%>
		                                                <%-- <div class="col-md-2 col-6">
		                                                    <label class="form-label text-muted">작성일</label>
		                                                    <h5>${estimateData.version_no}</h5>
		                                                </div> --%>
		                                                <div class="col-md-2 col-6">
		                                                    <label class="form-label text-muted">승인날짜</label>
		                                                    <h5><tags:code-name code_gb="estimate_stat" value="${estimateData.stat}"/> /${estimateData.apply_date}</h5>
		                                                </div>
		                                            </div>
		                                        </div>
		                                        <div class="card-footer d-flex justify-content-end">
		                                        	<c:if test = "${estimateData.apply_date eq null}">
														<c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
		                                            <button type="button" class="btn btn-warning btn-apply-estimate"  data-version_no="${estimateData.version_no}" data-work_no="${estimateData.work_no}" data-estimate_no="${estimateData.estimate_no}">견적승인</button>
		                                            	</c:if>
		                                            </c:if>
		                                            <c:if test = "${estimateData.apply_date ne null}">
														<c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
		                                            <button type="button" class="btn btn-danger btn-apply-cancel-estimate"  data-version_no="${estimateData.version_no}" data-work_no="${estimateData.work_no}" data-estimate_no="${estimateData.estimate_no}">승인취소</button>
		                                            	</c:if>
		                                            </c:if>
		                                            <button type="button" class="btn btn-success ms-2" onclick="showEstimate('${estimateData.version_no}');">출력</button>
		                                            <c:if test = "${estimateData.apply_date eq null}">
														<c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
			                                            <button type="button" class="btn btn-gray ms-2" onclick="popEstimate('${estimateData.version_no}');">수정</button>
			                                            </c:if>
		                                            </c:if>
		                                        </div>
		                                    </div>
											</c:forEach>
										</c:when>
										<c:otherwise>
												<div class="border p-2 rounded my-3 bg-default">견적서가 존재 하지않습니다.</div>
										</c:otherwise>
									</c:choose>
                                    <hr>
                                    <h5>
                                        <i class="fas fa-lg fa-fw fa-info-circle"></i>
                                        사용 가이드</h5>
                                    <ul class="mb-0">
                                        <li>승인 상태의 견적서의 총 견적금액이 이 작업의 최종 결제금액으로 설정됩니다.</li>
                                        <li>최종 결제금액을 바꿔야하는 경우 견적서를 새로운 버전으로 작성하여 승인처리 하세요.</li>
                                        <li>견적작성 시 예상실행가를 함께 입력하여 예상차액 및 마진율을 보며 작성할 수 있습니다.</li>
                                    </ul>
<form name="frm_estimate" id="frm_estimate" target="_estimate" action="/popup/estimate/form" method="POST">
	<input type="hidden" name="work_no" value="${param.work_no}">
	<input type="hidden" name="version_no" id="version_no">
</form>
<form name="show_estimate" id="show_estimate" target=_show_estimate action="/popup/estimate/view" method="POST">
	<input type="hidden" name="work_no" value="${param.work_no}">
	<input type="hidden" name="version_no" id="version_no2" >
</form>

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

<script>
	var curPage;

    function popEstimate(version_no) {
		let _form = $("#frm_estimate");	// form name
        var popup = window.open('', '_estimate', 'width=max,height=max,scrollbars=yes');
		$("#version_no").val(version_no);
        _form.submit();
    }
    function showEstimate(version_no) {
		let _form = $("#show_estimate");	// form name
        var popup = window.open('', '_show_estimate', 'width=1400px,height=max,scrollbars=yes');
		$("#version_no2").val(version_no);
        _form.submit();
    }

	function applyEstimate(){
		console.log("=== applyEstimate");
		if(!confirm("승인하시겠습니까?")) return;
		const _name = "견적서 승인";	// ajax name
		const _url = "/abc/work/estimate/apply/ajax";	// ajax url
		let _param = {work_no : $(this).data("work_no"),estimate_no : $(this).data("estimate_no"),version_no : $(this).data("version_no")};
		Utils.requestAjax(_name, _url, _param, {
			beforeSend: function(){},
            success:  function(data) {
        		pageRefresh("/abc/work/view",{"work_no":"${param.work_no}","tab":"#estimate_view"});
	          	alert(Message.SAVE);
            },
            complete:  function(response) {
            }
		});
	}

	function applyCancelEstimate(){
		console.log("=== applyCancelEstimate");
		if(!confirm("승인취소하시겠습니까?")) return;
		const _name = "견적서 승인취소";	// ajax name
		const _url = "/abc/work/estimate/applyCancel/ajax";	// ajax url
		let _param = {work_no : $(this).data("work_no"),estimate_no : $(this).data("estimate_no"),version_no : $(this).data("version_no")};
		Utils.requestAjax(_name, _url, _param, {
			beforeSend: function(){},
            success:  function(data) {
        		pageRefresh("/abc/work/view",{"work_no":"${param.work_no}","tab":"#estimate_view"});
	          	alert(Message.SAVE);
            },
            complete:  function(response) {
            }
		});
	}
	/* init page */
	$(function(){
		$(".btn-apply-estimate").on("click",applyEstimate);
		$(".btn-apply-cancel-estimate").on("click",applyCancelEstimate);
	});

</script>