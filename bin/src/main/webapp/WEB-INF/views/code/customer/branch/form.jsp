<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE HTML ================== -->
<ol class="breadcrumb float-xl-end">
	<li class="breadcrumb-item"><a href="javascript:;">Home</a></li>
	<li class="breadcrumb-item active">코드관리</li>
</ol>

<h1 class="page-header">
	고객사/지점 <span class="d-block small">코드관리</span>
</h1>

<div class="card">
	<div class="card-header">
		<h3 class="mb-0">고객사/지점 등록</h3>
	</div>
	<div class="card-body">
		<form class="form-horizontal form-bordered"
			data-parsley-validate="true" name="frm" id="frm" novalidate=""
			enctype="multipart/form-data">
			<input type="hidden" id="branch_no" name="branch_no"
				value="${data.branch_no }">
			<div class="row">

				<div class="col-md-4 col-12 mt-3">
					<label class="form-label">고객사명 <span class="text-danger">*</span></label>
					<select class="form-select" name="customer_no" id="customer_no"
						data-parsley-required="true"
						data-parsley-error-message="고객사명을 정확히 입력하세요."
						>
						<option value="">선택</option>
						<c:forEach items="${customer }" var="item">
							<option value="${item.customer_no }"
								${data.customer_no eq item.customer_no||customer_no eq item.customer_no?'selected':'' }>${item.customer_id }
								| ${item.customer_name }</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-md-4 col-12 mt-3">
					<label class="form-label">지점ID</label> <input type="text"
						class="form-control" id="customer_id" name="customer_id"
						value="${data.customer_id }" placeholder="고객사ID"
						data-parsley-error-message="지점ID을 정확히 입력하세요."
						readonly>
				</div>
				<div class="col-md-4 col-12 mt-3">
					<label class="form-label">지점명 <span class="text-danger">*</span></label>
					<input type="text" class="form-control" placeholder="지점명"
						id="branch_name" name="branch_name" value="${data.branch_name}"
						placeholder="지점명" data-parsley-required="true" 
						data-parsley-error-message="지점명을 정확히 입력하세요." />
				</div>
				<div class="col-md-2 col-12 mt-3">
					<label class="form-label">우편번호 <span class="text-danger"></span></label>
					<input type="text" class="form-control" placeholder="우편번호"
						id="work_zip" name="work_zip" value="${data.work_zip }"
						placeholder="우편번호" data-parsley-required="false"
						data-parsley-error-message="우편번호를 정확히 입력하세요."
						readonly
						/>
				</div>
				<div class="col-md-6 col-12 mt-3">
					<label class="form-label">주소 <span class="text-danger"></span></label>
					<input type="text" class="form-control" placeholder="주소"
						id="comp_addr1" name="comp_addr1" value="${data.comp_addr1}"
						placeholder="주소 검색" data-parsley-required="false"
						data-parsley-error-message="주소를 정확히 입력하세요."
						onclick="execDaumPostcode();" readonly />
				</div>
				<div class="col-md-4 col-12 mt-3">
					<label class="form-label">상세주소 <span class="text-danger"></span></label>
					<input type="text" class="form-control" placeholder="상세주소"
						id="comp_addr2" name="comp_addr2" value="${data.comp_addr2 }"
						placeholder="상세주소" data-parsley-required="false"
						data-parsley-error-message="상세주소를 정확히 입력하세요."
						 />
				</div>

				<div class="col-md-4 col-12 mt-3">
					<label class="form-label">사업자번호 <span class="text-danger">*</span></label>
					<input type="text" class="form-control" placeholder="사업자번호"
						id="comp_number" name="comp_number" value="${data.comp_number }"
						placeholder="사업자번호" data-parsley-required="true" 
						data-parsley-error-message="사업자번호를 정확히 입력하세요."
						busno />
				</div>
				<div class="col-md-4 col-12 mt-3">
					<label class="form-label">담당자 <span class="text-danger">*</span></label>
					<input type="text" class="form-control" placeholder="담당자"
						id="manager_name" name="manager_name"
						value="${data.manager_name }" placeholder="담당자"
						data-parsley-required="true" 
						data-parsley-error-message="담당자를 정확히 입력하세요."
						/>
				</div>
				<div class="col-md-4 col-12 mt-3">
					<label class="form-label">이메일 <span class="text-danger"></span></label>
					<input type="text" class="form-control" placeholder="이메일"
						id="manager_email" name="manager_email"
						value="${data.manager_email }" data-parsley-type="email"
						placeholder="이메일" data-parsley-required="false" 
						data-parsley-error-message="이메일을 정확히 입력하세요."
						/>
				</div>
				<div class="col-md-4 col-12 mt-3">
					<label class="form-label">세금계산서 발행 이메일 <span
						class="text-danger">*</span></label> <input type="text"
						class="form-control" placeholder="세금계산서 발행 이메일" id="tax_email"
						name="tax_email" value="${data.tax_email }"
						placeholder="세금계산서 발행 이메일" data-parsley-type="email"
						data-parsley-required="true"
						data-parsley-error-message="세금계산서 발행 이메일을 정확히 입력하세요."
						 />
				</div>
				<div class="col-md-4 col-12 mt-3">
					<label class="form-label">연락처 <span class="text-danger">*</span></label>
					<input type="text" class="form-control" placeholder="연락처"
						id="manager_hp1" name="manager_hp1" value="${data.manager_hp1 }"
						placeholder="연락처" data-parsley-required="true" 
						data-parsley-error-message="연락처를 정확히 입력하세요."
						phone />
				</div>
				<div class="col-md-12 col-12 mt-3">
					<label class="form-label">사업자등록증 사본 <span
						class="text-danger">*</span></label>
					<tags:image-upload name="upLoadFile" value="${imageList}"
						maxFileCount="1" required="true"
						category="IMG_TYPE_CUSTOMER_BRANCH_BUSS" type="image" />
				</div>


			</div>
		</form>
	</div>
</div>

<div class="d-flex justify-content-center mt-4">
<c:if test="${empty data.branch_no }">
    <button class="btn btn-gray" name="_button_page_list" data-to_url="/code/customer/branch/list">list</button>
 </c:if>
 <c:if test="${!empty data.branch_no }">
    <button class="btn btn-gray" name="_button_page_view" data-to_url="/code/customer/branch/view" data-to_param="branch_no^${data.branch_no}">cancel</button>
</c:if>
	<button type="button" class="btn btn-primary ms-2" id="_dev-save">save</button>
</div>

<!-- daum address layer css -->
<div id="layer"
	style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
	<img
		src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png"
		id="btnCloseLayer"
		style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
		onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>


<script>
	/* set title name mandatory */
	App.setPageTitle('코드관리 | 고객사/지점');
	App.restartGlobalFunction();
/*
	$.when(
		$.getScript('/assets/plugins/parsleyjs/dist/parsley.min.js'),
		$.getScript('/assets/plugins/highlight.js/highlight.min.js'),
		//$.getScript('/assets/plugins/bootstrap-datepicker/dist/js/bootstrap-datepicker.js'),
		$.Deferred(function( deferred ){
			$(deferred.resolve);
		})
	).done(function() {
		$.getScript('/assets/js/demo/render.highlight.js'),
		$.Deferred(function( deferred ){
			$(deferred.resolve);
		})
	});
*/
	/* plugin */
	var FormPlugins = function () {
		"use strict";
		return {
			//main function
			init: function () {
				handleDatepicker();
			}
		};
	}();

	/* set datepicker */
/* 	var datePickerOptions = {
		format: "yyyy-mm-dd",	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
	    //startDate: '-10d',	//달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
	    //endDate: '+10d',	//달력에서 선택 할 수 있는 가장 느린 날짜. 이후로 선택 불가 ( d : 일 m : 달 y : 년 w : 주)
	    autoclose : true,	//사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
	    //calendarWeeks : false, //캘린더 옆에 몇 주차인지 보여주는 옵션 기본값 false 보여주려면 true
	    clearBtn : false, //날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
	    //datesDisabled : ['2019-06-24','2019-06-26'],//선택 불가능한 일 설정 하는 배열 위에 있는 format 과 형식이 같아야함.
	    //daysOfWeekDisabled : [0,6],	//선택 불가능한 요일 설정 0 : 일요일 ~ 6 : 토요일
	    daysOfWeekHighlighted : [0], //강조 되어야 하는 요일 설정
	    disableTouchKeyboard : false,	//모바일에서 플러그인 작동 여부 기본값 false 가 작동 true가 작동 안함.
	    immediateUpdates: false,	//사용자가 보는 화면으로 바로바로 날짜를 변경할지 여부 기본값 :false
	    multidate : false, //여러 날짜 선택할 수 있게 하는 옵션 기본값 :false
	    //multidateSeparator :",", //여러 날짜를 선택했을 때 사이에 나타나는 글짜 2019-05-01,2019-06-01
	    templates : {
	        leftArrow: '&laquo;',
	        rightArrow: '&raquo;'
	    }, //다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징
	    showWeekDays : true ,// 위에 요일 보여주는 옵션 기본값 : true
	    //title: "테스트",	//캘린더 상단에 보여주는 타이틀
	    todayHighlight : true ,	//오늘 날짜에 하이라이팅 기능 기본값 :false
	    toggleActive : true,	//이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
	    weekStart : 0 ,//달력 시작 요일 선택하는 것 기본값은 0인 일요일
	    language : "kr",	//달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
	}; */


	/* set datepicker event */
/* 	var handleDatepicker = function() {
		$('#datepicker-default').datepicker(datePickerOptions);
		$('#datepicker-inline').datepicker({
			todayHighlight: true
		});
		$('.input-daterange').datepicker({
			todayHighlight: true
		});
		$('#datepicker-disabled-past').datepicker({
			todayHighlight: true
		});
		$('.datepicker').datepicker(datePickerOptions);
	}; */

	$(document).ready(function() {
		/* datepicker korea language */
/* 		$.fn.datepicker.dates['kr'] = {
			days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
			daysShort: ["일", "월", "화", "수", "목", "금", "토", "일"],
			daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
			months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
		}; */
		/* init plugin */
		FormPlugins.init();
	});

</script>


<!-- ================== END PAGE LEVEL JS ================== -->

<script>
	var curPage;

	/* init page */
	$(function(){
		console.log('page script !!!! ');
		console.log('테스트!!!');
		/* save data */
		$("#_dev-save").on("click", function(e){
			const _name = "고객사-지점 저장";	// ajax name
			const _url = "/code/customer/branch/save/ajax";	// ajax url
			const _form = "frm";	// form name

			/* validate */
			var validate = $("[name=frm]").parsley().validate();
			if(!validate) {
				console.log('# validate false !!!');
				return;
			}

			/** form data
			let _param = $("#frm").serializeObject();	// ajax param

			Utils.requestAjax(_name, _url, _param, {
				beforeSend: function(){},
	            success:  function(data) {
		          	alert(Message.SAVE);
		          	movePage("/code/customer/branch/index");
	            },
	            complete:  function(response) {}
			});
			*/

			/* multi form insert */
			Utils.requestMultiAjax(_name, _url, _form, {
	            success:  function(data) {
		          	alert(Message.SAVE);
		          	movePage("/code/customer/branch/list");
	            },
	            complete:  function(response) {}
			});

		});

		/* auto complete */
	    $("#customer_name").autocomplete({
	        source: function( request, response ) {
	        	let param = {};
	        	param.customer_name = $("#customer_name").val();
                $.ajax({
                    type: 'POST',
                    url: "/code/customer/list/ajax",
                    data: param,
//                    dataType: "json",
//                    data: JSON.stringify(param),
//                    contentType: "application/json",
                    success: function(data) {
                        response(
                            $.map(data.data, function(item) {    //json[i] 번째 에 있는게 item 임.
                            	console.log("item length:", item.length);
                            	console.log("item >>>> ", item);
                                return {
                                    label: item.customer_name +" ("+item.customer_id+")",    //UI 에서 보여지는 글자, 실제 검색어랑 비교 대상
                                    value: item.customer_name,    //사용자 설정값
                                    customer_no : item.customer_no,
                                    customer_id : item.customer_id,
                                    customer_name : item.customer_name
                                }
                            })
                        );
                    },
                    beforeSend: function( jqXHR, settings ){
                    	jqXHR.setRequestHeader("Authorization", getAuthToken());
                    },
               });
            },
	        select: function(event, ui) {
	        	$("#customer_no").val(ui.item.customer_no);
	        	$("#customer_id").val(ui.item.customer_id);
	        	$("#customer_name").val(ui.item.customer_name);
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

		/* set mask optional */
	    setInputMask();
	});

</script>

<!-- address -->

<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
	    	 console.log("post:", data)
	         // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	         // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	         // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	         var fullAddr = data.address; // 최종 주소 변수
	         var extraAddr = ''; // 조합형 주소 변수

	         let _zonecode = data.zonecode;
	         
	         $("#work_zip").val(Utils.nvl(_zonecode,''));
	         
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
	         document.getElementById('comp_addr1').value = fullAddr;
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

