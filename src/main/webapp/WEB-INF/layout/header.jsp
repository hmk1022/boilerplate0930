	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<link rel="shortcut icon" href="/assets/img/favicon.ico"/>
	<meta charset="utf-8" />
	<title>Workerman ABC</title>
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />

	<!-- favicon -->

	<!-- ================== BEGIN BASE CSS STYLE ================== -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
	<link href="/assets/css/default/pub/app.min.css" rel="stylesheet" id="coloradmin"/>
	<link href="/assets/css/default/app.min.css" rel="stylesheet" id="coloradmin"/>
	<!-- <link href="/assets/css/default/pub/app.min.css" rel="stylesheet" id="coloradmin"/> -->
	<!-- ================== END BASE CSS STYLE ================== -->

	<script type="text/javascript" src="/assets/js/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>

	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

	<!-- AQUA -->
	<!-- <link href="/assets/css/default/theme/aqua.min.css" rel="stylesheet" /> -->

	<!-- ================== BEGIN PQ CSS STYLE ================== -->
    <link rel="stylesheet" href="/assets/js/paramquery/pqgrid.dev.css" /><!--ParamQuery Grid css files-->
    <link rel="stylesheet" href="/assets/js/paramquery/pqgrid.ui.dev.css" /><!--add pqgrid.ui.css for jQueryUI theme support-->
    <link rel="stylesheet" href="/assets/js/paramquery/themes/bootstrap/pqgrid.css" /><!--ParamQuery Grid custom theme e.g., office, bootstrap, rosy, chocolate, etc (optional)-->
    <link rel="stylesheet" href="/assets/plugins/bootstrap-datepicker/dist/css/bootstrap-datepicker.css" /><!-- datepicker -->
    <link rel="stylesheet" href="/assets/plugins/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" /><!-- datepicker -->
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/excite-bike/jquery-ui.css" />
	<link rel="stylesheet" href="/assets/css/vendor.min.css" />

	<!-- ================== END PQ CSS STYLE ================== -->
	<!-- ================== BEGIN FULLCALENDAR STYLE ================== -->
	<link rel="stylesheet" href="/assets/js/fullcalendar-scheduler-5.8.0/lib/main.css" />
	<!-- ================== END FULLCALENDAR STYLE ================== -->


	<!-- ================== BEGIN 디자인업체 STYLE ================== -->
    <link href="/assets/css/vendor.min.css" rel="stylesheet" />
    <link href="/assets/css/workerman-admin.css" rel="stylesheet" />
    <link href="/assets/css/datepicker.css" rel="stylesheet" />
    <link href="/assets/css/jquery.gritter.css" rel="stylesheet" />
    <link href="/assets/css/cover.css" rel="stylesheet" />
    <link href="/assets/css/workman_admin.css" rel="stylesheet">

    <!-- ================== END 디자인업체 STYLE ================== -->

	<!-- ================== BEGIN 이미지팝업 STYLE ================== -->
	<link href="/assets/plugins/lightbox2/dist/css/lightbox.css" rel="stylesheet" />
    <!-- ================== END 이미지팝업 STYLE ================== -->


	<!-- ================== BEGIN PQ JS SCRIPT ================== -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script><!--ParamQuery Grid js files-->
    <script type="text/javascript" src="/assets/js/paramquery/pqgrid.dev.js" defer></script>
    <script src="/assets/js/paramquery/localize/pq-localize-kr.js" defer></script><!--ParamQuery Grid localization file (necessary since v5.2.0)-->
    <script type="text/javascript" src="/assets/js/paramquery/pqTouch/pqtouch.min.js" defer></script><!--Include pqTouch file to provide support for touch devices (optional)-->
    <script type="text/javascript" src="/assets/js/paramquery/jsZip-2.5.0/jszip.min.js" defer></script><!--Include jsZip file to support xlsx and zip export (optional)-->
    <script type="text/javascript" src="/assets/js/paramquery/javascript-detect-element-resize/jquery.resize.js" defer></script><!--Include jquery.resize to support auto height of detail views in hierarchy (optional)-->
    <script type="text/javascript" src="/assets/plugins/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" defer></script><!--Include jquery.resize to support auto height of detail views in hierarchy (optional)-->
    <!-- ================== END PQ JS SCRIPT ================== -->

	<!-- ================== BEGIN ETC PLUGIN SCRIPT ================== -->
	<script type="text/javascript" src="/assets/js/jquery.bootpag.min.js"></script>
	<script type="text/javascript" src="/assets/js/FileSaver.js"></script>
	<!-- ================== END ETC PLUGIN SCRIPT ================== -->
	<!-- file upload -->

	<!-- ================== BEGIN UTILS SCRIPT ================== -->
	<script type="text/javascript" src="/assets/js/Utils.js"></script>
	<!-- ================== END UTIS SCRIPT ================== -->

	<!-- ================== BEGIN FULLCALENDAR SCRIPT ================== -->
 	<script type="text/javascript" src="/assets/js/fullcalendar-scheduler-5.8.0/lib/main.js"></script>
 	<script type="text/javascript" src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
 	<script type="text/javascript" src="https://unpkg.com/tippy.js"></script>
	<!-- ================== END FULLCALENDAR SCRIPT ================== -->



	<!-- ================== BEGIN file-upload css, script ================== -->
	<!--
	<link rel="stylesheet" href="/assets/plugins/jQuery-File-Upload-master/css/jquery.fileupload.css"/>
	<link rel="stylesheet" href="/assets/plugins/jQuery-File-Upload-master/css/jquery.fileupload-ui.css"/>
	 -->
	<!-- <script type="text/javascript" src="/assets/fileinput/js/fileinput.js" defer></script> -->
	<link href="/assets/plugins/bootstrap-fileinput/css/fileinput.css" media="all" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" crossorigin="anonymous">
    <link href="/assets/plugins/bootstrap-fileinput/themes/explorer-fas/theme.css" media="all" rel="stylesheet" type="text/css"/>
    <!-- <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script> -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" crossorigin="anonymous"></script>
    <script src="/assets/plugins/bootstrap-fileinput/js/plugins/piexif.js" type="text/javascript"></script>
    <script src="/assets/plugins/bootstrap-fileinput/js/plugins/sortable.js" type="text/javascript"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

    <script src="/assets/plugins/bootstrap-fileinput/js/fileinput.js" type="text/javascript" defer></script>
    <script src="/assets/plugins/bootstrap-fileinput/js/locales/kr.js" type="text/javascript" defer></script>
    <!-- <script src="/assets/plugins/bootstrap-fileinput/js/locales/es.js" type="text/javascript"> defer</script> -->
    <script src="/assets/plugins/bootstrap-fileinput/themes/fas/theme.js" type="text/javascript" defer></script>
    <script src="/assets/plugins/bootstrap-fileinput/themes/explorer-fas/theme.js" type="text/javascript" defer></script>

	<script type="text/javascript" src="/assets/js/jquery.inputmask.min.js" defer></script><!-- input mask -->
	<!-- ================== END file-upload css, script ================== -->


	<!-- ================== BEGIN validate script ================== -->
	<script src="/assets/plugins/parsleyjs/dist/parsley.min.js" type="text/javascript" defer></script>
	<script src="/assets/plugins/highlight.js/highlight.min.js" type="text/javascript" defer></script>
	<!-- ================== END validate script ================== -->

	<!-- ================== BEGIN spinner script ================== -->
	<script src="/assets/plugins/bootstrap-input-spinner-master/src/bootstrap-input-spinner.js" type="text/javascript" defer></script>
	<!-- ================== END spinner script ================== -->


	<!-- ================== BEGIN BASE JS ================== -->
	<script src="/assets/js/app.min.js"></script>
	<script src="/assets/js/theme/default.min.js"></script>
	<!-- ================== END BASE JS ================== -->
	<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<!-- 	<script src="/assets/plugins/datatables.net/js/jquery.dataTables.min.js"></script>
	<script src="/assets/plugins/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
	<script src="/assets/plugins/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script src="/assets/plugins/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>
	<script src="/assets/plugins/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
	<script src="/assets/plugins/datatables.net-buttons-bs4/js/buttons.bootstrap4.min.js"></script>
	<script src="/assets/plugins/datatables.net-buttons/js/buttons.colVis.min.js"></script>
	<script src="/assets/plugins/datatables.net-buttons/js/buttons.flash.min.js"></script>
	<script src="/assets/plugins/datatables.net-buttons/js/buttons.html5.min.js"></script>
	<script src="/assets/plugins/datatables.net-buttons/js/buttons.print.min.js"></script> -->
	<script src="/assets/plugins/jszip/dist/jszip.min.js"></script>
	<script src="/assets/js/demo/table-manage-buttons.demo.js"></script>

	<script src="/assets/plugins/lightbox2/dist/js/lightbox.min.js"></script>
	<!-- ================== END PAGE LEVEL JS ================== -->


	<style>

		/* pq-grid title align */
		.pq-td-div {
			text-align : center !important;
			font-family: "Noto Sans KR" !important;
		}
		/*
		div.pq-grid *
		{
		    font-size: ;
		    font-family: "Noto Sans KR";
		    line-height: ;
		}
		*/
		.pq-grid-number-cell {
			text-align: center !important;
			position:relative !important;
			line-height: inherit  !important;
			display: table-cell !important;
  			vertical-align: middle !important;
		}
	/* 	.pq-grid-row {
			margin: auto !important;
			vertical-align: middle !important;
			display: inline-block !important;

		} */

		/* modal size  */
		.modal-xl {
		    width: 90%;
		   	max-width:1200px;
		}

		#grid_json {
		  	border: 0px;
		  	padding-top: 0px;
		  	padding-bottom: 0px;
		  	padding-left: 0px;
		  	padding-right: 0px;
		}

		.card-body {
			margin-bottom: 0px;
		}

		div.pq-grid *
		{
		    font-size: .75rem;
		    font-family: "Open Sans", sans-serif;
		    line-height: 1.5;
		}

		.pq-grid-col>.pq-td-div{
		  position: absolute;
		  left:4px;
		  bottom:4px;
		  width:calc(100% - 8px);
		}

		.card{
			overflow-x:hidden;
		}


		.ui-autocomplete { 
		  position:absolute; cursor:default;
		  z-index:9999999 !important;    
		}
	</style>
	
	