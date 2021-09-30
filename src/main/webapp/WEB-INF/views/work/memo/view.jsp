<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<form class="form-horizontal form-bordered" name="viewFrm" id="viewFrm">
			<input type="hidden" name="work_no" value="${workList.work_no }">
	<div class="mb-5">
	    <div class="d-flex align-items-center justify-content-between mb-3">
	        <h4 class="mb-0">고객 요청사항</h4>
	        <button type="button" class="btn btn-gray" id="saveReqContent">수정</button>
	    </div>
	    <textarea rows="6" class="form-control" disabled id="req_content" name="req_content">${workList.req_content }</textarea>
	</div>
	<div class="mb-5">
	    <h4 class="mb-3">관리자 메모</h4>
	    <div class="input-group">
			<input class="form-control " type="text" id="memo" name="memo" value="" placeholder="메모 입력" data-parsley-required="true" data-parsley-error-message="관리자메모를 정확히 입력하세요." data-parsley-errors-container="#validation_error" >
	        <a href="#" class="btn btn-primary btn-save-memo" id="save_memo">등록</a>
	        <div class="invalid-feedback">메모를 입력하세요.</div>
	    </div>
	    <div id="validation_error"></div>
	    <c:choose>
			<c:when test="${!empty adminMemoList }">
				<c:forEach var="data" items="${adminMemoList }" varStatus="cnt">
					<div class="border p-2 rounded my-3 bg-default">
				        <span class="memo_date"><tags:str-datetime value="${data.create_date}"/></span> |<span> ${data.admin_name }</span>
				        <h6>${data.memo }</h6>
				    </div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="border p-2 rounded my-3 bg-default">등록된 메모가 없습니다.</div>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="mb-5">
	    <h4 class="mb-3">워커맨 메모</h4>
		<c:choose>
			<c:when test="${!empty workermanMemoList }">
				<c:forEach var="data" items="${workermanMemoList }" varStatus="cnt">
					<div class="border p-2 rounded my-3 bg-default">
				        <p><tags:str-datetime value="${data.create_date }"/> | ${data.admin_name }</p>
				        <h6>${data.memo }</h6>
				    </div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="border p-2 rounded my-3 bg-default">등록된 메모가 없습니다.</div>
			</c:otherwise>
		</c:choose>

	</div>
	<div class="">
		<h4 class="mb-3">작업 이미지</h4>
		<tags:image imageList="${imageList}"
			emptyMsg="등록된 이미지가 없습니다."
		/>
	</div>
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

	/* init page */
	$(function(){
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

                const _name = "고객요청사항 수정";	// ajax name
    			const _url = "/abc/work/reqContent/save/ajax";	// ajax url
    			let _param = {"work_no":${workList.work_no },"req_content":$("#req_content").val()}
    			Utils.requestAjax(_name, _url, _param, {
    				beforeSend: function(){},
    	            success:  function(data) {
    		          	alert(Message.SAVE);
    		          	$('a[href="#memo_view"]').trigger("click");
    	            },
    	            complete:  function(response) {}
    			});
        	}


        });
		/* save data */
		$("#save_memo").on("click", function(e){
			const _name = "관리자메모 저장";	// ajax name
			const _url = "/abc/work/memo/save/ajax";	// ajax url
			const _form = "viewFrm";	// form name

			let validate = $("#viewFrm").parsley().validate();

			if(!validate) {
				console.log('# validate false !!!');
				return;
			}
			let _param = $("#viewFrm").serializeObject();	// ajax param
			console.log(_param);
			Utils.requestAjax(_name, _url, _param, {
				beforeSend: function(){},
	            success:  function(data) {
		          	alert(Message.SAVE);
		          	//movePage("/code/customer/branch/index");
		          	$('a[href="#memo_view"]').trigger("click");
	            },
	            complete:  function(response) {}
			});


		});

	});

</script>