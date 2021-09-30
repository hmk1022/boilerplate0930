<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
                                    <h4 class="mb-3">완료보고서</h4>
									<div class="client-form">
	                                    <div class="card mb-2">
	                                        <div class="card-body">
	                                            <div class="row">
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">문서번호</label>
	                                                    <h5>-</h5>
	                                                </div>
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">버전</label>
	                                                    <h5>고객사 전송용</h5>
	                                                </div>
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">작성자</label>
	                                                    <h5>-</h5>
	                                                </div>
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">작성일</label>
	                                                    <h5>작성 전</h5>
	                                                </div>
	                                            </div>
	                                        </div>
	                                        <c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
	                                        <div class="card-footer d-flex justify-content-end">
	                                            <button class="btn btn-success" onclick="popClientReportForm('${workData.version_no}')" >작성</button>
	                                        </div>
	                                        </c:if>
	                                    </div>
									</div>
									<div class="in-form">
	                                    <div class="card mb-2 report-in-form">
	                                    <!-- 이미 작성했다면 postData로 조건부 렌더링 걸어주자 -->
	                                    	<div class="card-body">
	                                            <div class="row">
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">문서번호</label>
	                                                    <h5>${exp_memo.work_no}</h5>
	                                                </div>
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">버전</label>
	                                                    <h5>내부 보고용</h5>
	                                                </div>
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">작성자</label>
	                                                    <h5>-</h5>
	                                                </div>
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">작성일</label>
	                                                    <h5>작성 전</h5>
	                                                </div>
	                                            </div>
	                                        </div>
	                                        <div class="card-footer d-flex justify-content-end">
	                                            <button class="btn btn-success" onclick="popInterReportForm('${workData.version_no}')">작성</button>
	                                        </div>
	                                    </div>
									</div>
									<div class="client-view">
	                                    <div class="card mb-2">
	                                        <div class="card-body">
	                                            <div class="row">
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">문서번호</label>
	                                                    <h5>${exp_memo.work_no}</h5>
	                                                </div>
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">버전</label>
	                                                    <h5>고객사 전송용</h5>
	                                                </div>
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">작성자</label>
	                                                    <h5>${data.manager_admin_name }</h5>
	                                                </div>
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">작성일</label>
	                                                    <h5>${clientReport.create_day }(${clientReport.day_of_week })</h5>
	                                                </div>
	                                            </div>
	                                        </div>
	                                        <div class="card-footer d-flex justify-content-end">
	                                            <button class="btn btn-primary" onclick="popClientReport('${workData.version_no}')">보기</button>
	                                            <c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
	                                            <button class="btn btn-gray ms-2" onclick="popClientReportPost('${workData.version_no}')">수정</button>
	                                            </c:if>
	                                        </div>
	                                    </div>
									</div>
									<div class="in-view">
	                                    <div class="card mb-2">
	                                        <div class="card-body">
	                                            <div class="row">
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">문서번호</label>
	                                                    <h5>${clientReport.work_no }</h5>
	                                                </div>
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">버전</label>
	                                                    <h5>내부 보고용</h5>
	                                                </div>
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">작성자</label>
	                                                    <h5>${data.manager_admin_name }</h5>
	                                                </div>
	                                                <div class="col-md-3 col-6">
	                                                    <label class="form-label text-muted">작성일</label>
	                                                    <h5>${exp_memo.create_day}(${exp_memo.day_of_week })</h5>
	                                                </div>
	                                            </div>
	                                        </div>
	                                        <div class="card-footer d-flex justify-content-end">
	                                            <button class="btn btn-primary" onclick="popInterReport('${workData.version_no}')">보기</button>
	                                            <c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
	                                            <button class="btn btn-gray ms-2" onclick="popInterReportPost('${workData.version_no}')">수정</button>
	                                            </c:if>
	                                        </div>
	                                    </div>
									</div>
                                    <hr>
                                    <h5>
                                        <i class="fas fa-lg fa-fw fa-info-circle"></i>
                                        사용 가이드</h5>
                                    <ul class="mb-0">
                                        <li>완료보고서는 고객전송용, 내부보고용 두가지 버전으로 제공됩니다.</li>
                                        <li>[작성] 버튼을 눌러 세부 내용을 작성 완료해야 전송용 버전의 문서가 제공됩니다.</li>
                                    </ul>
<!-- 완료보고서 고객사용 작성 -->
<form name="frm_client_report_form" id="frm_client_report_form" target="_client_report_form" action="/popup/report/client/form" method="POST">
	<input type="hidden" name="work_no" value="${workData.work_no}">
	<input type="hidden" name="version_no" id="version_no">
</form>
<!-- 완료보고서 고객사용 수정 -->
<form name="frm_client_report_post" id="frm_client_report_post" target="_client_report_post" action="/popup/report/client/post" method="POST">
	<input type="hidden" name="work_no" value="${workData.work_no}">
	<input type="hidden" name="version_no" id="version_no">
</form>
<!-- 완료보고서 고객사용(이미지) 작성 -->
<form name="frm_client_img_report_form" id="frm_client_img_report_form" target="_client_img_report_form" action="/popup/report/client/form" method="POST">
	<input type="hidden" name="work_no" value="${workData.work_no}">
	<input type="hidden" name="version_no" id="version_no">
</form>
<!-- 완료보고서 고객사용 -->
<form name="frm_client_report_view" id="frm_client_report_view" target="_client_report_view" action="/popup/report/client/view" method="POST">
	<input type="hidden" name="work_no" value="${workData.work_no}">
	<input type="hidden" name="version_no" id="version_no">
</form>
<!-- 완료보고서 내부용 작성 -->
<form name="frm_inter_report_form" id="frm_inter_report_form" target="_inter_report_form" action="/popup/report/inter/form" method="POST">
	<input type="hidden" name="work_no" value="${workData.work_no}">
	<input type="hidden" name="version_no" id="version_no">
</form>
<!-- 완료보고서 내부용 수정 -->
<form name="frm_inter_report_post" id="frm_inter_report_post" target="_inter_report_post" action="/popup/report/inter/post" method="POST">
	<input type="hidden" name="work_no" value="${workData.work_no}">
	<input type="hidden" name="version_no" id="version_no">
</form>
<!-- 완료보고서 내부용 보기 -->
<form name="frm_inter_report" id="frm_inter_report" target="_inter_report" action="/popup/report/inter/view" method="POST">
	<input type="hidden" name="work_no" value="${workData.work_no}">
	<input type="hidden" name="version_no" id="version_no2">
</form>
<input type="hidden" name="clientReport" id="clientReport" value="${clientReport}">
<input type="hidden" name="exp_memo" id="exp_memo" value="${exp_memo}">

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

	function popClientReportForm(version_no) {
		let _form = $("#frm_client_report_form");
	    var popup = window.open('', '_client_report_form', 'width=1400px,height=max,scrollbars=yes');
	    $("#version_no").val(version_no);
	    _form.submit();
	}
	function popClientImgReportForm(version_no) {
		let _form = $("#frm_client_report_view");
	    var popup = window.open('', '_client_img_report_form', 'width=1400px,height=max,scrollbars=yes');
	    $("#version_no").val(version_no);
	    _form.submit();
	}
	function popInterReportForm(version_no) {
		let _form = $("#frm_inter_report_form");	// form name
	    var popup = window.open('', '_inter_report_form', 'width=1400px,height=max,scrollbars=yes');
	    $("#version_no").val(version_no);
	    _form.submit();
	}
	function popInterReportPost(version_no) {
		let _form = $("#frm_inter_report_post");	// form name
	    var popup = window.open('', '_inter_report_post', 'width=1400px,height=max,scrollbars=yes');
	    $("#version_no").val(version_no);
	    _form.submit();
	}
	function popClientReport(version_no) {
		let _form = $("#frm_client_report_view");	// form name
	    var popup = window.open('', '_client_report_view', 'width=1400px,height=max,scrollbars=yes');
	    $("#version_no").val(version_no);
	    _form.submit();
	}
	function popClientReportPost(version_no) {
		let _form = $("#frm_client_report_post");	// form name
	    var popup = window.open('', '_client_report_post', 'width=1400px,height=max,scrollbars=yes');
	    $("#version_no").val(version_no);
	    _form.submit();
	}
	function popInterReport(version_no) {
		let _form = $("#frm_inter_report");	// form name
	    var popup = window.open('', '_inter_report', 'width=1400px,height=max,scrollbars=yes');
	    $("#version_no2").val(version_no);
	    _form.submit();
	}

	/* init page */
	$(function(){

		const in_report = $('#exp_memo').val();
		const client_report = $('#clientReport').val();

		if(in_report) {
			$('.in-form').css('display','none');
		} else {
			$('.in-view').css('display','none');
		}
		if(client_report){
			$('.client-form').css('display','none');
		} else {
			$('.client-view').css('display','none');
		}

        $('#saveReqContent').on('click', function() {
            if ($('#saveReqContent').hasClass('btn-gray')) {
                $('#req_content').attr('disabled', false);
                $('#saveReqContent').removeClass('btn-gray');
                $('#saveReqContent').addClass('btn-primary');
                $('#saveReqContent').text('저장');
                $('#req_content').focus();
            } else {
                $('#req_content').attr('disabled', true);
                $('#saveReqContent').removeClass('btn-primary');
                $('#saveReqContent').addClass('btn-gray');
                $('#saveReqContent').text('수정');
        	}
        });
		/* save data */
		$("#save_memo").on("click", function(e){
			const _name = "관리자메모 저장";	// ajax name
			const _url = "/abc/work/memo/save/ajax";	// ajax url
			const _form = "viewFrm";	// form name

			let validate = $("#frm").parsley().validate();
			/* if(!validate) {
				console.log('# validate false !!!');
				return;
			} */
			let _param = $("#viewFrm").serializeObject();	// ajax param
			console.log(_param);
			Utils.requestAjax(_name, _url, _param, {
				beforeSend: function(){},
	            success:  function(data) {
		          	alert(Message.SAVE);
		          	//movePage("/code/customer/branch/index");
		          	$("#memo_view").trigger("click");
	            },
	            complete:  function(response) {}
			});


		});

	});

</script>