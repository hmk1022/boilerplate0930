<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE HTML ================== -->
    <ol class="breadcrumb float-xl-end">
        <li class="breadcrumb-item"><a href="javascript:;">Home</a></li>
        <li class="breadcrumb-item active">코드관리</li>
    </ol>

    <h1 class="page-header">외주용역 및 업체 <span class="d-block small">코드관리</span></h1>
    <div class="card">
        <div class="card-header">
            <h3 class="mb-0">외주용역 및 업체 등록</h3>
        </div>
        <div class="card-body">
   			<form class="form-horizontal form-bordered" data-parsley-validate="true" name="saveForm" id="saveForm" novalidate="" enctype="multipart/form-data">
			<input type="hidden" id="partner_no" name="partner_no" value="${data.partner_no }" >
			<input type="hidden" id="id_no" name="id_no" value="${data.id_no }" >
            <div class="row">
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">이름/업체명 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="이름/업체명" 
                    	id="partner_name" 
                    	name="partner_name" 
                    	value="${data.partner_name }" 
                    	data-parsley-required="true" 
                    	data-parsley-error-message="이름/업체명을 정확히 입력하세요."
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">파트너 구분 <span class="text-danger">*</span></label>
					<tags:code-radio
						codeList="${partner_type }"
						checked="${data.partner_type}"
						name="partner_type"
						required="true"
						initValue="01"
					/>
                </div>
                <div class="col-md-4 col-12 mt-3">
                </div>            
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">분야1 <span class="text-danger">*</span></label>
                    <select class="form-select" id="work_cate1" name="work_cate1" data-parsley-required="true"
                    data-parsley-error-message="분야1을 정확히 입력하세요."
                    >
				        <tags:code-select
							codeList="${work_cate }"
							selected="${data.work_cate1 }"
							defaultValue="선택"
						/>
					</select>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">분야2 <span class="text-danger"></span></label>
                    <select class="form-select" id="work_cate2" name="work_cate2" >
				        <tags:code-select
							codeList="${work_cate }"
							selected="${data.work_cate2 }"
							defaultValue="선택"
						/>
					</select>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">분야3 <span class="text-danger"></span></label>
                    <select class="form-select" id="work_cate3" name="work_cate3" >
				        <tags:code-select
							codeList="${work_cate }"
							selected="${data.work_cate3 }"
							defaultValue="선택"
						/>
					</select>
                </div>
                <div class="col-md-2 col-12 mt-3" name="partner_type_01">
                    <label class="form-label">주민번호<span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="주민번호 " 
                    	id="id_no1" 
                    	name="id_no1" 
                    	value="${data.id_no1 }" 
                    	data-parsley-required="true"
                    	data-parsley-type="number"
                    	data-parsley-error-message="주민번호를 정확히 입력하세요."
                    	maxlength="6" 
                    	/>
                </div>
                <div class="col-md-2 col-12 mt-3" name="partner_type_01">
                    <label class="form-label">주민번호뒤 1자리 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="주민번호뒤 1자리" 
                    	id="id_no2" 
                    	name="id_no2" 
                    	value="${data.id_no2 }" 
                    	data-parsley-required="true"
                    	data-parsley-type="number"
                    	maxlength="1" 
                    	data-parsley-error-message="주민번호뒤 1자리를 정확히 입력하세요."
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3" name="partner_type_02">
                    <label class="form-label">담당자명 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="담당자명 " 
                    	id="manager_name" 
                    	name="manager_name" 
                    	value="${data.manager_name }" 
                    	data-parsley-required="false"
                    	data-parsley-error-message="담당자명을 정확히 입력하세요." 
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3" name="partner_type_02">
                    <label class="form-label">담당자 이메일 <span class="text-danger"></span></label>
                    <input type="text" class="form-control" 
                    	placeholder="담당자 이메일 " 
                    	id="manager_email" 
                    	name="manager_email" 
                    	value="${data.manager_email }" 
                    	data-parsley-type="email"
                    	data-parsley-required="false" 
                    	data-parsley-error-message="이메일을 정확히 입력하세요." 
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3" name="partner_type_02">
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">연락처 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="연락처 " 
                    	id="partner_hp1" 
                    	name="partner_hp1" 
                    	value="${data.partner_hp1 }" 
                    	data-parsley-required="true"
                    	data-parsley-error-message="연락처를 정확히 입력하세요."
                    	phone
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">연락처2 <span class="text-danger"></span></label>
                    <input type="text" class="form-control" 
                    	placeholder="연락처 " 
                    	id="partner_hp2" 
                    	name="partner_hp2" 
                    	value="${data.partner_hp2 }" 
                    	data-parsley-required="false"
                    	 data-parsley-error-message="연락처2를 정확히 입력하세요."
                    	phone 
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3" name="partner_type_02">
                </div>                
                <div class="col-md-4 col-12 mt-3" name="partner_type_02">
                    <label class="form-label">사업자번호 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="사업자번호 " 
                    	id="comp_number" 
                    	name="comp_number" 
                    	value="${data.comp_number }" 
                    	data-parsley-required="false"
                    	data-parsley-error-message="사업자번호를 정확히 입력하세요."
                    	busno
                    	/>
                </div>                
                <div class="col-md-4 col-12 mt-3" name="partner_type_02">
                    <label class="form-label">세금계산서 발행 이메일 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="세금계산서 발행 이메일 " 
                    	id="tax_email" 
                    	name="tax_email" 
                    	value="${data.tax_email }"                     	
                    	data-parsley-required="false" 
                    	data-parsley-type="email"
                    	data-parsley-error-message="세금계산서 발행 이메일을 정확히 입력하세요."
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3" name="partner_type_02">
                </div>                
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">은행 <span class="text-danger">*</span></label>
                    <select class="form-select" id="bank_code" name="bank_code" data-parsley-required="true" data-parsley-error-message="은행을 선택하세요.">
				        <tags:code-select
							codeList="${vacct_bank_code }"
							selected="${data.bank_code }"
							defaultValue="선택"
						/>
					</select>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">계좌번호<span class="text-danger">*</span></label>
                    <input type="text" class="form-control" 
                    	placeholder="계좌번호" 
                    	id="acct" 
                    	name="acct" 
                    	value="${data.acct }" 
                    	data-parsley-required="true"
                    	data-parsley-error-message="계좌번호를 정확히 입력하세요." 
                    	data-parsley-type="number"
                    	/>
                </div>
                <div class="col-md-4 col-12 mt-3">
                </div>
                <div class="col-md-4 col-12 mt-3" name="partner_type_01">
                    <label class="form-label">신분증 사본 (주민등록증, 운전면허증, 여권 등)<span class="text-danger"></span></label>
					<div class="is-valid">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="id_no_fin_yn" name="id_no_fin_yn" value="Y" ${data.id_no_fin_yn eq 'Y' ? 'checked':'' }>
                            <label class="form-check-label" for="id_no_fin_yn">재무/회계팀에 사본 전달 완료 후 체크하세요</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-12 mt-3">
                    <label class="form-label">통장 사본<span class="text-danger"></span></label>
					<div class="is-valid">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="acct_fin_yn" name="acct_fin_yn" value="Y" ${data.acct_fin_yn eq 'Y' ? 'checked':'' }>
                            <label class="form-check-label" for="acct_fin_yn">재무/회계팀에 사본 전달 완료 후 체크하세요</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 col-12 mt-3">
                    <label class="form-label">사업자등록증 사본</label>
					<tags:image-upload 
						name="upLoadFile"
                        value="${imageList}"
                        maxFileCount = "1"
                        required = "false"
                        category = "IMG_TYPE_PARTNER_BUSS"
                        type="image"
                    />
                </div>                
            </div>
            </form>
        </div>
    </div>
			
    <div class="d-flex justify-content-center mt-4">
<c:if test="${empty data.partner_no }">
    <button class="btn btn-gray" name="_button_page_list" data-to_url="/code/partner/list">list</button>
 </c:if>
 <c:if test="${!empty data.partner_no }">
    <button class="btn btn-gray" name="_button_page_view" data-to_url="/code/partner/view" data-to_param="partner_no^${data.partner_no}">cancel</button>
</c:if>
        <button class="btn btn-primary ms-2" id="_dev-save">save</button>
    </div>    
    
	<!-- end panel -->

<!-- ================== END PAGE LEVEL JS ================== -->
	
<script>
	var curPage;
	
	/* init page */
	$(function(){
		console.log('page script !!!! ');
		console.log('테스트!!!');
		
		// 신분증 번호
		if($("#id_no").val() != ''){
			let id_no = $("#id_no").val();
			$("#id_no1").val(id_no.substr(0,6));
			$("#id_no2").val(id_no.substr(6,1));
		} 
		
		/* save data */
		$("#_dev-save").on("click", function(e){
			const _name = "외주용역 및 업체 저장";	// ajax name
			const _url = "/code/partner/save/ajax";	// ajax url
			const _form = "saveForm";	// form name
			
			$("#id_no").val($("#id_no1").val()+""+$("#id_no2").val());			
			
			/* validate */
			let validate = $("[name=saveForm]").parsley().validate();
			
			if(!validate) {
				console.log('# validate false !!!');
				return;
			}
			
			/* multi form insert */
			Utils.requestMultiAjax(_name, _url, _form, {
	            success:  function(data) {
		          	alert(Message.SAVE);
		            movePage("/code/partner/list");
	            },
	            complete:  function(response) {
	            	console.log('complete!!!');
	            }
			});
			
		});
		/* partner_type이 처음앤 개인이므로 필요하지 않은 인풋은 것들은 없애해준다 */
		$("div[name='partner_type_02']").hide();
		
		// partner type 
		$("[name='partner_type']").on("change click", function(e){			
			let partner_type = $(this).filter(":checked").val();
			let partner_type_test = $("[name='partner_type']").filter(":checked").val();
			console.log('파트너 타입 : ',partner_type_test);
		    if(partner_type == '01') {
		     	$("#manager_name").attr('data-parsley-required',false);
		    	$("#comp_number").attr('data-parsley-required',false);
		    	$("#tax_email").attr('data-parsley-required',false);
		    	$("#id_no1").attr('data-parsley-required',true);
		    	$("#id_no2").attr('data-parsley-required',true);
		        $("div[name='partner_type_01']").show();
		        $("div[name='partner_type_02']").hide();
		        $("div[name='partner_type_02'] input").val('');
		    } else {
		    	$("#id_no1").attr('data-parsley-required',false);
		    	$("#id_no2").attr('data-parsley-required',false);
		    	$("#manager_name").attr('data-parsley-required',true);
		    	$("#comp_number").attr('data-parsley-required',true);
		    	$("#tax_email").attr('data-parsley-required',true);
		        $("div[name='partner_type_01']").hide();
		        $("div[name='partner_type_02']").show();
		        $("div[name='partner_type_01'] input").val('');
		    }    
		});

		// 개인, 비개인 trigger
		if('${data.partner_type}' == ''){
			$("#partner_type1").trigger("click");
		}else {
			$("[name=partner_type][value='${data.partner_type}']").prop("checked", true);
			$("[name=partner_type][value='${data.partner_type}']").trigger("click");
		}
		
		/* set mask optional */
	    setInputMask();
	});

</script>

