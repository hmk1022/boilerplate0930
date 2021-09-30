<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	$(function() {
		//colorChange();

		$(document).ajaxSuccess(function() {

		});

		/* 문제있을시 해당부분 주석처리 2021.08.10 sb.ahn */
		window.onpopstate = function(event) {
			if (event.state == null) {
				return;
			}
			let _state = event.state;
			let _callFunc = _state.callFunc;
			let _url = _state.url;
			let _param = _state.param;

			if (_callFunc == "getPage") {
				getPage(_url, _param);
			}
			if (_callFunc == "postPage") {
				postPage(_url, _param);
			}
			if (_callFunc == "postTabPage") {
				let _id = _param.id;
				console.log("_id : ", _id);
				//$('a[href="'+_id+'"]').trigger("click");
				postTabPage(_url, _param, _id);
			}
			if (_callFunc == "grid") {
				console.log("grid", grid);
				grid.option("dataModel.postData", _param);
				grid.refreshDataAndView();
			}

		};
		/*********************************************/
		/* Ajax Setup  *****************************************************/
		$.ajaxSetup({
			statusCode : {
				401 : function() {
					alert("로그인후 이용가능합니다.");
					window.location.href = "/";
				}
			}
		});

		// 페이지로 이동.
		$("#app").on("click", "[name='_button_page_list']", function(e) {
			e.preventDefault();
			let param = {};
			let _to_url = $(this).data("to_url");

			console.log("★★★★★★★★★★★★★★★★★★ get page  ★★★★★★★★★★★★★★★★★★");
			console.log("★ url :", _to_url);
			console.log("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");
			getPage(_to_url, param);
		});

		// 페이지로 이동.
		$("#app").on("click", "[name='_button_page_view']", function(e) {
			e.preventDefault();
			let param = {};
			let _to_url = $(this).data("to_url");
			let _to_param = $(this).data("to_param");
			param[_to_param.split("^")[0]] = _to_param.split("^")[1];
			console.log("★★★★★★★★★★★★★★★★★★ get page  ★★★★★★★★★★★★★★★★★★");
			console.log("★ url :", _to_url);
			console.log("★ param :", param);
			console.log("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");
			postPage(_to_url, param);
		});

	});
	/* 페이지 이동 */
	function pageRefresh(movePageUrl, param) {
		if (opener != null) {
			opener.postPage(movePageUrl, param);
			window.close();
		} else {
			postPage(movePageUrl, param)
		}
	}
	/* get auth token */
	function getAuthToken() {
		var authorization = '';
		if (localStorage.getItem('login_data') != null) {
			authorization = 'Bearer ' + JSON.parse(localStorage.getItem('login_data')).token;
		}
		;
		return authorization;
	}

	/* logout function */
	function logout() {
		if (confirm("로그아웃 하시겠습니까?")) {
			localStorage.removeItem('login_data');
			localStorage.clear();
			deleteAllCookies();
			//moveToPage(17);
			location.href = "/";

			$("#chat_box").addClass('hide');
		}
	}

	/* delete login info */
	function deleteAllCookies() {
		var cookies = document.cookie.split(";");

		for (var i = 0; i < cookies.length; i++) {
			var cookie = cookies[i];
			var eqPos = cookie.indexOf("=");
			var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
			document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
		}
	}

	/* plugin */
	var FormPlugins = function() {
		"use strict";
		return {
			//main function
			init : function() {
				handleDatepicker();
			}
		};
	}();

	/* set datepicker */
	var datePickerOptions = {
		format : "yyyy-mm-dd", //데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
		startDate : '2010-01-01', //달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
		//endDate: '+10d',	//달력에서 선택 할 수 있는 가장 느린 날짜. 이후로 선택 불가 ( d : 일 m : 달 y : 년 w : 주)
		autoclose : true, //사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
		//calendarWeeks : false, //캘린더 옆에 몇 주차인지 보여주는 옵션 기본값 false 보여주려면 true
		clearBtn : false, //날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
		//datesDisabled : ['2019-06-24','2019-06-26'],//선택 불가능한 일 설정 하는 배열 위에 있는 format 과 형식이 같아야함.
		//daysOfWeekDisabled : [0,6],	//선택 불가능한 요일 설정 0 : 일요일 ~ 6 : 토요일
		daysOfWeekHighlighted : [
			0
		], //강조 되어야 하는 요일 설정
		disableTouchKeyboard : false, //모바일에서 플러그인 작동 여부 기본값 false 가 작동 true가 작동 안함.
		immediateUpdates : false, //사용자가 보는 화면으로 바로바로 날짜를 변경할지 여부 기본값 :false
		multidate : false, //여러 날짜 선택할 수 있게 하는 옵션 기본값 :false
		//multidateSeparator :",", //여러 날짜를 선택했을 때 사이에 나타나는 글짜 2019-05-01,2019-06-01
		templates : {
			leftArrow : '&laquo;',
			rightArrow : '&raquo;'
		}, //다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징
		showWeekDays : true,// 위에 요일 보여주는 옵션 기본값 : true
		//title: "테스트",	//캘린더 상단에 보여주는 타이틀
		todayHighlight : true, //오늘 날짜에 하이라이팅 기능 기본값 :false
		toggleActive : false, //이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
		weekStart : 0,//달력 시작 요일 선택하는 것 기본값은 0인 일요일
		language : "kr", //달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
	};

	/* set datepicker event */
	var handleDatepicker = function() {
		$('#datepicker-default').datepicker(datePickerOptions);
		$('#datepicker-inline').datepicker({
			todayHighlight : true
		});
		$('.input-daterange').datepicker(datePickerOptions);
		$('#datepicker-disabled-past').datepicker(datePickerOptions);
		$('input[datepicker]').datepicker(datePickerOptions);
		$("div.daterange").each(function() {
			var $inputs = $(this).find('input');
			$inputs.datepicker(datePickerOptions);
			if ($inputs.length >= 2) {
				var $from = $inputs.eq(0);
				var $to = $inputs.eq(1);
				$from.on('changeDate', function(e) {
					if (e.date != undefined) {
						var d = new Date(e.date.valueOf());
						$to.datepicker('setStartDate', d); // 종료일은 시작일보다 빠를 수 없다.
						$to.datepicker('setDate', d); // 시작일은 종료일보다 늦을 수 없다.
					}
				});
				$to.on('changeDate', function(e) {
					var d = new Date(e.date.valueOf());
					$from.datepicker('setEndDate', d); // 시작일은 종료일보다 늦을 수 없다.
				});
				$from.datepicker('setDate', new Date($from.val()));
			}
		})
	};

	/* select member info  */
	function getMemberInfo() {
		const _name = "고객정보조회"; // ajax name
		const _url = "/member/info/ajax"; // ajax url
		const _form = "frm"; // form name

		/* multi form insert */
		Utils.requestAjax(_name, _url, {}, {
			success : function(data) {
				$("#content_admin_id").html(data.admin_id);
				leftMenu();
			},
			complete : function(response) {
			}
		});
	}

	/*
	 * after move ajax page init function
	 */
	function initGlobalFunction() {
		FormPlugins.init();
	}

	function setInputMask() {
		console.log('# set mask !!!');
		/* phone no mask */
		var phones = [
				{
					"mask" : "###-####-####"
				}, {
					"mask" : "###-###-####"
				}
		];
		$("input[phone], h5[phone]").inputmask({
			mask : phones,
			greedy : false,
			placeholder : ' ',
			allowMinus : false,
			definitions : {
				'#' : {
					validator : "[0-9]",
					cardinality : 1
				}
			}
		}).attr("inputmode", "numeric");

		var busno = [
			{
				"mask" : "###-##-#####"
			}
		];
		$("input[busno], h5[busno]").inputmask({
			mask : busno,
			greedy : false,
			placeholder : ' ',
			allowMinus : false,
			definitions : {
				'#' : {
					validator : "[0-9]",
					cardinality : 1
				}
			}
		}).attr("inputmode", "numeric");

		var jubuns = [
			{
				"mask" : "######-#"
			}
		];
		$("input[jubuns], div[jubuns]").inputmask({
			mask : jubuns,
			greedy : false,
			placeholder : ' ',
			allowMinus : false,
			definitions : {
				'#' : {
					validator : "[0-9]",
					cardinality : 1
				}
			}
		}).attr("inputmode", "numeric");

		var datepicker = [
			{
				"mask" : "####-##-##"
			}
		];
		$("input[datepicker], div[datepicker], h5[date]").inputmask({
			mask : datepicker,
			greedy : false,
			placeholder : ' ',
			allowMinus : false,
			definitions : {
				'#' : {
					validator : "[0-9]",
					cardinality : 1
				}
			}
		}).attr("inputmode", "numeric");

		var idno = [
			{
				"mask" : "######-#"
			}
		];
		$("input[idno], h5[idno]").inputmask({
			mask : idno,
			greedy : false,
			placeholder : ' ',
			allowMinus : false,
			definitions : {
				'#' : {
					validator : "[0-9]",
					cardinality : 1
				}
			}
		}).attr("inputmode", "numeric");

		var macAddress = [
			{
				"mask" : "##-##-##-##-##-##"
			}
		];
		$("input[macAddress]").inputmask({
			mask : macAddress,
			greedy : false,
			placeholder : ' ',
			allowMinus : false,
		//definitions: { '#': { validator: "[0-9]", cardinality: 1}}
		}).attr("inputmode");

		/*
		var comma = [{ "mask": "###,###,###,###,###"}];
		$("input[comma], h5[comma]").inputmask({
		    mask: comma,
		    greedy: false,
		    placeholder: '',
		    allowMinus: false,
		    definitions: { '#': { validator: "[0-9]", cardinality: 1}}
		}).attr("inputmode","numeric");
		 */

		$("input[comma], h5[comma], h3[comma], td[comma]").inputmask({
			alias : 'numeric',
			groupSeparator : ',',
			autoGroup : true,
			digits : 0,
			radixPoint : ".",
			digitsOptional : false,
			allowMinus : true,
			//'prefix': 'R$ ',
			placeholder : '',
			rightAlign : !1
		});
	}

	function setDivMask() {
		/* phone no mask */
		var phones = [
				{
					"mask" : "###-####-####"
				}, {
					"mask" : "###-###-####"
				}
		];
		$("div[phone]").inputmask({
			mask : phones,
			greedy : false,
			placeholder : ' ',
			allowMinus : false,
			definitions : {
				'#' : {
					validator : "[0-9]",
					cardinality : 1
				}
			}
		}).attr("inputmode", "numeric");

		var busno = [
			{
				"mask" : "###-##-#####"
			}
		];
		$("div[busno]").inputmask({
			mask : busno,
			greedy : false,
			placeholder : ' ',
			allowMinus : false,
			definitions : {
				'#' : {
					validator : "[0-9]",
					cardinality : 1
				}
			}
		}).attr("inputmode", "numeric");
	}

	function movePage(_url, _param) {

		if (Utils.isEmpty(_url))
			return;
		console.log("menu :", _url);

		let param = Utils.isEmpty(_param) ? null : _param;

		/* 	  	$.ajax({
		 type: "GET",
		 dataType: "html",
		 timeout: 3 * 60 * 1000,
		 url: _url,
		 data:param,
		 beforeSend : function(xhr){
		 xhr.setRequestHeader("Authorization", getAuthToken());
		 },
		 success: function(response) {
		 $("#content").empty();
		 $("#content").css("display", "");
		 $("#subpage").css("display", "none");
		 $("#content").html(response);
		 },
		 error: function(request, status, error) {},
		 complete: function(response) {}
		 }); */

		getPage(_url, param);
	};

	function leftMenu() {
		let _url = "/left_menu";
		let _param = {
			admin_no : JSON.parse(localStorage.getItem("login_data")).member_no
		};
		$.ajax({
			type : "GET",
			dataType : "html",
			timeout : 3 * 60 * 1000,
			url : _url,
			data : _param,
			beforeSend : function(xhr) {
				xhr.setRequestHeader("Authorization", getAuthToken());
			},
			success : function(response) {
				$("#left_menu").empty();
				$("#left_menu").html(response);
			},
			error : function(request, status, error) {
			},
			complete : function(response) {
			}
		});
	};

	function postPage(_url, _param) {

		// go back with div
		$("#_listPage").empty();
		$("#_viewPage").empty();
		$("#_editPage").empty();
		
		if (Utils.isEmpty(_url))
			return;
		console.log("menu :", _url);

		$.ajax({
			type : "POST",
			dataType : "html",
			timeout : 3 * 60 * 1000,
			url : _url,
			data : _param,
			beforeSend : function(xhr) {
				xhr.setRequestHeader("Authorization", getAuthToken());
			},
			success : function(response) {
				$("#content").empty();
				$("#content").css("display", "");
				$("#subpage").css("display", "none");
				$("#content").html(response);

				initGlobalFunction();
				setInputMask();
			},
			error : function(request, status, error) {
			},
			complete : function(response) {
			}
		});
	};

	// move list page
	function goListPage(_url, _param) {

		if (Utils.isEmpty(_url)) return;
		console.log("goListPage :", _url);

		$.ajax({
			type : "GET",
			dataType : "html",
			timeout : 3 * 60 * 1000,
			url : _url,
			data : _param,
			beforeSend : function(xhr) {
				xhr.setRequestHeader("Authorization", getAuthToken());
			},
			success : function(response) {
				$("#content").empty();	// 기존리스트 지우기.
				$("#subpage").empty();
				$("#_listPage").empty();
				$("#_viewPage").hide();
				$("#_editPage").hide();
				$("#_listPage").html(response);
				$("#_listPage").show();
				initGlobalFunction();
				setInputMask();
			},
			error : function(request, status, error) {
			},
			complete : function(response) {
				
			}
		});
	};
	
	// move list page  
	function backListPage() {
		$("#_listPage").show();
		$("#_viewPage").empty();
		$("#_editPage").empty();
		
		// id, name 겹치는 문제 해결				
		$("#_listPage form, #_listPage input, #_listPage select").each(function(item, idx){
		    console.log("name:", $(this).attr("name"));
		    console.log("name:", $(this).attr("id"));
		    
		    if(!Utils.isEmpty($(this).attr("name"))){
		    	$(this).attr("name", Utils.remove($(this).attr("name"),'_temp_name'));	
		    }
		    if(!Utils.isEmpty($(this).attr("id"))){
		    	$(this).attr("id", Utils.remove($(this).attr("id"),'_temp_id'));	
		    }
		});
	};

	// move view page  
	function backViewPage() {
		//$("#_listPage").show();
		$("#_viewPage").show();
		$("#_editPage").empty();
	};
	
	// move view page  
	function goViewPage(_url, _param) {

		if (Utils.isEmpty(_url)) return;
		console.log("menu :", _url);

		$.ajax({
			type : "POST",
			dataType : "html",
			timeout : 3 * 60 * 1000,
			url : _url,
			data : _param,
			beforeSend : function(xhr) {
				xhr.setRequestHeader("Authorization", getAuthToken());
			},
			success : function(response) {
				$("#_listPage").hide();
				$("#_viewPage").empty();
				$("#_editPage").empty();
				$("#_viewPage").html(response);
				$("#_viewPage").show();
				initGlobalFunction();
				setInputMask();
			},
			error : function(request, status, error) {
			},
			complete : function(response) {
				// id, name 겹치는 문제 해결을 위해 name, id 변경				
				$("#_listPage form, #_listPage input, #_listPage select").each(function(item, idx){
				    if(!Utils.isEmpty($(this).attr("name"))){
				    	$(this).attr("name", $(this).attr("name")+'_temp_name');	
				    }
				    if(!Utils.isEmpty($(this).attr("id"))){
				    	$(this).attr("id", $(this).attr("id")+'_temp_id');	
				    }
				});
			}
		});
	};
	
	// move edit page  
	function goEditPage(_url, _param) {

		if (Utils.isEmpty(_url)) return;
		console.log("menu :", _url);

		$.ajax({
			type : "POST",
			dataType : "html",
			timeout : 3 * 60 * 1000,
			url : _url,
			data : _param,
			beforeSend : function(xhr) {
				xhr.setRequestHeader("Authorization", getAuthToken());
			},
			success : function(response) {
				$("#_listPage").hide();
				$("#_viewPage").hide();
				$("#_editPage").empty();
				$("#_editPage").html(response);
				$("#_editPage").show();
				initGlobalFunction();
				setInputMask();
			},
			error : function(request, status, error) {
			},
			complete : function(response) {
				// id, name 겹치는 문제 해결을 위해 name, id 변경				
				$("#_listPage form, #_listPage input, #_listPage select").each(function(item, idx){
				    if(!Utils.isEmpty($(this).attr("name"))){
				    	$(this).attr("name", $(this).attr("name")+'_temp_name');	
				    }
				    if(!Utils.isEmpty($(this).attr("id"))){
				    	$(this).attr("id", $(this).attr("id")+'_temp_id');	
				    }
				});
			}
		});
	};
	
	function getPage(_url, _param) {
		
		// go back with div
		$("#_listPage").empty();
		$("#_viewPage").empty();
		$("#_editPage").empty();
		
		if (Utils.isEmpty(_url))
			return;
		$.ajax({
			type : "GET",
			dataType : "html",
			timeout : 3 * 60 * 1000,
			url : _url,
			data : _param,
			beforeSend : function(xhr) {
				xhr.setRequestHeader("Authorization", getAuthToken());
			},
			success : function(response) {
				$("#content").empty();
				$("#content").css("display", "");
				$("#subpage").css("display", "none");
				$("#content").html(response);
				initGlobalFunction();
				setInputMask();
			},
			error : function(request, status, error) {
			},
			complete : function(response) {
			}
		});
	};

	function pushState(_url, _param, _callFunc) {
		console.log("pushState", _callFunc);
		let _state = {};
		_state.param = _param;
		_state.url = _url;
		_state.callFunc = _callFunc;
		console.log(_callFunc);
		/* 문제있을시 해당부분 주석처리 2021.08.10 sb.ahn */
		window.history.pushState(_state, '', 'main#' + _url);
		/**************************/
	}
	function postTabPage(_url, _param, _target) {
		if (Utils.isEmpty(_url))
			return;
		let element = $(_target);
		let tabBtn = $('a[href="' + _target + '"]')
		$.ajax({
			type : "POST",
			dataType : "html",
			timeout : 3 * 60 * 1000,
			url : _url,
			data : _param,
			beforeSend : function(xhr) {
				xhr.setRequestHeader("Authorization", getAuthToken());
			},
			success : function(response) {
				$(".tab-pane").empty();
				element.html(response);
				element.addClass("show active");
				$(".nav-link").removeClass("active");
				tabBtn.addClass("active");
				initGlobalFunction();
				setInputMask();
			},
			error : function(request, status, error) {
			},
			complete : function(response) {
				//history.pushState(_param,'','main');
			}

		});

	};
</script>

<script>
	/* serialize to json */
	jQuery.fn.serializeObject = function() {
		var obj = null;
		try {
			if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
				var arr = this.serializeArray();
				if (arr) {
					obj = {};
					jQuery.each(arr, function() {
						obj[this.name] = this.value;
					});
				}//if ( arr ) {
			}
		} catch (e) {
			alert(e.message);
		} finally {
		}

		return obj;
	};

	/* message const */
	var Message = {
		SAVE : "저장되었습니다.",
		DELETE : "삭제 됐습니다.",
		CONFIRM : {
			DELETE : "삭제 하시겠습니까?",
		}
	}

	/***** END Utils *****************************************************************************/

	// 숫자 타입에서 쓸 수 있도록 format() 함수 추가
	Number.prototype.money = function() {
		if (this == 0)
			return 0;
		var reg = /(^[+-]?\d+)(\d{3})/;
		var n = (this + '');
		while (reg.test(n))
			n = n.replace(reg, '$1' + ',' + '$2');
		return n;
	};

	// 문자열 타입에서 쓸 수 있도록 format() 함수 추가
	String.prototype.money = function() {
		var num = parseFloat(this);
		if (isNaN(num))
			return "0";
		return num.money();
	};

	/* 전화걸기 */
	function updateCallCnt(work_no, req_hp) {
		var map = {
			work_no : work_no
		};
		$.ajax({
			url : "/admin/updateCallCnt",
			method : 'POST',
			dataType : 'text',
			data : map,
			success : function(str) {
				if (str == "00") {
					location.href = "tel:" + req_hp;
				} else {
					alert('실패하였습니다');
					return false;
				}
			},
			error : function() {
				alert('실패하였습니다');
				return false;
			}
		});
	}

	/* 부재중문자전송 */
	function sendSms(req_hp, admin_hp, admin_name) {
		let sms_url = "sms:" + req_hp;
		if (admin_name != undefined && admin_name != '') {
			sms_url += '?body=안녕하세요. 워커맨 ' + admin_name + '입니다.\n';
		}
		location.href = sms_url;

		/*
		if(admin_hp == ""){
			alert("워커폰 번호가 미등록되어 있습니다. \n기술연구소에 문의해 주세요.");
			return;
		}
		if(confirm("고객에게 부재중 문자를 전송하시겠습니까?")){
			var map = {
				req_hp   	: req_hp,
				admin_hp 	: admin_hp
			};
			$.ajax({
				url : "/admin/sendSms",
				method : 'POST',
				dataType: 'text',
				data : map,
				success : function(str) {
				  if(str =="00"){
					 alert("문자가 전송 됐습니다");
				  }else{
					  alert('실패하였습니다');
					  return false;
				  }
				},
				error : function() {
					alert('실패하였습니다');
					return false;
				}
			});
		}
		 */
	}
</script>


<script>
	/* param query script const */
	const PARAM_QUERY = {
		GRID_WIDTH : '100%',
		GRID_HEIGHT : 550,
		GRID_INIT_CNT : 50,
	}

	/* workerman grid */
	var excelGrid;
	var Wgrid = {
		draw : function(element, param, url, colModel, options, desc) {

			console.log("★★★★★★★★★★★★★★★★★★ call ajax ★★★★★★★★★★★★★★★★★★");
			console.log("★ desc :", desc);
			console.log("★ url :", url);
			console.log("★ param :", param);
			console.log("★ GRID_WIDTH :", PARAM_QUERY.GRID_WIDTH);
			console.log("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");

			let dataModel = {
				location : "remote",
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				dataType : "text",
				method : "POST",
				url : url,
				postData : param,
				beforeSend : function(jqXHR, settings) {
					//console.log('!! beforeSend !!');
					jqXHR.setRequestHeader("Authorization", getAuthToken());
				},
				error : function(jqXHR, textStatus, errorThrown) {
					//console.log('!! pgGrid Error !!');
				},
				getData : function(response) {
					var responseJson = JSON.parse(response);
					//console.log("data",response);
					return {
						curPage : responseJson.curPage == 0 ? 1 : responseJson.curPage,
						totalRecords : responseJson.totalRecords == 0 ? 1 : responseJson.totalRecords,
						data : responseJson.data
					};
				}
			}
			//main object to be passed to pqGrid constructor.
			let defaultOptions = {
				showTop : false,
				width : PARAM_QUERY.GRID_WIDTH, //width of grid
				height : PARAM_QUERY.GRID_HEIGHT, //height of grid
				colModel : colModel,
				pageModel : {
					type : "remote",
					rPP : PARAM_QUERY.GRID_INIT_CNT,
					strRpp : "{0}"
				},
				dataModel : dataModel,
				resizable : true,
				editable : false,
				scrollModel : {
					autoFit : false
				},
				selectionModel : {
					type : 'cell'
				},
				/* cellRightClick: function (evt, ui) {
				    let text = this.getCell( { rowIndx: ui.rowIndx, dataIndx:ui.dataIndx}).text();
				    let tempElement = document.createElement("textarea");
				    $(tempElement).val(text);
				    console.log( $("body").append(tempElement) );
				    tempElement.select();
				    document.execCommand("copy");
				    tempElement.remove();
				}, */
				contextMenu : {
					on : true,
					cellItems : [
						{
							name : '복사',
							icon : 'ui-icon ui-icon-copy',
							action : function(evt, ui, item) {
								let text = this.getCell({
									rowIndx : ui.rowIndx,
									colIndx : ui.colIndx
								}).text();
								let tempElement = document.createElement("textarea");
								$(tempElement).val(text);
								$("body").append(tempElement)
								tempElement.select();
								document.execCommand("copy");
								tempElement.remove();
							}
						}
					]
				},
				copyModel : {
					render : true
				},
				stripeRows : true,
				showBottom : true,
				numberCell : {
					resizable : true,
					width : 30,
					title : " "
				},
				//bootstrap: { on : true },
				flexHeight : true,
				rowBorders : true,
				rowHtHead : 35,
				rowHt : 35,
				columnTemplate : {
					//set horizontal and vertical alignment of all cells in all columns.
					valign : 'center'
				},
			};

			let settings = $.extend({}, defaultOptions, options);
			console.log(settings);
			$(element).on("contextmenu", function(e) {
				return false;
			});
			return pq.grid(element, settings);
		},
		excel : function(_excelParam, _excelUrl, _excelOptions) {
			console.log("_excelOptions", _excelOptions);
			$("body").append("<div id=\"grid_excel\" style=\"display:none;\"></div>");
			let title = _excelOptions.title == "&nbsp;" ? "export_excel" : _excelOptions.title;
			let ext = "xlsx";
			let saveFileName = title + "." + ext
			let excelOptions = {
				load : function(event, ui) {
					let excelBlob = excelGrid.exportData({
						format : ext,
						render : true
					});
					saveAs(excelBlob, saveFileName);
				},
				pageModel : {}
			}
			let options = $.extend({}, excelOptions, _excelOptions);
			if (excelGrid != null) {
				excelGrid.destroy();
			}
			excelGrid = Wgrid.draw("#grid_excel", _excelParam, _excelUrl, '', options);
		}
	}
	/* modal */
	var Modal = {
		$element : $("#modal-dialog"),
		$title : $("#modal-dialog").find("h4.modal-title"),
		$description : $("#modal-dialog").find("div.modal_description"),
		$content : $("#modal-dialog").find("div.modal-body"),
		defaultOptions : {
			title : "모달창 기본타이틀",
			description : "",
			content : "<div id=\"modal_grid\"></div>",
			size : "",
			callback : "",
			callbackParam : ""
		},
		init : function(settings) {
			/* modal 사이즈 설정 */
			this.$element.find(".modal-dialog").removeClass("modal-lg modal-xl");
			this.$element.find(".modal-dialog").addClass(settings.size);
			this.$title.html(settings.title);
			this.$description.html(settings.description);
			this.$content.html(settings.content);
		},
		popup : function(options) {
			let settings = $.extend({}, this.defaultOptions, options);
			/* 모달창 초기화 */
			this.init(settings);

			/* modal 호출 후 실행 될 함수 bind*/
			console.log(typeof settings.callback);
			if (typeof settings.callback === 'function') {
				this.$element.one("shown.bs.modal", function(e) {
					settings.callback(settings.callbackParam);
				});
			}
			/* modal show */
			this.$element.modal("show");
			console.log(this);
		},
		close : function() {
			this.$element.modal("hide");
		}

	}

	/*
	 *********** pq grid init
	1. 최초 수정 불가 페이지로 로드.




	 */

	/* 코드 목록 */
	function listCode() {
		const _name = "코드목록 조회"; // ajax name
		const _url = "/common/code/list/ajax"; // ajax url

		/* multi form insert */
		Utils.requestAjax(_name, _url, {}, {
			success : function(data) {

				//debugger;
				console.log("data:", data.length);
				console.log("addr_cd:", data.addr_cd);
				let no = 0;
				$.each(data, function(_key, _item) {
					//console.log("key:", _key, "data list :", _item, "=idx=", ++no);
					session.setItem("code." + _key, JSON.stringify(_item));
				});
			},
			complete : function(response) {
				console.log('complete!!!');
			}
		});
	}

	/* session storage */
	window.session = window.sessionStorage || (function() {
		// window.sStorage = (function() {
		var winObj = opener || window; //opener가 있으면 팝업창으로 열렸으므로 부모 창을 사용
		var data = JSON.parse(winObj.top.name || '{}');
		var fn = {
			length : Object.keys(data).length,
			setItem : function(key, value) {
				data[key] = value + '';
				winObj.top.name = JSON.stringify(data);
				fn.length++;
			},
			getItem : function(key) {
				return data[key] || null;
			},
			key : function(idx) {
				return Object.keys(data)[idx] || null; //Object.keys() 는 IE9 이상을 지원하므로 IE8 이하 브라우저 환경에선 수정되어야함
			},
			removeItem : function(key) {
				delete data[key];
				winObj.top.name = JSON.stringify(data);
				fn.length--;
			},
			clear : function() {
				winObj.top.name = '{}';
				fn.length = 0;
			}
		};
		return fn;
	})();

	/* if empty session storage */
	if (session.getItem("code.work_stat") == null) {
		listCode();
	}

	/* code list */
	function getCode(_code_gb) {
		if (Utils.isEmpty(_code_gb))
			return 'empty code group';
		let _item = JSON.parse(session.getItem("code." + _code_gb));
		if (Utils.isEmpty(_item))
			return 'empty code list';
		else
			return _item;
	}

	/* code name */
	function getCodeNm(_code_gb, _code_value) {
		if (Utils.isEmpty(_code_gb))
			return 'empty code group';
		let _item = JSON.parse(session.getItem("code." + _code_gb));

		let _code_name = "";
		$.each(_item, function(idx, item) {
			if (_code_value == item.code_value) {
				_code_name = item.code_name;
				return false;
			}
		});
		return _code_name;
	}

	function maskCurrency(amount) {
		return new Intl.NumberFormat().format(amount) + " 원";
	}
	/**
	function createCodeDb(){
		const dbName = "code_db";

		var request = indexedDB.open(dbName, 2);

		request.onerror = function(event) {
		  // Handle errors.
		};
		request.onupgradeneeded = function(event) {
		  var db = event.target.result;

		  // Create an objectStore to hold information about our customers. We're
		  // going to use "ssn" as our key path because it's guaranteed to be
		  // unique - or at least that's what I was told during the kickoff meeting.
		  var objectStore = db.createObjectStore("customers", { keyPath: "ssn" });

		  // Create an index to search customers by name. We may have duplicates
		  // so we can't use a unique index.
		  objectStore.createIndex("name", "name", { unique: false });

		  // Create an index to search customers by email. We want to ensure that
		  // no two customers have the same email, so use a unique index.
		  objectStore.createIndex("email", "email", { unique: true });

		  // Use transaction oncomplete to make sure the objectStore creation is
		  // finished before adding data into it.
		  objectStore.transaction.oncomplete = function(event) {
		    // Store values in the newly created objectStore.
		    var customerObjectStore = db.transaction("customers", "readwrite").objectStore("customers");
		    customerData.forEach(function(customer) {
		      customerObjectStore.add(customer);
		    });
		  };
		};
	}*/
	function onlyNumber(evt) {
		var code = evt.which ? evt.which : event.keyCode;
		if (!((code > 47 && code < 58) || code == 37 || code == 39 || code == 8)) {
			return false;
		}
	}

	// 이미지 팝업
	function getImagePop(_img_type, _key_no, _image_name) {

		var popup = window.open('/popup/common/img?img_type=' + _img_type + '&key_no=' + _key_no + '&image_name=' + _image_name, '_expense', 'width=1200px,height=max ,scrollbars=yes');
	}

	// link 팝업
	function getLinkPop(_link, _image_name) {
		if (Utils.isEmpty(_link)) {
			alert('link가 존재하지 않습니다.');
			return;
		} else {
			if (_link.indexOf('http://') == -1 && _link.indexOf('https://') == -1) {
				alert('잘못된 url입니다.');
				return;
			}
		}
		var popup = window.open(_link, '_expense', 'width=1200px,height=700px,scrollbars=yes');
	}

	$(document).ready(function() {

		/* datepicker korea language */
		$.fn.datepicker.dates['kr'] = {
			days : [
					"일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"
			],
			daysShort : [
					"일", "월", "화", "수", "목", "금", "토", "일"
			],
			daysMin : [
					"일", "월", "화", "수", "목", "금", "토", "일"
			],
			months : [
					"1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"
			],
			monthsShort : [
					"1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"
			]
		};
		/* init plugin */
		FormPlugins.init();

		/* begin move page ajax ****************************************************************/
		$('#sideMenu a').on("click", function(e) {
			let _url = $(this).data("url");
			if (Utils.isEmpty(_url))
				return;
			getPage(_url, {});
		});

		$("#content").on("click", "[name=movePage]", function(e) {
			let _url = $(this).data("url");
			if (Utils.isEmpty(_url))
				return;
			console.log("menu :", _url);
			$.ajax({
				type : "GET",
				dataType : "html",
				timeout : 3 * 60 * 1000,
				url : _url,
				beforeSend : function(xhr) {
					xhr.setRequestHeader("Authorization", getAuthToken());
				},
				success : function(response) {
					$("#content").css("display", "none");
					$("#subpage").show().html(response);
					initGlobalFunction();
					setInputMask();
				},
				error : function(request, status, error) {
				},
				complete : function(response) {
				}
			});
		});

		$("#subpage").on("click", "[name=moveBack]", function(e) {
			$("#content").css("display", "");
			$("#subpage").empty();
		});

		/* end move page ajax ****************************************************************/

		getMemberInfo(); // 회원정보 조회.

		/* 초기화 검색 폼 */
		$(".app-content").on("click", "#search_init", function(e) {
			console.log("form init")
			$("#frm_search")[0].reset();
		});

		$(".app-content").on("click", "._btn_init_srch", function(e) {
			$("#frm_search")[0].reset();
		});

		// 검색 페이지 엔터키 처리
		$("#app").on("keydown", "#frm_search input, #frm_search select", function(key) {
			if (key.keyCode == 13) {
				$("#frm_search .btn-search").trigger("click");
				return false;
			} else {
				//console.log('key:', key.keyCode);
			}
		});

	});
</script>