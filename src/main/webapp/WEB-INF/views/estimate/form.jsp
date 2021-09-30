<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<div class="card">
	<form class="form-horizontal form-bordered" data-parsley-validate="true" name="frm" id="frm" novalidate="">
		<div class="card-header">
			<div class="d-flex align-items-center justify-content-between">
				<h3>
					견적서 작성 <span class="text-primary ms-3">${workData.work_id }</span><span class="text-dark small ms-3">${param.report_date} ${param.day_of_week }</span>
				</h3>
			</div>
		</div>
		<div class="panel panel-inverse">
			<div class="panel-body" style="">
				<input type="hidden" id="estimate_no" name="estimate_no" value="${data.estimate_no }">
				<c:forEach var="work" items="${workList }">
					<div class="card mt-4">
						<div class="card-header">
							<h3>${work.work_id } ${work.location_name }</h3>
							<div class="d-flex align-items-center justify-content-between">
								<p class="mb-0 small">${work.admin_memo }</p>
							</div>
						</div>
						<div class="card-body table-responsive" style="margin: auto;">
							<table class="table table-striped mb-0 align-middle ">
								<thead>
									<tr>
										<th rowspan="2">No.</th>
										<th rowspan="2">구분</th>
										<th rowspan="2">내역</th>
										<th rowspan="2">규격</th>
										<th colspan="4">견적</th>
										<th colspan="4">예상실행가</th>
										<th colspan="2">예상마진</th>
										<th rowspan="2">수정/삭제</th>
									</tr>
									<tr>
										<th rowspan="1">단위</th>
										<th rowspan="1">수량</th>
										<th rowspan="1">단가(원)</th>
										<th rowspan="1">금액(원)</th>

										<th rowspan="1">단위</th>
										<th rowspan="1">수량</th>
										<th rowspan="1">단가(원)</th>
										<th rowspan="1">금액(원)</th>

										<th rowspan="1">차액(원)</th>
										<th rowspan="1">마진율(%)</th>

									</tr>
								</thead>
								<tbody id="tbody_${work.work_no }">

									<c:set var="estimate_map" value="estimate_${work.work_no }" scope="request"></c:set>
									<c:forEach var="item" items="${requestScope[estimate_map]}" varStatus="status">
										<tr data-resource_no="${item.resource_no }" data-estimate_no="${item.estimate_no }" data-version_no="${item.version_no }" data-work_no="${item.work_no }">
											<td>${status.count }</td>
											<td>
												<select class="form-control form-control-sm" name="resource_type">
													<tags:code-select codeList="${resource_type }" selected="${item.resource_type }" defaultValue="선택" />
												</select>
											</td>
											<td nowrap>
												<input type="text" class="form-control form-control-sm" name="resource_name" value="${item.resource_name }" />
											</td>
											<td class="text-start">
												<input type="text" class="form-control form-control-sm" name="resource_standard" value="${item.resource_standard }" />
											</td>
											<td>
												<select class="form-control form-control-sm" id="unit_cd" name="unit_cd">
													<tags:code-select codeList="${unit_cd }" selected="${item.unit_cd }" defaultValue="선택" />
												</select>
											</td>
											<td>
												<input type="number" name="resource_count" class="form-control form-control-sm input-sm number" value="${item.resource_count }" style="width: 60px" />
											</td>
											<td>
												<input type="text" name="unit_price" class="form-control form-control-sm number" value="${item.unit_price }" style="width: 100px" />
											</td>
											<td name="unit_sum_price">0</td>
											<td>
												<select class="form-control form-control-sm" name="est_unit_cd" disabled>
													<tags:code-select codeList="${unit_cd }" selected="${item.est_unit_cd }" defaultValue="선택" />
												</select>
											</td>
											<td>
												<input type="number" name="est_resource_count" class="form-control form-control-sm number" value="${item.est_resource_count }" style="width: 60px" />
											</td>
											<td>
												<input type="text" name="est_unit_price" class="form-control form-control-sm number" value="${item.est_unit_price }" style="width: 100px" />
											</td>
											<td name="est_unit_sum_price">0</td>
											<td>
												<b name="amt_margin" >0</b>
											</td>
											<td>
												<b name="rate_margin">0</b>
											</td>
											<td nowrap="">
												<div class="btn btn-sm btn-primary w-60px me-1" name="_dev-save" style="display: none">저장</div>
												<div class="btn btn-sm btn-white w-60px me-1" name="_dev-edit_cancel" style="display: none">취소</div>
												<div class="btn btn-sm btn-primary w-60px me-1" name="_dev-edit">수정</div>
												<div class="btn btn-sm btn-white w-60px" name="_dev-delete">삭제</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<div class="form-group ">
							<div class="col-sm-14 text-center">
								<button type="button" class="btn btn-primary btn-add" id="_dev-add" data-work_no="${work.work_no }" data-version_no="${estimate_version_no }" data-estimate_no="${work.estimate_no}">추가</button>
								<button type="button" class="btn btn-primary _dev-close" id="_dev-close">닫기</button>
								<%-- <button type="button" class="btn btn-grey" name="moveBack">${empty work.estimate_no ? 'list':'cancel'}</button> --%>
							</div>
						</div>

					</div>
				</c:forEach>

				<!-- - -->

				<!-- - -->
				<!--
			<div class="d-flex mt-4">
            	<button class="btn btn-block btn-primary">등록</button>
            </div>
            -->
			</div>
		</div>
	</form>
</div>

<!-- end panel -->

<style>
/* pq-grid title align */
table tr td {
	vertical-align: middle !important;
}
</style>


<script>
	/* set title name mandatory */
	App.setPageTitle('${param.work_no } | 견적서작성');
	App.restartGlobalFunction();
</script>


<!-- ================== END PAGE LEVEL JS ================== -->

<script>
	$("table tr td input,select").prop("disabled", true);

	/* 공통코드 */
	var unit_cd = "<option value=''>선택</option>";
	<c:forEach var="item" items="${unit_cd}">
	unit_cd += "<option value="+"${item.code_value}"+">" + "${item.code_name }"
			+ "</option>";
	</c:forEach>
	var resource_type = "<option value=''>선택</option>";
	<c:forEach var="item" items="${resource_type}">
	resource_type += "<option value="+"${item.code_value}"+">"
			+ "${item.code_name }" + "</option>";
	</c:forEach>

	/* init page */
	$(function() {
		/* add row */
		$(".btn-add").on("click", function(e) {
			console.log("추가 버튼클릭!");
			addRow($(this).data("work_no"), $(this).data("version_no"), $(this).data("estimate_no"),);
		});

		/* add row */
		$("#_dev-close").on("click", function(e) {
    		//pageRefresh("/abc/work/view",{"work_no":"${param.work_no}","tab":"#estimate_view"});
    		window.close();
		});
		$("._dev-close").on("click", function(e) {
    		window.close();
		});
		/* tbody row event */
		$("tbody").on("click", "[name=_dev-edit]", function(e) {
			let $_tr = $(this).closest("tr");
			$_tr.find("input,select:not([name=est_unit_cd])").prop("disabled", false);
			$_tr.find("[name=_dev-edit]").css("display", "none");
			$_tr.find("[name=_dev-delete]").css("display", "none");
			$_tr.find("[name=_dev-edit_cancel]").css("display", "");
			$_tr.find("[name=_dev-save]").css("display", "");
			$("[name=unit_cd]",$_tr).off();
			$("[name=unit_cd]",$_tr).on("change",function(){
				$("[name=est_unit_cd]",$_tr).val(this.value);
			})

		}).on("click", "[name=_dev-edit_cancel]", function(e) {
			let $_tr = $(this).closest("tr");
			$_tr.find("input,select").prop("disabled", true);
			$_tr.find("[name=_dev-edit]").css("display", "");
			$_tr.find("[name=_dev-delete]").css("display", "");
			$_tr.find("[name=_dev-edit_cancel]").css("display", "none");
			$_tr.find("[name=_dev-save]").css("display", "none");

		}).on("click", "[name=_dev-cancel]", function(e) {

			$(this).closest("tr").remove();

		}).on(
				"click",
				"[name=_dev-save]",
				function(e) {
					console.log("저장 버튼클릭!");

					let $_tr = $(this).closest("tr");
					$_tr.find("[name=est_unit_cd]").prop("disabled", false);
					let param = {};

					let work_no = $_tr.data("work_no");
					let version_no = $_tr.data("version_no");
					let resource_no = $_tr.data("resource_no");

					let resource_type = $_tr.find("[name=resource_type]");
					let resource_name = $_tr.find("[name=resource_name]");
					let resource_standard = $_tr.find("[name=resource_standard]");
					let resource_count = $_tr.find("[name=resource_count]");
					let unit_cd = $_tr.find("[name=unit_cd]");
					let unit_price = $_tr.find("[name=unit_price]");

					let est_unit_cd = $_tr.find("[name=est_unit_cd]");
					let est_resource_count = $_tr.find("[name=est_resource_count]");
					let est_unit_price = $_tr.find("[name=est_unit_price]");

					//debugger;
					if (resource_type.val() == '') {
						alert('견적서 구분을 선택하세요!');
						resource_type.focus();
						return;
					}
					if (resource_name.val() == '') {
						alert('내역을 입력하세요!');
						resource_type.focus();
						return;
					}
					/* 	if(resource_standard.val() == ''){
					 alert('규격을 입력하세요!');
					 resource_standard.focus();
					 return;
					 } */
					if (unit_cd.val() == '') {
						alert('자재 단위를 선택하세요!');
						unit_cd.focus();
						return;
					}
					if (resource_count.val() == '') {
						alert('수량을 입력하세요!');
						resource_count.focus();
						return;
					}
					if (unit_price.val() == '') {
						alert('단가를 입력하세요!');
						unit_price.focus();
						return;
					}

					if (est_unit_cd.val() == '') {
						alert('예상실행가 단위를 입력하세요!');
						est_unit_cd.focus();
						return;
					}

					if (est_resource_count.val() == '') {
						alert('예상실행가 수량을 입력하세요!');
						est_resource_count.focus();
						return;
					}
					if (est_unit_price.val() == '') {
						alert('예상실행가 단가를 입력하세요!');
						est_unit_price.focus();
						return;
					}

					param['resource_type'] = resource_type.val();
					param['resource_name'] = resource_name.val();
					param['resource_standard'] = resource_standard.val();
					param['unit_cd'] = unit_cd.val();
					param['resource_count'] = Utils.rmComma(resource_count
							.val());
					param['unit_price'] = Utils.rmComma(unit_price.val());
					//
					param['est_unit_cd'] = est_unit_cd.val();
					param['est_resource_count'] = Utils
							.rmComma(est_resource_count.val());
					param['est_unit_price'] = Utils.rmComma(est_unit_price
							.val());

					param['work_no'] = work_no;
					param['version_no'] = version_no;
					param['resource_no'] = resource_no;

					saveRow(param,$_tr);

					$_tr.find("input,select").prop("disabled", true);
					$_tr.find("[name=_dev-edit]").css("display", "");
					$_tr.find("[name=_dev-delete]").css("display", "");
					$_tr.find("[name=_dev-edit_cancel]").css("display", "none");
					$_tr.find("[name=_dev-save]").css("display", "none");
					$_tr.find("[name=_dev-cancel]").remove();

				}).on("click", "[name=_dev-delete]", function(e) {
			console.log("삭제 버튼클릭!");

			if (!confirm(Message.CONFIRM.DELETE))
				return;

			let $_tr = $(this).closest("tr");
			let param = {};
			let resource_no = $_tr.data("resource_no");
			param['resource_no'] = resource_no;
			deleteRow(param);
			$_tr.remove();
		}).on(
				"keyup blur",
				"[name$=resource_count], [name$=unit_price]",
				function(e) {

					let $_tr = $(this).closest("tr");

					if (Utils.isEmpty($(this).val()))
						return;

					let resource_count = 0;
					let unit_price = 0;
					let amt = 0;

					let _name = $(this).prop("name");
					let _tmpname = "";

					if (_name.indexOf("est_") > -1) {
						_tmpname = "est_";
					}

					resource_count = Utils.rmComma($_tr.find(
							"[name=" + _tmpname + "resource_count]").val());
					unit_price = Utils.rmComma($_tr.find(
							"[name=" + _tmpname + "unit_price]").val());
					amt = resource_count * unit_price;

					$_tr.find("[name=" + _tmpname + "unit_sum_price]")
							.html(new Intl.NumberFormat().format(amt));

					let unit_sum_price = Utils.rmComma($_tr.find(
							"[name=unit_sum_price]").text());
					let est_unit_sum_price = Utils.rmComma($_tr.find(
							"[name=est_unit_sum_price]").text());

					let amt_margin = unit_sum_price - est_unit_sum_price;
					let rate_margin = amt_margin / unit_sum_price * 100;


					$_tr.find("[name=amt_margin]").html(new Intl.NumberFormat().format(amt_margin));
					$_tr.find("[name=rate_margin]").html(
							Utils.round(rate_margin, 1));

				});

		init();
	});

	function init(){
		$($("tbody [name$=unit_price]")).each(function (idx,item) { $(item).trigger("blur"); });
		$(".btn-add").each(function (idx,item){ $(item).trigger("click")});

		/* 견적 단위 선택시 예상실행 단위 자동으로 선택 */
		/* $('[name=unit_cd]').change(function(){
			console.log('셀렉트',$('[name=unit_cd]').val());
			let unit_cd_val = $('[name=unit_cd]').val();
			$('[name="est_unit_cd"]').val(unit_cd_val);
		});	 */

		/* $('select[name=unit_cd]').change(function(){
			console.log('셀렉티드',$('select[name=unit_cd]').val());
		});	 */
	}

	function saveRow(_param,_tr) {
		const _name = "견적서 저장"; // ajax name
		const _url = "/estimate/save/ajax"; // ajax url
		//let _param = $("#frm").serializeObject();	// ajax param

		/* validate */
		//let validate = $("[name=frm]").parsley().validate();
		//if(!validate) {
		//	console.log('# validate false !!!');
		//	return;
		//}
		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
			success : function(data) {
				alert(data.result_msg);
				_tr.data("resource_no",data.key_no);
				//movePage("/code/partner/list");
			},
			complete : function(response) {
				console.log('complete!!!');
			}
		});
	}

	function deleteRow(_param) {
		const _name = "견적서 리소스 삭제"; // ajax name
		const _url = "/estimate/resource/delete"; // ajax url
		//let _param = $("#frm").serializeObject();	// ajax param

		/* validate */
		//let validate = $("[name=frm]").parsley().validate();
		//if(!validate) {
		//	console.log('# validate false !!!');
		//	return;
		//}
		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
			success : function(data) {
				alert(Message.SAVE);
				//movePage("/code/partner/list");
			},
			complete : function(response) {
				console.log('complete!!!');
			}
		});
	}
	/* 추가한 row 정보  */
	let addRowInfo

	function addRow(_work_no, _version_no, _estimate_no) {
		let $tbody = $("#tbody_" + _work_no);
		let rowIdx = $("tr",$tbody).length;
		let $trId = "row_"+ _work_no + "_" +rowIdx;
		const tr_tmp = '<tr id="'+$trId+'" data-work_no="'+ _work_no+'" data-version_no="'+ _version_no+'" data-estimate_no="'+ _estimate_no+'">'
				+ '<td>'
				+ (++rowIdx)
				+ '</td>'
				+ '<td><select class="form-control form-control-sm" name="resource_type">'
				+ resource_type
				+ '</select></td>'
				+ '<td nowrap>'
				+ '<input type="text" class="form-control form-control-sm" name="resource_name" value="" data-parsley-required="true" />'
				+ '</td>'
				+ '<td class="text-start">'
				+ '<input type="text" class="form-control form-control-sm" name="resource_standard" value="" data-parsley-required="true" />'
				+ '</td>'
				+ '<td><select class="form-control form-control-sm" name="unit_cd">'
				+ unit_cd
				+ '</select></td>'
				+ '<td><input type="number" class="form-control form-control-sm input-sm number" style="ime-mode:disabled;" name="resource_count" style="width:60px"  data-parsley-type="number" data-parsley-required="true" /></td>'
				+ '<td><input type="number" class="form-control form-control-sm number" style="ime-mode:disabled;" name="unit_price" style="width:100px" data-parsley-type="number" data-parsley-required="true" /></td>'
				+ '<td name="unit_sum_price">0</td>'
				+ '<td><select class="form-control form-control-sm" name="est_unit_cd"  disabled>'
				+ unit_cd
				+ '</select></td>'
				+ '<td><input type="number" class="form-control form-control-sm number" name="est_resource_count" style="width:60px" data-parsley-type="number" data-parsley-required="true" /></td>'
				+ '<td><input type="number" class="form-control form-control-sm number"  name="est_unit_price" style="width:100px" data-parsley-type="number" data-parsley-required="true" /></td>'
				+ '<td name="est_unit_sum_price">0</td>'
				+ '<td><b name="amt_margin">0</b></td>'
				+ '<td><b name="rate_margin">0</b></td>'
				+ '<td nowrap="">'
				+ '<div class="btn btn-sm btn-primary w-60px me-1" name="_dev-save">저장</div>'
				+ '<div class="btn btn-sm btn-white w-60px" name="_dev-cancel">취소</div>'
				+ '<div class="btn btn-sm btn-primary w-60px me-1" style="display:none;" name="_dev-edit">수정</div>'
				+ '<div class="btn btn-sm btn-white w-60px" style="display:none;" name="_dev-delete">삭제</div>'
				+ '</td>' + '</tr>';
		$tbody.append(tr_tmp);
		$("[name=unit_cd]","#"+$trId).on("change",function(){
			$("[name=est_unit_cd]","#"+$trId).val(this.value);
		})
		addRowInfo = $tbody + rowIdx + $trId;
	}
</script>



