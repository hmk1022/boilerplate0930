<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

	<!-- begin page-header -->
	<h1 class="page-header">지출결의서 <small>회계관리</small></h1>
	<!-- end page-header -->
	<!-- begin panel -->
	<div class="panel panel-inverse">
		<div class="panel-heading">
			<h4 class="panel-title">지출결의서 목록</h4>
			<%@ include file="/WEB-INF/layout/include/panelHeadingBtn.jsp" %>
		</div>
		<div class="panel-body" style="">
			<form class="form-horizontal form-bordered" data-parsley-validate="true" name="viewFrm" id="frm" novalidate="">

			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="admin_no">기안자 </label>
				<div class="col-md-8 col-sm-8">
					${data.admin_no }
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="department">담당부서 </label>
				<div class="col-md-4 col-sm-8">
					${data.department }
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="disbursement_amt">지출금액 </label>
				<div class="col-md-4 col-sm-8">
					${data.disbursement_amt }
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="disbursement_type">지출비용성격 </label>
				<div class="col-md-4 col-sm-8">
					${data.disbursement_type }
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="disbursement_usage">지출비용용도 </label>
				<div class="col-md-4 col-sm-8">
					${data.disbursement_usage }
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="remark">기타내용 </label>
				<div class="col-md-4 col-sm-8" >
					${data.remark }
				</div>
			</div>			
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="manager_hp">지출일 </label>
				<div class="col-md-4 col-sm-8" >
					${data.disbursement_date }
				</div>
			</div>
			
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="">증빙 영수증</label>
				<!-- image tag -->
				<div class="media media-lg">
					<tags:image imageList="${imageList}"/>
				</div>
			</div> 
			        
			<div class="form-group ">
				<div class="col-sm-14 text-center">
					<button type="button" class="btn btn-primary" id="move_edit" data-disbursement_no="${data.disbursement_no }" >edit</button>
					<button type="button" class="btn btn-grey" name="moveBack">list</button>
				</div>
			</div>
			</form>
		</div>
	</div>
	<!-- end panel -->
	
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
			let param = {disbursement_no: $(this).data("disbursement_no")}
			postPage("/account/disbursement/form", param);
		});
		
	});
</script>