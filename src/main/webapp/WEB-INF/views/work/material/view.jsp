<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
                                    <div class="mb-5">
                                        <div class="d-flex align-items-center justify-content-between mb-3">
                                            <h4 class="mb-0">자재요청내역</h4>
                                            <c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
                                            <button type="button" class="btn btn-primary" onclick="popMaterial()">자재요청</button>
                                            </c:if>
                                        </div>
										<c:choose>
											<c:when test="${!empty materialDocList }">
												<c:forEach var="materialDocData" items="${materialDocList }" varStatus="cnt">
												<c:set var="materialReqCnt" value="${materialDocData.cnt-1}"/>
			                                        <div class="card mb-2">
			                                            <div class="card-body">
			                                                <div class="row">
			                                                    <div class="col-md-2 col-6">
			                                                        <label class="form-label text-muted">문서번호</label>
			                                                        <h5>${materialDocData.material_doc_id }</h5>
			                                                    </div>
			                                                    <div class="col-md-2 col-6">
			                                                        <label class="form-label text-muted">사용일</label>
			                                                        <h5>${materialDocData.use_date }</h5>
			                                                    </div>
			                                                    <div class="col-md-2 col-6">
			                                                        <label class="form-label text-muted">요청자재</label>
			                                                        <h5>${materialDocData.material_name } <c:if test="${materialReqCnt > 0}"> 외 ${materialReqCnt}건</c:if></h5>
			                                                    </div>
			                                                    <div class="col-md-2 col-6">
			                                                        <label class="form-label text-muted">요청자</label>
			                                                        <h5>${materialDocData.doc_admin_name }</h5>
			                                                    </div>
			                                                    <div class="col-md-2 col-6">
			                                                        <label class="form-label text-muted">수령방법</label>
			                                                        <h5><tags:code-name code_gb="receive_type" value="${materialDocData.receive_type }"/></h5>
			                                                    </div>
			                                                    <div class="col-md-2 col-6">
			                                                        <label class="form-label text-muted">작성일</label>
			                                                        <h5>${materialDocData.create_date }</h5>
			                                                    </div>
			                                                </div>
			                                            </div>
			                                            <div class="card-footer d-flex align-items-center justify-content-between">
			                                                <h5 class="mb-0 text-muted"><tags:code-name code_gb="doc_stat" value="${materialDocData.doc_stat }"/></h5>
			                                                <button type="button" class="btn btn-gray ms-2" onclick="popMaterialDoc('${materialDocData.material_doc_no }')">상세</button>
			                                            </div>
			                                        </div>
                                        		</c:forEach>
											</c:when>
											<c:otherwise>
													<div class="border p-2 rounded my-3 bg-default">자재요청 내역이 존재 하지않습니다.</div>
											</c:otherwise>
										</c:choose>
                                    </div>
									<div class="d-flex align-items-center justify-content-between mb-3">
                                            <h4 class="mb-0"></h4>
                                            <c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
                                            <button type="button" class="btn btn-primary" onclick="popMaterial()">자재요청</button>
                                            </c:if>
                                        </div>
                                    <div class="">
                                        <h4 class="mb-3">사용자재목록</h4>

                                        <div class="table-responsive">
                                            <table class="table table-striped ">
                                                <thead>
                                                    <tr>
                                                        <th>요청번호</th>
                                                        <th>품번</th>
                                                        <th>품명</th>
                                                        <th>수량</th>
                                                        <th>단가</th>
                                                        <th>금액</th>
                                                        <th>사용일</th>
                                                        <th>상태</th>
                                                        <th>등록일</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
													<c:choose>
														<c:when test="${!empty materialReqList }">
															<c:forEach var="materialReqData" items="${materialReqList }" varStatus="cnt">
			                                                    <tr>
			                                                        <td><a href="#" onclick="popMaterialDoc('${materialReqData.material_doc_no }')">${materialReqData.material_doc_id }</a></td>
			                                                        <td>${materialReqData.material_id }</td>
			                                                        <td class="text-start">${materialReqData.material_name }</td>
			                                                        <td>${materialReqData.material_cnt }</td>
			                                                        <td class="text-end"><tags:code-currency value="${materialReqData.purchased_price }"/></td>
			                                                        <td class="text-end fw-bold"><tags:code-currency value="${materialReqData.purchased_price * materialReqData.material_cnt }"/></td>
			                                                        <td>${materialReqData.use_date }</td>
			                                                        <td><tags:code-name code_gb="req_stat" value="${materialReqData.req_stat }"/></td>
			                                                        <td>${materialReqData.create_date }<br/>${materialReqData.reg_admin_name }</td>
                                                    </tr>
			                                        		</c:forEach>
														</c:when>
														<c:otherwise>
																<div class="border p-2 rounded my-3 bg-default">자재요청 내역이 존재 하지않습니다.</div>
														</c:otherwise>
													</c:choose>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
<form name="frm_material" id="frm_material" target="_material" action="/popup/material/form" method="POST">
	<input type="hidden" name="work_no" value="${param.work_no}">
</form>
<form name="frm_material_doc" id="frm_material_doc" target="_materialDoc" action="/popup/material/view" method="POST">
	<input type="hidden" name="material_doc_no" id="material_doc_no">
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

    function popMaterial() {
		let _form = $("#frm_material");	// form name
        var popup = window.open('', '_material', 'width=1200px,height=1000px,scrollbars=yes');
        _form.submit();
    }
    function popMaterialDoc(material_doc_no) {
		let _form = $("#frm_material_doc");	// form name
        var popup = window.open('', '_materialDoc', 'width=1000px,height=1000px,scrollbars=yes');
		$("#material_doc_no").val(material_doc_no);
        _form.submit();
    }
	/* init page */
	$(function(){

	});

</script>