<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

	<!-- begin page-header -->
	<h1 class="page-header">매출관리 <span class="d-block small">회계관리</span></h1>
	<!-- end page-header -->
	<!-- begin panel -->
	<div class="card">
        <div class="card-header">
            <h3 class="mb-0">매출관리 등록</h3>
        </div>
		<div class="card-body" style="">
			<form class="form-horizontal form-bordered" data-parsley-validate="true" name="saveFrm" id="saveFrm" novalidate="" enctype="multipart/form-data">
			<input type="hidden" id="pay_no" name="pay_no" value="${data.pay_no }" >
			
			<div class="row">

	            <div class="col-md-6 col-12">
	            	<label class="form-label">작업구분 <span class="text-danger">*</span></label>
	                <input type="text" class="form-control " placeholder="작업구분"
	                 name="work_no" id="work_no" value="${data.work_no }" data-parsley-required="true"
	                 data-parsley-error-message="작업구분을 정확히 입력하세요."
	                >
	            </div>
	            <div class="col-md-6 col-12">
	            	<label class="form-label">견적서 <span class="text-danger">*</span></label>
	                <input type="text" class="form-control " placeholder="견적서"
	                 name="estimate_no" id="estimate_no" value="${data.estimate_no }" data-parsley-required="true"
	                 data-parsley-error-message="견적서를 정확히 입력하세요."
	                >
	            </div>
				<div class="col-md-6 col-12 mt-3 ">
					<label class="form-label">매출구분 <span class="text-danger">*</span></label>
					<select class="form-select" id="amount_type" name="amount_type" data-parsley-required="true"
					data-parsley-error-message="매출구분을 정확히 입력하세요." >
				        <option value="">선택</option>
				        <tags:code-select
							codeList="${amount_type }"
							selected="${data.amount_type }"
						/>
					</select>
				</div>
				<div class="col-md-6 col-12 mt-3 ">
					<label class="form-label">지불구분 <span class="text-danger">*</span></label>
					<select class="form-select" id="pay_type" name="pay_type" data-parsley-required="true"
					data-parsley-error-message="지분구분을 정확히 입력하세요.">
				        <option value="">선택</option>
				        <tags:code-select
							codeList="${pay_type }"
							selected="${data.pay_type }"
						/>
					</select>
				</div>
	            <div class="col-md-6 col-12 mt-3">
	            	<label class="form-label">결제 총금액 <span class="text-danger">*</span></label>
	                <input type="text" class="form-control " placeholder="결제 총금액"
	                 name="total_pay_price" id="total_pay_price" value="${data.total_pay_price }" data-parsley-required="true"
	                 data-parsley-type="number" data-parsley-error-message="결제총금액 정확히 입력하세요."
	                >
	            </div>
	            <div class="col-md-6 col-12 mt-3">
	            	<label class="form-label">결제한 금액 <span class="text-danger">*</span></label>
	                <input type="text" class="form-control " placeholder="결제한 금액"
	                 name="paid_amount" id="paid_amount" value="${data.paid_amount }" data-parsley-required="true"
	               		data-parsley-type="number" data-parsley-error-message="결제한 금액을 정확히 입력하세요."
	                >
	            </div>
	            <div class="col-md-6 col-12 mt-3 ">
	            	<label class="form-label">결제일 <span class="text-danger">*</span></label>
	                <input type="text" class="form-control " placeholder="결제일"
	                 name="st_date" id="st_date" value="${data.st_date }" data-parsley-required="true" datepicker
	                 data-parsley-error-message="결제일을 정확히 입력하세요."
	                >
	            </div>
				<div class="col-md-6 col-12 mt-3 ">
					<label class="form-label">결제상태 <span class="text-danger"></span></label>
					<tags:code-radio
						codeList="${stat }"
						checked="${data.stat }"
						name="stat"
						required="true"
					/>
				</div>

	            <div class="col-md-6 col-12 mt-3">
	            	<label class="form-label">확인자 <span class="text-danger"></span></label>
	                <input type="text" class="form-control " placeholder="확인자"
	                 name="confirm_admin_no" id="confirm_admin_no" value="${data.confirm_admin_no }" 
	                >
	            </div>
	            <div class="col-md-6 col-12 mt-3 ">
	            	<label class="form-label">확인일 <span class="text-danger"></span></label>
	                <input type="text" class="form-control " placeholder="확인일"
	                 name="confirm_date" id="confirm_date" value="${data.confirm_date }" datepicker
	                >
	            </div>
	            <div class="col-md-12 col-12 mt-3">
	            	<label class="form-label">비고 <span class="text-danger"></span></label>
	                <input type="text" class="form-control " placeholder="비고"
	                 name="remarks" id="remarks" value="${data.remarks }" 
	                >
	            </div>					            
					            
					            
					            
				<div class="col-md-12 col-12 mt-3 ">
					<label class="form-label">증빙 영수증 <span class="text-danger"></span></label>
					<div class="col-md-12 col-12">
						<tags:image-upload name="upLoadFile"
	                                       value="${imageList}"
	                                       maxFileCount = "1"
	                                       required = "true"
	                                       category = "IMG_TYPE_PAYMENT"
	                                       type="image"
	                    />
					</div>
				</div>
				<div class="form-group ">
					<div class="col-sm-14 text-center">
						<button type="button" class="btn btn-primary" id="_dev-save">save</button>
						<button type="button" class="btn btn-grey" name="moveBack">${empty data.pay_no ? 'list':'cancel'}</button>
					</div>
				</div>
			</div>
			</form>
		</div>
	</div>
	<!-- end panel -->

    
<script>
	/* set title name mandatory */
	App.setPageTitle('코드관리 | 고객사');
	App.restartGlobalFunction();
	
</script>


<!-- ================== END PAGE LEVEL JS ================== --->
	
<script>
	var curPage;
	
	/* init page */
	$(function(){
		
		/* 수정 화면일 경우 처리 */
		if(!Utils.isEmpty($("#pay_no").val())){
			$("#work_no").prop("disabled", true);
		} else {
			$("#work_no").prop("disabled", false);
		}
		
		console.log('page script !!!! ');
		console.log('테스트!!!');
		/* save data */
		$("#_dev-save").on("click", function(e){
			const _name = "매출관리 저장";	// ajax name
			const _url = "/account/payment/save/ajax";	// ajax url
			const _form = "saveFrm";	// form name

			/* validate */
			let validate = $("[name=saveFrm]").parsley().validate();
			
			if(!validate) {
				console.log('# validate false !!!');
				return;
			}
			
			/* multi form insert */
			Utils.requestMultiAjax(_name, _url, _form, {
	            success:  function(data) {
		          	alert(Message.SAVE);
		          	movePage("/account/payment/list");
	            },
	            complete:  function(response) {}
			});

		});
		
	    /* 작업목록 조회 */
	    listWork();
	    
	});

	/* 작업 목록 */
	function listWork(){

		const _name = "작업목록 조회";	// ajax name
		const _url = "/work/list/ajax";	// ajax url
		
		/* multi form insert */
		Utils.requestAjax(_name, _url, {}, {
            success:  function(data) {
	          	
	          	if(data != undefined){
	          		let work_list = '<option value="">작업 선택</option>';
	          		$.each(data.data, function(index, item){
	          			//console.log("item >>>> ", (item));
	          			
	          			let temp = {};
	          			//TODO : 데이터 없음.
	          			//temp['manager_admin_no'] = item.manager_admin_no;
	          			temp['director_no'] = '104';
	          			temp['work_addr1'] 	= item.work_addr1;
	          			temp['work_addr2'] 	= item.work_addr2;
	          			temp['work_zip'] 	= item.work_zip;
	          			temp['req_name'] 	= item.req_name;
	          			// B2B 기업구분
	          			let _req_name = item.req_name;
	          			if(item.work_target == '04'){
	          				_req_name = item.customer_name+"/"+item.branch_name;
	          				temp['req_name'] 	= _req_name;
	          			}	          			
	          			work_list += '<option value="'+item.work_no+'" data-item=\''+JSON.stringify(temp)+'\' >'+item.work_id+' | '+_req_name+' | '+item.location_name+'</option>';	          			
	          		});
	          		$("#work_no").html(work_list);
	          	}
	          	/* selected work_no */
	    		if('${data.work_no}' != '') {
	    			$("#work_no").val('${data.work_no}');
	    		}
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
	
</script>

