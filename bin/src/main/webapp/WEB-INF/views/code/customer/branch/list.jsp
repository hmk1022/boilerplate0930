<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- begin page-header -->
<h1 class="page-header">고객사/지점 관리</h1>
<!-- end page-header -->
<!-- begin panel -->

<div class="row">
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

	<!-- 목록 -->

	<div class="col-12">
		<div class="card">
			<div class="card-header">
				<div class="d-flex align-items-center justify-content-between">
					<div class="d-flex align-items-center"></div>
					<div class="d-flex align-items-center">
						<button class="btn btn-outline-success" name="movePage"
							data-url="/code/customer/branch/form">등록버튼</button>
					</div>
				</div>
			</div>
			<div class="card-body">
				<div id="grid_json"></div>
			</div>
		</div>
		<div class="card-footer">
			<div class="d-flex align-items-center justify-content-between">
				<div class="pagination"></div>
				<div class="d-flex align-items-center">
					<button class="btn btn-outline-success" name="movePage"
						data-url="/code/customer/branch/form">등록버튼</button>
				</div>
			</div>
		</div>
	</div>

</div>
<!-- end panel -->

<!-- buttons -->
<!-- <a href="#" class="btn btn-primary" name="movePage"
	data-url="/code/customer/branch/form">등록</a> -->

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


		var colModel = [ {
			title : "지점ID", 
			width : 150, 
			align : "center",
			dataType : "string", 
			dataIndx : "branch_id",
        	render : function(ui) {
			let row = ui.rowData;
				return {
					text : ""
							+ '<p style="margin-bottom: 0px; color: #00acac; text-decoration: underline; text-underline-offset: 3px; ">'
							+ row.branch_id + '</p>',
				};
			}
		}, 
		{
			title : "고객사명", 
			width : 200, 
			dataType : "string",
			align : "center",
			dataIndx : "customer_name" 
		},
		{
			title : "지점명", 
			width : 200, 
			dataType : "string", 
			align : "center",
			dataIndx : "branch_name" 
		}, 
		{
			title : "주소", 
			width : 400, 
			dataType : "string", 
			render : function(ui) {
				let row = ui.rowData;
				let _text = "";
				return {
					text : "("+row.work_zip+") "+row.comp_addr1 
				};
			}
		},
		{
			title : "사업자번호", 
			width : 140, 
			dataType : "string", 
			align : "center",
			dataIndx : "comp_number",
			format: function(val){
            	return Utils.bussNo(val);
            }
		}, 
		{
			title : "담당자", 
			width : 80, 
			align : "center",
			dataType : "string", 
			dataIndx : "manager_name" 
		}, 
		{
			title : "이메일", 
			width : 200, 
			dataType : "string", 
			dataIndx : "manager_email" 
		}, 
		{
			title : "세금계산서 발행 이메일", 
			width : 200, 
			dataType : "string", 
			dataIndx : "tax_email" 
		}, 
		{
			title : "연락처", 
			width : 140, 
			dataType : "string",
			align : "center",
			dataIndx : "manager_hp1",
			format: function(val){
            	return Utils.phone(val);
            }
		}, 
		 {
            title: "등록일시",
            width: 100,
            dataType: "string",
            dataIndx: "create_date",
            align: "center",
            format: "yy-mm-dd"
        },
		 {
            title: "수정일시",
            width: 100,
            dataType: "string",
            dataIndx: "update_date",
            align: "center",
            format: "yy-mm-dd"
        },

		];

		const _desc = "고객사 지점 목록 조회"; // ajax name
		const _url = "/code/customer/branch/list/ajax"; // ajax url
		let _param = {}; // ajax param
		var data;

		// draw grind 
		let options = {
			rowDblClick : function(event, ui) {
				event.preventDefault();
				console.log("ui", ui.rowData.branch_no);
				let param = {
					branch_no : ui.rowData.branch_no
				}
				postPage("/code/customer/branch/view", param);
			}
		};

		Wgrid.draw("#grid_json", _param, _url, colModel, options, _desc);

	});
</script>