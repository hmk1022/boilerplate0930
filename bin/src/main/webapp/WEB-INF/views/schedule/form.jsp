<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<form class="form-horizontal form-bordered" data-parsley-validate="true" name="frm_schedule" id="frm_schedule">
			<input type="hidden" name="admin_no" id="admin_no" value="${param.admin_no }"/>
			<input type="hidden" name="workerman_type" id="workerman_type" value="${param.workerman_type }"/>
			<input type="hidden" name="schedule_group_no" id="schedule_group_no" value="${param.schedule_group_no }"/>
				<div class="card">
                     <div class="card-header">
                         <h3>일정 등록</h3>
                     </div>
                     <div class="card-body">
                         <div class="row">
								<div class="col-6">
									<label class="form-label" for=""> 워커맨 </label>
									<div class="worker-nm">${param.admin_name }</div>
								</div>
								<div class="col-md-6 col-12 mt-3">
										<label class="form-label" for="">일정구분</label>
										<select class="form-select" name="work_type" id="work_type">
											<option value="">선택</option>
											<c:forEach var="item" items="${holiday }">
											<option value="${item.code_value }" ${item.code_value eq schedule.schedule_type ? "selected" : "" }>${item.code_name }</option>
											</c:forEach>
										</select>
								</div>

								<div class="col-md-6 col-12 mt-3 daterange">
										<label class="form-label">시작 <span class="text-danger">*</span></label>
										<div class="input-group date " data-date-format="yyyy-mm-dd" data-date-start-date="Date.default">
											<input type="text" class="form-control" placeholder="연도. 월. 일." id="st_date_ymd" name="st_date_ymd" value="${schedule.st_date_ymd }">
											<select class="form-select others" id="st_date_h" name="st_date_h">
												<option value="06" ${schedule.st_date_h eq '06' ? 'selected' : '' }>06</option>
                       						 	<option value="07" ${schedule.st_date_h eq '07' ? 'selected' : '' }>07</option>
												<option value="08" ${schedule.st_date_h eq '08' ? 'selected' : '' }>08</option>
												<option value="09" ${schedule.st_date_h eq '09' ? 'selected' : '' }>09</option>
												<option value="10" ${schedule.st_date_h eq '10' ? 'selected' : '' }>10</option>
												<option value="11" ${schedule.st_date_h eq '11' ? 'selected' : '' }>11</option>
												<option value="12" ${schedule.st_date_h eq '12' ? 'selected' : '' }>12</option>
												<option value="13" ${schedule.st_date_h eq '13' ? 'selected' : '' }>13</option>
												<option value="14" ${schedule.st_date_h eq '14' ? 'selected' : '' }>14</option>
												<option value="15" ${schedule.st_date_h eq '15' ? 'selected' : '' }>15</option>
												<option value="16" ${schedule.st_date_h eq '16' ? 'selected' : '' }>16</option>
												<option value="17" ${schedule.st_date_h eq '17' ? 'selected' : '' }>17</option>
												<option value="18" ${schedule.st_date_h eq '18' ? 'selected' : '' }>18</option>
												<option value="19" ${schedule.st_date_h eq '19' ? 'selected' : '' }>19</option>
												<option value="20" ${schedule.st_date_h eq '20' ? 'selected' : '' }>20</option>
												<option value="21" ${schedule.st_date_h eq '21' ? 'selected' : '' }>21</option>
												<option value="22" ${schedule.st_date_h eq '22' ? 'selected' : '' }>22</option>
												<option value="23" ${schedule.st_date_h eq '23' ? 'selected' : '' }>23</option>
												<option value="24" ${schedule.st_date_h eq '24' ? 'selected' : '' }>24</option>
											</select>
											<select class="form-select others"  id="st_date_m" name="st_date_m">
												<option value="00" ${schedule.st_date_m eq '00' ? 'selected' : '' }>00</option>
												<option value="10" ${schedule.st_date_m eq '10' ? 'selected' : '' }>10</option>
												<option value="20" ${schedule.st_date_m eq '20' ? 'selected' : '' }>20</option>
												<option value="30" ${schedule.st_date_m eq '30' ? 'selected' : '' }>30</option>
												<option value="40" ${schedule.st_date_m eq '40' ? 'selected' : '' }>40</option>
												<option value="50" ${schedule.st_date_m eq '50' ? 'selected' : '' }>50</option>
											</select>
										</div>
										<label class="form-label">종료 <span class="text-danger">*</span></label>
										<div class="input-group date" data-date-format="yyyy-mm-dd" data-date-start-date="Date.default">
											<input type="text" class="form-control" placeholder="연도. 월. 일." id="ed_date_ymd" name="ed_date_ymd"   value="${schedule.ed_date_ymd }">
											<select class="form-select others" id="ed_date_h" name="ed_date_h">
												<option value="06" ${schedule.ed_date_h eq '06' ? 'selected' : '' }>06</option>
                       						 	<option value="07" ${schedule.ed_date_h eq '07' ? 'selected' : '' }>07</option>
												<option value="08" ${schedule.ed_date_h eq '08' ? 'selected' : '' }>08</option>
												<option value="09" ${schedule.ed_date_h eq '09' ? 'selected' : '' }>09</option>
												<option value="10" ${schedule.ed_date_h eq '10' ? 'selected' : '' }>10</option>
												<option value="11" ${schedule.ed_date_h eq '11' ? 'selected' : '' }>11</option>
												<option value="12" ${schedule.ed_date_h eq '12' ? 'selected' : '' }>12</option>
												<option value="13" ${schedule.ed_date_h eq '13' ? 'selected' : '' }>13</option>
												<option value="14" ${schedule.ed_date_h eq '14' ? 'selected' : '' }>14</option>
												<option value="15" ${schedule.ed_date_h eq '15' ? 'selected' : '' }>15</option>
												<option value="16" ${schedule.ed_date_h eq '16' ? 'selected' : '' }>16</option>
												<option value="17" ${schedule.ed_date_h eq '17' ? 'selected' : '' }>17</option>
												<option value="18" ${schedule.ed_date_h eq '18' ? 'selected' : '' }>18</option>
												<option value="19" ${schedule.ed_date_h eq '19' ? 'selected' : '' }>19</option>
												<option value="20" ${schedule.ed_date_h eq '20' ? 'selected' : '' }>20</option>
												<option value="21" ${schedule.ed_date_h eq '21' ? 'selected' : '' }>21</option>
												<option value="22" ${schedule.ed_date_h eq '22' ? 'selected' : '' }>22</option>
												<option value="23" ${schedule.ed_date_h eq '23' ? 'selected' : '' }>23</option>
												<option value="24" ${schedule.ed_date_h eq '24' ? 'selected' : '' }>24</option>
											</select>
											<select class="form-select others"  id="ed_date_m" name="ed_date_m">
												<option value="00" ${schedule.ed_date_m eq '00' ? 'selected' : '' }>00</option>
												<option value="10" ${schedule.ed_date_m eq '10' ? 'selected' : '' }>10</option>
												<option value="20" ${schedule.ed_date_m eq '20' ? 'selected' : '' }>20</option>
												<option value="30" ${schedule.ed_date_m eq '30' ? 'selected' : '' }>30</option>
												<option value="40" ${schedule.ed_date_m eq '40' ? 'selected' : '' }>40</option>
												<option value="50" ${schedule.ed_date_m eq '50' ? 'selected' : '' }>50</option>
											</select>
										</div>
								</div>
								<div class="col-md-6 col-12 mt-3 others">
									<label for="scTitle">제목</label>
									<input type="text" class="form-control"  id="scd_text" name="scd_text" value="${schedule.scd_text }">
								</div>

								<div class="col-md-6 col-12 mt-3 others">
									<label for="scTitle">내용</label>
									<input type="text" class="form-control"  id="scd_content" name="scd_content" value="${schedule.scd_content }">
								</div>

								<div class="btn-box floating fixed2">
						            <button type="button" class="btn btn-danger " id="delete_schedule" name="btn_delete_holiday"><span>삭제</span></button>&nbsp;
						            <button type="button" class="btn btn-primary btn-block" id="save_schedule" name="btn_save_holiday"><span>등록</span></button>&nbsp;
						        </div>
							</div>
                     </div>
                 </div>
            <a href="javascript:;" class="btn btn-icon btn-circle btn-success btn-scroll-to-top" data-toggle="scroll-to-top"><i class="fa fa-angle-up"></i></a>
</form>


<!-- ================== END PAGE LEVEL JS ================== -->

<script>

	var curPage;
	/* init page */
	function init(){
		App.restartGlobalFunction();
		changeHolyday("${schedule.schedule_type}");
		if("${param.schedule_group_no}" != ""){
			$("#st_date_h").val("${schedule.st_date_h}");
			$("#st_date_m").val("${schedule.st_date_m}");
			$("#ed_date_h").val("${schedule.ed_date_h}");
			$("#ed_date_m").val("${schedule.ed_date_m}");
			console.log("init","${schedule.ed_date_h}");
		}
	}

	function saveSchedule(){
		console.log("=== saveSchedule");
		const _name = "일정 저장";	// ajax name
		const _url = "/abc/work/schedule/save/ajax";	// ajax url
		const _form = "frm_schedule";	// form name
		let _$form = $("#"+_form);
		let validate = _$form.parsley().validate();
		if(!validate) {
			console.log('# validate false !!!');
			return;
		}
		let _param = _$form.serializeObject();	// ajax param
		let admin_list = [];
		let obj = {
				workerman_type : "${param.workerman_type }",
				admin_no : "${param.admin_no }"
			};
		admin_list.push(obj);
		_param.admin_list = JSON.stringify(admin_list);
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	alert(Message.SAVE);
            	opener.$('a[href="/schedule/view"]').trigger('click');
            	window.close();
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
		let _param = {schedule_group_no : "${param.schedule_group_no}" };
		Utils.requestAjax(_name, _url, _param, {
			beforeSend: function(){},
            success:  function(data) {
	          	alert(Message.SAVE);
	          	opener.$('a[href="/schedule/view"]').trigger('click');
	          	window.close();
            },
            complete:  function(response) {
            }
		});
	}

	function changeHolyday(schedule_type){
		if(schedule_type == '99' || schedule_type == ''){
			$(".others").show();
			$("#scd_text").prop("disabled",false);
			$("#scd_content").prop("disabled",false);
			$("#st_date_h").val("06");
			$("#st_date_m").val("00");
			$("#ed_date_h").val("06");
			$("#ed_date_m").val("00");
		}else{
			$(".others").hide();
			$("#scd_text").prop("disabled",true);
			$("#scd_content").prop("disabled",true);
			if(schedule_type == '05'){
				$("#st_date_h").val("09");
				$("#st_date_m").val("00");
				$("#ed_date_h").val("13");
				$("#ed_date_m").val("00");
			} else if(schedule_type == '06'){
				$("#st_date_h").val("14");
				$("#st_date_m").val("00");
				$("#ed_date_h").val("18");
				$("#ed_date_m").val("00");
			} else{
				$("#st_date_h").val("09");
				$("#st_date_m").val("00");
				$("#ed_date_h").val("18");
				$("#ed_date_m").val("00");
			}
		}
	}

	$(function(){
		$("#work_type").on("change", function(e){
			changeHolyday(this.value);
		});
		$("#save_schedule").on("click", saveSchedule);
		$("#delete_schedule").on("click", deleteSchedule);
		init();
		$("#st_date_ymd").val(new Date('${param.date}'));
	});

</script>

