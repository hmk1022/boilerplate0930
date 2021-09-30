<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

<!-- begin page-header -->
<!-- <h1 class="page-header">
	지출결의서 <span class="d-block small">회계관리</span>
</h1> -->
<!-- end page-header -->
<!-- begin panel -->
<div class="card">
	<div class="card-header">
		<h3 class="mb-0">지출결의서 작성</h3>
	</div>
	<div class="card-body" style="">
		<form class="form-horizontal form-bordered" data-parsley-validate="true" name="saveFrm" id="saveFrm" novalidate="" enctype="multipart/form-data">
			<div class="row">
				<div class="col-md-4 col-12 mt-3">
					<label class="form-label">기안자 <span class="text-danger">*</span></label>
					<input type="text" class="form-control " placeholder="기안자"
						id="admin_name" value="${member.admin_name}"
						readonly
						/>
				</div>
				<div class="col-md-4 col-12 mt-3 ">
					<label class="form-label">담당부서 <span class="text-danger">*</span></label>
					<input type="text" 
						class="form-control " 
						id="department" 
						value='${member.department_name}' 
						readonly
						/>
				</div>
				<div class="col-md-4 col-12 mt-3"></div>
				<div class="col-md-4 col-12 mt-3">
					<label class="form-label">차량번호 <span class="text-danger"></span></label>
					<input type="text" class="form-control " placeholder="차량번호"
						name="car_no" value="${member.car_no}"
						readonly
						/>
				</div>
				<div class="col-md-4 col-12 mt-3 ">
					<label class="form-label">법인카드 뒤 4자리 <span class="text-danger"></span></label>
					<input type="text" 
						class="form-control " 
						name="card_no" 
						value='${member.card_no}' 
						readonly
						/>
				</div>
				<div class="col-md-4 col-12 mt-3"></div>
				<div class="col-md-4 col-12 mt-3">
					<label class="form-label">지출일자 <span class="text-danger">*</span></label>
					<input type="text" class="form-control " placeholder="지출일"
						name="disb_date" id="disb_date"
						data-parsley-required="true"
						data-parsley-error-message="지출일을 정확히 입력하세요."
						datepicker>
				</div>				
				<div class="col-md-4 col-12 mt-3">
					<label class="form-label">지출금액 <span class="text-danger">*</span></label>
					<input type="text" class="form-control " placeholder="지출금액"
						name="disb_amt" id="disb_amt"
						data-parsley-required="true"
						data-parsley-error-message="지출금액을 정확히 입력하세요."
						comma>
				</div>
				<div class="col-md-8 col-12 mt-3"></div>
				
				<div class="col-md-12 col-12 mt-3 ">
					<label class="form-label">지출비용 성격 <span class="text-danger">*</span></label>
					<div style="margin-top: 3px;">
						<div class="form-check form-check-inline " data-parsley-required="true">
		            		<input class="form-check-input" type="radio" id="disb_type_01" name="disb_type" value="01" checked="checked">
		            		<label class="form-check-label" for="disb_type_01">업무활동비(법인카드 소유자 전체)</label>
				        </div>
						<div class="form-check form-check-inline " data-parsley-required="true">
				            <input class="form-check-input" type="radio" id="disb_type_02" name="disb_type" value="02">
				            <label class="form-check-label" for="disb_type_02">직책활동비(권한자:부서장)</label>
				        </div>
						<div class="form-check form-check-inline " data-parsley-required="true">
				            <input class="form-check-input" type="radio" id="disb_type_03" name="disb_type" value="03">
				            <label class="form-check-label" for="disb_type_03">영업활동비(권한자:대표이사, COO, 영업본부장)</label>
				        </div>
					</div>
				</div>

				<div class="col-md-4 col-12 mt-3 ">
					<label class="form-label">지출비용 용도 <span class="text-danger">*</span></label>
					<select class="form-select" 
						id="disb_usage"
						name="disb_usage" 
						data-parsley-required="true"
						data-parsley-error-message="지출비용용도를 정확히 입력하세요.">
						<option value="">선택</option>
						<c:forEach var="item" items="${disb_usage }" varStatus="cnt">
                        	<option value="${item.code_value }" data-code_memo="${item.code_memo }">${item.code_name }</option>
                        </c:forEach>
					</select>
				</div>
				<div class="col-md-8 col-12 mt-3"></div>
				
				<div class="col-md-8 col-12 mt-3" style="display:none" id="_div_disb_target">
					<label class="form-label">지출대상자 <span class="text-danger">*</span></label>
					<input type="text" 
						class="form-control " 
						placeholder="지출대상자"
						data-parsley-error-message="지출대상자를 입력하세요."
						name="disb_target" 
						id="disb_target" />
				</div>
				<div class="col-md-8 col-12 mt-3" style="display:none" id="_div_remark">
					<label class="form-label">기타내용 <span class="text-danger">*</span></label>
					<input type="text" 
						class="form-control " 
						placeholder="기타내용"
						data-parsley-error-message="기타내용을 입력하세요."
						name="remark" id="remark" 
						/>
				</div>

				<div class="col-md-8 col-12 mt-3">
					<label class="form-label" for="upLoadFile">증빙 영수증 <span
						class="text-danger">*</span></label>
						<tags:image-upload name="upLoadFile" value="${imageList}"
							maxFileCount="3" required="true" category="IMG_TYPE_DISBURSEMENT"
							type="image" />
				</div>

				<div class="form-group ">
					<div class="col-sm-14 text-center">
						<button type="button" class="btn btn-secondary" id="_button_cancel">취소</button>
						<button type="button" class="btn btn-primary" id="_dev-save">제출</button>
					</div>
				</div>

			</div>
		</form>

	</div>
</div>
<!-- end panel -->

<!-- ================== END PAGE LEVEL JS ================== -->
<script>
	/* init page */
	$(function(){
		//console.log('page script !!!! ');
		//console.log('테스트!!!');
		
		$("[name=disb_type]").on("click", function(e){
			let _val = $(this).val();
			$("#disb_usage option").each(function(idx, item){
				let _code_memo = $(this).data("code_memo");
				//console.log(_code_memo)
				if(_code_memo != null && _code_memo.indexOf(_val) == -1) {
					$(this).hide();
				}else {
					$(this).show();
				}
            });
			$("[name=disb_usage]").val('');
			$("[name=disb_usage]").trigger("change");
		});
		
		// 지출대상자 표시
		$("[name=disb_usage]").on("change", function(e){
			
			let _val = $(this).val();
			// 지출대상자 표시
			if(_val == '02' ||_val == '03' ||_val == '05' ||_val == '06' ||_val == '07' ||_val == '08') {
				$("#_div_disb_target").show();
			} else {
				$("#_div_disb_target").hide();
			}
			
			// 기타사유 입력
			if(_val == '99') {
				$("#_div_remark").show();
			} else {
				$("#_div_remark").hide();
			}
			
			$('#disb_target').attr('data-parsley-required', 'false');
			$('#remark').attr('data-parsley-required', 'false');
			
	    	if($("#_div_disb_target").is(":visible")){
	    		$('#disb_target').attr('data-parsley-required', 'true');
	    	}
	    	if($("#_div_remark").is(":visible")){
	    		$('#remark').attr('data-parsley-required', 'true');
	    	}
		});
		
		$("[name=disb_type][value='01']").trigger("click");
		
		$("#_button_cancel").on("click", function(e){
			e.preventDefault();
			document.saveFrm.reset();
		});
		/* save data */
		$("#_dev-save").on("click", function(e){
			const _name = "지출결의서 저장";	// ajax name
			const _url = "/account/disbursement/save/ajax";	// ajax url
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
		          	document.saveFrm.reset();
	            },
	            complete:  function(response) {}
			});
		});
	});

</script>