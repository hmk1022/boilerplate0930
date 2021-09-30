<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<form class="form-horizontal form-bordered" data-parsley-validate="true" name="frm_schedule" id="frm_schedule" novalidate="">
			<input type="hidden" name="work_no" value="{{work_no}}">
			<div class="pop-body">
                <div class="form-group">
                    <label class="form-label">작업명 <span class="text-danger">*</span></label>
                    <h5>{{location_name}}</h5>
                </div>
                <div class="form-group mt-3">
                    <label class="form-label">타입 <span class="text-danger">*</span></label>
                    <div class="">
                        <div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" id="work_type_33" name="work_type" value="33" >
                            <label class="form-check-label" for="inlineRadio2">감리</label>
                        </div>
                        <div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" id="work_type_32" name="work_type" value="32" checked>
                            <label class="form-check-label" for="inlineRadio1">작업</label>
                        </div>
                        <div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" id="work_type_31" name="work_type" value="31" >
                            <label class="form-check-label" for="inlineRadio2">답사</label>
                        </div>
                    </div>
                </div>

                <div class="row mt-3 daterange">
                    <div class="col-4 date " data-date-format="yyyy-mm-dd" data-date-start-date="Date.default">
                        <label class="form-label">시작일 <span class="text-danger">*</span></label>
                        <input datepicker type="text" class="form-control" id="st_date_ymd" name="st_date_ymd" placeholder="연도. 월. 일." data-parsley-required="true" >
                    </div>
                    <div class="col-4 date" data-date-format="yyyy-mm-dd" data-date-start-date="Date.default">
                        <label class="form-label">종료일 <span class="text-danger">*</span></label>
                        <input datepicker type="text" class="form-control" id="ed_date_ymd" name="ed_date_ymd" placeholder="연도. 월. 일." data-parsley-required="true" >
                    </div>
                </div>
                <div class="row mt-3" id="endDay">
                     <div class="col-4">
                        <label class="form-label">시작시간 <span class="text-danger">*</span></label>
                        <div class="input-group">
                        	<select class="form-select" name="st_date_h" id="st_date_h" data-parsley-required="true" >
                       		 	<option value="06" ${workData.req_w_date_h eq '06' ? 'selected' : '' }>06</option>
                       		 	<option value="07" ${workData.req_w_date_h eq '07' ? 'selected' : '' }>07</option>
								<option value="08" ${workData.req_w_date_h eq '08' ? 'selected' : '' }>08</option>
								<option value="09" ${workData.req_w_date_h eq '09' ? 'selected' : '' }>09</option>
								<option value="10" ${workData.req_w_date_h eq '10' ? 'selected' : '' }>10</option>
								<option value="11" ${workData.req_w_date_h eq '11' ? 'selected' : '' }>11</option>
								<option value="12" ${workData.req_w_date_h eq '12' ? 'selected' : '' }>12</option>
								<option value="13" ${workData.req_w_date_h eq '13' ? 'selected' : '' }>13</option>
								<option value="14" ${workData.req_w_date_h eq '14' ? 'selected' : '' }>14</option>
								<option value="15" ${workData.req_w_date_h eq '15' ? 'selected' : '' }>15</option>
								<option value="16" ${workData.req_w_date_h eq '16' ? 'selected' : '' }>16</option>
								<option value="17" ${workData.req_w_date_h eq '17' ? 'selected' : '' }>17</option>
								<option value="18" ${workData.req_w_date_h eq '18' ? 'selected' : '' }>18</option>
								<option value="19" ${workData.req_w_date_h eq '19' ? 'selected' : '' }>19</option>
								<option value="20" ${workData.req_w_date_h eq '20' ? 'selected' : '' }>20</option>
								<option value="21" ${workData.req_w_date_h eq '21' ? 'selected' : '' }>21</option>
								<option value="22" ${workData.req_w_date_h eq '22' ? 'selected' : '' }>22</option>
								<option value="23" ${workData.req_w_date_h eq '23' ? 'selected' : '' }>23</option>
								<option value="24" ${workData.req_w_date_h eq '24' ? 'selected' : '' }>24</option>
							</select>
							<select class="form-select" name="st_date_m" id="st_date_m" data-parsley-required="true" >
								<option value="00" ${workData.req_w_date_m eq '00' ? 'selected' : '' }>00</option>
								<option value="10" ${workData.req_w_date_m eq '10' ? 'selected' : '' }>10</option>
								<option value="20" ${workData.req_w_date_m eq '20' ? 'selected' : '' }>20</option>
								<option value="30" ${workData.req_w_date_m eq '30' ? 'selected' : '' }>30</option>
								<option value="40" ${workData.req_w_date_m eq '40' ? 'selected' : '' }>40</option>
								<option value="50" ${workData.req_w_date_m eq '50' ? 'selected' : '' }>50</option>
							</select>
                        </div>
                    </div>
                    <div class="col-4">
                        <label class="form-label">종료시간 <span class="text-danger">*</span></label>
                        <div class="input-group">
                        	<select class="form-select" name="ed_date_h" id="ed_date_h" data-parsley-required="true" >
                       		 	<option value="06" ${workData.req_w_date_h eq '06' ? 'selected' : '' }>06</option>
                       		 	<option value="07" ${workData.req_w_date_h eq '07' ? 'selected' : '' }>07</option>
								<option value="08" ${workData.req_w_date_h eq '08' ? 'selected' : '' }>08</option>
								<option value="09" ${workData.req_w_date_h eq '09' ? 'selected' : '' }>09</option>
								<option value="10" ${workData.req_w_date_h eq '10' ? 'selected' : '' }>10</option>
								<option value="11" ${workData.req_w_date_h eq '11' ? 'selected' : '' }>11</option>
								<option value="12" ${workData.req_w_date_h eq '12' ? 'selected' : '' }>12</option>
								<option value="13" ${workData.req_w_date_h eq '13' ? 'selected' : '' }>13</option>
								<option value="14" ${workData.req_w_date_h eq '14' ? 'selected' : '' }>14</option>
								<option value="15" ${workData.req_w_date_h eq '15' ? 'selected' : '' }>15</option>
								<option value="16" ${workData.req_w_date_h eq '16' ? 'selected' : '' }>16</option>
								<option value="17" ${workData.req_w_date_h eq '17' ? 'selected' : '' }>17</option>
								<option value="18" ${workData.req_w_date_h eq '18' ? 'selected' : '' }>18</option>
								<option value="19" ${workData.req_w_date_h eq '19' ? 'selected' : '' }>19</option>
								<option value="20" ${workData.req_w_date_h eq '20' ? 'selected' : '' }>20</option>
								<option value="21" ${workData.req_w_date_h eq '21' ? 'selected' : '' }>21</option>
								<option value="22" ${workData.req_w_date_h eq '22' ? 'selected' : '' }>22</option>
								<option value="23" ${workData.req_w_date_h eq '23' ? 'selected' : '' }>23</option>
								<option value="24" ${workData.req_w_date_h eq '24' ? 'selected' : '' }>24</option>
							</select>
							<select class="form-select" name="ed_date_m" id="ed_date_m" data-parsley-required="true" >
								<option value="00" ${workData.req_w_date_m eq '00' ? 'selected' : '' }>00</option>
								<option value="10" ${workData.req_w_date_m eq '10' ? 'selected' : '' }>10</option>
								<option value="20" ${workData.req_w_date_m eq '20' ? 'selected' : '' }>20</option>
								<option value="30" ${workData.req_w_date_m eq '30' ? 'selected' : '' }>30</option>
								<option value="40" ${workData.req_w_date_m eq '40' ? 'selected' : '' }>40</option>
								<option value="50" ${workData.req_w_date_m eq '50' ? 'selected' : '' }>50</option>
							</select>
                        </div>
                    </div>
                </div>

                <div class="form-group mt-3" id="calendar">
                </div>

                <div class="btn-box mt-24">
                    <button type="button" class="btn btn-primary btn-block" id="save_schedule" data-work_no="${workData.work_no }" ><span>등록</span></button>
                </div>
            </div>
		</form>
<script type="text/javascript">
	$(function(){
		$("#save_schedule").on("click", saveSchedule);
		$("#st_date_ymd").on("change",function(){
			if($("#st_date_ymd").val() != null){
			cal.gotoDate($("#st_date_ymd").val());
			}
		});
		$("#ed_date_h").on("change",function(){
			if($("#st_date_h").val() > $("#ed_date_h").val() ){
				alert("종료시간은 시작시간보다 뒤의 시간을 입력하세요. ")
				$("#ed_date_h").val($("#st_date_h").val()).attr("selected","selected");
				return;
			}
		});
		$("#ed_date_h").one("change",function(){
			$("#st_date_h").on("change",function(){
				if($("#st_date_h").val() > $("#ed_date_h").val() ){
					alert("시작시간은 종료시간보다 이전 시간을 입력하세요. ")
					$("#st_date_h").val($("#ed_date_h").val()).attr("selected","selected");
					return;
				}
			});
		});

		$("#ed_date_m").on("change",function(){
			if($("#st_date_m").val() > $("#ed_date_m").val() ){
				alert("종료시간은 시작시간보다 뒤의 시간을 입력하세요. ")
				$("#ed_date_m").val($("#st_date_m").val()).attr("selected","selected");
				return;
			}
		});
		$("#ed_date_m").one("change",function(){
			$("#st_date_m").on("change",function(){
				if($("#st_date_m").val() > $("#ed_date_m").val() ){
					alert("시작시간은 종료시간보다 이전 시간을 입력하세요. ")
					$("#st_date_m").val($("#ed_date_m").val()).attr("selected","selected");
					return;
				}
			});
		});

		handleDatepicker();
	});
	function saveSchedule(){
		const _name = "일정 저장";	// ajax name
		const _url = "/abc/work/schedule/save/ajax";	// ajax url
		const _form = "frm_schedule";	// form name
		_$form = $("#"+ _form);

		let validate = _$form.parsley().validate();
		if(!validate) {
			console.log('# validate false !!!');
			return;
		}
		if($(".checkSchedule:checked").length == 0){
			alert('배정할 인원을 선택하세요.');
			return;
		}
		let _param = _$form.serializeObject();	// ajax param
		console.log("saveSchedule _param",_param);

		let admin_list = [];
		$(".checkSchedule:checked").each(function(){
			let workerman_id = $(this).data("idx").split("_");
			console.log(workerman_id);
			var obj = {
					workerman_type : workerman_id[0],
					admin_no : workerman_id[1],
					assignment_type : $(this).data("assignment_type")
				};
			admin_list.push(obj);
		});
		_param.admin_list = JSON.stringify(admin_list);
		Utils.requestAjax(_name, _url, _param, {
			beforeSend: function(){},
            success:  function(data) {
	          	alert(Message.SAVE);
            	Modal.close();
            	pageRefresh("/abc/work/view",{"work_no":"${param.work_no}","tab":"#schedule_view"});
            },
            complete:  function(response) {
            }
		});
	}

</script>