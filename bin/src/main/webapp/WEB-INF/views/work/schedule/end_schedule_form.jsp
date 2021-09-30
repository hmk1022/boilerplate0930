<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<form class="form-horizontal form-bordered" data-parsley-validate="true" name="frm_schedule" id="frm_schedule" novalidate="">
			<input type="hidden" name="schedule_group_no" value="{{schedule_group_no}}">
			<input type="hidden" name="schedule_stat" value="{{schedule_stat}}">
			<input type="hidden" name="work_no" value="{{work_no}}">
			            <div class="pop-body">
			                <div class="form-group">
			                    <label class="form-label">특이사항 <span class="text-danger"></span></label>
			                    <textarea class="form-control" id="memo_content" name="memo" value="memo" placeholder="발생한 특이사항을 입력하세요." data-parsley-required="true" data-parsley-id="1" aria-describedby="parsley-id-1"></textarea>
			                    <div class="invalid-feedback">유효성체크 문구자리</div>
			                </div>
			                <div class="btn-box mt-24">
			                    <button type="button" class="btn-basic full bg-main" id="modal_end_schedule_stat" data-schedule_group_no="{{schedule_group_no}}" data-schedule_stat="{{schedule_stat}}"><span>등록</span></button>
			                </div>
			            </div>

		</form>