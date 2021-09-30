<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE HTML ================== -->
<div class="card">
	<div class="card-header">
		<h3 class="mb-0">구매 상세내용 등록</h3>
	</div>
	<div class="card-body">
		<form class="form-horizontal form-bordered"
			data-parsley-validate="true" name="saveForm" id="saveForm"
			enctype="multipart/form-data">
			<input type="hidden" id="material_pcs_no" name="material_pcs_no"
				value="${data.material_pcs_no }"> <input type="hidden"
				id="bank_code" name="bank_code" value="${data.bank_code }">
			<input type="hidden" id="acct" name="acct" value="${data.acct }">


			<div class="row">

				<div class="col-md-6 col-12 mt-3">
					<label class="form-label">구매사유 <span class="text-danger">*</span></label>
					<tags:code-radio codeList="${pcs_reason }"
						checked="${data.pcs_reason }" name="pcs_reason" required="true"
						initValue="01" />
				</div>
				<div class="col-md-6 col-12 mt-3">
					<label class="form-label">구매번호 <span class="text-danger">*</span></label>
					<h5>${data.material_pcs_id }</h5>
				</div>
				<div class="col-md-12 col-12 mt-3" name="pcs_reason_div_99"
					style="display: none">
					<label class="form-label">기타사유<span class="text-danger"></span></label>
					<input type="text" 
						class="form-control" 
						placeholder="기타사유"
						id="etc_remarks" 
						name="etc_remarks" 
						value="${data.etc_remarks }"
						data-parsley-required="false" 
					/>
				</div>
				
				<div class="col-md-6 col-12 mt-3" name="pcs_reason_div_01">
					<div class = "form-group">
						<label class="form-label">작업선택 <span class="text-danger">*</span></label>
						<select class="form-select" name="work_no" id="work_no" data-parsley-required="true" data-parsley-error-message="작업을 선택 해주세요">
						</select>
					</div>
				</div>
				<%--
				<div class="col-md-6 col-12 mt-3" name="pcs_reason_div_01">
					<label class="form-label">작업일련번호 선택<span class="text-danger">*</span></label>
					<input type="text" class="form-control" placeholder="작업선택"
						id="work_no" name="
						work_no" 
                    	value="${data.work_id }|${data.req_name }"
						data-parsley-required="false"  />
				</div>
				--%>				
				<div class="col-md-3 col-12 mt-3" name="pcs_reason_div_01">
					<label class="form-label">자재요청서번호<span class="text-danger">*</span></label>
					<input type="text" 
						class="form-control" 
						placeholder="자재요청서번호"
						id="material_doc_id" 
                    	value="${data.material_doc_id }"
                    	readonly
						/>
				</div>
				<div class="col-md-3 col-12 mt-3" name="pcs_reason_div_01">
					<label class="form-label">요청자<span class="text-danger"></span></label>
					<input type="text" 
						class="form-control" 
						placeholder="요청자"
						id="doc_admin_name" 
						name="doc_admin_name"
						value="${data.doc_admin_name }"
						readonly
						/>
				</div>
				<div class="col-md-3 col-12 mt-3">
					<label class="form-label">매입거래처<span class="text-danger">*</span></label>
					<select class="form-select" id="vendor_no" name="vendor_no" data-parsley-error-message="매입거래처를 정확히 입력하세요."
						data-parsley-required="true">
						<option value=''>선택</option>
						<c:forEach items="${vendor }" var="item">
							<option value="${item.vendor_no}"
								data-vendor_hp1="${item.vendor_hp1}"
								data-bank_name="${item.bank_name}"
								data-bank_code="${item.bank_code}" data-acct="${item.acct}"
								data-comp_number="${item.comp_number}"
								${item.vendor_no eq data.vendor_no?" selected":"" }>${item.vendor_name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-md-3 col-12 mt-3">
					<label class="form-label">연락처<span class="text-danger"></span></label>
					<input type="text" class="form-control" placeholder="연락처"
						id="vendor_hp1" data-parsley-required="false" phone readonly/>
				</div>
				<div class="col-md-3 col-12 mt-3">
					<label class="form-label">결제정보<span class="text-danger"></span></label>
					<input type="text" class="form-control" placeholder="결제정보"
						id="acct_info" data-parsley-required="false" readonly/>
				</div>
				<div class="col-md-3 col-12 mt-3">
					<label class="form-label">지출증빙<span class="text-danger"></span></label>
					<input type="text" 
						class="form-control" 
						placeholder="지출증빙"
						id="evidence" 
						name="evidence" 
						data-parsley-required="false"
						readonly/>
				</div>
				<div class="col-md-3 col-12 mt-3">
					<label class="form-label">결제요청일<span class="text-danger">*</span></label>
					<input type="text" class="form-control" placeholder="결제요청일"
						id="pay_req_date" name="pay_req_date"
						value="${data.pay_req_date }" data-parsley-required="true" data-parsley-error-message="결제요청일을 정확히 입력하세요."
						datepicker />
				</div>
				<div class="col-md-9 col-12 mt-3">
					<label class="form-label">부가세 포함여부<span class="text-danger">*</span></label>
					<div style="margin-top: 3px;">
						<div class="form-check form-check-inline ">
							<input 
								class="form-check-input" 
								type="radio" 
								id="vat_yn1"
								name="vat_yn" 
								value="N" ${empty data.vat_yn || data.vat_yn eq 'N'?'checked':'' }>
							<label class="form-check-label" for="pcs_reason1">부가세별도</label>
						</div>
						<div class="form-check form-check-inline " data-parsley-required="true">
							<input 
								class="form-check-input" 
								type="radio" 
								id="vat_yn2"
								name="vat_yn" 
								value="Y" 
								${data.vat_yn eq 'Y'?'checked':'' }>
							<label class="form-check-label" for="pcs_reason2">부가세포함</label>
						</div>
					</div>
				</div>

				<div class="col-md-12 col-12 mt-3">
					<label class="form-label">거래명세서<span class="text-danger"></span></label>
					<tags:image-upload name="upLoadFile" value="${imageList}"
						maxFileCount="1" required="false" category="IMG_TYPE_MATERIAL_PCS"
						type="image" />
				</div>

				<div class="col-md-12 col-12 mt-3">
					<label class="form-label">메모<span class="text-danger"></span></label>
					<input type="text" class="form-control" placeholder="메모"
						id="remarks" name="remarks" value="${data.remarks }"
						data-parsley-required="false" />
				</div>
			</div>
		</form>
	</div>
</div>

<div class="d-flex justify-content-center mt-4">
	<%-- <button class="btn btn-gray" name="moveBack">${empty data.material_pcs_no ? 'list':'cancel'}</button> --%>
	<button class="btn btn-primary ms-2" id="_dev-save">save</button>
</div>
<!-- end panel -->

<!-- begin 자재 목록 -->
<div class="card mt-4">
	<div class="card-header">
		<div class="d-flex align-item-center justify-content-between">
			<h3 class="m-0">구매 자재 목록</h3>
			<!-- <a href="#" class="btn btn-sm btn-success" id="addMaterial">추가 하기</a> -->
		</div>
	</div>
	<div class="card-body" id="searchText">
		<!-- <div class="border rounded p-3" id="empty_material_pcs_list" style="display:none">등록된 자재가 없습니다. [추가하기] 버튼을 눌러 자재를 추가해보세요.</div> -->
		<table class="table table-striped m-b-0">
			<thead>
				<tr>
					<th>품번</th>
					<th>품명</th>
					<th>브랜드</th>
					<th>수량</th>
					<th>단가</th>
					<th>총금액</th>
					<th width="1%"></th>
				</tr>
			</thead>
			<tbody id="material_pcs_item_list">
				<tr>
					<td colspan="7">등록된 자재가 없습니다.</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>



<!-- begin modal -->
<!-- 자재 추가 -->
<div class="modal fade" id="modal-dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">자재 추가하기</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
			</div>
			<div class="modal-body">
				<!--  -->
				<form class="form-horizontal form-bordered"
					data-parsley-validate="true" name="materialFrm" id="materialFrm"
					novalidate="">

					<!-- <input type="hidden" id="material_no" name="material_no" > -->
					<input type="hidden" name="material_pcs_no"
						value="${data.material_pcs_no }"> <input type="hidden"
						id="req_stat" name="01">

					<!-- <input type="hidden" id="ware_house_cnt" name="ware_house_cnt" > -->
					<!-- <div class="form-row">
						<div class="col-md-4 mb-3">
							<label for="cate1">분야</label>
							<div class="">
								<select class="form-select" name="cate1" id="cate1"
									data-parsley-required="true">
									<option value="">선택</option>
								</select>
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="cate2">중분류</label>
							<div class="">
								<select class="form-select" name="cate2" id="cate2"
									data-parsley-required="true">
									<option value="">선택</option>
								</select>
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="cate3">소분류</label>
							<div class="">
								<select class="form-select" name="cate3" id="cate3"
									data-parsley-required="true">
									<option value="">선택</option>
								</select>
							</div>
						</div>
					</div> -->

					<!-- <div class="form-row">
						<div class="col-md-8 mb-3">
							<label for="material_list">자재선택</label>
							<div class="validationTooltip01">
								<select class="form-select" name="material_no"
									id="material_list" data-parsley-validate="true"
									data-parsley-required="true">
									<option value="">선택</option>
								</select>
							</div>
						</div>
					</div> -->
				  	<div class="form-row">
					    <div class="col-md-8 mb-3">
					      <label for="material_name_tmp">자재명</label>
					      <input type="text" class="form-control" name="material_name" id="material_name" placeholder="자재명" 
					      	data-parsley-required="true"
					      	data-parsley-error-message="자재를 선택해주세요."
							data-parsley-errors-container="#validation_material_name_error"
					      >
					      <input type="hidden" class="form-control" name="material_no" id="material_no" 
					      	data-parsley-required="true"
					   		data-parsley-error-message="자재를 선택해주세요."
							data-parsley-errors-container="#validation_material_name_error"
					      >
					      <div id="validation_material_name_error"></div>
					    </div>
				  	</div>
				  	<div class="form-row">
					    <div class="col-md-8 mb-3">
					      <label for="material_name_tmp">모델명</label>
					      <input type="text" class="form-control" name="model_name" id="model_name" placeholder="모델명" readonly>
					    </div>
				  	</div>
				  	
					<div class="form-row" name="div_all_material">
						<div class="col-md-6 mb-3">
							<label for="brand_no">브랜드</label>
							<div class="validationTooltip01">
								<select class="form-select" name="brand_no" id="brand_no"
									disabled>
								</select>
							</div>
						</div>
						<div class="col-md-3 mb-3">
							<label for="unit_cd">단위</label>
							<div class="validationTooltip01">
								<select class="form-select" id="unit_cd" name="unit_cd" disabled>
									<option value="">선택</option>
									<tags:code-select codeList="${unit_cd }"
										selected="${data.unit_cd }" />
								</select>
							</div>
						</div>
						<div class="col-md-3 mb-3">
							<label for="purchased_price">단가</label> <input type="text"
								class="form-control" id="purchased_price" name="purchased_price"
								placeholder="단가" data-parsley-required="true" disabled>
						</div>
					</div>
					<!-- 자재갯수 -->	
					<div class="form-row">
						<div class="col-md-3 mb-3">
							<label for="house_cnt">물류센터</label>
							<input type="text" class="form-control" id="house_cnt" placeholder="0" comma readonly>
						</div>
						<div class="col-md-3 mb-3">
							<label for="sba_cnt">성수SBA</label>
							<input type="text" class="form-control" id="sba_cnt" placeholder="0" comma readonly>
						</div>
						<div class="col-md-3 mb-3">
							<label for="vehicle_cnt">르노(마포)</label>
							<input type="text" class="form-control" id="vehicle_cnt" placeholder="0" comma readonly>
						</div>
						<div class="col-md-3 mb-3">
						</div>
					</div>
					<!-- 자재갯수 -->	
					<div class="form-row mt-3">
						<div class="col-md-3 mb-3">
							<label for="item_cnt">수량</label> 
							<input type="text" class="form-control" id="item_cnt" name="item_cnt" value="0"
								min="0" max="10000" 
								placeholder="수량" data-parsley-required="true"
								data-parsley-min="1"
					      		data-parsley-error-message="수량을 선택해주세요."
								data-parsley-errors-container="#validation_material_cnt_error"
								>
								<div id="validation_material_cnt_error"></div>
						</div>
						<div class="col-md-3 mb-3">
							<label for="total_material_price">금액</label> <input type="number"
								class="form-control" id="total_material_price"
								name="total_material_price" value="0" placeholder="금액" readonly>
						</div>
					</div>

				</form>

			</div>
			<div class="modal-footer">
				<a href="javascript:;" class="btn btn-white" data-dismiss="modal"
					id="close_material">닫기</a> <a href="javascript:;"
					class="btn btn-success" id="add_material">저장</a>
			</div>
		</div>
	</div>
</div>

<!-- end modal -->


<!-- ================== END PAGE LEVEL JS ================== -->

<script>

	$("#item_cnt").inputSpinner(); // spinner.

	var curPage;
	
	/* init page */
	$(function(){
		
		/* 수정 화면일 경우 처리 */
		if(!Utils.isEmpty($("#material_pcs_no").val())){
			$("#work_no").prop("disabled", true);
		} else {
			$("#work_no").prop("disabled", false);
		}
		
		/* 결제요청일 */
		$('#pay_req_date').datepicker(datePickerOptions);
		
		/* 자재삭제 */
		$("#material_pcs_item_list").on("click", "#del-material", function (e) {
			e.preventDefault();
			removeMaterialPcsItem($(this).data("material_pcs_item_no"));
		});
		
		/* 추가하기 */
		$("#addMaterial").on("click", function (event) {
			
			if(Utils.isEmpty($("#material_pcs_no").val())) {
				alert("기본정보 등록 후 제품등록을 추가 하세요.");
				return;
			}
			
			resetForm();	// reset material form 
			$('#modal-dialog').modal({backdrop: 'static', keyboard: false}) ;
			$("#modal-dialog").modal("show");

			/*
			$('#newModal').modal({backdrop: 'static', keyboard: false}) ;
			<button data-target="#newModal" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			새로운 모달
			</button>
			*/
		});
		
		$("#item_cnt").on("change", function (event) {
		    let item_cnt = 0;
		    let purchased_price = 0;
		    let total_material_price = 0;
		    
		    item_cnt = Utils.remove($("#item_cnt").val(),',') ;
		    purchased_price = Utils.remove($("#purchased_price").val(),',') ;
		    total_material_price = item_cnt * purchased_price;
		    $("#total_material_price").val(total_material_price);
		});
		
		/* save data */
		$("#_dev-save").on("click", function(e){
			const _name = "자재구매요청 저장";	// ajax name
			const _url = "/material/pcs/save/ajax";	// ajax url
			const _form = "saveForm";	// form name
			
			/* validate */
			let validate = $("#saveForm").parsley().validate();
			
			
			if(!validate) {
				console.log('# validate false !!!');
				return;
			}
			
			/* multi form insert */
			Utils.requestMultiAjax(_name, _url, _form, {
	            success:  function(data) {
		          	alert(Message.SAVE);
		          	$("#modal-dialog").modal("hide");
		          	listMaterialReq();
		          	/*
		          	if(Utils.isEmpty($("[name=material_pcs_no]").val())){
			          	$("[name=material_pcs_no]").val(data);
		          	}
		          	listMaterialPcsItem();
		          	*/
	            },
	            complete:  function(response) {
	            	console.log('complete!!!');
	            }
			});

		});
		
		
		/* set mask optional */
	    setInputMask();
		
	    /* 작업목록 조회 */
	    listWork();
	    
	    /* 작업선택 */
	    $("#work_no").on("change", function(){
	    	let data = $("#work_no > option:selected").data("item");
			$("#req_name").val(data.req_name);
			$("#director_no").val(data.director_no);
			$("#work_addr").val(data.work_addr1 +" "+ data.work_addr2);
	    });
	    
	    /* 자재 추가 */
	    $("#add_material").on("click", function(){
			saveMaterialPcsItem();
	    });	    

	    $("#close_material").on("click", function(){
	    	listMaterialPcsItem();
	    });	    
	    
	    
	    /* 카테고리 조회 */
	    //listCategory("1", "");
	    
	    $("#cate1").on("change", function(){
	    	listCategory("2", $(this).val());
	    	$("#cate3").html('<option value="">선택</option>');
	    	$("#material_list").html('<option value="">선택</option>');
	    });
	    $("#cate2").on("change", function(){
	    	listCategory("3", $(this).val());
	    });

	    /* 자재조회 */
	    $("#cate3").on("change", function(){
	    	listMaterial($(this).val());
	    });
	    
	    /* 자재선택 */
	    $("#material_list").on("change", function(){
				
	    	if($(this).val() == 'ADD'){ // 상품요청.
	    		initMaterialFrom('ADD');	// init form
	    	}
	    	else {	// 상품선택.
		    	let data = $("#material_list > option:selected").data("item");
	    		initMaterialFrom('SELECT', data);	// init form
	    	}
	    });

	    /* 작업선택 */
	    $("#work_no").on("change", function(){
	    	listAdminWork();
	    });
	    
	    
	    /* 자재목록 조회 */
	    listMaterialPcsItem();
	    
	    /* 매입거래처 선택 */
	    $("#vendor_no").on("change", function(){
	    	let _data = $(this).find("option:selected").data();
			$("#vendor_hp1").val(_data.vendor_hp1);
			$("#acct_info").val(_data.bank_name + "/"+ _data.acct);
			$("#evidence").val(_data.comp_number);

			$("#bank_code").val(_data.bank_code);
			$("#acct").val(_data.acct);
			
	    });

	    /* 구매사유 선택 */
	    $("[name=pcs_reason]").trigger("change");
	    $("[name=pcs_reason]").on("change", function(){
	    	let _val = $("[name=pcs_reason]:checked").val();
	    	$("[name^=pcs_reason_div]").hide();
	    	$("[name^=pcs_reason_div_"+_val+"]").show();
	   
	    	/* 구매사유에 따른 인풋박스 validation  */
	    	if($(this).val() != 01){
	    		$("#work_no").attr("data-parsley-required","false");
	    		//$("[name=material_doc_no]").attr("data-parsley-required","false");
	    	}
	    });

	    /* 부가세 금액 확인 */
	    $("[name=vat_yn]").on("change", function(){
	    	let _vat_yn = $(this).val();
	    	$("#vat_yn_total_price").html();
	    });
	    
	    /* 수령방법 trigger */
	    if('${data.pcs_reason}' != '') {
		    $("[name='pcs_reason']").trigger("change");
		    $("[name='pcs_reason']").not(":checked").prop("disabled", true);
	    }
	    /* 매입거래처 trigger */
	    if('${data.vendor_no}' != '') {
		    $("[name='vendor_no']").trigger("change");
	    }	   
	    // 부가세포함여부
	    if('${data.vat_yn}' != '') {
	    	let _val = '${data.vat_yn}';
		    $("[name='vat_yn'][value="+_val+"]").prop("checked", true);
	    }
	    
	    
	    /* 자재 검색 */
	    $("#material_name").autocomplete({
	        source: function( request, response ) {
	        	let param = {};
	        	param.s_material_name = $("#material_name").val();
                $.ajax({
                    type: 'POST',
                    url: "/material/list/ajax",
                    data: param,
//                    dataType: "json",
//                    data: JSON.stringify(param),
//                    contentType: "application/json",
    		    	beforeSend : function(xhr){
    		    		xhr.setRequestHeader("Authorization", getAuthToken());
    		    	},
                    success: function(data) {
                        response(
                            $.map(data.data, function(item) {    //json[i] 번째 에 있는게 item 임.
                            	let _material_name = item.material_name;
                            		if(item.brand_name != '' && item.brand_name != undefined){
                            			_material_name += "("+item.brand_name+")";
                            		}
                                return {
                                	label: _material_name,    //UI 에서 보여지는 글자, 실제 검색어랑 비교 대상
                                    value: item.material_name,    //사용자 설정값
                                    model_name : item.model_name,
                                    brand_name : item.brand_name,
                                    purchased_price : item.purchased_price,
                                    unit_name : item.unit_name,
                                    unit_cd : item.unit_cd,
                                    brand_no : item.brand_no,
                                    material_no : item.material_no,
                                    house_cnt : item.house_cnt,
                                    sba_cnt : item.sba_cnt,
                                    vehicle_cnt : item.vehicle_cnt
                                }
                            })
                        );
                    },
               });
            },
	        select: function(event, ui) {
	        	console.log("SELECT:", ui.item);
	        	let _form = $("#materialFrm");
	        	let _data = ui.item;
	        	_form.find("[name=brand_no]").val(_data.brand_no);
	        	_form.find("[name=model_name]").val(_data.model_name);
	        	_form.find("[name=unit_cd]").val(_data.unit_cd);
	        	_form.find("[name=purchased_price]").val(Utils.comma(_data.purchased_price));
	        	_form.find("[name=material_no]").val(_data.material_no);
	        	// 자재수량표시.
	        	_form.find("#house_cnt").val(_data.house_cnt);
	        	_form.find("#sba_cnt").val(_data.sba_cnt);
	        	_form.find("#vehicle_cnt").val(_data.vehicle_cnt);
	        },
	        minLength: 2,
	        autoFocus: true,
	        classes: {"ui-autocomplete": "highlight"},
	        delay: 150,
	        focus: function(event, ui) {
	            return false;
	        },
	        close : function(event){
            }
	    });
		
		// init form
/* 	    $("#material_name").on("change", function(e){
	    	let _form = $("#materialFrm");
        	_form.find("[name=brand_no]").val('');
        	_form.find("[name=model_name]").val('');
        	_form.find("[name=unit_cd]").val('');
        	_form.find("[name=purchased_price]").val('');
        	_form.find("[name=material_no]").val('');
        	_form.find("[name=total_material_price]").val('');
	    }); */
		
		
	});
	
	// 자재 선택에 따른 form init
	function initMaterialFrom(str, data){
			
		if(Utils.isEmpty(data)) {
			resetMaterialFrom();
			return;
		}
	
		$("#material_name").val(data.material_name);
		$("#brand_no").val(data.brand_no);
		$("#unit_cd").val(data.unit_cd);
		$("#purchased_price").val(data.purchased_price);
		
		// 상품수
		let item_cnt = 0;
		if($("[name='receive_type']:checked").val() =='01'){
			item_cnt = data.ware_house_cnt;
		} else if($("[name='receive_type']:checked").val() =='02'){
			item_cnt = data.company_cnt;
		} else if($("[name='receive_type']:checked").val() =='03'){
			item_cnt = data.sba_cnt_cnt;
		} else {
			item_cnt = 0;
		}
		
		$("#item_cnt").val(item_cnt);
		
		$("#item_cnt").trigger("change");
	}

	function resetMaterialFrom(){
		$("#material_name").val('');
		$("#brand_no").val('');
		$("#unit_cd").val('');
		$("#purchased_price").val('');
		$("#item_cnt").val('');
	}
	
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
	          	
	    		listAdminWork();
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
	
	/* 작업자 목록 */
	function listAdminWork(){

		const _name = "작업자목록 조회";	// ajax name
		const _url = "/work/admin/list/ajax";	// ajax url
		
		let _param = {};
		_param.work_no = $("#work_no").val();
		
		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	
	          	if(data != undefined){
	          		let work_list = '<option value="">선택</option>';
	          		$.each(data.data, function(index, item){
	          			let temp = {};
	          			work_list += '<option value="'+item.admin_no+'" >'+item.admin_name+'</option>';
	          		});
	          		$("#manager_no").html(work_list);
	          	}
	          	/* selected work_no */
	    		if('${data.manager_no}' != '') {
	    			$("#manager_no").val('${data.manager_no}');
	    		}
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
	
	/* 카테고리 목록 */
	function listCategory(category_level, p_category_id){

		const _name = "카테고리조회 조회";	// ajax name
		const _url = "/material/category/list/ajax";	// ajax url
		let _param = {};	// ajax param
		
		_param.category_level = category_level;
		_param.p_category_id = p_category_id;
		
		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	
	          	if(data != undefined){
	          		let temp_list = '<option value="">선택</option>';
	          		$.each(data.data, function(index, item){
	          			temp_list += '<option value="'+ item.category_id +'" data-category_no="'+ item.category_no +'" >'+item.name+ '</option>';
	          		});
	          		
	          		$("#cate"+category_level).html(temp_list);
	          	}
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
	
	/* 자재 목록 */
	function listMaterial(){

		const _name = "자재목록 조회";	// ajax name
		const _url = "/material/select/list/ajax";	// ajax url
		let _param = {};	// ajax param
		
		_param['category_no'] = $("#cate3 option:selected").data('category_no');
		
		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	
	          	if(data != undefined){
	          		let temp_list = '<option value="">선택</option>';
	          		$.each(data.data, function(index, item){
	          			let temp = {};
	          			// add brand_name
	          			let _materila_name = item.material_name;
	          			if(!Utils.isEmpty(item.brand_name)){
	          				_materila_name += '(' + item.brand_name +')';
	          			}	          			
	          			temp['material_no'] = item.material_no;
	          			temp['material_name'] = item.material_name;
	          			temp['brand_no'] = item.brand_no;
	          			temp['unit_cd'] = item.unit_cd;
	          			temp['ware_house_cnt'] = item.ware_house_cnt;
	          			temp['company_cnt'] = item.company_cnt;
	          			temp['sba_cnt'] = item.sba_cnt;
	          			temp['purchased_price'] 	= item.purchased_price;
	          			temp_list += '<option value="'+item.material_no+'" data-item=\''+JSON.stringify(temp)+'\' >'+ _materila_name +'</option>';
	          			//temp_list += '<option value="'+ item.material_no +'" >'+item.material_name+ '</option>';
	          		});
	          		
	          		// temp_list += '<option value="ADD">[상품추가]</option>';
	          		
	          		$("#material_list").html(temp_list);
	          	}
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
	
	function resetForm(){
		$('#materialFrm')[0].reset();
		$("#cate2").html('<option value="">선택</option>');
		$("#cate3").html('<option value="">선택</option>');
	}

	function saveMaterialPcsItem(){
		const _name = "자재구매요청 저장";	// ajax name
		const _url = "/material/pcs/item/save/ajax";	// ajax url
		
		
		//$("#materialFrm #material_pcs_no").val($("#material_pcs_no").val());
		
		//_param['material_pcs_no'] = $("#material_pcs_no").val();
		
		/* validate */
		let validate = $("#materialFrm").parsley().validate();
		
		if(!validate) {
			console.log('# validate false !!!');
			return;
		}
		
		let _param = {};	// ajax param
		_param['material_pcs_no'] = $("#material_pcs_no").val();
		_param['material_no'] = $("#material_no").val();
		_param['item_cnt'] = $("#item_cnt").val();
		
		
		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	alert(Message.SAVE);
	          	movePage("/material/pcs/list");
	          	//resetForm();	// reset material form
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
	
	
	function listMaterialPcsItem(){
		
		if(Utils.isEmpty($("#material_pcs_no").val())) return ;
		
		const _name = "자재구매요청 조회";	// ajax name
		const _url = "/material/pcs/item/list/ajax";	// ajax url
		let _param = {};	// ajax param
		_param['material_pcs_no'] = $("#material_pcs_no").val();
		
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	
	          	let tmp = '';
	          	if(Utils.isEmpty(data.data)){
	          		//tmp = '<tr><td colspan="7">등록된 데이터가 없습니다.</td></tr>';
	          		$("#empty_material_pcs_list").show();
	          	} else {
	          		let _total_purchased_price = 0;
	          		$.each(data.data, function(idx, item){
	          			tmp += '<tr>'+ 
	    				'<td>'+Utils.nvl(item.material_id)+'</td>'+
	    				'<td style="text-align:left">'+Utils.nvl(item.material_name)+'</td>'+
	    				'<td>'+Utils.nvl(item.brand_name)+'</td>'+
	    				'<td>'+Utils.nvl(item.item_cnt)+getCodeNm('unit_cd',item.unit_cd)+'</td>'+
	    				'<td>'+Utils.comma(Utils.nvl(item.purchased_price))+'</td>'+
	    				'<td>'+Utils.comma(Utils.nvl(item.total_purchased_price))+'</td>'+
	    				'<td class="with-btn" nowrap=""><a href="#" class="btn btn-sm btn-white width-60" id="del-material" data-material_pcs_item_no="'+item.material_pcs_item_no+'">삭제</a></td>'+
	    				'</tr>';
	          			_total_purchased_price += item.total_purchased_price;
	          		});
	          		
	          		tmp +='<tr class="table-success"><td colspan="6" class="fw-bold">소계</td><td class="text-end fw-bold">'+Utils.comma(_total_purchased_price)+' 원</td></tr>';
	          	}
	          	
	          	$("#empty_material_pcs_list").hide();
    			$("#material_pcs_item_list").html(tmp);
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}



	function removeMaterialPcsItem(material_pcs_item_no){
		if(!confirm(Message.CONFIRM.DELETE)){
			return;
		}
		const _name = "자재구매요청 삭제";	// ajax name
		const _url = "/material/pcs/item/delete/ajax";	// ajax url
		let _param = {};	// ajax param
		
		_param['material_pcs_item_no'] = material_pcs_item_no;
		
		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	//alert(Message.DELETE);
	          	listMaterialPcsItem();
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
	
	function saveMaterial(){
		const _name = "자재마스터 저장";	// ajax name
		const _url = "/material/save/ajax";	// ajax url
		let _param = $("#materialFrm").serializeObject();	// ajax param
		
		_param['work_no'] = $("#work_no").val();
		_param['use_date'] = Utils.remove($("#use_date").val(), "-");
		_param['use_hh'] = $("#use_hh").val();
		_param['use_mm'] = $("#use_mm").val();
		_param['receive_type'] = $("[name=receive_type]:checked").val();
		_param['material_pcs_no'] = $("#material_pcs_no").val();
		
		/* validate */
		let validate1 = $("[name=saveForm]").parsley().validate();
		let validate2 = $("[name=materialFrm]").parsley().validate();
		
		if(!validate1 || !validate2) {
			console.log('# validate false !!!');
			return;
		}
		
		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	alert(Message.SAVE);
	          	resetForm();	// reset material form
	          	listMaterialPcsItem();
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}
	
</script>