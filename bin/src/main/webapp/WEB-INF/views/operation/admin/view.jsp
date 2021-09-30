<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

	<!-- begin page-header -->
	<h1 class="page-header">계정관리 <span><small><small></<span></h1>
	<!-- end page-header -->
	<!-- begin panel -->
	<div class="row">
    <div class="col-12 mb-3">
        <div class="card">
            <div class="card-body ">
                <div class="row">
					<!-- <form class="form-horizontal form-bordered" data-parsley-validate="true" name="viewFrm" id="frm" novalidate=""> -->
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">이름</label>
						<h5>${data.admin_name }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">아이디</label>
						<h5>${data.admin_id }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">지점명</label>
						<h5 >본사</h5>
					</div>
					<hr>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">부서</label>
						<h5>${data.department_cd } <tags:code-name code_gb="position" value="${data.manager_rank}"/></h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">직책</label>
						<h5>${data.position_name }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">연락처</label>
						<h5 phone>${data.mobile }</h5>
					</div>
					<hr>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">카드번호</label>
						<h5 >${data.card_no }</h5>
					</div>					
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">차량번호</label>
						<h5 >${data.car_no }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">잔디ID</label>
						<h5 >${data.jandi_id }</h5>
					</div>
					<hr>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">상태</label>
						<h5 >${data.stat_cd }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">계정차단</label>
						<h5 class="admin_stat">${data.stat_cd }</h5>
					</div>
					<div class="col-md-4 col-12">
						<label class="form-label text-muted">Mac address</label>
						<h5 class="mac_address">${data.mac_address }</h5>
					</div>
					<hr>
					<%-- <div class="col-md-4 col-12">
						<label class="form-label text-muted">비밀번호 초기화</label>
						<h5 date>${data.deal_start_date }</h5>
					</div> --%>
				<%-- 	<div class="col-md-12 col-12">
						<label class="form-label text-muted">프로필 사진</label>
						<h5>
						<tags:image imageList="${imageList }"
							emptyMsg="등록된 이미지가 없습니다."
						/>
						</h5>
					</div>  --%> 
					
					<div class="col-md-12 col-12">
						<label class="form-label text-muted">프로필 사진</label>
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
		
		
		
<%-- 		<div class="card mt-4">
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
        </div> --%>
            
		<div class="d-flex justify-content-center mt-4">
			<div class="d-flex justify-content-center mt-4">
			    <button 
			    type="button" 
			    class="btn btn-secondary" 
			    name="_button_page_list" 
			    data-to_url="/operation/admin/index">list</button>
        	<%-- <button class="btn btn-primary ms-2" name="movePage" data-url="/code/customer/branch/form?customer_no=${data.customer_no }">지점등록</button> --%>
            <button class="btn btn-primary ms-2" id="move_edit" data-customer_no="${data.admin_name }">edit</button>
        </div>
	</div>
</div>
	<!-- end panel -->


<script>
$(function(){
	console.log('hello');
	
	let admin_stat	= $('.admin_stat').text();
	
	if(admin_stat === '정상'){
		 $('.admin_stat').text('해제');
	} else {
		 $('.admin_stat').text('차단');
	}
	
	
	$("#move_edit").on("click", function(e){
		let param = {admin_id: "${data.admin_id}", w_admin: "01", admin_no : "${data.admin_no}"}
		console.log('테스트!!',param);
		postPage("/operation/admin/form", param);
	});	
});

</script>