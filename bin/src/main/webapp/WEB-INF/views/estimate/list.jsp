<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<!-- begin page-header -->
	<h1 class="page-header">고객사 <small>코드관리</small></h1>
	<!-- end page-header -->
	<!-- begin panel -->
	<div class="panel panel-inverse">
		<div class="panel-heading">
			<h4 class="panel-title">고객사 목록</h4>
			<div class="panel-heading-btn">
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-success" data-click="panel-reload"><i class="fa fa-redo"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
			</div>
		</div>
		<div class="panel-body">
			<div id="grid_json">
			</div>
		</div>
	</div>
	<!-- end panel -->
	
	<!-- buttons -->
	<a href="#" class="btn btn-primary" name="movePage" data-url="/material/material/doc/form">등록</a>
	
	<!-- page script -->
	<script>
	var curPage;
	
	/* init page */
	$(function(){
		console.log('page script !!!! ');

		$("#dev_button_form").on("click", function(e){
			e.preventDefault()
			window.location.href="";
		});
		
		var colModel = [
	        {
	            title: "이름/업체명", //title of column.
	            width: 300, //initial width of column
	            dataType: "string", //data type of column
	            dataIndx: "warehouse_name" //should match one of the keys in row data.
	        },	        
	        {
	            title: "분야", //title of column.
	            width: 300, //initial width of column
	            dataType: "string", //data type of column
	            dataIndx: "target_material" //should match one of the keys in row data.
	        },
	        {
	            title: "구분", //title of column.
	            width: 150, //initial width of column
	            dataType: "string", //data type of column
	            dataIndx: "warehouse_type", //should match one of the keys in row data.
	            format: function(val){
	            	return Utils.bussNo(val);
	            }
	        },
	        {
	            title: "신분증", //title of column.
	            width: 150, //initial width of column
	            dataType: "string", //data type of column
	            dataIndx: "id_no" //should match one of the keys in row data.
	        },
	        {
	            title: "등록자",
	            width: 100,
	            dataType: "string",
	            dataIndx: "create_no"
	        },
	        {
	            title: "등록일시",
	            width: 100,
	            dataType: "string",
	            dataIndx: "create_date",
	            align: "center",
	            format: "yy.mm.dd"
	        },
	        {
	            title: "수정자",
	            width: 100,
	            dataType: "string",
	            dataIndx: "update_no"
	        },
	        {
	            title: "수정일시",
	            width: 100,
	            dataType: "string",
	            dataIndx: "update_date",
	            align: "center",
	            format: "yy.mm.dd"
	        },
	        {
	            title: "지점번호",
	            dataIndx: "warehouse_no",
	            hidden: true
	        },
	    ];


		const _desc = "고객사 지점 목록 조회";	// ajax name
		const _url = "/material/material/doc/list/ajax";	// ajax url
		let _param = {};	// ajax param
		var data;
		
	    // draw grind 
		let options = {
			rowDblClick: function( event, ui ) {
				event.preventDefault();
				console.log("ui", ui.rowData.warehouse_no);
				let param = {warehouse_no : ui.rowData.warehouse_no}
				postPage("/material/material/doc/view", param);
			}
	    };
		
	    
		Wgrid.draw("#grid_json", _param, _url, colModel, options, _desc);
		
		console.log('테스트!!!');
	});

	</script>