<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- begin page-header -->
<h1 class="page-header">지출결의서 목록</h1>
<!-- content area -->
<div class="row">
	<!-- Begin area search -->
	<div class="col-12 mb-3">
		<div class="card">
			<form id="frm_search" data-parsley-validate="true" name="frm"  novalidate="">
			<div class="card-body border border-primary">
				<div class="row justify-content-md-between">
					<div class="col-md-2 col-6 mt-3">
                        <label class="form-label mb-2">지출일/기안일</label>
                        <div class="">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" id="inlineRadio1" name="srch_date_yn" value="SRCHY" checked>
                                <label class="form-check-label" for="inlineRadio1">지출일</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" id="inlineRadio2" name="srch_date_yn" value="SRCHN">
                                <label class="form-check-label" for="inlineRadio2">기안일</label>
                            </div>
                        </div>
                    </div>
					<div class="col-md-3 col-6 mt-3">
						<label class="form-label">지출일/기안일</label>
						<div class="input-group date " data-date-start-date="Date.default">
							<input type="text" class="form-control text-center" id="start_dt" name="start_dt" placeholder="연도-월-일" datepicker autocomplete='off'>
							<span class="input-group-append input-group-text px-1 my-0 pt-1 rounded-0 border-right-0"> ~ </span>
							<input type="text" class="form-control text-center" id="end_dt" name="end_dt" placeholder="연도-월-일" datepicker autocomplete='off'>
						</div>
					</div>
					<div class="col-md-2 col-4 mt-3">
						<label class="form-label">기안자명</label>
						<input type="text" name="admin_name" class="form-control" placeholder="기안자명 입력하세요.">
					</div>
					<div class="col-md-2 col-4 mt-3">
						<label class="form-label">문서번호</label>
						<input type="text" name="disb_id" class="form-control" placeholder="문서번호를 입력하세요.">
					</div>
					<div class="col-md-2 col-4 mt-3">
						<label class="form-label">용도</label>
						<select class="form-select" id="disb_usage" name="disb_usage">
					        <tags:code-select
								codeList="${disb_usage }"
								selected=""
								defaultValue="선택" />
						</select>
					</div>
					<div class="col-md-1 col-4 mt-3"></div>
					<div class="col-md-2 col-4 mt-3">
						<label class="form-label">작업일련번호</label>
						<input type="text" name="work_id" class="form-control" placeholder="작업일련번호를 입력하세요.">
					</div>

					<div class="col-md-10 col-4 mt-3"></div>
				</div>
				<hr>
				<div class="d-flex justify-content-end">
					<button type="button" class="btn btn-outline-primary" id="search_init">초기화</button>
					<button type="button" class="btn-search btn btn-primary ms-2">검색</button>
				</div>
			</div>
			</form>
		</div>
	</div>

	<div class="col-12">
		<div class="card">
			<div class="card-header">
				<div class="d-flex align-items-center justify-content-between">
					<div class="d-flex align-items-center"></div>
					<div class="d-flex align-items-center">
						<button class="btn btn-outline-success btn-excel">엑셀버튼</button>
					</div>
				</div>
			</div>
			<div id="grid_json"></div>
		</div>
		<div class="card-footer">
			<!-- <div class="d-flex align-items-center justify-content-between">
				<div class="pagination"></div>
				<div class="d-flex align-items-center">
					<button class="btn btn-outline-success" name="movePage"
						data-url="/account/disbursement/form">등록버튼</button>
				</div>
			</div> -->
		</div>
	</div>


</div>


<!-- begin modal -->
	<!-- 자재 추가 -->
<%-- 	<div class="modal fade" id="modal-dialog-reject">
		<input type="hidden" id="disb_no"/>
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">반려사유</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
					<!-- <input type="hidden" id="ware_house_cnt" name="ware_house_cnt" > -->
					<div class="form-row">
					    <div class="col-md-12 mb-3">
					      <label class="form-label mb-2">반려사유</label>
					      <div class="col-md-12 pt-2">
					        <tags:code-radio
							        codeList="${disb_reject }"
							        checked=""
							        name="disb_reject"
							        required="false"
							        initValue="01"
							/>
					      </div>
					    </div>
				  	</div>
				</div>
				<div class="modal-footer">
					<a href="javascript:;" class="btn btn-white" data-dismiss="modal">닫기</a>
					<a href="javascript:;" class="btn btn-success" id="_btn_disb_reject">저장</a>
				</div>

			</div>
		</div>
	</div> --%>
	<%--
	<div class="modal fade" id="modal-dialog-confirm">
		<input type="hidden" id="disb_no"/>
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">결제확인</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
					<!-- <input type="hidden" id="ware_house_cnt" name="ware_house_cnt" > -->
					<div class="form-row">
					    <div class="col-md-12 mb-3">
					      <label class="form-label mb-2">결제범위</label>
					      <div class="col-md-12 pt-2">
					        <tags:code-radio
							        codeList="${pay_scope }"
							        checked=""
							        name="pay_scope"
							        required="false"
							        initValue="03"
							/>
					      </div>
					    </div>
				  	</div>

					<div class="col-md-12 col-12 mt-3">
	                    <label class="form-label">결제완료금액<span class="text-danger">*</span></label>
	                    <div class = "form-group form-inline">
		                    <input type="text" class="form-control"
		                    	placeholder="결제완료금액"
		                    	id="pay_price"
		                    	name="pay_price"
		                    	value=""
		                    	data-parsley-required="false"
		                    	comma
		                    />
		                    &nbsp;/&nbsp;
		                    <input type="text" class="form-control"
		                    	placeholder="총결제금액"
		                    	id="pay_req_amt"
		                    	name="pay_req_amt"
		                    	value=""
		                    	data-parsley-required="false"
		                    	readonly
		                    />
	                    </div>
	                </div>

					<div class="col-md-3 col-12 mt-3" id="_div_pay_scope" style="display:none">
	                    <label class="form-label">다음 결제일자<span class="text-danger">*</span></label>
	                    <input type="text" class="form-control"
	                    	placeholder="연도-월-일"
	                    	id="pay_next_date"
	                    	name="pay_next_date"
	                    	value=""
	                    	data-parsley-required="false"
	                    	datepicker
	                    	/>
	                </div>

				</div>
				<div class="modal-footer">
					<a href="javascript:;" class="btn btn-white" data-dismiss="modal">닫기</a>
					<a href="javascript:;" class="btn btn-success" id="_btn_disb_confirm">저장</a>
				</div>

			</div>
		</div>
	</div> --%>


<!-- begin modal -->
	<!-- 자재 추가 -->
<%-- 	<div class="modal fade" id="modal-dialog-reject">
		<input type="hidden" id="disb_no"/>
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">반려사유</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
					<!-- <input type="hidden" id="ware_house_cnt" name="ware_house_cnt" > -->
					<div class="form-row">
					    <div class="col-md-12 mb-3">
					      <label class="form-label mb-2">반려사유</label>
					      <div class="col-md-12 pt-2">
					        <tags:code-radio
							        codeList="${disb_reject }"
							        checked=""
							        name="disb_reject"
							        required="false"
							        initValue="01"
							/>
					      </div>
					    </div>
				  	</div>
				</div>
				<div class="modal-footer">
					<a href="javascript:;" class="btn btn-white" data-dismiss="modal">닫기</a>
					<a href="javascript:;" class="btn btn-success" id="_btn_disb_reject">저장</a>
				</div>

			</div>
		</div>
	</div> --%>
	<%--
	<div class="modal fade" id="modal-dialog-confirm">
		<input type="hidden" id="disb_no"/>
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">결제확인</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
					<!-- <input type="hidden" id="ware_house_cnt" name="ware_house_cnt" > -->
					<div class="form-row">
					    <div class="col-md-12 mb-3">
					      <label class="form-label mb-2">결제범위</label>
					      <div class="col-md-12 pt-2">
					        <tags:code-radio
							        codeList="${pay_scope }"
							        checked=""
							        name="pay_scope"
							        required="false"
							        initValue="03"
							/>
					      </div>
					    </div>
				  	</div>

					<div class="col-md-12 col-12 mt-3">
	                    <label class="form-label">결제완료금액<span class="text-danger">*</span></label>
	                    <div class = "form-group form-inline">
		                    <input type="text" class="form-control"
		                    	placeholder="결제완료금액"
		                    	id="pay_price"
		                    	name="pay_price"
		                    	value=""
		                    	data-parsley-required="false"
		                    	comma
		                    />
		                    &nbsp;/&nbsp;
		                    <input type="text" class="form-control"
		                    	placeholder="총결제금액"
		                    	id="pay_req_amt"
		                    	name="pay_req_amt"
		                    	value=""
		                    	data-parsley-required="false"
		                    	readonly
		                    />
	                    </div>
	                </div>

					<div class="col-md-3 col-12 mt-3" id="_div_pay_scope" style="display:none">
	                    <label class="form-label">다음 결제일자<span class="text-danger">*</span></label>
	                    <input type="text" class="form-control"
	                    	placeholder="연도-월-일"
	                    	id="pay_next_date"
	                    	name="pay_next_date"
	                    	value=""
	                    	data-parsley-required="false"
	                    	datepicker
	                    	/>
	                </div>

				</div>
				<div class="modal-footer">
					<a href="javascript:;" class="btn btn-white" data-dismiss="modal">닫기</a>
					<a href="javascript:;" class="btn btn-success" id="_btn_disb_confirm">저장</a>
				</div>

			</div>
		</div>
	</div>
		 --%>
<!-- end modal -->

<!-- begin modal -->
	<!-- 반려사유 -->
	<div class="modal fade" id="modal-dialog-stat">
		<input type="hidden" id="disb_no"/>
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">반려사유</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
					<!-- <input type="hidden" id="ware_house_cnt" name="ware_house_cnt" > -->
					<div class="form-row">
					    <div class="col-md-12 mb-3">
					      <label class="form-label mb-2">반려사유</label>
					      <div class="col-md-12 pt-2">
					        <tags:code-radio
							        codeList="${disb_reject }"
							        checked=""
							        name="disb_reject"
							        required="false"
							        initValue="01"
							/>
					      </div>
					    </div>
						<div class="col-md-12 mb-3 mt-3">
							<label class="form-label mb-2">반려상세사유</label>
							<div class="col-md-12 pt-2">
								<input type="text" class="form-control " placeholder="반려상세사유" name="reject_remark" id="reject_remark"/>
							</div>
						</div>
				  	</div>
				</div>
				<div class="modal-footer">
					<a href="javascript:;" class="btn btn-white" data-dismiss="modal">닫기</a>
					<a href="javascript:;" class="btn btn-success" id="_btn_disb_reject">저장</a>
				</div>

			</div>
		</div>
	</div>


<!-- end modal -->

	<!-- ================== BEGIN Jandi SCRIPT ================== -->
	<script type="text/javascript" src="/assets/js/Jandi.js"></script>
	<!-- ================== END Jandi SCRIPT ================== -->

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
	            title: "기안일시",
	            width: 130,
	            dataType: "string",
	            align: "center",
	            dataIndx: "create_date",
	            /* format: function(val){
	                return Utils.getDatetime(val);
	            } */
	        	render : function(ui) {
				let row = ui.rowData;
				let returnString = "";
				
				returnString = returnString 
					+ Utils.getDatetime(row.create_date).substr(0,10)
					+ '(' + Utils.getDayOfWeek(Utils.getDatetime(row.create_date).substr(0,10)) + ')'
					+ '<br>'
					+ Utils.getDatetime(row.create_date).substr(10,12)

				return returnString					
				}
	        },
	        {
	            title: "기안자정보",
	            colModel :[
	            	{
	    	            title: "이름",
	    	            width: 80,
	    	            dataType: "string",
	    	            dataIndx: "admin_name",
	    	            align: "center"
	    	        },
	    	        {
	    	            title: "부서",
	    	            width: 120,
	    	            dataType: "string",
	    	            dataIndx: "department_cd",
	    	            align: "center",
	    	            render: function( ui ){
	    	                let row = ui.rowData;
	    	                return {
	    	                    text: getCodeNm('department', row.department_cd)
	    	                };
	    	            }
	    	        },
	    	        {
	    	            title: "카드번호",
	    	            width: 80,
	    	            dataType: "string",
	    	            dataIndx: "card_no",
	    	            align: "center",
	    	        },
	            ]
	        },
	        {
	            title: "지출내역",
	            colModel :[
	            	{
	    	            title: "지출일",
	    	            width: 100,
	    	            dataType: "string",
	    	            align: "center",
	    	            dataIndx: "disb_date",
	    	            format: function(val){
	    	                return Utils.getDate(val) + '(' + Utils.getDayOfWeek(Utils.getDate(val)) + ')'
	    	            }
	    	        },
	    	        {
	    	            title: "지출금액",
	    	            width: 100,
	    	            dataType: "integer",
	    	            format: "#,###",
	    	            style: "font-weight: bold",
	    	            dataIndx: "disb_amt",
	    	        },
	    	        {
	    	            title: "용도",
	    	            width: 80,
	    	            dataType: "string",
	    	            dataIndx: "disb_usage",
	    	            align: "center",
	    	            render: function( ui ){
	    	                let row = ui.rowData;
	    	                let _text = getCodeNm('disb_usage', row.disb_usage);
	    	                if(!Utils.isEmpty(row.remark)){
	    	                	_text += "<br>"+row.remark;
	    	                }
	    	                return {
	    	                    text: _text
	    	                };
	    	            }
	    	        },
	    	        {
	    	            title: "성격",
	    	            width: 200,
	    	            dataType: "string",
	    	            dataIndx: "disb_type",
	    	            render: function( ui ){
	    	                let row = ui.rowData;
	    	                return {
	    	                    text: getCodeNm('disb_type', row.disb_type)
	    	                };
	    	            }
	    	        },
	    	        {
	    	            title: "작업일련번호",
	    	            width: 140,
	    	            dataType: "string",
	    	            align: "center",
	    	            dataIndx: "work_id",
						render : function(ui) {
							let row = ui.rowData;
							let _customer = row.req_name;
							let _work_id = row.work_id;
							if(Utils.isEmpty(_work_id)){
								_customer ='-';
							} else {
								if(!Utils.isEmpty(row.branch_name)){
									_customer = row.customer_name +"/"+row.branch_name +"<br>"+ row.work_id ;
								} else {
									_customer = row.req_name +"<br>"+ row.work_id ;
								}
							}
							return {
								text : _customer
							};
						}
	    	        },
	    	        {
	    	            title: "지출대상자",
	    	            width: 120,
	    	            dataType: "string",
	    	            align: "left",
	    	            dataIndx: "disb_target",
	    	            align: "center",
	    	        },
	    	        {
	    	            title: "차량번호",
	    	            width: 90,
	    	            dataType: "string",
	    	            align: "left",
	    	            dataIndx: "car_no",
	    	            align: "center",
	    	        },
	    	        {
	    	            title: "지출증빙",
	    	            width: 80,
	    	            dataType: "string",
	    	            align: "center",
						render : function(ui) {
							let row = ui.rowData;
							let _botton = '<button class="btn btn-xs btn-primary _button_img_pop" onclick="getImagePop(\'IMG_TYPE_DISBURSEMENT\', \''+row.disb_no+'\', \'지출증빙\');" >확인</button>';
							return {
								text : _botton,
							};
						}
	    	        },
	            ]
	        },
	        {
	            title: "상태",
	            width: 120,
	            align: "center",
	            dataType: "string",
	            dataIndx: "disb_stat",
    	        render : function(ui){
    	            let row = ui.rowData;
    	            let _disb_stat = getCodeNm('disb_stat', row.disb_stat);
    	            let _botton = '<button class="btn btn-xs btn-primary" name="_modal_disb_stat" data-disb_no="'+row.disb_no+'" data-disb_stat="02">완료</button>';
    	            	_botton += ' <button class="btn btn-xs btn-primary" name="_modal_disb_stat" data-disb_no="'+row.disb_no+'" data-disb_stat="99" data-row_indx="'+ui.rowIndx+'">반려</button>';

    	            let _text = '';
    	            if(row.disb_stat == '01'){
    	            	_text = _disb_stat+"<br>"+_botton;
    	            }
    	            else if(row.disb_stat == '99'){
    	            	_text = _disb_stat+"<br>"+getCodeNm('disb_reject', row.disb_reject);
    	            }
    	            else if(row.disb_stat == '02'){
    	            	_text = _disb_stat;
    	            }
    	            return {
    	                text: _text,
    	            };
    	        }
	        },
	        {
	            title: "문서번호",
	            width: 120,
	            dataType: "string",
	            dataIndx: "disb_id",
	            align: "center",
	            render : function(ui) {
					let row = ui.rowData;
					return {
						text : ""
								+ '<p style="margin-bottom: 0px; color: #00acac; text-decoration: underline; text-underline-offset: 3px; ">'
								+ row.disb_id + '</p>',
					};
				}
	        },
	        {
	            title: "",
	            width: 120,
	            dataType: "string",
	            dataIndx: "disb_no",
	            hidden : true
	        },
	    ];

		const _desc = "고객사 지점 목록 조회";	// ajax name
		const _url = "/account/disbursement/list/ajax";	// ajax url
		let _param = {};	// ajax param
		var data;

	    // draw grind
		let options = {
/* 			rowDblClick: function( event, ui ) {
				event.preventDefault();
				let param = {disb_no : ui.rowData.disb_no}
				postPage("/account/disbursement/view", param);
			} */
	    };

	    gridTmp = Wgrid.draw("#grid_json", _param, _url, colModel, options, _desc);

		/* 반려 modal*/
		$("#grid_json").on("click", "[name=_modal_disb_stat]", function(e){
			console.log("data:", $(this).data());

			let _disb_stat = $(this).data("disb_stat");

			if(_disb_stat == '02'){
				let _param ={};
				_param.disb_no = $(this).data("disb_no");
				_param.disb_stat = _disb_stat;	// 상태
				saveDisbStat(_param);
			}
			else if(_disb_stat == '99'){
				$('#modal-dialog-stat').modal({backdrop: 'static', keyboard: false}) ;
				$("#modal-dialog-stat").modal("show");
				$("#modal-dialog-stat #disb_no").val($(this).data("disb_no"));
			}
		});

		/* 반려 저장*/
		$("#modal-dialog-stat").on("click", "#_btn_disb_reject", function(e){
			let _param ={};
			_param.disb_no = $("#modal-dialog-stat #disb_no").val();
			_param.disb_reject = $("[name=disb_reject]:checked").val();
			_param.reject_remark = $("#reject_remark").val();
			_param.disb_stat = "99";	// 상태 반려
			saveDisbStat(_param);
		});

		$(".btn-excel").on("click", function(){
			let _excelColModel = [
		        {
		            title: "기안일시",
		            width: 160,
		            dataType: "string",
		            align: "center",
		            dataIndx: "create_date",
		            format: function(val){
		                return Utils.getDatetime(val);
		            } 
		          
		        },
		        {
		            title: "기안자정보",
		            colModel :[
		            	{
		    	            title: "이름",
		    	            width: 120,
		    	            dataType: "string",
		    	            dataIndx: "admin_name",
		    	            align: "center"
		    	        },
		    	        {
		    	            title: "부서",
		    	            width: 120,
		    	            dataType: "string",
		    	            dataIndx: "department_cd",
		    	            render: function( ui ){
		    	                let row = ui.rowData;
		    	                return {
		    	                    text: getCodeNm('department', row.department_cd)
		    	                };
		    	            }
		    	        },
		    	        {
		    	            title: "카드번호",
		    	            width: 120,
		    	            dataType: "string",
		    	            dataIndx: "card_no",
		    	        },
		            ]
		        },
		        {
		            title: "지출내역",
		            colModel :[
		            	{
		    	            title: "지출일",
		    	            width: 120,
		    	            dataType: "string",
		    	            align: "center",
		    	            dataIndx: "disb_date",
		    	            format: function(val){
		    	                return Utils.getDate(val);
		    	            }
		    	        },
		    	        {
		    	            title: "지출금액",
		    	            width: 120,
		    	            dataType: "integer",
		    	            format: "#,###",
		    	            style:"font-weight: bold" ,
		    	            dataIndx: "disb_amt",
		    	        },
		    	        {
		    	            title: "성격",
		    	            width: 200,
		    	            dataType: "string",
		    	            dataIndx: "disb_type",
		    	            render: function( ui ){
		    	                let row = ui.rowData;
		    	                return {
		    	                    text: getCodeNm('disb_type', row.disb_type)
		    	                };
		    	            }
		    	        },
		    	        {
		    	            title: "용도",
		    	            width: 160,
		    	            dataType: "string",
		    	            dataIndx: "disb_usage",
		    	            render: function( ui ){
		    	                let row = ui.rowData;
		    	                let _text = getCodeNm('disb_usage', row.disb_usage);
		    	                if(!Utils.isEmpty(row.remark)){
		    	                	_text += " / "+row.remark;
		    	                }
		    	                return {
		    	                    text: _text
		    	                };
		    	            }
		    	        },
		    	        {
		    	            title: "작업일련번호",
		    	            width: 180,
		    	            dataType: "string",
		    	            align: "center",
		    	            dataIndx: "work_id",
							render : function(ui) {
								let row = ui.rowData;
								let _customer = row.req_name;
								let _work_id = row.work_id;
								if(Utils.isEmpty(_work_id)){
									_customer ='-';
								} else {
									if(!Utils.isEmpty(row.branch_name)){
										_customer = row.customer_name +"/"+row.branch_name +" / "+ row.work_id ;
									} else {
										_customer = row.req_name +" / "+ row.work_id ;
									}
								}
								return {
									text : _customer
								};
							}
		    	        },
		    	        {
		    	            title: "지출대상자",
		    	            width: 120,
		    	            dataType: "string",
		    	            align: "left",
		    	            dataIndx: "disb_target",
		    	        },
		    	        {
		    	            title: "차량번호",
		    	            width: 120,
		    	            dataType: "string",
		    	            align: "left",
		    	            dataIndx: "car_no",
		    	        },
		            ]
		        },
		        {
		            title: "상태",
		            width: 200,
		            align: "center",
		            dataType: "string",
		            dataIndx: "disb_stat",
	    	        render : function(ui){
	    	            let row = ui.rowData;
	    	            let _disb_stat = getCodeNm('disb_stat', row.disb_stat);

	    	            let _text = '';
	    	            if(row.disb_stat == '01'){
	    	            	_text = _disb_stat;
	    	            }
	    	            else if(row.disb_stat == '99'){
	    	            	_text = _disb_stat+" / "+getCodeNm('disb_reject', row.disb_reject);
	    	            }
	    	            else if(row.disb_stat == '02'){
	    	            	_text = _disb_stat;
	    	            }
	    	            return {
	    	                text: _text,
	    	            };
	    	        }
		        },
		        {
		            title: "문서번호",
		            width: 120,
		            dataType: "string",
		            dataIndx: "disb_id",
		            align: "center", 
		            render : function(ui) {
						let row = ui.rowData;
						return {
							text : ""
									+ '<p style="margin-bottom: 0px; color: #00acac; font-weight: bold; text-decoration: underline; text-underline-offset: 3px; ">'
									+ row.disb_id + '</p>',
						};
					}
		            
		        },
		    ];
			let _excelParam = $("#frm_search").serializeObject();
			let _excelUrl = _url;
			let _excelOptions = {
					colModel : _excelColModel,
					title : "지출결의리스트"
			};
			Wgrid.excel(_excelParam, _excelUrl,_excelOptions);
		});
	});

	/* 상태 변경 */
	function saveDisbStat(_param){
		const _name = "반려사유저장 저장";	// ajax name
		const _url = "/account/disbursement/stat/save/ajax";	// ajax url

		/* multi form insert */
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	$("#modal-dialog-stat").modal("hide");
	          	alert(Message.SAVE);
	          	gridTmp.refreshDataAndView();

	          	console.log("_param.disb_stat:", _param.disb_stat);
	          	if(_param.disb_stat == '99') {
		          	// sending jandi message...
		          	gridTmp.one("complete", function(event, ui){
		          		console.log('grid complete');
			          	// JANDI Webhook
			          	let _data = {};
			          	for(const arg of gridTmp.getData()){
			          		if(_param.disb_no == arg.disb_no){
			          			_data = arg;
			          			break;
			          		}
			          	}
			          	Jandi.sendWebHookDisb(_data);
		          	});
	          	}

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