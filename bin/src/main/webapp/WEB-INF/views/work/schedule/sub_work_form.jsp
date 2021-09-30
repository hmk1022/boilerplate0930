<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form class="form-horizontal form-bordered" data-parsley-validate="true" name="frm_sub_work" id="frm_sub_work" novalidate="">
	<input type="hidden" name="work_no" value="{{work_no}}">
	<input type="hidden" name="p_work_no" value="{{p_work_no}}">
	<div class="pop-body">
	    <div class="form-group">
	        <label class="form-label">작업명 <span class="text-danger">*</span></label>
	        <input type="text" class="form-control" id="location_name" name="location_name" value="{{location_name}}" placeholder="100자 이내" data-parsley-required="true" data-parsley-id="1" aria-describedby="parsley-id-1"  data-parsley-error-message="작업명을 정확히 입력하세요.">
	        <div class="invalid-feedback">유효성체크 문구자리</div>
	    </div>
	    <div class="form-group mt-3">
	        <label class="form-label">작업내용 <span class="text-danger">*</span></label>
	        <input type="text" class="form-control"id="admin_memo" name="admin_memo" value="{{admin_memo}}" placeholder="200자 이내" data-parsley-required="true" data-parsley-id="2" aria-describedby="parsley-id-2" data-parsley-error-message="작업내용을 정확히 입력하세요.">
	        <div class="invalid-feedback">유효성체크 문구자리</div>
	    </div>
	    <div class="btn-box mt-24">
	        <button type="button" class="btn btn-primary btn-block" id="modal_save_sub_work" data-p_work_no="{{p_work_no}}" data-work_no="{{work_no}}"><span>{{#unless work_no}}등록{{else}}수정{{/unless}}</span></button>
	    </div>
	</div>
</form>