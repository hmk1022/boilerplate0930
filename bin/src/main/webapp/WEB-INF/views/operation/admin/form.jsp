<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

		<!-- begin page-header -->
		<h1 class="page-header">Admin 계정 관리 <span><small>Admin 운영<small></<span></h1>
		<!-- end page-header -->
		<!-- begin panel -->
		<div class="card">
			<div class="card-header">
				<h4 class="panel-title">Admin 계정 등록</h4>
			</div>
			<div class="card-body" style="">
				<form class="form-horizontal form-bordered" data-parsley-validate="true" novalidate="" name="saveForm" id="frm" enctype="multipart/form-data">
				<input type="hidden" id="admin_no" name="admin_no" value="${data.admin_no }" >
				<input type="hidden" id="admin_type" name="admin_type" value="${data.admin_type }" >
				<div class="row">
				<div class="col-md-6 col-12 mt-3 custom-type-p" >
					<label class="form-label" for="req_name">아이디 <span class="text-danger">*</span> </label>
					<input class="form-control " type="text" type="text" id="admin_id" name="admin_id" value="${data.admin_id }" placeholder="아이디" data-parsley-required="true" data-parsley-id="1" aria-describedby="parsley-id-1"
					 data-parsley-error-message="아이디를 정확히 입력하세요">
				</div>
				<c:if test="${data eq null }">
				<div class="col-md-6 col-12 mt-3 custom-type-p" >
					<label class="form-label" for="req_name">비밀번호 <span class="text-danger">*</span> </label>
					<input class="form-control " type="password" id="password" name="password" value="" placeholder="비밀번호" data-parsley-required="true" data-parsley-id="2" aria-describedby="parsley-id-2" data-parsley-error-message="비밀번호를 정확히 입력하세요">
				</div>
				</c:if>  
				<div class="col-md-6 col-12 mt-3 custom-type-p" >
					<label class="form-label" for="req_name">이름 <span class="text-danger">*</span> </label>
					<input class="form-control " type="text" id="admin_name" name="admin_name" value="${data.admin_name }" placeholder="이름" data-parsley-required="true" data-parsley-id="3" aria-describedby="parsley-id-3" data-parsley-error-message="이름을 정확히 입력하세요">
				</div>
				<div class="col-md-6 col-12 mt-3 custom-type-p" >
					<label class="form-label" for="mobile">연락처 <span class="text-danger">*</span> </label>
					<input class="form-control " type="text" id="mobile" name="mobile" value="${data.mobile }" placeholder="연락처" data-parsley-required="true" data-parsley-id="3" aria-describedby="parsley-id-3" data-parsley-error-message="이름을 정확히 입력하세요">
				</div>
				<div class="col-md-6 col-12 mt-3 custom-type-p">
						<label class="form-label" for="branch_no">지점명<span class="text-danger">*</span></label>
					    <select name="company_no" class="form-control" placeholder="지점명" data-parsley-required="true" data-parsley-id="8" aria-describedby="parsley-id-8" data-parsley-error-message="지점명을 선택하세요">
							<tags:code-select
								codeList="${company }"
								selected="${data.company_no }"
								defaultValue="선택"
							/> 
					</select>
				</div>
				<div class="col-md-6 col-12 mt-3 custom-type-p" >
					<label class="form-label" for="req_name">부서 <span class="text-danger">*</span> </label>
					<%-- <input class="form-control " type="text" id="department_cd" name="department_cd" value="${data.group_name }" placeholder="부서" data-parsley-required="true" data-parsley-id="4" aria-describedby="parsley-id-4" data-parsley-error-message="부서를 정확히 입력하세요"> --%>
					<select class="form-select" id="department_cd" name="department_cd" data-parsley-required="true" data-parsley-id="" data-parsley-error-message="부서를 선택하세요">
							  <tags:code-select
								codeList="${department }"
								selected="${data.department_code }"
								defaultValue="선택"
							/>
					</select>
				</div>		
				<div class="col-md-6 col-12 mt-3 custom-type-p">
						<label class="form-label" for="branch_no">직책<span class="text-danger">*</span> </label>
					    <select class="form-select" id="position_cd" name="position_cd" data-parsley-required="true" data-parsley-id="" data-parsley-error-message="직책을 선택하세요">
							  <tags:code-select
								codeList="${position }"
								selected="${data.position_cd }"
								defaultValue="선택"
							/>
					</select>
				</div>
				<%-- <div class="col-md-6 col-12 mt-3 custom-type-p">
						<label class="form-label" for="branch_no">계정상태<span class="text-danger">*</span> </label>
					    <select id="stat" name="stat" class="form-control " placeholder="계정상태" data-parsley-required="true" data-parsley-id="9" aria-describedby="parsley-id-9" data-parsley-error-message="계정상태를 선택하세요">
							 <tags:code-select
								codeList="${stat_cd }"
								selected="${data.stat }"
								defaultValue="선택"
							/>
					</select>
				</div>  --%>
				<div class="col-md-6 col-12 mt-3 custom-type-p" >
					<label class="form-label" for="card_no">카드번호 </label>
					<input class="form-control " type="text" id="card_no" name="card_no" value="${data.card_no }" placeholder="카드번호" data-parsley-required="false" data-parsley-id="4" aria-describedby="parsley-id-4" data-parsley-error-message="카드번호 정확히 입력하세요" data-parsley-type="number" 	maxlength="4">
				</div>
				<div class="col-md-6 col-12 mt-3 custom-type-p" >
					<label class="form-label" for="car_no">차량번호 </label>
					<input class="form-control " type="text" id="car_no" name="car_no" value="${data.car_no }" placeholder="차량번호" data-parsley-required="false" data-parsley-id="4" aria-describedby="parsley-id-4" data-parsley-error-message="차량번호를 정확히 입력하세요" maxlength="8">
				</div>
				<div class="col-md-6 col-12 mt-3 custom-type-p" >
					<label class="form-label" for="jandi_id">잔디ID<span class="text-danger">*</span> </label>
					<input class="form-control " type="text" id="jandi_id" name="jandi_id" value="${data.jandi_id }" placeholder="잔디ID" data-parsley-required="true" data-parsley-id="4" aria-describedby="parsley-id-4" data-parsley-error-message="잔디ID를 정확히 입력하세요" data-parsley-type="email">
				</div>
				<div class="col-md-6 col-12 mt-3 custom-type-p" >
					<label class="form-label" for="jandi_id">Mac address<span class="text-danger">*</span> </label>
					<input class="form-control " type="text" id="mac_address" name="mac_address" value="${data.mac_address }" placeholder="맥주소" data-parsley-required="true" data-parsley-id="4" aria-describedby="parsley-id-4" data-parsley-error-message="맥주소를 정확히 입력하세요" macAddress>
				</div>
				<div class="col-md-12 col-12 mt-3 ">
					<label class="col-md-2 col-sm-4 form-label" for="manager_hp2">프로필</label>
					<div class="col-md-12 col-12">
						<tags:image-upload2 name="upLoadFile"
	                                       value="${imageList}"
	                                       maxFileCount = "1"
	                                       required = "false"
	                                       category = "IMG_TYPE_ADMIN"
	                                       type="image"
	                    />
					</div> 
				</div> 
			    <input class="form-control " type="hidden" id="main_name" name="department_cd" value="${data.main_name }" >
			    <input class="form-control " type="hidden" id="main_type" name="department_cd" value="${data.main_type }" >
	
				<div class="form-group ">
					<div class="col-sm-14 text-center">
						<button type="button" class="btn btn-primary" id="_dev-save">save</button>
						<c:if test="${empty data.admin_no }">
						    <button class="btn btn-gray" name="_button_page_list" data-to_url="/operation/admin/index">list</button>
						 </c:if>
						 <c:if test="${!empty data.admin_no }">
						    <button class="btn btn-gray" name="_button_page_view" data-to_url="/operation/admin/view" data-to_param="admin_no^${data.admin_no}">cancel</button>
						</c:if>
						<%-- <button type="button" class="btn btn-grey" name="moveBack">${empty data.admin_no ? 'list':'cancel'}</button> --%>
					</div>
				</div>
				</form>
	
			</div>
		</div>
		<!-- end panel -->
<script>
	/* set title name mandatory */
	App.setPageTitle('Admin 운영 | Admin 계정 관리');
	App.restartGlobalFunction();

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
	var datePickerOptions = {
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
	};


	/* set datepicker event */
	var handleDatepicker = function() {
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
	};

	$(document).ready(function() {
		/* datepicker korea language */
		$.fn.datepicker.dates['kr'] = {
			days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
			daysShort: ["일", "월", "화", "수", "목", "금", "토", "일"],
			daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
			months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
		};
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
		
		let data = 	'${data}';
		
		if (data){
			$('#admin_id').attr('disabled', true);
			$('#frm').attr('name','postForm')
			$('#password').attr('data-parsley-required',false);
		}
		
		/* save data */
		$("#_dev-save").on("click", function(e){
			const _name = "Admin 계정등록 저장";	// ajax name
			const _url = "/operation/admin/save/ajax";	// ajax url
			const _form = "frm";	// form name
			
			/* validate */
			let validate 
			
			if (data){
				validate = $("[name=postForm]").parsley().validate();
			} else {
				validate = $("[name=saveForm]").parsley().validate();
			}
			
			if(!validate) {
				console.log('# validate false !!!');
				return;
			}  
			/* let validate = $("[name=save_form]").parsley().validate();
			
			if(!validate) {
				console.log('# validate false !!!');
				return;
			} */  
			/* multi form insert */
			Utils.AdminrequestMultiAjax(_name, _url, _form, {
	            success:  function(data) {
		          	alert(Message.SAVE);
		          	movePage("/operation/admin/index");
	            },
	            complete:  function(response) {}
			});

		});

		/* set mask optional */
	    setInputMask();
	});

</script>