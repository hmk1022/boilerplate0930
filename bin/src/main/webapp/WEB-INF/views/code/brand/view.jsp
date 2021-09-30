<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE LEVEL HTML ================== -->
<h1 class="page-header">브랜드<span class="ms-3 fw-bold">코드관리</span></h1>

<div class="row">
    <div class="col-12 mb-3">
        <div class="card">
            <div class="card-body ">
                <div class="row">

					<div class="col-md-4 col-12">
						<label class="form-label text-muted">브랜드명</label>
						<h5>${data.brand_name }</h5>		
					</div>
<hr>
					<div class="col-md-12 col-12">
						<label class="form-label text-muted">사용여부</label>
						<h5 class="del_yn">${data.del_yn }</h5>
					</div>	
<hr>
					<div class="col-md-12 col-12">
						<label class="form-label text-muted">설명</label>
						<h5>${data.remarks }</h5>
					</div>
<hr>
					<div class="col-md-12 col-12">
						<label class="form-label text-muted">URL</label>
						<h5>${data.brand_url }</h5>
					</div>					
				</div>
			</div>
		</div>
		
		<div class="d-flex justify-content-center mt-4">
        	<button 
			    type="button" 
			    class="btn btn-secondary" 
			    name="_button_page_list" 
			    data-to_url="/code/brand/list"
			    >list</button>
            <button class="btn btn-primary ms-2" id="move_edit" data-brand_no="${data.brand_no }">edit</button>
        </div>
	</div>
</div>
<!-- ================== END PAGE LEVEL HTML ================== -->
	
<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<!-- ================== END PAGE LEVEL JS ================== -->
	
<script>
	/* init page */
	$(function(){
		console.log('page script !!!! ');
		console.log('테스트!!!');
		/* save data */
		$("#move_edit").on("click", function(e){
			let param = {brand_no: $(this).data("brand_no")}
			postPage("/code/brand/form", param);
		});
		
		
		let del_yn = $('.del_yn').text();
		
		if(del_yn == 'Y') $('.del_yn').text('사용');
		else  $('.del_yn').text('미사용');
		
		
	});
</script>