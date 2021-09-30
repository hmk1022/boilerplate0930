<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- contents -->
<div class="card">
	<div class="card-header">
		<div class="d-flex align-items-center justify-content-between">
			<h3>작업을 취소하는 이유는 무엇인가요!</h3>
		</div>
	</div>
	<div class="card-body">
		<form name="frm" id="frm">
			<input type="hidden" name="work_no" value="${param.work_no }" />
			<input type="hidden" name="reject_type" id="reject_type" value="03" />
			<input type="hidden" name="reject_gb" id="reject_gb" value="01" />
			<div class="col-md-12 col-12 mb-4">
				<tags:code-radio codeList="${reject_code_list }" checked="" name="reject_cd" required="true" initValue="01" />
			</div>
			<h4>상세 사유 입력 (선택)</h4>
			<div class="input-group">
				<textarea rows="5" class="form-control" name="reject_content" id="reject_content"></textarea>
			</div>
		</form>

		<div class="btn-box floating fixed2">
			<button type="button" class="btn btn-primary" id="save_reject">작업 취소하기</button>
		</div>
	</div>
</div>
<!-- contents -->


<!-- scripts -->
<script>
	$(function() {
		console.log('취소 팝!!!');
		$(".form-check-inline").addClass("mt-2");
		$(".form-check-inline").removeClass("form-check-inline");
		$("#save_reject").on("click", function() {
			cancelWork();
		});

	});

	function cancelWork() {
		console.log("=== cancelWork");

		if ($("[name=reject_cd]:checked").val() == undefined) {
			alert("취소사유를 선택해주세요");
			return;
		}

		if (!confirm("작업취소 하시겠습니까?"))
			return;
		const _name = "작업 취소"; // ajax name
		const _url = "/abc/work/cancel/ajax"; // ajax url
		let _param = $("#frm").serializeObject();	// ajax param

		Utils.requestAjax(_name, _url, _param, {
			beforeSend : function() {
			},
			success : function(data) {
				pageRefresh("/abc/work/view", {
					"work_no" : "${param.work_no}",
					"tab" : "#memo_view"
				});
				alert(Message.SAVE);
			},
			complete : function(response) {
			}
		});
	}
</script>