<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

	<!-- begin page-header -->
	<h1 class="page-header">권한 관리 <small>Admin 운영</small></h1>
	<!-- end page-header -->
	<!-- begin panel -->
	<div class="card">
		<div class="card-header">
            <h3 class="mb-0">권한 등록</h3>
        </div>
		<div class="card-body" style="">
			<form class="form-horizontal form-bordered" data-parsley-validate="true" name="frm" id="frm" novalidate="" enctype="multipart/form-data">
			<input type="hidden" id="role_no" name="role_no" value="${data.role_no }" >
				<div class="row">
					<div class="col-md-6 col-12 mt-3">
						<label class="form-label" for="req_hp">권한명 <span class="text-danger">*</span></label>
						<input class="form-control " type="text" id="name" name="name" value="${data.name }" placeholder="권한명을 입력해주세요" data-parsley-required="true"  data-parsley-error-message="권한명을 정확히 입력하세요.">
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
		
		$("[name=moveBack]").on("click", function(){
			movePage("/operation/role/index");
		});
		
		console.log('page script !!!! ');
		/* save data */
		$("#_dev-save").on("click", function(e){
			const _name = "admin role 저장";	// ajax name
			const _url = "/operation/role/save/ajax";	// ajax url
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
		          	movePage("/operation/role/index");
	            },
	            complete:  function(response) {}
			});

		});

		/* set mask optional */
	    setInputMask();
	});

</script>