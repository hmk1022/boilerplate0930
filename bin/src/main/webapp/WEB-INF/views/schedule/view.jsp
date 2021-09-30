<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- begin page-header -->
<h1 class="page-header">
	일정관리<span class="ms-3 fw-bold"></span>
</h1>
<!-- end page-header -->
<div class="row">
	<div class="col-12 mb-3">
		<div class="card">
			<div class="card-body border border-primary">
				<div class="row">
					<div class="col-md-25 col-4">
						<label class="form-label">조회일</label>
						<div class="input-group date input-daterange">
							<input type="text" class="form-control" placeholder="연도. 월. 일." id="date_ymd" name="date_ymd">
						</div>
					</div>
<!--                     <div class="col-md-25 col-4">
                    <label class="form-label">워커맨타입</label>
                   		 <div class="">
                        <button type="button" id="workerman_02" value="02" class="btn btn-outline-warning workerman-type active">워커맨</button>
                        <button type="button" id="workerman_03" value="03" class="btn btn-outline-secondary workerman-type active">외주</button>
                        </div>
                    </div> -->
				</div>
			</div>
		</div>
		<div class="card mt-4">
			<div class="card-body border">
				<div class="row">
					<div class="form-group mt-3" id="calendar"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<form name="frm_schedule" id="frm_schedule" target="_schedule" action="/popup/schedule/form" method="POST">
	<input type="hidden" name="admin_no" id="admin_no" value="">
	<input type="hidden" name="workerman_type" id="workerman_type" value="">
	<input type="hidden" name="admin_name" id="admin_name" value="">
	<input type="hidden" name="date" id="date" value="">
	<input type="hidden" name="schedule_group_no" id="schedule_group_no" value="">
</form>

<!-- page script -->

<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<script>
	App.restartGlobalFunction();

	$.when(

	$.getScript('/assets/plugins/parsleyjs/dist/parsley.min.js'),
			$.getScript('/assets/plugins/highlight.js/highlight.min.js'),
			$.Deferred(function(deferred) {
				$(deferred.resolve);
			})).done(
			function() {
				$.getScript('/assets/js/demo/render.highlight.js'), $
						.Deferred(function(deferred) {
							$(deferred.resolve);
						})
			});

	/* set mask optional */
	setDivMask();
</script>
<!-- ================== END PAGE LEVEL JS ================== -->

<script>
	function popScheduleForm() {
		let _form = $("#frm_schedule"); // form name
		var popup = window.open('', '_schedule','width=600px,height=600px,scrollbars=yes');
		_form.submit();
	}

	function workermanType(){
		console.log(this.className);
		$(this).toggleClass("active");
	}

	function init() {
		calendar();
		$("#date_ymd").val(new Date());
		$("#date_ymd").datepicker('setDate', new Date($("#date_ymd").val()));
		$("#date_ymd").on("changeDate",function(e){
			var date = new Date(e.date.valueOf());
			console.log(date);
			console.log(e);
			if($("#date_ymd").val() != null){
				calendar.gotoDate($("#date_ymd").val());
			}
		});
		$(".workerman-type").on("click",workermanType);

	}

	var calendar;
	function calendar() {
		var calendarEl = document.getElementById('calendar');
		calendar = new FullCalendar.Calendar(
				calendarEl,
				{
					schedulerLicenseKey : '0846060009-fcs-1621225175',
					initialView : 'resourceTimeline',
					locale : 'kr',
					height : 900,
					editable : false,
					buttonText : {
						today : "오늘",
						month : "월별",
						week : "주별",
						day : "일별",
					},
					slotMinTime : '06:00:00',
					slotMaxTime : '24:00:00',
					slotLabelFormat : {
						hour : 'numeric',
						minute : '2-digit',
						omitZeroMinute : true,
						meridiem : 'short',
						hour12 : false
					},
					resourceAreaWidth : 200,
					views : {
						resourceTimeline : {
							type:'resourceTimeline'
						}
					},
					resourceAreaColumns : [ {
						headerContent : '워커맨',
						field : 'title'
					} ],
					resources : function(fetchInfo, successCallback,
							failureCallback) {
						const _name = "calendar resource"; // ajax name
						const _url = "/schedule/admin/list/ajax"; // ajax url
						const _form = ""; // form name
						let _param = {};
						_param.workerman_type = "";
						console.log("_param : ",_param);
						console.log($(".workerman-type.active"));
						Utils.requestAjax(_name, _url, _param, {
							beforeSend : function() {
							},
							success : function(response) {
								successCallback(response.data);
							},
							complete : function(response) {
								console.log("complete : ", calendar.getDate());
								$("td.fc-datagrid-cell.fc-resource").on(
										"click",
										function() {
											let resource_id = $(this).data("resource-id");
											let workerman_type = resource_id.split("_")[0];
											let admin_no = resource_id.split("_")[1];
											let admin_name = $(".fc-datagrid-cell-main",this).text();
											$("#workerman_type").val(workerman_type);
											$("#admin_no").val(admin_no);
											$("#admin_name").val(admin_name);
											popScheduleForm();
										});
								$("td.fc-datagrid-cell.fc-resource").css(
										"cursor", "pointer");
							}
						});
					},
					resourceGroupField: 'dept',
					resourceGroupLabelDidMount:function(event){
						if(event.groupValue != "B2B" && event.groupValue != "프로젝트팀" ){
							$(".fc-icon-minus-square", event.el).trigger("click");
						}
					},
					resourceOrder : 'workerman_type,-main_type,admin_name',
					events : function(fetchInfo, successCallback,
							failureCallback) {
						const _name = "calendar resource"; // ajax name
						const _url = "/schedule/list/ajax"; // ajax url
						const _form = ""; // form name
						let _param = {
							"start" : fetchInfo.start,
							"end" : fetchInfo.end
						};
						Utils.requestAjax(_name, _url, _param, {
							beforeSend : function() {
							},
							success : function(response) {
								successCallback(response.data);
								console.log("response.data", response.data);
								let date = fetchInfo.start;
								$("#date").val(date);
							},
							complete : function(response) {
							}
						});
					},
					eventContent : function(event) {
						let schedule_type = event.event.extendedProps.schedule_type;
						let admin_name = event.event.extendedProps.admin_name;
						let title = event.event.title;
						let scd_text = event.event.extendedProps.scd_text;
						let content;
						console.log(event.backgroundColor);
						if ('05|06|07|08|09|10|11'.match(schedule_type)) {
							content = "["
									+ getCodeNm("p_scd_type", schedule_type)
									+ "] ";
						} else if (schedule_type == '99') {
							content = "["
									+ getCodeNm("p_scd_type", schedule_type)
									+ "] " + scd_text;
						} else if ('31|32|33'.match(schedule_type)) {
							content = title;
						}

						if ('05|06|07|08|09|10|11'.match(schedule_type)) {
							event.backgroundColor = "#6c757d";
						} else if (schedule_type == '99') {
							event.backgroundColor = "#727cb6";
						} else if ('31' == schedule_type) {
							event.backgroundColor = "#f59c1a";
						} else if ('32' == schedule_type) {
						} else if ('33' == schedule_type) {
							event.backgroundColor = "#49b6d6";
						}
						let returtnText = '<div class="fc-event-main-frame"><div class="fc-event-title-container"><div class="fc-event-title fc-sticky" style="top: 0px;">'
								+ content + '</div></div></div>';
						return {
							html : returtnText
						}
					},
					eventDidMount : function(event) {
						let schedule_type = event.event.extendedProps.schedule_type;
						if(!'31|32|33'.match(schedule_type)){
							$(event.el).css("cursor","pointer");
						}
						tippy(event.el, {
							content : event.el.text,
						});
					},
					eventClick : function(event) {
						let schedule_type = event.event.extendedProps.schedule_type;
						let schedule_group_no = event.event.extendedProps.schedule_group_no;
						let admin_name =event.event.extendedProps.admin_name;
						if(!'31|32|33'.match(schedule_type)){
							console.log(event);
							$("#schedule_group_no").val(schedule_group_no);
							$("#admin_name").val(admin_name);
							popScheduleForm();
							$("#schedule_group_no").val("");
						}
					}
				});
		calendar.render();
	}
	$(function() {
		init();
	});
</script>
