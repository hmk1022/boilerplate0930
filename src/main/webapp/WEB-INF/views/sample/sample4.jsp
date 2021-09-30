<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

	<!-- begin page-header -->
	<h1 class="page-header">고객사/지점 <small>코드관리</small></h1>
	<!-- end page-header -->
	<!-- begin panel -->
	<div class="panel panel-inverse">
		<div class="panel-heading">
			<h4 class="panel-title">고객사/지점 목록</h4>
			<div class="panel-heading-btn">
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-success" data-click="panel-reload"><i class="fa fa-redo"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
			</div>
		</div>
		<div class="panel-body" style="">
			<form class="form-horizontal form-bordered" data-parsley-validate="true" name="frm" id="frm" novalidate="" enctype="multipart/form-data">
			<input type="hidden" id="branch_no" name="branch_no" value="${data.branch_no }" >
			<!-- 
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label">고객사 * </label>
				<div class="col-md-4 col-sm-8">
					<select 
						class="form-control parsley-success" 
						id="select-required" name="customer_no" 
						data-parsley-required="true" data-parsley-id="1"
						data-parsley-error-message="고객사를 선택하세요!"
					>
						<option value="">고객사 선택</option>
						<option value="1">Foo</option>
						<option value="2">Bar</option>
					</select>
				<ul class="parsley-errors-list" id="parsley-id-21" aria-hidden="true"></ul>
				</div>
			</div>
			 -->
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="branch_name_a">고객사 * </label>
				<div class="col-md-4 col-sm-8">
					<input class="form-control ui-autocomplete-input" type="text" id="customer_name" name="customer_name" value="${data.customer_name }" placeholder="고객사명" data-parsley-required="true" data-parsley-id="1" aria-describedby="parsley-id-1">
					<input type="hidden" id="customer_no" name="customer_no" value="${data.customer_no }" >
				</div>
			</div>			
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="branch_name">지점명 * </label>
				<div class="col-md-4 col-sm-8">
					<input class="form-control " type="text" id="branch_name" name="branch_name" value="${data.branch_name }" placeholder="지점명" data-parsley-required="true" data-parsley-id="1" aria-describedby="parsley-id-1">
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="comp_number">사업자번호 * </label>
				<div class="col-md-4 col-sm-8">
					<input class="form-control " type="text" id="comp_number" name="comp_number" value="${data.comp_number }" placeholder="사업자번호" data-parsley-required="true" data-parsley-id="2" aria-describedby="parsley-id-2" busno>
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="email">담당자 * </label>
				<div class="col-md-4 col-sm-8">
					<input class="form-control " type="text" id="email" name="manager_name" value="${data.manager_name }" placeholder="담당자" data-parsley-required="true" data-parsley-id="3" aria-describedby="parsley-id-3">
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="manager_email">이메일 * </label>
				<div class="col-md-4 col-sm-8">
					<input class="form-control " type="text" id="manager_email" name="manager_email" value="${data.manager_email }" data-parsley-type="email" placeholder="Email" data-parsley-required="true" data-parsley-id="4" aria-describedby="parsley-id-4">
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="manager_hp1">연락처1 * </label>
				<div class="col-md-4 col-sm-8">
					<input class="form-control" type="text" id="manager_hp1" name="manager_hp1" value="${data.manager_hp1 }" placeholder="연락처" data-parsley-id="5" data-parsley-required="true" phone>
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="manager_hp2">연락처2</label>
				<div class="col-md-4 col-sm-8">
					<input class="form-control" type="text" id="manager_hp2" name="manager_hp2" value="${data.manager_hp2 }" placeholder="연락처" data-parsley-id="6" phone>
				</div>
			</div>
			
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="manager_hp2">사업자등록증 사본</label>
				<div class="col-md-8 col-sm-8">
					
					<input id="input-file-1" name="upLoadFile" multiple type="file" accept="image/*" data-browse-on-zone-click="true">
					
				</div>
			</div>
			
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="manager_hp2">통장 사본</label>
				<div class="col-md-8 col-sm-8">
					<input class="form-control" type="text" id="manager_hp2" name="manager_hp2" value="${data.manager_hp2 }" placeholder="연락처" data-parsley-id="6" phone>
				</div>
			</div>
			
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="manager_hp2">파일 업로드</label>
				<div class="col-md-4 col-sm-8">
					<input class="form-control" type="text" id="manager_hp2" name="manager_hp2" value="${data.manager_hp2 }" placeholder="연락처" data-parsley-id="6" phone>
				</div>
			</div>

			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="select_date">게시일</label>
				<div class="col-md-4 col-sm-8 input-group">
					<input type="text" class="form-control datepicker" name="select_date" id="select_date" placeholder="select date" />
					<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
				</div>
			</div>
			
			<div class="form-group ">
				<div class="col-sm-14 text-center">
					<button type="button" class="btn btn-primary" id="_dev-save">save</button>
					<button type="button" class="btn btn-grey" name="moveBack">${empty data.branch_no ? 'list':'cancel'}</button>
				</div>
			</div>
			</form>

		</div>
	</div>
	<!-- end panel -->

    
<script>
	/* set title name mandatory */
	App.setPageTitle('코드관리 | 고객사/지점');
	App.restartGlobalFunction();

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
		          	movePage("/code/customer/branch/index");
	            },
	            complete:  function(response) {}
			});

		});
		
		/* auto complete */
	    $("#customer_name").autocomplete({
	        source: function( request, response ) {
                $.ajax({
                    type: 'POST',
                    url: "/code/customer/list/ajax",
                    dataType: "json",
                    data: JSON.stringify({customer_name: $("#customer_name").val()}),
                    contentType: "application/json",
                    success: function(data) {
                        response(
                            $.map(data, function(item) {    //json[i] 번째 에 있는게 item 임.
                                return {
                                    label: item.customer_name,    //UI 에서 보여지는 글자, 실제 검색어랑 비교 대상
                                    value: item.customer_name,    //사용자 설정값
                                    customer_no : item.customer_no
                                }
                            })
                        );
                    }
               });
            },
	        select: function(event, ui) { 
	        	$("#customer_no").val(ui.item.customer_no);
	        },
	        minLength: 2,
	        autoFocus: false,	        
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


<!-- file upload css, script END -->
<script defer>
						
	/* image config list */
	var fileList = []; // image url list 
	var fileConfig = [];	// img config 
	var imgList = [];	// img list temp
	
	console.log("", '${imageList}');
	console.log("", JSON.stringify('${imageList}'));
	
	var temp = {};
	<c:forEach var="item" items="${imageList}" varStatus="status">
	temp = {};
	temp['caption'] = '${item.img_name}';
	temp['type'] = 'image';
	temp['size'] = '${item.img_size}';
	temp['key'] = '${item.branch_no}';
	temp['img_url'] = '${item.img_url}';
	fileConfig.push(temp);
	</c:forEach> 
	
	/* file list */
	$.each(fileConfig, function(idx, item){
		fileList.push(item.img_url);
	});
	
	console.log("fileList", fileList);
	console.log("fileConfig", fileConfig);
	
	const fileinput = {
	    uploadUrl: "/file/upload",
	    autoOrientImage: true,
	    //previewFileIcon: '<i class="fas fa-file"></i>',
	    allowedFileExtensions : [ 'jpg', 'jpeg', 'png', 'gif', 'war' ],
		//allowedFileTypes: ['image', 'video', 'flash'],
		overwriteInitial : false,
		maxFileSize : 10000,
		maxFilesNum : 10,
		enctype: 'multipart/form-data',
		fileActionSettings: {
			showUpload: false, // Removing upload button from action settings
		},
		showUpload: false,
	    showClose: false,
	    showCaption: true,	
		slugCallback : function(filename) {
			return filename.replace('(', '_').replace(']', '_');
		},
		theme: 'fas',	// theme
		initialPreview: fileList,	// 초기 이미지 목록
	    initialPreviewAsData: true, // defaults markup  
		initialPreviewConfig: fileConfig,	// file config list
	    deleteUrl : "/file/delete",			// file delete url
	    preferIconicPreview: false,	// file content or icon view					        
	}
	
	$("#input-file-1").fileinput(fileinput).on('fileuploaded', function(event, previewId, index, fileId) {
	    console.log('File Uploaded', 'ID: ' + fileId + ', Thumb ID: ' + previewId);
	}).on('fileuploaderror', function(event, previewId, index, fileId) {
	    console.log('File Upload Error', 'ID: ' + fileId + ', Thumb ID: ' + previewId);
	}).on('filebatchuploadcomplete', function(event, preview, config, tags, extraData) {
		console.log('File Batch Uploaded', preview, config, tags, extraData);
	}).on( 'filesorted', function (e, params) {
	    console.log ( '파일 정렬 변수', params);
	});


</script>