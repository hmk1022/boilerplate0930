<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE LEVEL HTML ================== -->
<h1 class="page-header">자재마스터 <span class="ms-3 fw-bold">자재관리</span></h1>

<div class="row">
    <div class="col-12 mb-3">
        <div class="card">
            <div class="card-body ">
            	<!-- tabs -->
				<ul class="nav nav-pills">
                    <li class="nav-item">
                        <a href="#default-tab-1" data-toggle="tab" class="nav-link active">자재정보</a>
                    </li>
                    <li class="nav-item">
                        <a href="#default-tab-2" data-toggle="tab" class="nav-link">재고현황</a>
                    </li>
                    <!-- <li class="nav-item">
                        <a href="#default-tab-3" data-toggle="tab" class="nav-link">연결된시공</a>
                    </li> -->
                </ul>
				<!-- tab-1 -->
				<div class="tab-content bg-white p-3">
                	<div class="tab-pane fade active show" id="default-tab-1">
                	    <!-- <div class="d-flex align-items-center justify-content-between mb-3">
                         	<h4 class="mb-0">자재정보</h4>
                        </div>  -->   
		                <div class="row">
		                	<div class="col-md-3 col-12 mt-3">
								<label class="form-label text-muted">제품ID</label>
								<h5>${data.material_id }</h5>
							</div>		  
		                    <div class="col-md-3 col-12 mt-3">
								<label class="form-label text-muted">랙번호</label>
								<h5>${data.rack_id }</h5>
							</div>								
		                	<div class="col-md-3 col-12 mt-3">
								<label class="form-label text-muted">분류</label>
								<h5>
								<c:if test="${not empty data.cate3_name }">
								${data.cate1_name } > ${data.cate2_name } > ${data.cate3_name }
								</c:if>
								</h5>
							</div>
							<hr>
		                	<div class="col-md-6 col-12 mt-3">
								<label class="form-label text-muted">상품명</label>
								<h5>${data.material_name }</h5>
							</div>
		                	<div class="col-md-6 col-12 mt-3">
								<label class="form-label text-muted">관리명</label>
								<h5>${data.house_name }</h5>
							</div>
							<hr>
		                	<div class="col-md-3 col-12">
								<label class="form-label text-muted">브랜드</label>
								<h5>${data.brand_name }</h5>
							</div>						
							<div class="col-md-3 col-12 mt-3">
								<label class="form-label text-muted">모델명</label>
								<h5>${data.model_name }</h5>
							</div>
		                	<div class="col-md-3 col-12 mt-3">
								<label class="form-label text-muted">단위</label>
								<h5><tags:code-name code_gb="unit_cd" value="${data.unit_cd}"/></h5>
							</div>					
						<hr>
							<div class="col-md-3 col-12">
								<label class="form-label text-muted">단가</label>
								<h5 comma>${data.purchased_price }</h5>
							</div>
		                    <div class="col-md-3 col-12">
								<label class="form-label text-muted">워커맨공급가</label>
								<h5 comma>${data.workerman_price }</h5>
							</div>
		                    <div class="col-md-3 col-12">
								<label class="form-label text-muted">복수시공가</label>
								<h5 comma>${data.multi_price }</h5>
							</div>
		                    <div class="col-md-3 col-12">
								<label class="form-label text-muted">시장가</label>
								<h5 comma>${data.sale_price }</h5>
							</div>
							<hr>			
		                	<div class="col-md-6 col-12">
								<label class="form-label text-muted">Link</label>
								<h5><a href="#" onclick="newPage('${data.material_link }')" target="_brank">${data.material_link }</a></h5>
							</div>
		                	<div class="col-md-6 col-12">
								<label class="form-label text-muted">Link</label>
								<h5><a href="#" onclick="newPage('${data.material_link1 }')" target="_brank">${data.material_link1 }</a></h5>
							</div>
		<hr>					
		
		                	<div class="col-md-12 col-12">
								<label class="form-label text-muted">자재 이미지</label>
								<h5>
								<tags:image imageList="${imageList}"
									emptyMsg="등록된 이미지가 없습니다."
								/>
								</h5>
							</div>
		<hr>					 
		                    <div class="col-md-3 col-12">
								<label class="form-label text-muted">비고</label>
								<h5>${data.remarks }</h5>
							</div>
		<hr>				                
		                    <div class="col-md-3 col-12">
								<label class="form-label text-muted">고객노출 유무</label>
								<h5>${data.member_open_yn eq 'Y'?'노출':'비노출'}</h5>
							</div>
<%-- 
		                    <div class="col-md-3 col-12">
								<label class="form-label text-muted">물류창고 수량</label>
								<h5>${data.house_cnt }</h5>
							</div>
		                    <div class="col-md-3 col-12">
								<label class="form-label text-muted">성수SBA 수량</label>
								<h5>${data.sba_cnt }</h5>
							</div>
						 --%>



<%--							
		<hr>					               
		                    <div class="col-md-3 col-12">
								<label class="form-label text-muted">입고확인자</label>
								<h5>${data.confirm_admin_no }</h5>
							</div>               
		                    <div class="col-md-3 col-12">
								<label class="form-label text-muted">입고확인일</label>
								<h5>${data.confirm_date }</h5>
							</div>
 --%>
							
						</div>
						
						<!-- 수정버튼 -->
						<div class="d-flex justify-content-center mt-4">
							<!-- 
				        	<button 
							    type="button" 
							    class="btn btn-secondary" 
							    name="_button_page_list" 
							    data-to_url="/material/list">list</button>
							 -->
							<button 
							    type="button" 
							    class="btn btn-secondary" 
								onclick="javasciprt:backListPage()"	
						    >list</button>
				            <button class="btn btn-primary ms-2" id="move_edit" data-material_no="${data.material_no }">edit</button>
				        </div>
						<!-- 수정버튼 -->
					</div>
					
					<div class="tab-pane fade " id="default-tab-2"> 
					    <!-- <div class="d-flex align-items-center justify-content-between mb-3">
                                <h4 class="mb-0">재고현황</h4>
                                <button class="btn btn-outline-primary" onclick="pop_OPEN('workmaster_popup3');">비용등록</button>
                        </div> --> 
						<div class="row">
		                	<div class="col-md-3 col-12 mt-3">
								<label class="form-label text-muted">현 재고</label>
								<h5>${data.house_cnt } / ${data.sba_cnt } / ${data.vehicle_cnt }</h5>
							</div>
		                	<div class="col-md-3 col-12 mt-3">
								<label class="form-label text-muted">단가</label>
								<h5 comma>${data.purchased_price }</h5>
							</div>
		                	<div class="col-md-3 col-12 mt-3">
								<label class="form-label text-muted">자산금액</label>
								<h5 comma>${(data.house_cnt + data.sba_cnt + data.vehicle_cnt) * data.purchased_price }</h5>
							</div>
						</div>
						<!-- 자재변동 내역 -->
						<hr>
						<div class="">
                            <div class="d-flex align-items-center justify-content-between mb-3">
                                <h4 class="mb-0">재고 변동 내역</h4>
                                <!-- <button class="btn btn-outline-primary" onclick="pop_OPEN('workmaster_popup3');">비용등록</button> -->
                            </div>
                            <div class="table-responsive">
                                <table class="table table-striped ">
                                    <thead>
                                        <tr>
                                            <th>유형</th>
                                            <th>일자</th>
                                            <th>내역</th>
                                            <th>수령방법</th>
                                            <th>수량(과천)</th>
                                            <th>수량(SBA)</th>
                                            <th>르노(마포)</th>
                                            <th>사유</th>
                                            <th>전표</th>
                                        </tr>
                                    </thead>
                                    <tbody>
				                    <c:forEach items="${inoutList }" var="item">
				                        <tr>
				                            <td><tags:code-name code_gb="bound_type" value="${item.bound_type}"/></td>
				                            <td><tags:str-date value="${item.bound_date}"/></td>
				                            <c:if test="${ item.bound_type eq '01'}">
				                            <td><tags:code-name code_gb="income_type" value="${item.income_type}"/></td>
				                            <td><tags:code-name code_gb="receive_type" value="${item.bound_locate}"/></td>
				                            <td style="text-align:right;font-weight: bold;color:blue">
				                            <c:choose>
				                            	<c:when test="${item.bound_locate eq '01'}"> ${item.house_bound_cnt}</c:when><c:otherwise> - </c:otherwise>
				                            </c:choose>
				                            </td>
				                            <td style="text-align:right;font-weight: bold;color:blue">
				                            <c:choose>
				                            	<c:when test="${item.bound_locate eq '02'}"> ${item.sba_bound_cnt}</c:when><c:otherwise> - </c:otherwise>
				                            </c:choose>
				                            </td>
				                            <td style="text-align:right;font-weight: bold;color:blue">
				                            <c:choose>
				                            	<c:when test="${item.bound_locate eq '05'}"> ${item.vehicle_cnt}</c:when><c:otherwise> - </c:otherwise>
				                            </c:choose>
				                            </td>
				                            </c:if>
				                            <c:if test="${ item.bound_type eq '02'}">
				                            <td><tags:code-name code_gb="out_type" value="${item.out_type}"/></td>
				                            <td><tags:code-name code_gb="receive_type" value="${item.bound_locate}"/></td>
				                            <td style="text-align:right;font-weight: bold;color:red">
				                            <c:choose>
				                            	<c:when test="${item.bound_locate eq '01'}"> ${item.house_bound_cnt}</c:when><c:otherwise> - </c:otherwise>
				                            </c:choose>
											</td>
				                            <td style="text-align:right;font-weight: bold;color:red">
				                            <c:choose>
				                            	<c:when test="${item.bound_locate eq '02'}"> ${item.sba_bound_cnt}</c:when><c:otherwise> - </c:otherwise>
				                            </c:choose>
											</td>
				                            <td style="text-align:right;font-weight: bold;color:red">
				                            <c:choose>
				                            	<c:when test="${item.bound_locate eq '05'}"> ${item.vehicle_cnt}</c:when><c:otherwise> - </c:otherwise>
				                            </c:choose>
											</td>
				                            </c:if>
				                            <td>${item.etc_remarks }</td>
				                            <td>${item.material_bound_id }</td>
				                        </tr>
				                    </c:forEach>                                    
									<c:if test="${empty inoutList }">
										<tr>
				                            <td colspan="9">조회된 데이터가 없습니다.</td>
				                        </tr>
									</c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
						<!-- 자재변동 내역 -->
					</div>

					<%--
  					<div class="tab-pane fade " id="default-tab-3">
						<div class="">
                            <div class="d-flex align-items-center justify-content-between mb-3">
                                <h4 class="mb-0">연결된 시공</h4>
                                <!-- <button class="btn btn-outline-primary" onclick="pop_OPEN('workmaster_popup3');">비용등록</button> -->
                            </div>
                            <div class="table-responsive">
                                <table class="table table-striped ">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>대분류</th>
                                            <th>중분류</th>
                                            <th>소분류</th>
                                            <th>시공명</th>
                                            <th>사용여부</th>
                                        </tr>
                                    </thead>
                                    <tbody>
				                    <c:forEach items="${docList }" var="item" varStatus="status">
				                        <tr>
				                            <td>${status.count }</td>
				                            <td>${item.cate1_name }</td>
				                            <td>${item.cate2_name }</td>
				                            <td>${item.material_name }</td>
				                            <td>${item.req_name }</td>
				                            <td>-</td>
				                        </tr>
				                    </c:forEach>                                    
									<c:if test="${empty docList }">
										<tr>
				                            <td colspan="6">조회된 데이터가 없습니다.</td>
				                        </tr>
									</c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
					</div>
					 --%>
					
				</div>
			</div>
		</div>
		

	</div>
</div>
<!-- ================== END PAGE LEVEL HTML ================== -->
              
	
	<!-- page script -->
	
<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<!-- ================== END PAGE LEVEL JS ================== -->
	
<script>
	/* init page */
	$(function(){
		console.log('page script !!!! ');
		console.log('테스트!!!');
		/* save data */
		$("#move_edit").on("click", function(e){
			let param = {material_no: $(this).data("material_no")}
			//postPage("/material/form", param);
			goEditPage("/material/form", param);
		});
		
	});
	
	// 자재 이미지 링크.
	function newPage(_url){
		if(!Utils.isEmpty(_url)){
			if(_url.indexOf("http://") == -1 && _url.indexOf("https://") == -1) {
				_url = 'http://' + _url;
			}
			var popup = window.open(_url);
		}
	}
</script>