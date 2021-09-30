<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- <body class="p-3"> -->
<div class="card">
	<div class="card-body">
		<h5>기본 정보 입력</h5>
		<div class="row">
			<div class="col-12 mb-3">
				<!-- begin panel -->
				<div class="card">
					<div class="card-header">
						<h3 class="mb-0">비용처리 등록</h3>
					</div>
					<div class="card-body" style="">
						<form class="form-horizontal form-bordered" data-parsley-validate="true" name="saveFrm" id="saveFrm" novalidate="" enctype="multipart/form-data">
							<input type="hidden" id="exp_no" name="exp_no" value="${data.exp_no }">
							<input type="hidden" id="bank_code" name="bank_code" value="${data.bank_code }">
							<input type="hidden" id="acct" name="acct" value="${data.acct }">

							<div class="row">

								<div class="col-md-6 col-12 mt-3 ">
									<label class="form-label">작업선택 <span class="text-danger">*</span></label>
									<select class="form-select" name="work_no" id="work_no" data-parsley-required="true" data-parsley-error-message="작업선택하세요.">
									</select>
								</div>
								<div class="col-md-3 col-12 mt-3 ">
									<label class="form-label">비용분류 <span class="text-danger">*</span></label>
									<select class="form-select" id="exp_type" name="exp_type" data-parsley-required="true" data-parsley-error-message="비용분류를 선택하세요.">
										<option value="">선택</option>
										<tags:code-select codeList="${exp_type }" selected="${data.exp_type }" />
									</select>
								</div>
								<div class="col-md-3 col-12 mt-3">
									<label class="form-label">품의번호 <span class="text-danger">*</span></label>
									<input type="text" class="form-control " placeholder="비용용도" name="exp_id" id="exp_id" value="${data.exp_id }" readonly data-parsley-error-message="품의번호을 정확히 입력하세요.">
								</div>
								<div class="col-md-12 col-12 mt-3">
									<label class="form-label">비용용도 <span class="text-danger">*</span></label>
									<input type="text" class="form-control " placeholder="비용용도" name="exp_usage" id="exp_usage" value="${data.exp_usage }" data-parsley-required="true" data-parsley-error-message="비용용도을 정확히 입력하세요.">
								</div>

								<div class="col-md-4 col-12 mt-3 " name="exp_type_01">
									<label class="form-label">외주용역선택 <span class="text-danger">*</span></label>
									<select class="form-select" id="partner_no" name="partner_no" data-parsley-required="true" data-parsley-error-message="외주용역을 선택하세요.">
										<option value="">선택</option>
										<c:forEach var="item" items="${partner_list }">
											<option value="${item.partner_no }" data-partner_hp1="${item.partner_hp1}" data-bank_name="${item.bank_name}" data-bank_code="${item.bank_code}" data-acct="${item.acct}" data-comp_number="${item.comp_number}" data-partner_type="${item.partner_type}" data-id_no="${item.id_no}" ${data.partner_no eq item.partner_no?'selected':'' }>${item.partner_name }</option>
										</c:forEach>
									</select>
								</div>

								<div class="col-md-4 col-12 mt-3" name="exp_type_03" style="display: none">
									<label class="form-label">매입거래처<span class="text-danger">*</span></label>
									<select class="form-select" id="vendor_no" name="vendor_no" data-parsley-required="true">
										<option value=''>선택</option>
										<c:forEach items="${vendor }" var="item">
											<option value="${item.vendor_no}" data-vendor_hp1="${item.vendor_hp1}" data-bank_name="${item.bank_name}" data-bank_code="${item.bank_code}" data-acct="${item.acct}" data-comp_number="${item.comp_number}" ${item.vendor_no eq data.vendor_no?" selected":"" }>${item.vendor_name}</option>
										</c:forEach>
									</select>
								</div>

								<div class="col-md-4 col-12 mt-3 " name="exp_type_01_02_03">
									<label class="form-label">결제정보 <span class="text-danger">*</span></label>
									<input type="text" class="form-control " placeholder="결제정보" name="pay_info" id="pay_info" value="${data.pay_card_no }" data-parsley-required="true" data-parsley-error-message="경제정보를 정확히 입력하세요." readonly>
								</div>

								<!-- 은행 코드!!!! -->
								<div class="col-md-4 col-12 mt-3 " name="exp_type_04" style="display: none">
									<label class="form-label">은행 <span class="text-danger">*</span></label>
									<select class="form-select" id="etc_bank_code" name="etc_bank_code" data-parsley-required="false" data-parsley-error-message="은행을 선택하세요.">
										<option value="">선택</option>
										<tags:code-select codeList="${bank_code }" selected="${data.bank_code }" />
									</select>
								</div>
								<div class="col-md-4 col-12 mt-3 " name="exp_type_04" style="display: none">
									<label class="form-label">계좌정보 <span class="text-danger">*</span></label>
									<input type="text" class="form-control " placeholder="계좌정보" name="etc_acct" id="etc_acct" value="${data.acct }" data-parsley-required="false" data-parsley-error-message="계좌정보를 정확히 입력하세요.">
								</div>
								<!-- 계좌정보 -->
								<div class="col-md-4 col-12 mt-3 ">
									<label class="form-label">지출증빙 <span class="text-danger"></span></label>
									<input type="text" class="form-control " placeholder="지출증빙" name="evidence" id="evidence" value="${data.evidence }" readonly>
								</div>

								<div class="col-md-4 col-12 mt-3 " name="exp_type_04" style="display: none">
									<label class="form-label">사용처 <span class="text-danger">*</span></label>
									<input type="text" class="form-control " placeholder="사용처" data-parsley-required="true" data-parsley-error-message="사용처를 정확히 입력하세요.." name="exp_target" id="exp_target" value="${data.exp_target }">
								</div>
								<div class="col-md-4 col-12 mt-3 ">
									<label class="form-label">사용일 <span class="text-danger">*</span></label>
									<select class="form-select" id="st_date" name="st_date" data-parsley-required="true" data-parsley-error-message="사용일을 선택하세요."  >
										<option>사용일</option>
									</select>
								</div>
								<div class="col-md-4 col-12 mt-3 ">
									<label class="form-label">결제요청일 <span class="text-danger">*</span></label>
									<input type="text" class="form-control " placeholder="결제요청일 " name="pay_req_date" id="pay_req_date" data-parsley-required="true" data-parsley-error-message="결제요청일을 선택하세요" value="${data.pay_req_date }" datepicker>
								</div>
								<div class="col-4 mt-3 mt-3 ">
									<label class="form-label">비용단위 <span class="text-danger"></span></label>
									<select class="form-select" id="exp_unit_cd" name="exp_unit_cd" data-parsley-required="true" data-parsley-error-message="비용단위를 정확히 입력하세요.">
										<option value="">선택</option>
										<tags:code-select codeList="${exp_unit_cd }" selected="${data.exp_unit_cd }" />
									</select>
								</div>
								<div class="col-md-4 col-12 mt-3 ">
									<label class="form-label">갯수 <span class="text-danger">*</span></label>
									<input type="text" class="form-control " placeholder="갯수" name="exp_cnt" id="exp_cnt" value="${data.exp_cnt }" data-parsley-required="true" data-parsley-type="number" data-parsley-error-message="갯수를 정확히 입력하세요.">
								</div>
								<div class="col-md-4 col-12 mt-3 ">
									<label class="form-label">단가 <span class="text-danger">*</span></label>
									<input type="text" class="form-control " placeholder="단가" name="exp_price" id="exp_price" value="${data.exp_price }" data-parsley-required="true" data-parsley-error-message="단가를 정확히 입력하세요." comma>
								</div>
								<div class="col-md-4 col-12 mt-3 " name="exp_type_01_02_03"></div>
								<div class="col-md-4 col-12 mt-3 ">
									<label class="form-label">결제수단 <span class="text-danger">*</label></span>
									<div style="margin-top: 3px;">
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio" id="pay_type1" name="pay_type" value='ACCT' checked>
											<label class="form-check-label" for="pay_type1">계좌이체</label>
										</div>
									</div>
								</div>
								<div class="col-md-4 col-12 mt-3 ">
									<label class="form-label">총 비용 <span class="text-danger"></span></label>
									<input type="text" class="form-control " placeholder="단가" id="total_exp_price" value="${data.exp_cnt * data.exp_price }" readonly comma>
								</div>
								<div class="col-md-12 col-12 mt-3 ">
									<label class="form-label">거래명세서<span class="text-danger">*</span></label>
									<tags:image-upload name="upLoadFile" value="${imageList}" maxFileCount="10" required="true" category="IMG_TYPE_EXPENSES" type="image" />
								</div>
								<div class="form-group ">
									<div class="col-sm-14 text-center">
										<button type="button" class="btn btn-primary" id="_dev-save">등록</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- </div> -->
<!-- end panel -->



<!-- ================== END PAGE LEVEL JS ================== -->

<script>
	var curPage;
	var workDayList = ${workDayList};
	/* init page */
	$(function() {

		/* 수정 화면일 경우 처리 */
		if (!Utils.isEmpty($("#exp_no").val())) {
			$("#work_no").prop("disabled", true);
		} else {
			$("#work_no").prop("disabled", false);
		}

		// 총비용계산
		$("#exp_cnt, #exp_price").on("change", function(e){
		    console.log("===================================", $(this).val());
		    let _exp_cnt =Utils.remove($("#exp_cnt").val(),',');
		    let _exp_price =Utils.remove($("#exp_price").val(),',');
		    let _total_exp_cnt = _exp_cnt * _exp_price;
		    $("#total_exp_price").val(Utils.comma(_total_exp_cnt));
		});

		$("#work_no").on("change",changeSelWorkNo);

		/* 공과잡비 선택시 경제정보 & 지출증빙 input 활성화 */
		$("#exp_type").change(function(){
			let _exp_type = $('#exp_type').val();

			if(_exp_type == '04'){
				$( '#pay_info' ).removeAttr('readonly');
				$( '#evidence' ).removeAttr('readonly');
			}else{
				$( '#pay_info' ).attr('readonly');
				$( '#evidence' ).attr('readonly');
			}
		});

		/* save data */
		$("#_dev-save").on("click", function(e) {
			const _name = "비용처리 저장"; // ajax name
			const _url = "/account/expenses/save/ajax"; // ajax url
			const _form = "saveFrm"; // form name

			/* validate */
			let validate = $("[name=saveFrm]").parsley().validate();

			if (!validate) {
				return;
			}

			/* 공과 잡비 인경우 */
			if($("#exp_type").val() == '04'){
				$("#bank_code").val($("#etc_bank_code").val());
				$("#acct").val($("#etc_acct").val());
			}

			/* multi form insert */
			Utils.requestMultiAjax(_name, _url, _form, {
				success : function(data) {
					alert(Message.SAVE);
					movePage("/account/expenses/list");
					pageRefresh("/abc/work/view",{"work_no":"${param.work_no}","tab":"#excute_price_view"});
				},
				complete : function(response) {
				}
			});

		});

		/* 외주업체 선택 */
		$("#partner_no").on("change", function() {
			let _data = $(this).find("option:selected").data();
			let _evidence = _data.comp_number+"";

			if(_data.partner_type == '01'){
				_evidence = _data.id_no+"";
				if(_evidence.length == 7){
					_evidence = _evidence.substring(0, 6) + "-" + _evidence.substring(6) + "******";
				}
			} else {
				_evidence = Utils.bussNo(_data.comp_number);
			}

			$("#partner_hp1").val(_data.partner_hp1);
			$("#pay_info").val(_data.bank_name + "/" + _data.acct);
			//$("#evidence").val("사업소득공제 / "+ _evidence);
			$("#evidence").val(_evidence);
			$("#bank_code").val(_data.bank_code);
			$("#acct").val(_data.acct);
		});

		/* 매입거래처 선택 */
		$("#vendor_no").on("change", function() {
			let _data = $(this).find("option:selected").data();
			$("#vendor_hp1").val(_data.vendor_hp1);
			$("#pay_info").val(_data.bank_name + "/" + _data.acct);
			//$("#evidence").val(_data.comp_number);

			$("#bank_code").val(_data.bank_code);
			$("#acct").val(_data.acct);
		});

		/* 비용분류 */
		$("#exp_type").on("change", function() {
			let _exp_type = $("#exp_type").val();
			console.log("_exp_type:", _exp_type)
			$("[name^=exp_type_]").hide();

			// 개개, 법법
			let _partner = $("#partner_no").find("option");
			_partner.each(function(e){
				let _partner_type = $(this).data("partner_type");
				if(_exp_type == '01'){
					if(_partner_type == '01' || _partner_type == undefined) {
						$(this).show();
					} else {
						$(this).hide();
					}
				}
				if(_exp_type == '02'){
					if(_partner_type == '02' || _partner_type == '03' || _partner_type==undefined) {
						$(this).show();
					} else {
						$(this).hide();
					}
				}
			});

			if (_exp_type == '02') {
				_exp_type = '01';
			}

			$("#pay_info").val('');
			$("#evidence").val('');

			$("[name^=exp_type_]").each(function(idx, item){
				let _exp_type_name = $(this).attr("name");
				if(_exp_type_name.indexOf(_exp_type) > -1){
					$(this).show();
				} else {
					$(this).hide();

				}
			});

			//validator
			$('#partner_no').attr('data-parsley-required', 'false'); // 외주용역
			$('#vendor_no').attr('data-parsley-required', 'false'); // 매입거래처
			$('#exp_target').attr('data-parsley-required', 'false'); // 사용처
			$('#etc_bank_code').attr('data-parsley-required', 'false'); // 공과잡비 은행
			$('#etc_acct').attr('data-parsley-required', 'false'); // 공과잡비 계좌
			$('#pay_info').attr('data-parsley-required', 'false'); // 계좌 정보

			if(_exp_type == '01'){
				$('#partner_no').attr('data-parsley-required', 'true'); // 외주용역
				$('#pay_info').attr('data-parsley-required', 'true'); // 계좌 정보
			}
			else if(_exp_type == '03'){
				$('#vendor_no').attr('data-parsley-required', 'true'); // 외주용역
				$('#pay_info').attr('data-parsley-required', 'true'); // 계좌 정보
			}
			else if(_exp_type == '04'){
				$('#exp_target').attr('data-parsley-required', 'true'); // 외주용역
				$('#etc_bank_code').attr('data-parsley-required', 'true'); // 공과잡비 은행
				$('#etc_acct').attr('data-parsley-required', 'true'); // 공과잡비 계좌
			}
		});

		/* 작업목록 조회 */
		listWork();

		$("#st_date").on("change", function(e){
			let _st_date = $(this).val();
			if(!Utils.isEmpty(_st_date)){
				$("#pay_req_date").val(_st_date);
			}
		});
	});
	function changeSelWorkNo(){
		console.log("=== changeSelWorkNo");
		let workNo = this.value;
		console.log(workNo);
		$("#st_date").empty();
		$("#st_date").append("<option value=\"\">사용일</option>");
		$.each(workDayList,function(index,item){
		    if(item.work_no == workNo){
		        let option = $("<option value=\""+item.day_ymd+"\">"+item.st_date_ymd+" ("+item.day_of_week+")</option>");
		        $("#st_date").append(option);
		    }
		})
	}
	/* 작업 목록 */
	function listWork() {

		const _name = "작업목록 조회"; // ajax name
		const _url = "/work/list/ajax"; // ajax url

		/* multi form insert */
		Utils.requestAjax(_name, _url, {work_no:${param.work_no} }, {
			success : function(data) {

				if (data != undefined) {
					let work_list = '<option value="">작업 선택</option>';
					$.each(data.data, function(index, item) {
						//console.log("item >>>> ", (item));

						let temp = {};
						//TODO : 데이터 없음.
						//temp['manager_admin_no'] = item.manager_admin_no;
						temp['director_no'] = '104';
						temp['work_addr1'] = item.work_addr1;
						temp['work_addr2'] = item.work_addr2;
						temp['work_zip'] = item.work_zip;
						temp['req_name'] = item.req_name;
						// B2B 기업구분
	          			let _req_name = item.req_name;
	          			if(item.work_target == '04'){
	          				_req_name = item.customer_name+"/"+item.branch_name;
	          				temp['req_name'] 	= _req_name;
	          			}
						work_list += '<option value="'+item.work_no+'" data-item=\''+JSON.stringify(temp)+'\' >'+item.work_id+' | '+_req_name+' | '+item.location_name+'</option>';
					});
					$("#work_no").html(work_list);
					$("#work_no").val("${param.work_no}").attr("selected");
					$("#work_no").trigger("change");
				}
				/* selected work_no */
				if ('${data.work_no}' != '') {
					$("#work_no").val('${data.work_no}');
				}

			},
			complete : function(response) {
				console.log('complete!!!');
			}
		});
	}

</script>

