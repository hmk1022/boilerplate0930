<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form class="form-horizontal form-bordered" data-parsley-validate="true" name="frm_payment" id="frm_payment" enctype="multipart/form-data">
	<input type="hidden" name="work_no" value="{{work_no}}">
	<input type="hidden" name="total_amount" id="total_amount" value="{{total_amount}}">
	<div class="card-body">
		<div class="row">
			<div class="col-6">
				<div class="form-group">
					<label class="form-label">결제종류 <span class="text-danger">*</span></label>
					<select class="form-control" id="amount_type" name="amount_type" data-parsley-required="true" data-parsley-error-message="결제종류를 선택하세요.">
						<option value="">선택</option>
						<tags:code-select codeList="${amount_type }" selected="" />
					</select>
				</div>
			</div>
			<div class="col-6">
				<div class="form-group  date input-daterange" data-date-format="yyyy-mm-dd" data-date-start-date="Date.default">
					<label class="form-label">결제예정일<span class="text-danger">*</span></label>
					<input type="text" class="form-control" name="pay_date" id="pay_date" placeholder="연도. 월. 일." data-parsley-required="true" data-parsley-error-message="결제예정일을 정확히 입력하세요.">
				</div>
			</div>
			<div class="col-6 mt-3">
				<div class="form-group">
					<label class="form-label">입력가능금액</label>
					<input type="text" id="total_amount_view" class="form-control" value="{{total_amount_view}}" readonly>
				</div>
			</div>
			<div class="col-6 mt-3">
				<div class="form-group">
					<label class="form-label">결제대상금액 <span class="text-danger">*</span></label>
					<input type="text" class="form-control" name="total_pay_price" id="total_pay_price" placeholder="입력가능금액보다 같거나 작은 금액 입력" data-parsley-required="true" data-parsley-error-message="결제대상금액을 정확히 입력하세요." data-parsley-type="number">
					<div class="form-check form-check-inline ms-3">
						<input class="form-check-input" type="checkbox" id="max_amount" name="max_amount">
						<label class="form-check-label" for="max_amount">입력가능금액 전액</label>
					</div>

				</div>
			</div>
			<div class="col-6 mt-3">
				<label class="form-label mb-2">결제수단 <span class="text-danger">*</span></label>
				<!--<div class="is-invalid">-->
				<div>
					<tags:code-radio codeList="${pay_type }" checked="" name="pay_type" required="true" />
				</div>
				<input name="radio_val_check" data-parsley-error-message="결제수단을 선택하세요" data-parsley-errors-container="#validation_err">
				<div id="validation_err"></div>
				<!-- <div class="invalid-feedback">유효성체크 문구 자리</div> -->
			</div>
			<div class="col-6 mt-3">
				<label class="form-label mb-2">지출증빙 <span class="text-danger">*</span></label>
				<!--<div class="is-invalid">-->
				<div>
					<tags:code-radio codeList="${pay_bill_type }" checked="" name="pay_bill_type" required="true" />
				</div>
				<input name="radio_val_check2" data-parsley-error-message="지출증빙 종류를 선택하세요" data-parsley-errors-container="#validation_err2">
				<div id="validation_err2"></div>
			</div>
			<!-- <div class="col-6 mt-3 bill-cash">
				<div class="form-group">
					<label class="form-label">현금영수증 발행 정보</label>
					<input type="text" name="pay_bill_no" id="pay_bill_no" class="form-control" data-parsley-required="true" data-parsley-error-message="현금영수증 발행 정보를 입력하세요.">
				</div>
			</div> -->
			<div class="col-6 mt-3">
				<div class="form-group bill-form">
					<label class="form-label bill-tax">사업자번호</label> <label class="form-label bill-cash">현금영수증 발행 정보</label>
					<input type="text" name="pay_bill_comp_number" id="pay_bill_comp_number" class="form-control" value="{{comp_number}}">
				</div>
			</div>
			<div class="col-6 mt-3 bill-form bill-tax">
				<div class="form-group">
					<label class="form-label">세금계산서 발행 이메일</label>
					<input type="text" name="pay_bill_email" id="pay_bill_email" class="form-control" value="{{tax_email}}">
				</div>
			</div>
			<div class="col-md-12 col-12 mt-3 bill-form bill-tax">
				<label class="form-label text-muted">사업자등록증 사본</label>
				<h5>
					<input id="upLoadFile" name="upLoadFile" multiple type="file" accept="image/*" data-browse-on-zone-click="true" category="IMG_TYPE_CUSTOMER_BRANCH_BUSS" data-parsley-error-message="파일을 선택해주세요." data-parsley-errors-container="#validation_file_upload_error" data-theme="fas">
					<input type="hidden" name="category_upLoadFile" value="IMG_TYPE_SOLE_PROPRIETOR_BUSS" />
				</h5>
			</div>
		</div>
	</div>
	<div class="card-footer">
		<button type="button" class="btn btn-primary btn-block" id="modal_save_payment">등록</button>
	</div>
</form>
<script type="text/javascript">
	/* 결제수단에 따라 지출증빙이 방법이 바뀜 */
	var _pay_type
	$("[name=pay_type]").change(function() {
		_pay_type = $("input[name='pay_type']:checked").val();
		if (_pay_type == 02) {
			$('[name=pay_bill_type]').attr('disabled', true);
			$('[name=pay_bill_comp_number]').attr('disabled', true);
			$('[name=pay_bill_email]').attr('disabled', true);
			$('.bill-form').css('display', 'none');
			$('[name=pay_bill_email]').attr('data-parsley-required', false);
			$('[name=pay_bill_comp_number]').attr('data-parsley-required', false);
			$('[name= radio_val_check2]').attr('data-parsley-required', false);
		} else if (_pay_type == 01 || _pay_type == 03) {
			$('[name=pay_bill_type]').attr('disabled', false);
			$('[name=pay_bill_comp_number]').attr('disabled', false);
			$("[name=pay_bill_type]").trigger("change");
			$('.bill-form').css('display', '');
		}
	});
	$("[name=pay_bill_type]").change(function() {
		_pay_bill_type = $("input[name='pay_bill_type']:checked").val();
		if (_pay_bill_type == 03) {
			$('[name=pay_bill_email]').attr('data-parsley-required', true);
			$('[name=pay_bill_comp_number]').attr('data-parsley-required', true);
			$('[name=pay_bill_email]').prop('disabled', false);
			$('[name=pay_bill_comp_number]').prop('disabled', false);
			$('[name=pay_bill_comp_number]').val('{{comp_number}}');

			$('.bill-form').css('display', 'block');
			$('.bill-cash').css('display', 'none');
			$('.bill-tax').css('display', 'block');
		} else if (_pay_bill_type == 01) {
			$('[name=pay_bill_email]').attr('data-parsley-required', false);
			$('[name=pay_bill_comp_number]').attr('data-parsley-required', true);
			$('[name=pay_bill_comp_number]').val('');
			$('[name=pay_bill_email]').prop('disabled', true);
			$('[name=pay_bill_comp_number]').prop('disabled', false);

			$('.bill-form').css('display', 'block');
			$('.bill-cash').css('display', 'block');
			$('.bill-tax').css('display', 'none');
		} else if (_pay_bill_type == 02) {
			$('[name=pay_bill_email]').attr('data-parsley-required', false);
			$('[name=pay_bill_comp_number]').attr('data-parsley-required', false);
			$('[name=pay_bill_email]').prop('disabled', true);
			$('[name=pay_bill_comp_number]').prop('disabled', true);

			$('.bill-form').css('display', 'none');
		}
	});
	function savePayment() {
		console.log("=== savePayment");
		const _name = "결제 저장"; // ajax name
		const _url = "/abc/work/payment/save/ajax"; // ajax url
		const _form = "frm_payment"; // form name
		_$form = $("#" + _form);

		/* radio validation 결제수단 & 지출증빙 */
		_pay_type = $("input[name='pay_type']:checked").val();
		if (!_pay_type) {
			$('[name= radio_val_check]').attr('data-parsley-required', true);
		} else if (_pay_type == 02) {
			$('[name= radio_val_check]').attr('data-parsley-required', false);
			$('[name= radio_val_check2]').attr('data-parsley-required', false);
		} else {
			$('[name= radio_val_check]').attr('data-parsley-required', false);
		}

		let _pay_bill_type = $("input[name='pay_bill_type']:checked").val();

		if (!_pay_bill_type && _pay_type != 02) {
			$('[name= radio_val_check2]').attr('data-parsley-required', true);
		} else {
			$('[name= radio_val_check2]').attr('data-parsley-required', false);
		}

		/* validation */
		let validate = $("[name=frm_payment]").parsley().validate();
		if (!validate) {
			console.log('# validate false !!!');
			return;
		}
		let _param = _$form.serializeObject(); // ajax param
		if (_param.pay_bill_type != 03) {

		}
		Utils.requestMultiAjax(_name, _url, _form, {
			beforeSend : function() {
			},
			success : function(data) {
				alert(Message.SAVE);
				Modal.close();
				$('a[href="#payment_view"]').trigger("click");
			},
			complete : function(response) {
			}
		});
	}
	function init() {
		$("#pay_type_03").trigger("click");
		$("#pay_bill_type_03").trigger("click");
		$("#max_amount").on("click", function() {
			$("#total_pay_price").val($("#total_amount").val());
		});
		$("#total_pay_price").on("keydown", function() {
			let total_pay_price = this.value + event.key;
			let pay_price = parseInt(total_pay_price);
			let total_price = parseInt($("#total_amount").val());
			if (pay_price > total_price) {
				$('#total_pay_price').attr('data-parsley-error-message', '결제대상금액은 입력가능금액보다 클 수 없습니다.');
				$('#total_pay_price').attr('data-parsley-type', 'email'); // 결제대상금액이 입력가능금액보다 클경우 validation false로 만들어준다.
				event.stopPropagation();
				event.preventDefault();
			} else {
				$('#total_pay_price').attr('data-parsley-type', 'number');
			}
		})

		$("#modal_save_payment").on("click", savePayment)
		handleDatepicker();
		/* jsp로 만들어진 radio check에 parsley를 직접 적용할 방법을 못찾아서 dispaly:none input으로 대신처리 */
		$('[name=radio_val_check ]').css('display', 'none');
		$('[name=radio_val_check2 ]').css('display', 'none');
		$('[name=pay_bill_input]').css('display', 'none');
	}

	$(function() {
		init();
		initFileUloadForm();
	})

	function initFileUloadForm() {
		/* image config list */
		let fileList = []; // image url list
		let fileConfig = []; // img config
		let imgList = []; // img list temp

		let _temp_preview_array = {};

		console.log("fileList :", fileList);
		console.log("fileConfig :", fileConfig);
		console.log("imgList :", imgList);

		/* file list */
		$.each(fileConfig, function(idx, item) {
			fileList.push(item.img_url);
		});

		let fileinput = {};
		fileinput = {
			uploadUrl : "/file/upload",
			autoOrientImage : true,
			//previewFileIcon: '<i class="fas fa-file"></i>',
			allowedFileExtensions : [
					'jpg', 'jpeg', 'png', 'gif', 'pdf'
			],
			//allowedFileTypes: ['image', 'video', 'flash'],
			overwriteInitial : false,
			//initialPreviewShowDelete : true,
			maxFileSize : 20000,
			//maxFilesNum : 10,
			uploadAsync : false,
			maxFileCount : 1,
			enctype : 'multipart/form-data',
			fileActionSettings : {
				showUpload : false, // Removing upload button from action settings
			},
			showUpload : false,
			showClose : false,
			showCaption : true,
			slugCallback : function(filename) {
				return filename.replace('(', '_').replace(']', '_');
			},
			theme : 'fas', // theme
			initialPreview : fileList, // 초기 이미지 목록
			initialPreviewAsData : true, // defaults markup
			initialPreviewConfig : fileConfig, // file config list
			deleteUrl : "/file/delete", // file delete url
			preferIconicPreview : false, // file content or icon view
		}

		$("#upLoadFile").fileinput(fileinput).on('fileuploaded', function(event, previewId, index, fileId) {
			console.log('File Uploaded', 'ID: ' + fileId + ', Thumb ID: ' + previewId);
		}).on('fileuploaderror', function(event, previewId, index, fileId) {
			console.log('File Upload Error', 'ID: ' + fileId + ', Thumb ID: ' + previewId);
		}).on('filebatchuploadcomplete', function(event, preview, config, tags, extraData) {
			console.log('File Batch Uploaded', preview, config, tags, extraData);
		}).on('filesorted', function(e, params) {
			console.log('filesorted', params);
		}).on('filebeforedelete', function() {
			let aborted = !window.confirm('해당 파일을 삭제 하시겠습니까?');
			if (aborted) {
			}
			;
			return aborted;
		}).on('filedeleted', function() {
			setTimeout(function() {
				window.alert('삭제 됐습니다! ');
			}, 500);
		}).on('filepreupload', function() {
			//$('#kv-success-box').html('');
			console.log('filepreupload');
		});

		var krajeeGetCount = function(id) {
			let cnt = $('#' + id).fileinput('getFilesCount');
			return cnt === 0 ? 'You have no files remaining.' : 'You have ' + cnt + ' file' + (cnt > 1 ? 's' : '') + ' remaining.';
		};

	}
</script>