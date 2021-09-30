<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

	<!-- begin page-header -->
	<h1 class="page-header">외주용역 및 업체 <small>코드관리</small></h1>
	<!-- end page-header -->
	<!-- begin panel -->
	<div class="panel panel-inverse">
		<div class="panel-heading">
			<h4 class="panel-title">외주용역 및 업체 등록</h4>
			<div class="panel-heading-btn">
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-success" data-click="panel-reload"><i class="fa fa-redo"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
			</div>
		</div>
		<div class="panel-body" style="">
			<form class="form-horizontal form-bordered" data-parsley-validate="true" name="frm" id="frm" novalidate="">

			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="warehouse_name">이름/업체명 </label>
				<div class="col-md-8 col-sm-8">
					${data.warehouse_name }
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="branch_name">구분 </label>
				<div class="col-md-4 col-sm-8">
					${data.warehouse_type }
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="comp_number">분야 </label>
				<div class="col-md-2 col-sm-8">
					${data.work_cate1 }
				</div>
				<div class="col-md-2 col-sm-8">
					${data.work_cate2 }
				</div>
				<div class="col-md-2 col-sm-8">
					${data.work_cate3 }
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="email">담당자 </label>
				<div class="col-md-4 col-sm-8">
					${data.manager_name }
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="warehouse_hp1">연락처 </label>
				<div class="col-md-4 col-sm-8" phone>
					${data.warehouse_hp1 }
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="warehouse_hp2">연락처 </label>
				<div class="col-md-4 col-sm-8" phone>
					${data.warehouse_hp2 }
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="manager_email">이메일 </label>
				<div class="col-md-4 col-sm-8">
					${data.manager_email }
				</div>
			</div>
			
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="warehouse_link">Link </label>
				<div class="col-md-4 col-sm-8">
					${data.warehouse_link }
				</div>
			</div>

			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="warehouse_link">주민번호 </label>
				<div class="col-md-4 col-sm-8" jubuns>
					${data.id_no }
				</div>
			</div>

			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="warehouse_link">은행 </label>
				<div class="col-md-4 col-sm-8">
					${data.bank_material }
				</div>
			</div>

			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="warehouse_link">계좌번호 </label>
				<div class="col-md-4 col-sm-8">
					${data.acct }
				</div>
			</div>
			        
			<div class="form-group ">
				<div class="col-sm-14 text-center">
					<button type="button" class="btn btn-primary" id="move_edit" data-warehouse_no="${data.warehouse_no }" >edit</button>
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
			let param = {warehouse_no: $(this).data("warehouse_no")}
			postPage("/material/material/doc/form", param);
		});
		
	});
</script>