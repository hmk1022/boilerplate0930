<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

<!-- begin page-header -->
<h1 class="page-header">결제 및 매출관리</h1>
	<!-- content area -->
	<div class="row">
	<!-- Begin area search -->
	<div class="col-12 mb-3">
		<div class="card">
			<form id="frm_search" data-parsley-validate="true" name="frm"  novalidate="">
			<div class="card-body border border-primary">
				<div class="row justify-content-md-between">
					<div class="col-md-3 col-6 mt-3">
						<label class="form-label">매출일</label>
						<div class="input-group"
							data-date-format="yyyy-mm-dd"
							data-date-start-date="Date.default"
							>
							<input type="text" class="form-control text-center" id="start_dt" name="start_dt" placeholder="연도-월-일" datepicker autocomplete='off'>
							<span class="input-group-append input-group-text px-1 my-0 pt-1 rounded-0 border-right-0"> ~ </span>
							<input type="text" class="form-control text-center" id="end_dt" name="end_dt" placeholder="연도-월-일" datepicker autocomplete='off'>
						</div>
					</div>
					<div class="col-md-2 col-4 mt-3">
						<label class="form-label">사업구분</label>
						<select class="form-select" name="work_target">
					        <tags:code-select
								codeList="${work_target }"
								selected=""
								defaultValue="선택" />
						</select>
					</div>
					<div class="col-md-2 col-4 mt-3">
						<label class="form-label">고객명</label>
						<input type="text" name="req_name" class="form-control" placeholder="고객명를 입력하세요.">
					</div>
					<div class="col-md-2 col-4 mt-3">
						<label class="form-label"></label>
						<input type="text" name="work_id" class="form-control" placeholder="일련번호를 입력하세요.">
					</div>
					<div class="col-md-2 col-4 mt-3">
						<label class="form-label">공사명</label>
						<input type="text" name="location_name" class="form-control" placeholder="공사명을 입력하세요.">
					</div>
					<div class="col-md-1 col-4 mt-3"></div>
				</div>
				<hr>
				<div class="d-flex justify-content-end">
					<button type="button" class="btn btn-outline-primary" id="search_init">초기화</button>
					<button type="button" class="btn btn-primary ms-2 btn-search">검색</button>
				</div>
			</div>
			</form>
		</div>
	</div>



	<div class="col-12">
		<div class="card">
<!-- 			<div class="card-header">
				<div class="d-flex align-items-center justify-content-between">
					<div class="d-flex align-items-center"></div>
					<div class="d-flex align-items-center">
						<button class="btn btn-outline-success" name="movePage"
							data-url="/account/payment/form">등록버튼</button>
					</div>
				</div>
			</div> -->
			<div id="grid_json"></div>
		</div>
		<div class="card-footer">
<!-- 			<div class="d-flex align-items-center justify-content-between">
				<div class="pagination"></div>
				<div class="d-flex align-items-center">
					<button class="btn btn-outline-success" name="movePage"
						data-url="/account/payment/form">등록버튼</button>
				</div>
			</div> -->
		</div>
	</div>
</div>

<!-- begin modal -->
	<!-- 증빙 추가 -->
	<div class="modal fade" id="modal-dialog-approval">
		<input type="hidden" id="pay_no"/>
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">지출증빙 발행하기</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
					<div class="form-row">
					    <div class="col-md-12 mb-3">
					      <label class="form-label mb-2">지출증빙종류</label>
					      <div class="col-md-12 pt-2">
					      	<div>
					        <tags:code-radio2
							        codeList="${pay_bill_type }"
							        checked=""
							        name="pay_bill_type"
							        required="false"
							        initValue="01"
							/>
							<div class="form-check form-check-inline">
					            <input class="form-check-input" type="radio" id="pay_bill_type4" name="pay_bill_type" value="00">
					            <label class="form-check-label" for="pay_bill_type4">카드발행</label>
					        </div>
					        </div>
					      </div>
					    </div>
				  	</div>
	            	<div class="form-row">
			            <div class="col-md-6 col-12 ">
			            	<label class="form-label">발행일 <span class="text-danger"></span></label>
			                <input type="text" class="form-control " placeholder="발행일"
			                 name="pay_bill_yymmdd" id="pay_bill_yymmdd" datepicker
			                >
			            </div>
			            <div class="col-md-6 col-12 ">
			            	<label class="form-label">승인번호 <span class="text-danger"></span></label>
			                <input type="text" class="form-control " placeholder="승인번호"
			                 name="pay_approval_no" id="pay_approval_no"
			                 maxlength="15"
			                >
			            </div>
					</div>
					<div class="form-row">
			            <div class="col-md-6 col-12 mt-3" name="pay_bill_type_01_03">
			            	<label class="form-label">발행정보 <span class="text-danger"></span></label>
			                <input type="text" class="form-control " placeholder="발행정보"
			                 name="pay_bill_email" id="pay_bill_email"
			                >
			            </div>
			            <div class="col-md-6 col-12 mt-3" name="pay_bill_type_01_03">
			            	<label class="form-label">사업자등록번호 <span class="text-danger"></span></label>
			                <input type="text" class="form-control " placeholder="사업자등록번호"
			                 name="pay_bill_comp_number" id="pay_bill_comp_number"
			                 maxlength="15"
			                >
			            </div>
			            <div class="col-md-12 col-12 mt-3 buss-img">
							<label class="form-label text-muted">사업자등록증 사본</label>
							<h5>
								<div class="border p-3 my-3">
								    <ul class="registered-users-list clearfix">
								        <li>
								        	<a class="example-image-link" href="" data-lightbox="example-set" ><img class="example-image" src="" alt=""/></a>
								        </li>
								    </ul>
								</div>
							</h5>
						</div>
		            </div>
		            <div class="form-row">
		            	<div class="col-md-4 col-12 mt-3"></div>
		            </div>
					<div class="modal-footer">
						<a href="javascript:;" class="btn btn-white" data-dismiss="modal">닫기</a>
						<a href="javascript:;" class="btn btn-success" id="_btn_pay_approval">저장</a>
					</div>

				</div>
			</div>
		</div>
	</div>


	<!-- 결제 완료하기 -->
	<div class="modal fade" id="modal-dialog-complete">
		<input type="hidden" id="pay_no"/>
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">결제 완료하기</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
					<div class="form-row">
					    <div class="col-md-12 mb-3">
					      <label class="form-label mb-2">결제수단</label>
					      <div class="col-md-12 pt-2">
					        <tags:code-radio
							        codeList="${pay_type }"
							        checked=""
							        name="pay_type"
							        required="false"
							        initValue="01"
							/>
					      </div>
					    </div>
				  	</div>
	            	<div class="form-row">
			            <div class="col-md-6 col-12 ">
			            	<label class="form-label">결제완료일 <span class="text-danger"></span></label>
			                <input type="text" class="form-control " placeholder="발행일"
			                 name="paid_date" id="paid_date" datepicker
			                >
			            </div>
			            <!--
			            <div class="col-md-8 col-12 " name="pay_bill_type_02">
			            	<label class="form-label">승인번호 <span class="text-danger"></span></label>
			                <input type="text" class="form-control " placeholder="승인번호"
			                 name="approval_no" id="approval_no"
			                 maxlength="15"
			                >
			            </div> -->
					</div>
		            <div class="form-row">
		            	<div class="col-md-4 col-12 mt-3"></div>
		            </div>
					<div class="modal-footer">
						<a href="javascript:;" class="btn btn-white" data-dismiss="modal">닫기</a>
						<a href="javascript:;" class="btn btn-success" id="_btn_pay_complete">저장</a>
					</div>

				</div>
			</div>
		</div>
	</div>

	<!-- 수정하기 -->
	<div class="modal fade" id="modal-dialog-info">
		<input type="hidden" id="pay_no" name="pay_no"/>
		<div class="modal-dialog ">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">매출정보 변경하기</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
			        <div class="form-row">
			            <div class="col-md-6 col-12 mt-3">
			            	<label class="form-label">결제금액 <span class="text-danger"></span></label>
			                <input type="text" class="form-control " placeholder="결제금액"
			                 name="total_pay_price" id="total_pay_price"
			                 comma readonly
			                >
			            </div>
			            <div class="col-md-6 col-12 mt-3" name="pay_bill_type_02">
			            	<label class="form-label">결제완료일 <span class="text-danger"></span></label>
			                <input type="text" class="form-control " placeholder="결제완료일"
			                 name="paid_date" id="paid_date"
			                 maxlength="15" datepicker
			                >
			            </div>
					</div>
					<div class="form-row mt-3">
					    <div class="col-md-12 mb-3 mt-3">
					      <label class="form-label mb-2">결제수단</label>

					        <tags:code-radio
							        codeList="${pay_type }"
							        checked=""
							        name="pay_type"
							        required="false"
							        initValue=""
							/>
					    </div>
				  	</div>
					<div class="form-row mt-3">
					    <div class="col-md-12 mb-3">
					      <label class="form-label mb-2">지출증빙</label>
					      <div>
					        <tags:code-radio2
							        codeList="${pay_bill_type }"
							        checked=""
							        name="pay_bill_type"
							        required="false"
							        initValue=""
							/>
							<div class="form-check form-check-inline ">
					            <input class="form-check-input" type="radio" id="pay_bill_type_004" name="pay_bill_type" value="00">
					            <label class="form-check-label" for="pay_bill_type_004">카드발행</label>
					        </div>
					        </div>
					    </div>
				  	</div>
	            	<div class="form-row">
			            <div class="col-md-6 col-12 mt-3">
			            	<label class="form-label">지출증빙 발행일(매출일) <span class="text-danger"></span></label>
			                <input type="text" class="form-control " placeholder="발행일"
			                 name="pay_bill_yymmdd" id="pay_bill_yymmdd"
			                 datepicker
			                >
			            </div>
			            <div class="col-md-6 col-12 mt-3" name="pay_bill_type_02">
			            	<label class="form-label">승인번호 <span class="text-danger"></span></label>
			                <input type="text" class="form-control " placeholder="승인번호"
			                 name="pay_approval_no" id="pay_approval_no"
			                 maxlength="15"
			                >
			            </div>
					</div>
		            <div class="form-row">
		            	<div class="col-md-4 col-12 mt-3"></div>
		            </div>
					<div class="modal-footer">
						<a href="javascript:;" class="btn btn-white" data-dismiss="modal">닫기</a>
						<a href="javascript:;" class="btn btn-success" id="_btn_pay_info">저장</a>
					</div>

				</div>
			</div>
		</div>
	</div>
	<!-- page script -->
	<script>
	var curPage;
	var gridTmp ;
	/* init page */
	$(function(){
		console.log('page script !!!! ');

		$(".btn-search").on("click", search);

		$("#dev_button_form").on("click", function(e){
			e.preventDefault()
			window.location.href="";
		});

		var colModel = [
	        {
	            title: "사업구분",
	            width: 80,
	            dataType: "string",
	            align: "center",
	            dataIndx: "work_target",
	            format: function(val){
	                return getCodeNm('work_target', val);
	            }

	        },
	        {
	            title: "작업일련번호",
	            width: 120,
	            dataType: "string",
	            align: "center",
	            dataIndx: "work_id",
	        	render : function(ui) {
					let row = ui.rowData;
					return {
						text : row.work_id
					};
				}
	        },
	        /* {
	            title: "",
	            width: 120,
	            dataType: "string",
	            align: "center",
	            dataIndx: "work_id"
	        }, */
	        {
	            title: "고객(사)명",
	            width: 140,
	            dataType: "string",
	            dataIndx: "req_name",
	            align: "center",
				render : function(ui) {
					let row = ui.rowData;
					let _customer = row.req_name;
					if(!Utils.isEmpty(row.branch_name)){
						_customer = row.customer_name +"/"+row.branch_name +"<br>"+row.manager_name;
					}
					return {
						text : _customer
					};
				}
	        },
	        {
	            title: "작업명",
	            width: 200,
	            dataType: "string",
	            dataIndx: "location_name"
	        },
	        {
	            title: "담당자",
	            width: 60,
	            dataType: "string",
	            align : "center",
	            dataIndx: "manager_admin_name",
	        },
	        {
	            title: "결제종류",
	            width: 80,
	            dataType: "string",
	            align: "center",
	            dataIndx: "amount_type",
	            format: function(val){
	                return getCodeNm('amount_type', val);
	            }
	        },
	        {
	            title: "결제대상금액",
	            width: 100,
	            dataType: "integer",
	            format: "#,###",
	            style: "font-weight: bold",
	            dataIndx: "total_pay_price",
	        },
	        {
	            title: "매출액",
	            width: 90,
	            dataType: "integer",
	            format: "#,###",
	            dataIndx: "sales_price",
	        },
	        {
	            title: "세액",
	            width: 80,
	            dataType: "integer",
	            format: "#,###",
	            dataIndx: "tax_price",
	        },
	        {
	            title: "결제예정일",
	            width: 100,
	            dataType: "string",
	            dataIndx: "pay_date",
	            render: function(ui){
	            	let row = ui.rowData;
	            	let _style = "";
	            	if(row.date_diff > -1){
	            		row.date_diff = " +" + row.date_diff;
	            		_style = "color:blue";
	            	} else {
	            		_style = "color:red";
	            	}

	            	let _text = Utils.getDate(row.pay_date) +"<br><span style='"+ _style +"'>D " + row.date_diff +"</span>";
    	            return {
    	                text: _text,
    	                style:"text-align:center"
    	            };
	            }
	        },

	        {
	            title: "결제수단",
	            width: 80,
	            dataType: "string",
	            dataIndx: "pay_type",
	            align: "center",
	            format: function(val){
	                return getCodeNm('pay_abc_type', val);
	            }
	        },
	        {
	            title: "지출증빙",
	            width: 150,
	            dataType: "string",
	            dataIndx: "pay_approval_no",
	            render : function(ui){
    	            let row = ui.rowData;
    	            let _pay_bill_stat = row.pay_bill_stat;
    	            let _pay_bill_type = row.pay_bill_type;

   	            	let _botton = '<button class="btn btn-xs btn-primary" name="_modal_pay_approval" data-pay_no="'+row.pay_no+'" data-pay_bill_type="'+row.pay_bill_type+'" data-pay_bill_no="'+row.pay_bill_no+'" data-pay_bill_email="'+row.pay_bill_email+'" data-pay_bill_comp_number="'+row.pay_bill_comp_number+'" data-img_url="'+row.img_url+'">발행</button>';
   	            	let _text = '';

   	             	if(_pay_bill_stat == '99' || Utils.isEmpty(_pay_bill_stat)){ 	// 미발행
 	            		_text = getCodeNm('pay_bill_type', _pay_bill_type)+'<br>'+_botton;
 	            	}
 	            	/* else if(_pay_bill_stat == '00'){	// 발행
 	            		_text = getCodeNm('pay_bill_type', _pay_bill_type)+'<br>('+row.pay_approval_no+')<br>'+Utils.getDatetime(row.pay_bill_date)+'<br>'+ row.pay_bill_admin_name;
 	            	} */
 	            	else {
 	            		_text = getCodeNm('pay_bill_type', _pay_bill_type)+'<br>('+row.pay_approval_no+')<br>'+Utils.getDatetime(row.pay_bill_date)+'<br>'+ row.pay_bill_admin_name;
 	            		//_text = getCodeNm('pay_bill_type', _pay_bill_type)
 	            	}
    	            return {
    	                text: _text,
    	                style:"text-align:center"
    	        	};
    	        }
	        },
	        {
	            title: "결제완료일",
	            width: 120,
	            dataType: "string",
	            align: "center",
    	        render : function(ui){
    	            let row = ui.rowData;

    	            let _botton = '<button class="btn btn-xs btn-primary" name="_modal_pay_complete" data-pay_no="'+row.pay_no+'">완료</button>';
    	            let _text = '';

    	            let _pay_type = row.pay_type ;
    	            let _paid_date = row.paid_date ;
    	            let _stat = row.stat ;
    	            let _paid_proc_date = row.paid_proc_date ;
    	            let _paid_proc_admin_name = row.paid_proc_admin_name ;


    	            if(_stat == '01'){ 	// 결제전
    	            	//_text = getCodeNm('pay_stat', _stat)+'<br>'+_botton;
    	            	_text = '결제전'+'<br>'+_botton;
    	            }
    	            else if(_stat == '10'){	// 결제완료
    	            	let _day = Utils.getDayOfWeek(Utils.getDate(_paid_date));

    	            	if (!_day) _day = "";

    	            	_text = Utils.getDate(_paid_date) + '(' + _day + ')'//결제일
    	            	/* +
    	            	'<br>' + Utils.getDatetime(_paid_proc_date).substr(0,10)
    	            	+ '(' + Utils.getDayOfWeek(Utils.getDatetime(_paid_proc_date).substr(0,10))+ ')' +'<br>'+_paid_proc_admin_name; */ // 처리일
    	            }

    	            return {
    	            	text: _text,
    	            };
    	        }
	        },
	        {
	            title: "매출일",
	            width: 100,
	            dataType: "string",
	            dataIndx: "pay_bill_yymmdd",
	            render: function(ui){
	            	let row = ui.rowData;
	            	let _text = Utils.getDate(row.pay_bill_yymmdd) + '(' + Utils.getDayOfWeek(Utils.getDate(row.pay_bill_yymmdd)) + ')'

	            	if (!Utils.getDayOfWeek(Utils.getDate(row.pay_bill_yymmdd))) _text = ""
	            	return {
    	                text: _text,
    	                style:"text-align:center"
    	            };
	            }
	        },
	        {
	            title: "수정",
	            width: 70,
	            dataType: "string",
	            dataIndx: "",
	            align: "center",
    	        render : function(ui){
    	            let row = ui.rowData;
    	            let _botton = '<button class="btn btn-xs btn-primary" name="_move_pay_no" onclick="popEdit('+row.pay_no+')">수정</button>';
    	            return {
    	                text: _botton
    	            };
    	        }
	        },
	        {
	            title: "처리일",
	            width: 100,
	            dataType: "string",
	            dataIndx: "",
	            align: "center",
    	        render : function(ui){
    	            let row = ui.rowData;

    	            let _pay_type = row.pay_type ;
    	            let _paid_date = row.paid_date ;
    	            let _stat = row.stat ;
    	            let _paid_proc_date = row.paid_proc_date ;
    	            let _paid_proc_admin_name = row.paid_proc_admin_name ;

    	           	let _text
    	           	if (Utils.getDatetime(_paid_proc_date).substr(0,10)) {
    	           		_text =	Utils.getDatetime(_paid_proc_date).substr(0,10)
    	            	+ '(' + Utils.getDayOfWeek(Utils.getDatetime(_paid_proc_date).substr(0,10))+ ')' +'<br>'+_paid_proc_admin_name;
    	           	} else {
    	           		_text = "";
    	           	}


    	            return {
    	            	text: _text
    	            }
    	        }
	        },
	    ];


		const _desc = "고객사 지점 목록 조회";	// ajax name
		const _url = "/account/payment/list/ajax";	// ajax url
		let _param = {};	// ajax param
		var data;

	    // draw grind
		let options = {
		/*
 			rowDblClick: function( event, ui ) {
				event.preventDefault();
				let param = {pay_no : ui.rowData.pay_no}
				postPage("/account/payment/view", param);
			} */
	    };

	    $("#gird_json").on("click", "[name=_move_pay_no]", function(e) {
	    	e.preventDefault();
			let param = {pay_no : $(this).data('pay_no')}
			postPage("/account/payment/view", param);
	    });

		gridTmp = Wgrid.draw("#grid_json", _param, _url, colModel, options, _desc);

		/* 증빙 modal*/
		$("#grid_json").on("click", "[name=_modal_pay_approval]", function(e){
			let _pay_bill_type = $(this).data("pay_bill_type");
			let _buss_img_url = $(this).data("img_url");
			//console.log("exp_no:", $(this).data());
			//console.log("_pay_bill_type:", $(this).data("pay_bill_type"));

			$('#modal-dialog-approval').modal({backdrop: 'static', keyboard: false}) ;
			$("#modal-dialog-approval").modal("show");
			$("#modal-dialog-approval #pay_no").val($(this).data("pay_no"));

			if($(this).data("pay_bill_type") == '01'){ // 현금영수증(고객일 경우)
				$("#modal-dialog-approval #pay_bill_email").val($(this).data("pay_bill_no"));
			} else if($(this).data("pay_bill_type") == '03') { // 세금계산서 발행일 경우.
				$("#modal-dialog-approval #pay_bill_email").val($(this).data("pay_bill_email"));
			}

			$("#modal-dialog-approval #pay_bill_comp_number").val($(this).data("pay_bill_comp_number"));

			$("#modal-dialog-approval #pay_bill_yymmdd").val(Utils.getToday("-"));

			if(Utils.isNotEmpty(_pay_bill_type)){
				$("#modal-dialog-approval [name=pay_bill_type][value="+_pay_bill_type+"]").prop("checked", true);
			}
			if(Utils.isNotEmpty(_buss_img_url)){
				$(".buss-img").show();
				$(".example-image-link", ".buss-img").attr("href",_buss_img_url);
				$(".example-image", ".buss-img").attr("src",_buss_img_url);
			}else{
				$(".buss-img").hide();
				$(".example-image-link", ".buss-img").attr("href","");
				$(".example-image", ".buss-img").attr("src","");
			}

			$("[name=pay_bill_type]").trigger("change");
		});
		/* 증빙 저장*/
		$("#modal-dialog-approval").on("click", "#_btn_pay_approval", function(e){
			let _param ={};
			_param.pay_no = $("#modal-dialog-approval #pay_no").val();
			_param.pay_bill_type = $("[name=pay_bill_type]:checked").val();
			_param.pay_bill_stat = "00";	// 발행완료

			if(_param.pay_bill_type == '01') {
				_param.pay_bill_no = $("#modal-dialog-approval #pay_bill_email").val(); // 현금영수증 발행번호
			}else if(_param.pay_bill_type == '03') {
				_param.pay_bill_email = $("#modal-dialog-approval #pay_bill_email").val(); // 발행이메일
			}
			_param.pay_approval_no = $("#modal-dialog-approval #pay_approval_no").val(); // 지출증빙번호
			_param.pay_bill_yymmdd = $("#modal-dialog-approval #pay_bill_yymmdd").val(); // 용수증발행일/매출일
			_param.pay_bill_comp_number = $("#modal-dialog-approval #pay_bill_comp_number").val(); // 사업번호

			if(Utils.isEmpty(_param.pay_bill_yymmdd)){
				alert("발행일을 입력하세요.");
				return;
			}
			if(Utils.isEmpty(_param.pay_approval_no)){
				alert("승인번호를 입력하세요.");
				return;
			}
			/*
			if(Utils.isEmpty(_param.pay_bill_email)){
				alert("발행정보를 입력하세요.");
				return;
			}
			if(Utils.isEmpty(_param.pay_bill_comp_number)){
				alert("사업자등록번호를 입력하세요.");
				return;
			}
			 */
			savePayApproval(_param);
		});

		/* 지출증빙 */
		$("[name=pay_bill_type]").on("change", function(e){
			let _pay_bill_type = $("[name=pay_bill_type]:checked").val();

			console.log("_pay_bill_type", _pay_bill_type)
			if( _pay_bill_type == '02' || _pay_bill_type == '00') { // 현금영수증(자체)
				$("[name=pay_bill_type_01_03]").hide();
			}
			else {
				$("[name=pay_bill_type_01_03]").show();
			}
		});

		/* 결제완료 modal*/
		$("#grid_json").on("click", "[name=_modal_pay_complete]", function(e){
			console.log("exp_no:", $(this).data("pay_no"));
			$('#modal-dialog-complete').modal({backdrop: 'static', keyboard: false}) ;
			$("#modal-dialog-complete").modal("show");
			$("#modal-dialog-complete #pay_no").val($(this).data("pay_no"));

			//$("[name=exp_reject][value='01']").prop("checked", true);
		});

		/* 결제완료 저장*/
		$("#modal-dialog-complete").on("click", "#_btn_pay_complete", function(e){
			let _param ={};
			_param.pay_no = $("#modal-dialog-complete #pay_no").val();
			_param.pay_type = $("[name=pay_type]:checked").val();
			_param.stat = "10";	// 결제완료
			_param.paid_date = $("#modal-dialog-complete #paid_date").val(); // 결제타입
			_param.approval_no = $("#modal-dialog-complete #approval_no").val(); // 증빙번호

			savePayComplete(_param);
		});


		/* 결제 완료하기 */
		$("[name=pay_type]").on("change", function(e){
			let _pay_type = $(this).filter(":checked").val();
			if(_pay_type == '02') {	// 카드
				$("[name=pay_type_02]").show();
			}
			else {
				$("[name=pay_type_02]").hide();
			}
		});

		/* 매출정보 변경하기 */
		$("#_btn_pay_info").on("click", function(e){
			savePayInfo();
		});


	});


	//
	function savePayComplete(_param){

		const _name = "결제완료하기";	// ajax name
		const _url = "/account/payment/complete/save/ajax";	// ajax url

		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	alert(Message.SAVE);
	          	$("#modal-dialog-complete").modal("hide");
	          	gridTmp.refreshDataAndView();
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}

	//
	function savePayApproval(_param){

		const _name = "지출증빙 저장";	// ajax name
		const _url = "/account/payment/approval/save/ajax";	// ajax url

		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	alert(Message.SAVE);
	          	$("#modal-dialog-approval").modal("hide");
	          	gridTmp.refreshDataAndView();
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}

	// 수정페이지 pop
	function popEdit(_pay_no){
		let _param = {pay_no : _pay_no};
		console.log("");
		$('#modal-dialog-info').modal({backdrop: 'static', keyboard: false}) ;
		$("#modal-dialog-info").modal("show");

		// reset !!!

		const _name = "매출정보 조회";	// ajax name
		const _url = "/account/payment/view/select/ajax";	// ajax url

		let _target = $("#modal-dialog-info");

		_target.find("#paid_amount").val('');
        _target.find("#paid_date").val('');
        _target.find("[name=pay_type]").prop("checked", false);
        _target.find("[name=pay_bill_type]").prop("checked", false);
		_target.find("#pay_bill_yymmdd").val('');
    	_target.find("#pay_approval_no").val('');
    	_target.find("#pay_no").val('');

		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
            	console.log('data:', data);

            	_target.find("#total_pay_price").val(data.total_pay_price);
            	_target.find("#paid_date").val(data.paid_date);

            	_target.find("[name=pay_type][value='"+data.pay_type+"']").prop("checked", true);
            	_target.find("[name=pay_bill_type][value='"+data.pay_bill_type+"']").prop("checked", true);

            	_target.find("#pay_bill_yymmdd").val(data.pay_bill_yymmdd);
            	_target.find("#pay_approval_no").val(data.pay_approval_no);
            	_target.find("#pay_no").val(data.pay_no);
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}

	//
	function savePayInfo(){

		const _name = "매출정보 변경하기";	// ajax name
		const _url = "/account/payment/info/save/ajax";	// ajax url

		let _param ={};

		let _target = $("#modal-dialog-info");

		_param.total_pay_price =_target.find("#total_pay_price").val();
		_param.paid_date =_target.find("#paid_date").val();
		_param.pay_type =_target.find("[name=pay_type]:checked").val();
		_param.pay_bill_type =_target.find("[name=pay_bill_type]:checked").val();
		_param.pay_bill_yymmdd =_target.find("#pay_bill_yymmdd").val();
		_param.pay_approval_no =_target.find("#pay_approval_no").val();
		_param.pay_no =_target.find("#pay_no").val();

		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	alert(Message.SAVE);
	          	$("#modal-dialog-info").modal("hide");
	          	gridTmp.refreshDataAndView();
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}

	function search() {
		console.log("========== run search()");
		let $form = $("#frm_search");
		param = $form.serializeObject();
		console.log('search : ', param);
		gridTmp.option("dataModel.postData", param);
		gridTmp.refreshDataAndView();
	}
	</script>