<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
<div class="d-flex align-items-center justify-content-between mb-3">
	<h4 class="mb-0">하위작업 및 일정 관리</h4>
	<button type="button" class="btn btn-primary btn-modal-save-sub-work" id="" data-work_no="${workData.work_no }">하위작업등록</button>
</div>
</c:if>
<c:choose>
	<c:when test="${!empty subWorkList }">
		<c:forEach var="data" items="${subWorkList}" varStatus="cnt">
			<div class="card mb-2">
				<div class="card-body">
					<div class="w-100 d-flex align-items-center justify-content-between mb-2">
						<div class="">
							<h5 class="mb-0">${data.work_id }<span class="ms-2 text-primary">${data.location_name } </span><span class="ms-2 small text-dark">${data.admin_memo }</span>
							</h5>
						</div>
						<div class="d-flex ">
							<button type="button" class="btn btn-gray btn-modal-modify-sub-work" data-work_no="${data.work_no }" data-location_name="${data.location_name}" data-admin_memo="${data.admin_memo}">수정</button>
							<c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
							<button type="button" class="btn btn-success ms-2 btn-modal-save-schedule" data-work_no="${data.work_no}" data-location_name="${data.location_name}">일정등록</button>
							</c:if>
						</div>
					</div>
					<c:choose>
						<c:when test="${!empty data.scheduleList }">
							<c:forEach var="scheduleData" items="${data.scheduleList }" varStatus="cnt">
								<div class="accordion">
									<div class="accordion-item border-0">
										<div class="accordion-header" id="headingOne">
											<div class="accordion-button px-3 py-10px pointer-cursor collapsed" type="button" data-toggle="collapse" data-target="#collapseOne_${scheduleData.schedule_group_no}" aria-expanded="false">
												<div class="row w-100">
													<div class="col-md-1 col-5">
														<label class="form-label text-muted">타입</label>
														<h5>
															<tags:code-name code_gb="work_type" value="${scheduleData.schedule_type}" />
														</h5>
													</div>
													<div class="col-md-3 col-5">
														<label class="form-label text-muted">일정</label>
														<h5>
															<tags:str-date value="${scheduleData.st_date_ymd}" hasDayOfWeek="true" />
															-
															<tags:str-date value="${scheduleData.ed_date_ymd}" hasDayOfWeek="true" />
															${scheduleData.st_date_h}:${scheduleData.st_date_m} ~ ${scheduleData.ed_date_h}:${scheduleData.ed_date_m}
														</h5>
													</div>
													<div class="col-md-3 col-5 mt-md-0 mt-3">
														<label class="form-label text-muted">워커맨</label>
														<h5>${scheduleData.workerman_admin_name }</h5>
													</div>
													<div class="col-md-3 col-5 mt-md-0 mt-3">
														<label class="form-label text-muted">외주</label>
														<h5>
															<c:choose>
																<c:when test="${scheduleData.workerman_partner_name ne null}"> ${scheduleData.workerman_partner_name } </c:when>
																<c:otherwise> - </c:otherwise>
															</c:choose>
														</h5>
													</div>
													<div class="col-md-1 col-5 mt-md-0 mt-3">
														<label class="form-label text-muted">상태</label>
														<h5>
															<tags:code-name code_gb="schedule_stat" value="${scheduleData.schedule_stat}" />
														</h5>
													</div>
												</div>
											</div>
										</div>
										<c:if test="${scheduleData.schedule_stat ne '35' }">
											<div id="collapseOne_${scheduleData.schedule_group_no }" class="accordion-collapse collapse " style="">
												<div class="accordion-body">
													<div class="row">
														<div class="col-3">
															<button type="button" class="btn btn-danger btn-modal-end-schedule" data-work_no="${data.work_no}" data-schedule_group_no="${scheduleData.schedule_group_no}" data-schedule_stat="35">일정종료</button>
														</div>
													</div>
													<hr>
													<div class="text-end">
														<button type="button" class="btn btn-danger btn-delete-schedule" data-schedule_group_no="${scheduleData.schedule_group_no }">삭제</button>
														<!-- <button class="btn btn-primary ms-1">수정</button> -->
													</div>
												</div>
											</div>
										</c:if>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="border p-2 rounded my-3 bg-default">등록된 일정이 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<div class="border p-2 rounded my-3 bg-default">목록이 존재 하지않습니다.</div>
	</c:otherwise>
</c:choose>
<c:if test="${workData.work_stat ne '99' and workData.work_stat ne '19' }">
<div class="d-flex align-items-center justify-content-between mb-3">
	<h4 class="mb-0"></h4>
	<button type="button" class="btn btn-primary btn-modal-save-sub-work" data-work_no="${workData.work_no }">하위작업등록</button>
</div>
</c:if>
<hr>
<h5>
	<i class="fas fa-lg fa-fw fa-info-circle"></i> 사용 가이드
</h5>
<ul class="mb-0">
	<li>하위작업 생성 후 견적서를 작성하세요.</li>
	<li>하나의 하위작업에 여러개의 일정을 등록할 수 있습니다.</li>
	<li>일정등록 시 워커맨, 외주용역, 외주업체를 등록하세요.</li>
	<li>이 작업의 감리로 등록되었을 경우, 감리 담당자에게 등록한 모든 일정이 함께 배정됩니다.</li>
	<li>일정이 등록되지 않은 날짜는 비용등록 및 자재요청에 사용할 수 없습니다.</li>
</ul>
<!-- end panel -->

<!-- page script -->
<script id="save_schedule_form" type="text/x-handlebars-template">
<%@ include file="schedule_form.jsp" %>
</script>
<script id="save_sub_work_form" type="text/x-handlebars-template">
<%@ include file="sub_work_form.jsp" %>
</script>
<script id="end_schedule_form" type="text/x-handlebars-template">
<%@ include file="end_schedule_form.jsp" %>
</script>
<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<script>

	App.setPageTitle('');
	App.restartGlobalFunction();

	$.when(
		$.getScript('/assets/plugins/parsleyjs/dist/parsley.min.js'),
		$.getScript('/assets/plugins/highlight.js/highlight.min.js'),
		$.Deferred(function( deferred ){
			$(deferred.resolve);
		})
	).done(function() {
		$.getScript('/assets/js/demo/render.highlight.js'),
		$.Deferred(function( deferred ){
			$(deferred.resolve);
		})
	});

	/* set mask optional */
	setDivMask();

</script>
<!-- ================== END PAGE LEVEL JS ================== -->

<script>
	var curPage;
	/* init page */

	function subWorkCallbackFunc(param){
		$("#modal_save_sub_work").one("click", saveSubWork)
		handleDatepicker();
	}
	function endScheduleCallbackFunc(param){
		$("#modal_end_schedule_stat").one("click", endSchedule)
		handleDatepicker();
	}

	function saveSubWork(){
		console.log("=== saveSubWork");
		const _name = "일정 저장";	// ajax name
		const _url = "/abc/work/sub/save/ajax";	// ajax url
		const _form = "frm_sub_work";	// form name
		_$form = $("#"+ _form);

		let validate = _$form.parsley().validate();
		if(!validate) {
			console.log('# validate false !!!');
			return;
		}
		let _param = _$form.serializeObject();	// ajax param
		Utils.requestAjax(_name, _url, _param, {
			beforeSend: function(){},
            success:  function(data) {
	          	alert(Message.SAVE);
            	Modal.close();
        		$('a[href="#schedule_view"]').trigger("click");
            },
            complete:  function(response) {
            }
		});
	}


	function endSchedule(){
		console.log("=== endSchedule");
		const _name = "일정 종료";	// ajax name
		const _url = "/abc/work/schedule/end/ajax";	// ajax url
		const _form = "frm_schedule";	// form name
		_$form = $("#"+ _form);

		let validate = _$form.parsley().validate();
		if(!validate) {
			console.log('# validate false !!!');
			return;
		}
		let _param = _$form.serializeObject();	// ajax param
		Utils.requestAjax(_name, _url, _param, {
			beforeSend: function(){},
            success:  function(data) {
	          	alert(Message.SAVE);
            	Modal.close();
        		$('a[href="#schedule_view"]').trigger("click");
            },
            complete:  function(response) {
            }
		});
	}

	function deleteSchedule(){
		console.log("=== deleteSchedule");
		if(!confirm(Message.CONFIRM.DELETE)) return;
		const _name = "일정 삭제";	// ajax name
		const _url = "/abc/work/schedule/delete/ajax";	// ajax url
		let _param = {schedule_group_no : $(this).data("schedule_group_no")};
		Utils.requestAjax(_name, _url, _param, {
			beforeSend: function(){},
            success:  function(data) {
	          	alert(Message.SAVE);
        		$('a[href="#schedule_view"]').trigger("click");
            },
            complete:  function(response) {
            }
		});
	}

	$(function(){
		console.log('page script !!!! ');
		/* save data */
		$(".btn-modal-save-sub-work").on("click", function(e){
			let source = $("#save_sub_work_form").html();
			console.log("source",source);
			let template = Handlebars.compile(source);
			let data = {p_work_no : ${workData.work_no } };
			let content = template(data);

			let modalOptions = {
					title : "하위작업등록",
					description:"등록된 하위작업은 견적서, 예상실행가, 지출결의, 비용, 자재요청 등에 활용됩니다.",
					content : content,
					size : "modal-md",
					callback:subWorkCallbackFunc,
					callbackParam:""
				}
			Modal.popup(modalOptions);
		});
		$(".btn-modal-modify-sub-work").on("click", function(e){
			let source = $("#save_sub_work_form").html();
			let template = Handlebars.compile(source);
			let data = {
					work_no : $(this).data("work_no"),
					location_name:$(this).data("location_name"),
					admin_memo:$(this).data("admin_memo")
				};
			let content = template(data);

			let modalOptions = {
					title : "하위작업등록",
					description:"등록된 하위작업은 견적서, 예상실행가, 지출결의, 비용, 자재요청 등에 활용됩니다.",
					content : content,
					size : "",
					callback:subWorkCallbackFunc,
					callbackParam:""
				}
			Modal.popup(modalOptions);
		});


		$(".btn-modal-end-schedule").on("click", function(e){
			let source = $("#end_schedule_form").html();
			let template = Handlebars.compile(source);
			let data = {
					schedule_group_no : $(this).data("schedule_group_no"),
					schedule_stat:$(this).data("schedule_stat"),
					work_no:$(this).data("work_no")
				};
			let content = template(data);

			let modalOptions = {
					title : "일정종료",
					description:"특이사항 입력 후 등록하면 답사종료 됩니다.",
					content : content,
					size : "modal-md",
					callback:endScheduleCallbackFunc,
					callbackParam:""
				}
			Modal.popup(modalOptions);
		});

		/* save data */
		$(".btn-modal-save-schedule").on("click", function(e){
			let source = $("#save_schedule_form").html();
			let template = Handlebars.compile(source);
			let data = {work_no : $(this).data("work_no"), location_name:$(this).data("location_name") };
			let content = template(data);

			let modalOptions = {
					title : "일정등록",
					description:"각 하위작업에는 여러개의 일정이 등록될 수 있으며, 등록된 일정대로 작업일지를 생성할 수 있습니다.",
					content : content,
					size : "modal-xl",
					callback:calendar,
					callbackParam:""
				}
			Modal.popup(modalOptions);
		});
		/* delete schedule */
		$(".btn-delete-schedule").on("click", deleteSchedule);
	});
	var cal;
	function calendar(){
		var calendarEl = document.getElementById('calendar');
		cal = new FullCalendar.Calendar(calendarEl, {
				schedulerLicenseKey: '0846060009-fcs-1621225175',
	          	initialView: 'resourceTimeline',
	          	locale:'kr',
	         	height: 600,
			    editable: false,
			    buttonText: {
				    today : "오늘",
				    month : "월별",
				    week : "주별",
				    day : "일별",
			    },
			    slotMinTime: '06:00:00',
				slotMaxTime: '24:00:00',
				slotLabelFormat : {
					hour : 'numeric',
					minute : '2-digit',
					omitZeroMinute : true,
					meridiem : 'short',
					hour12 : false
				},
			    resourceAreaWidth: 200,
				views : {
					resourceTimeline : {
						type:'resourceTimeline'
					}
				},
			    resourceAreaColumns: [
		        {
		        	headerContent: '워커맨',
		          	field: 'title'
		        },
		         {
		        	headerContent: '',
		        	width:'40px',
		          	cellContent : function(arg) {
		          		let resource = arg.resource;
		          		let content = "<input type=\"checkbox\" class=\"checkSchedule\" id=\"checkbox_"+resource.id+"_2\" data-assignment_type=\"02\" data-idx=\""+resource.id+"\" value=\""+resource.id+"\">";
		          		return {html : content}
		              },
		              cellDidMount:function(arg){
		            	  //$(arg.el).find("input").on("click",function(){check(this);})
		              }
		        }
		      ],
		      resources: function (fetchInfo, successCallback, failureCallback) {
				const _name = "calendar resource";	// ajax name
				const _url = "/abc/work/admin/list/ajax";	// ajax url
				const _form = "";	// form name
				let _param = {};
				Utils.requestAjax(_name, _url, _param, {
					beforeSend: function(){},
		            success:  function(response) {
		            	successCallback(response.data);
		            },
		            complete:  function(response) {
		            }
				});
			},
			resourceGroupField: 'dept',
			resourceGroupLabelDidMount:function(event){
				if(event.groupValue != "B2B"){
					$(".fc-icon-minus-square", event.el).trigger("click");
				}
			},
			resourceOrder : 'workerman_type,-main_type,admin_name',
			events : function(fetchInfo, successCallback, failureCallback){
				const _name = "calendar resource";	// ajax name
				const _url = "/abc/work/schedule/list/ajax";	// ajax url
				const _form = "";	// form name
					let _param = {
							"start" : fetchInfo.start,
							"end" : fetchInfo.end
						};
				Utils.requestAjax(_name, _url, _param, {
					beforeSend: function(){},
		            success:  function(response) {
		            	successCallback(response.data);
		            	console.log("response.data",response.data);
		            },
		            complete:  function(response) {
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
				tippy(event.el, {
					content : event.el.text,
				});
			},
			eventClick : function(info) {
				console.log("eventClick", info);
			}
	    });
		cal.render();
	}
</script>