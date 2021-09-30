<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

<h1 class="page-header">고객사관리<span class="ms-3 fw-bold">상세보기</span></h1>

<div class="row">
    <div class="col-12 mb-3">
        <div class="card">
            <div class="card-body ">
                <div class="row">
					<!-- <form class="form-horizontal form-bordered" data-parsley-validate="true" name="viewFrm" id="frm" novalidate=""> -->
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">고객사ID</label>
						<h5>${data.customer_id }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">고객사명ID</label>
						<h5>${data.customer_name }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">사업자번호</label>
						<h5 busno>${data.comp_number }</h5>
					</div>
					<hr>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">담당자</label>
						<h5>${data.manager_name } <tags:code-name code_gb="position" value="${data.manager_rank}"/></h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">이메일</label>
						<h5>${data.manager_email }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">연락처</label>
						<h5>${data.manager_hp }</h5>
					</div>
					<hr>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">세금계산서 이메일</label>
						<h5>${data.tax_email }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">거래시작일</label>
						<h5 date>${data.deal_start_date }</h5>
					</div>					
					<div class="col-md-4 col-12"></div>
					<hr>
					<div class="col-md-12 col-12">
						<label class="form-label text-muted">사업자등록증 사본</label>
						<h5>
							<tags:image imageList="${imageList}"
								emptyMsg="등록된 이미지가 없습니다."
							/>
						</h5>
					</div>
					<!-- </form> -->
				</div>
			</div>
		</div>
		
		
		
		<div class="card mt-4">
            <div class="card-header">
                <h3>지점목록</h3>
                <div class="d-flex align-items-center justify-content-between">
                    <!-- <p class="mb-0 small">간단한 가이드 문구가 들어가는 자리</p> -->
                    <!-- <p class="mb-0 small">간단한 가이드 문구가 들어가는 자리</p> -->
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-striped ">
                    <thead>
                        <tr>
                            <th>지점코드</th>
                            <th>지점명</th>
                            <th>현장주소</th>
                            <th>담당자</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${branch }" var="item">
                        <tr>
                            <td>${item.branch_id }</td>
                            <td>${item.branch_name }</td>
                            <td>${item.comp_addr1 }</td>
                            <td>${item.manager_name }</td>
                        </tr>
                    </c:forEach>
					<c:if test="${empty branch }">
		    			<tr>
                            <td colspan=4>등록된 지점이 없습니다.</td>
                        </tr>
					</c:if>                            
                    </tbody>
                </table>
            </div>
        </div>
            
		<div class="d-flex justify-content-center mt-4">
			<div class="d-flex justify-content-center mt-4">
			    <!-- <button 
			    type="button" 
			    class="btn btn-secondary" 
			    name="_button_page_list" 
			    data-to_url="/code/customer/list">list</button> -->
			    <button 
			    type="button" 
			    class="btn btn-secondary" 
				onclick="javasciprt:backListPage()"	
			    >list</button>
        	<button class="btn btn-primary ms-2" name="movePage" data-url="/code/customer/branch/form?customer_no=${data.customer_no }">지점등록</button>
            <button class="btn btn-primary ms-2" id="move_edit" data-customer_no="${data.customer_no }">edit</button>
	        </div>
		</div>
	</div>
</div>

	
<script>
	/* init page */
	$(function(){
		console.log('page script !!!! ');
		console.log('테스트!!!');
		/* save data */
		$("#move_edit").on("click", function(e){
			let param = {customer_no: $(this).data("customer_no")}
			//postPage("/code/customer/form", param);
			goEditPage("/code/customer/form", param);
		});
		
	});
</script>