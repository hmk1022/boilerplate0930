<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

	<!-- begin page-header -->
	<h1 class="page-header">작업마스터 <span class="d-block small">작업 관리</span></h1>
	<!-- end page-header -->
	<!-- begin panel -->
	<div class="card" id="job-master-form">
		<div class="card-header">
			<h3 class="mb-0">신규 작업 등록</h3>
		</div>
		<div class="card-body" style="">
			<form class="form-horizontal form-bordered" data-parsley-validate="true" name="frm" id="frm" novalidate="" enctype="multipart/form-data">
				<div class="row">
					<div class="col-md-6 col-12 mt-3">
						<label class="form-label" for="">사업구분 * </label>
						<div class="is-invalid">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" id="work_target_04" name="work_target" value="04" checked>
								<label class="form-check-label" for="work_target">B2B</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" id="work_target_03" name="work_target" value="03" >
								<label class="form-check-label" for="work_target">PROJECT</label>
							</div>
						</div>
					</div>

					<div class="col-md-6 col-12 mt-3">
						<label class="form-label">고객구분 * </label>
						<div class="is-invalid">
							<div class="form-check form-check-inline">
								<input class="radio radio-css radio-inline " type="radio" id="custom_type_p" name="custom_type" value="p" checked>
								<label for="custom_type_p">법인</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="radio radio-css radio-inline " type="radio" id="custom_type_c" name="custom_type" value="c" >
								<label for="custom_type_c">개인</label>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-12 mt-3 custom-type-p">
						<label class="form-label" for="customer_no">고객사 * </label>
						<select class="form-select" id="customer_no" name="customer_no" data-parsley-required="true" data-parsley-id="" data-parsley-error-message="고객사를 선택하세요">
							<option value="">고객사</option>
							<c:forEach var="item" items="${customerList}">
							<option value="${item.customer_no}">${item.customer_name}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-6 col-12 mt-3 custom-type-p">
						<label class="form-label" for="branch_no">지점 * </label>
						<select class="form-select" id="branch_no" name="branch_no" data-parsley-required="true" data-parsley-id="" data-parsley-error-message="지점을 선택하세요">
							<option value="">지점</option>
						</select>
					</div>
					<div class="col-md-6 col-12 mt-3" >
						<label class="form-label custom-type-p" for="req_name">담당자명 * </label>
						<label class="form-label custom-type-c" for="req_name">고객명 * </label>
						<input class="form-control " type="text" id="req_name" name="req_name" value="" placeholder="한글,영문,숫자 입력 가능" data-parsley-required="true" data-parsley-id="2" aria-describedby="parsley-id-2" data-parsley-error-message="담당자명을 정확히 입력하세요.">
					</div>

					<div class="col-md-6 col-12 mt-3">
						<label class="form-label" for="req_hp">연락처 * </label>
						<input class="form-control " type="text" id="req_hp" name="req_hp" value="${data.req_hp }" placeholder="숫자만 입력" data-parsley-required="true" data-parsley-id="2" aria-describedby="parsley-id-2" data-parsley-error-message="연락처를 정확히 입력하세요.">
					</div>
					<div class="col-md-6 col-12 mt-3">
						<label class="form-label" for="title">현장주소1 * </label>
						<input type="text" id="work_addr1" name="work_addr1" class="form-control" placeholder="주소 검색" onclick="execDaumPostcode();" value="" readonly data-parsley-required="true" data-parsley-error-message="현장주소1을 정확히 입력하세요.">
					</div>
					<div class="col-md-6 col-12 mt-3">
						<label class="form-label" for="title">현장주소2 * </label>
						<input type="text" id="work_addr2" name="work_addr2" class="form-control" placeholder="상세주소" value=""  data-parsley-required="true" data-parsley-error-message="현장주소2를 정확히 입력하세요.">
					</div>

					<div class="col-md-12 col-12 mt-3 ">
						<label class="form-label" for="location_name">공사명 * </label>
						<input class="form-control " type="text" id="location_name" name="location_name" value="${data.location_name }" placeholder="한글,영문,숫자 (100자 이내)" data-parsley-required="true" data-parsley-id="2" aria-describedby="parsley-id-2" data-parsley-error-message="공사명을 정확히 입력하세요." >
					</div>

					<div class="col-md-12 col-12 mt-3 ">
						<label class="form-label" for="req_content">요청사항 </label>
						<textarea class="form-control" rows="5" name="req_content" id="req_content" placeholder="고객 요청사항 입력(500자 이내)">${data.req_content }</textarea>
					</div>

					<div class="col-md-12 col-12 mt-3 ">
						<label class="form-label" for="manager_rank">현장사진 </label>
						<div class="col-md-12 col-12">
							<%--
							<input id="input-file-1" name="upLoadFile" multiple type="file" accept="image/*" data-browse-on-zone-click="true">
							 --%>
							<tags:image-upload name="upLoadFile"
		                                       value="${imageList}"
		                                       maxFileCount = "20"
		                                       category = "IMG_TYPE_WORK_REG"
		                                       type="image"
		                    />
						</div>
					</div>
					<div class="col-md-6 col-12 mt-3" >
						<label class="form-label" for="manager_admin_no">공무 * </label>
							<select class="form-select" id="manager_admin_no" name="manager_admin_no" data-parsley-required="true" data-parsley-id="" data-parsley-error-message="공무담장자를 선택하세요.">
								<option value="">워커맨</option>
								<c:forEach var="item" items="${adminList}">
								<option value="${item.admin_no}">${item.admin_name}</option>
								</c:forEach>
							</select>
					</div>
					<div class="col-md-6 col-12 mt-3" >
						<label class="form-label" for="req_name"> 접수경로 </label>
						<select class="form-select" id="channel" name="channel" data-parsley-required="false" data-parsley-id="">
							<option value="">선택</option>
							<tags:code-select codeList="${channel }"/>
						</select>
					</div>
					<div class="form-group ">
						<div class="col-sm-14 text-center">
							<button type="button" class="btn btn-primary" id="_dev-save">save</button>
							<button type="button" class="btn btn-grey" name="moveBack">list</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- end panel -->

<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script>
	/* set title name mandatory */
	App.restartGlobalFunction();

</script>


<!-- ================== END PAGE LEVEL JS ================== -->

<script>
	var curPage;
	var branchList = ${customerBranchList};
	var $this = $('#job-master-form');
	function changeSelCustomerNo(){
		console.log("=== changeSelCustomerNo");
		let customerNo = this.value;
		$("#branch_no",$this).empty();
		$("#branch_no",$this).append("<option value=\"\">지점선택</option>");
		$.each(branchList,function(index,item){
		    if(item.customer_no == customerNo){
		        let option = $("<option value=\""+item.branch_no+"\">"+item.branch_name+"</option>");
		        $("#branch_no",$this).append(option);
		    }
		})
	}
	function changeSelBranchNo(){
		console.log("=== changeSelBranchNo");
		let branchNo = this.value;
		$.each(branchList,function(index,item){
		    if(item.branch_no == branchNo){
			console.log("=== branchNo",branchNo);
			console.log("=== item.comp_addr1",item.comp_addr1);
			console.log("=== item.comp_addr2",item.comp_addr2);
			$("#req_name",$this).val("");
	        $("#req_hp",$this).val("");
		        $("#req_name",$this).val(item.manager_name);
		        $("#req_hp",$this).val(item.manager_hp1);
		        $("#work_addr1",$this).val(item.comp_addr1);
		        $("#work_addr2",$this).val(item.comp_addr2);
		    }
		})
	}
	/* init page */
	function init(){
		$("#custom_type_p").trigger("click");
		$("#work_target_04").trigger("click");
	}
	$(function(){
		$("#customer_no",$this).on("change",changeSelCustomerNo);
		$("#branch_no",$this).on("change",changeSelBranchNo);
		$("input[name=\"custom_type\"",$this).on("click",function(){
			if(this.value == "p"){
				$(".custom-type-p").show();
				$(".custom-type-c").hide();
				$(".custom-type-p .form-select").attr("data-parsley-required",true)
				$(".custom-type-c .form-select").attr("data-parsley-required",false)
				$(".custom-type-p .form-select").prop("disabled",false);
				$(".custom-type-c .form-select").prop("disabled",true);
			}else if(this.value == "c"){
				$(".custom-type-p").hide();
				$(".custom-type-c").show();
				$(".custom-type-p .form-select").attr("data-parsley-required",false)
				$(".custom-type-c .form-select").attr("data-parsley-required",true)
				$(".custom-type-p .form-select").prop("disabled",true);
				$(".custom-type-c .form-select").prop("disabled",false);
			}
		})
		$("input[name=\"work_target\"",$this).on("click",function(){
			if(this.value == "04"){
				console.log("aa");
				$("#custom_type_c").prop("disabled",true);
			}else if(this.value == "03"){
				console.log("bb");
				$("#custom_type_c").prop("disabled",false);
			}
		})

		/* save data */
		$("#_dev-save").on("click", function(e){
			const _name = "";	// ajax name
			const _url = "/abc/work/save/ajax";	// ajax url
			const _form = "frm";	// form name

			/* validate */
			var validate = $("[name=frm]").parsley().validate();
			if(!validate) {
				console.log('# validate false !!!');
				return;
			}

			/* multi form insert */
			Utils.requestMultiAjax(_name, _url, _form, {
	            success:  function(data) {
		          	alert(Message.SAVE);
		          	$("#content").css("display", "");
		      		$("#subpage").empty();
		      		$(".btn-search").trigger("click");
	            },
	            complete:  function(response) {}
			});

		});
		init();
		/* set mask optional */
	    setInputMask();
	});

</script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	//우편번호 찾기 화면을 넣을 element
	var element_layer = document.getElementById('layer');
	function closeDaumPostcode() {
	 // iframe을 넣은 element를 안보이게 한다.
	 element_layer.style.display = 'none';
	}

	function execDaumPostcode() {
		//alert('dsadsa');
	 new daum.Postcode({
	     oncomplete: function(data) {
	         // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	         // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	         // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	         var fullAddr = data.address; // 최종 주소 변수
	         var extraAddr = ''; // 조합형 주소 변수

	         // 기본 주소가 도로명 타입일때 조합한다.
	         if(data.addressType === 'R'){
	             //법정동명이 있을 경우 추가한다.
	             if(data.bname !== ''){
	                 extraAddr += data.bname;
	             }
	             // 건물명이 있을 경우 추가한다.
	             if(data.buildingName !== ''){
	                 extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	             }
	             // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	             fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	         }

	         // 우편번호와 주소 정보를 해당 필드에 넣는다.
	        // document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
	         document.getElementById('work_addr1').value = fullAddr;
	         //document.getElementById('sample2_addressEnglish').value = data.addressEnglish;
	 		 $('.js_address_area').show();
	         // iframe을 넣은 element를 안보이게 한다.
	         // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
	         element_layer.style.display = 'none';
	     },
	     width : '100%',
	     height : '100%',
	     maxSuggestItems : 5
	 }).embed(element_layer);

	 //iframe을 넣은 element를 보이게 한다.
	 element_layer.style.display = 'block';

	 //iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
	 initLayerPosition();

	 //
	 $("#layer").css("z-index","99999999999");

	}

	//브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
	//resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
	//직접 element_layer의 top,left값을 수정해 주시면 됩니다.
	function initLayerPosition(){
	 var width = 300; //우편번호서비스가 들어갈 element의 width
	 var height = 400; //우편번호서비스가 들어갈 element의 height
	 var borderWidth = 5; //샘플에서 사용하는 border의 두께

	 // 위에서 선언한 값들을 실제 element에 넣는다.
	 element_layer.style.width  = width  + 'px';
	 element_layer.style.height = height + 'px';
	 element_layer.style.border = borderWidth + 'px solid';
	 // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
	 element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
	 element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
	}
</script>


