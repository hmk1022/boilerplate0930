<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<!-- begin page-header -->
<h1 class="page-header">구매 거래처 관리</h1>
	<!-- content area -->
	<div class="row">
		<!-- Begin area search -->
	<!-- <div class="col-12 mb-3">
		<div class="card">
			<div class="card-body border border-primary">
				<div class="row justify-content-md-between">
					<div class="col-md-25 col-6">
						<label class="form-label mb-2">날짜검색</label>
						<div class="">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" id="inlineRadio1"
									name="inlineRadio"> <label class="form-check-label"
									for="inlineRadio1">접수일</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" id="inlineRadio2"
									name="inlineRadio"> <label class="form-check-label"
									for="inlineRadio2">작업일</label>
							</div>
						</div>
					</div>
					<div class="col-md-25 col-6 row align-items-end">
						<div class="input-group">
							<input type="text" class="form-control text-center"
								id="reg_date_from" placeholder="연도. 월. 일."> <span
								class="input-group-append input-group-text px-1 my-0 pt-1 rounded-0 border-right-0">
								~ </span> <input type="text" class="form-control text-center"
								id="reg_date_to" placeholder="연도. 월. 일.">
						</div>
					</div>
					<div class="col-md-25 col-4">
						<label class="form-label">고객구분</label> <select class="form-select">
							<option value="">선택</option>
						</select>
					</div>
					<div class="col-md-25 col-4">
						<label class="form-label">고객사</label> <select class="form-select">
							<option value="">선택</option>
						</select>
					</div>
					<div class="col-md-25 col-4">
						<label class="form-label">지점</label> <select class="form-select">
							<option value="">선택</option>
						</select>
					</div>
					<div class="col-md-25 col-4 mt-3">
						<label class="form-label">고객명</label> <input type="text"
							class="form-control">
						<div class="invalid-feedback">고객명을 입력하세요.</div>
					</div>
					<div class="col-md-25 col-4 mt-3">
						<label class="form-label">현장주소</label> <input type="text"
							class="form-control">
						<div class="invalid-feedback">현장주소를 입력하세요.</div>
					</div>
					<div class="col-md-25 col-4 mt-3">
						<label class="form-label">담당자</label> <input type="text"
							class="form-control">
						<div class="invalid-feedback">담당자를 입력하세요.</div>
					</div>
					<div class="col-md-25 col-4 mt-3">
						<label class="form-label">일련번호</label> <input type="text"
							class="form-control">
						<div class="invalid-feedback">일련번호을 입력하세요.</div>
					</div>
					<div class="col-md-25 col-4 mt-3">
						<label class="form-label">공사명</label> <input type="text"
							class="form-control">
						<div class="invalid-feedback">공사명을 입력하세요.</div>
					</div>
				</div>
				<hr>
				<div class="d-flex justify-content-end">
					<button class="btn btn-outline-primary">초기화</button>
					<button class="btn btn-primary ms-2">검색</button>
				</div>
			</div>
		</div>
	</div> -->



	<div class="col-12">
		<div class="card">
			<div class="card-header">
				<div class="d-flex align-items-center justify-content-between">
					<div class="d-flex align-items-center"></div>
					<div class="d-flex align-items-center">
						<button class="btn btn-outline-success" name="movePage"
							data-url="/code/vendor/form">등록버튼</button>
					</div>
				</div>
			</div>
			<div id="grid_json"></div>
		</div>
		<div class="card-footer">
			<div class="d-flex align-items-center justify-content-between">
				<div class="pagination"></div>
				<div class="d-flex align-items-center">
					<button class="btn btn-outline-success" name="movePage"
						data-url="/code/vendor/form">등록버튼</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- end panel -->

<!-- buttons -->
<!-- <a href="#" class="btn btn-primary" name="movePage"
	data-url="/code/vendor/form">등록</a> -->

<!-- page script -->
<script>
	var curPage;

	/* init page */
	$(function() {
		console.log('page script !!!! ');

		$("#dev_button_form").on("click", function(e) {
			e.preventDefault()
			window.location.href = "";
		});

		var colModel = [ 
			{
				title : "거래처명", //title of column.
				width : 300, //initial width of column
				dataType : "string", //data type of column
				align : "center",
				dataIndx : "vendor_name" //should match one of the keys in row data.
			},	
			{
				title : "분야", //title of column.
				width : 200, //initial width of column
				align : "center",
				dataType : "string", //data type of column
				dataIndx : "work_cate1",
			    render: function( ui ){
					let row = ui.rowData;
			        return {
			            text: getCodeNm('work_cate', row.work_cate1)+(row.work_cate2==''?'':'/')+getCodeNm('work_cate', row.work_cate2)+(row.work_cate3==''?'':'/')+getCodeNm('work_cate', row.work_cate3)
			        };
			    }
			}, 
			{
				title : "연락처", //title of column.
				width : 150, //initial width of column
				align : "center",
				
				dataType : "string", //data type of column
				dataIndx : "vendor_hp1", //should match one of the keys in row data.
				format : function(val) {
					return Utils.phone(val);
				}
			}, {
				title : "은행", //title of column.
				width : 110, //initial width of column
				align : "center",
				dataType : "string", //data type of column
				dataIndx : "bank_code",
	            format: function(val){
	            	return getCodeNm('vacct_bank_code', val);
	            }
			}, {
				title : "계좌", //title of column.
				width : 150, //initial width of column
				dataType : "string", //data type of column
				align: "center",
				dataIndx : "acct", //should match one of the keys in row data.
			}, {
				title : "사업자등록번호", //title of column.
				width : 150, //initial width of column
				align : "center",
				dataType : "string", //data type of column
				dataIndx : "comp_number", //should match one of the keys in row data.
				format : function(val) {
					return Utils.bussNo(val);
				}
			}, {
				title : "등록자",
				width : 100,
				dataType : "string",
				align: "center",
				dataIndx : "create_name"
			}, {
				title : "등록일시",
				width : 100,
				dataType : "date",
				dataIndx : "create_date",
				align : "center",
				format : "yy-mm-dd"
			}, {
				title : "수정자",
				width : 100,
				align : "center",
				dataType : "string",
				dataIndx : "update_name"
			}, {
				title : "수정일시",
				width : 100,
				dataType : "string",
				dataIndx : "update_date",
				align : "center",
				format : "yy-mm-dd"
			}, {
				title : "지점번호",
				dataIndx : "vendor_no",
				hidden : true
			}, 
		];

		const _desc = "고객사 지점 목록 조회"; // ajax name
		const _url = "/code/vendor/list/ajax"; // ajax url
		let _param = {}; // ajax param
		var data;

		// draw grind 
		let options = {
			rowDblClick : function(event, ui) {
				event.preventDefault();
				console.log("ui", ui.rowData.vendor_no);
				let param = {
					vendor_no : ui.rowData.vendor_no
				}
				postPage("/code/vendor/view", param);
			}
		};

		Wgrid.draw("#grid_json", _param, _url, colModel, options, _desc);

		console.log('테스트!!!');
	});
</script>