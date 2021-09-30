<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<c:set scope="session" var="active"><tiles:getAsString name="active"/></c:set>

<!DOCTYPE html>
<html lang="en">
<head>
	<tiles:insertAttribute name="header" />
</head>
<body>
	<div id="app" class="app app-header-fixed app-sidebar-fixed">
	    <div class="app-header">
	        <div class="navbar-header">
	            <a href="#" class="navbar-brand"><b>워커맨 Admin</b> </a>
	            <button type="button" class="navbar-mobile-toggler" data-toggle="app-sidebar-mobile">
	                <span class="icon-bar"></span>
	                <span class="icon-bar"></span>
	                <span class="icon-bar"></span>
	            </button>
	        </div>
	        <div class="navbar-nav">
	            <div class="navbar-item navbar-user dropdown">
	                <a href="#" class="navbar-link dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown" onclick="logout();">
	                    <span>
	                        Log Out
	                        <b class=""></b>
	                    </span>
	                </a>
	                <!--
	                <div class="dropdown-menu dropdown-menu-end me-1">
	                    <a href="javascript:;" class="dropdown-item">Edit Profile</a>
	                    <a href="javascript:;" class="dropdown-item"><span class="badge bg-danger float-end rounded-pill">2</span> Inbox</a>
	                    <a href="javascript:;" class="dropdown-item">Calendar</a>
	                    <a href="javascript:;" class="dropdown-item">Setting</a>
	                    <div class="dropdown-divider"></div>
	                    <a href="javascript:;" class="dropdown-item">Log Out</a>
	                </div>
	                 -->
	            </div>
	        </div>
	    </div>

	<!-- begin #sidebar -->
		<div id="sidebar" class="sidebar ">
			<!-- begin sidebar scrollbar -->
			<div data-scrollbar="true" data-height="100%">
				<!-- begin sidebar user -->
				<ul class="nav">
					<!-- <li class="nav-profile">
						<a href="javascript:;" data-toggle="nav-profile">
							<div class="cover with-shadow"></div>
							<div class="image image-icon bg-black text-grey-darker">
								<i class="fa fa-user"></i>
							</div>
							<div class="info">
								<b class="caret pull-right"></b><span id="content_admin_id">워커맨</span>
								<small>워커맨 사업부 </small>
							</div>
						</a>
					</li> -->

<!-- 					<li>
						<ul class="nav nav-profile">
							<li><a href="javascript:;"><i class="fa fa-cog"></i> Settings</a></li>
							<li><a href="javascript:;"><i class="fa fa-pencil-alt"></i> Send Feedback</a></li>
							<li><a href="javascript:;"><i class="fa fa-question-circle"></i> Helps</a></li>
						</ul>
					</li>
 -->
				</ul>
				<!-- end sidebar user -->
				<!-- begin sidebar nav -->
				<div id="left_menu">
					<!--
					<li class="has-sub">
						<a href="javascript:;">
							<b class="caret"></b>
							<i class="fa fa-align-left"></i>
							<span>Admin 운영</span>
						</a>
						<ul class="sub-menu">
							<li class="has-sub">
								<a href="#" data-url="/operation/admin/index">
									<b class="caret"></b>
									Admin 계정 관리
								</a>
							</li>
							<li class="has-sub">
								<a href="#" data-url="/operation/workerman/index">
									<b class="caret"></b>
									워커맨 계정 관리
								</a>
							</li>
							<li class="has-sub">
								<a href="#" data-url="/operation/role/index">
									<b class="caret"></b>
									권한관리
								</a>
							</li>
						</ul>
					</li>
				 -->
				</div>
				<!-- end sidebar nav -->
			</div>
			<!-- end sidebar scrollbar -->
		</div>
		<div class="sidebar-bg"></div>
		<!-- end #sidebar -->


	    <div class="app-sidebar-bg"></div>
	    <div class="app-sidebar-mobile-backdrop"><a href="#" data-dismiss="app-sidebar-mobile" class="stretched-link"></a></div>

		<!-- Begin area content -->
	    <div class="app-content" id="content">
			<!-- begin breadcrumb -->
	       	<ol class="breadcrumb float-xl-end">
	        	<li class="breadcrumb-item"><a href="javascript:;">Home</a></li>
	            <li class="breadcrumb-item active">Dashboard</li>
			</ol>
			<tiles:insertAttribute name="body" />
	    </div>
		<div id="subpage" class="content" style="display:none;">
		</div>
		<!-- page div -->
		<div id="_listPage" class="app-content" style="display:none;"></div>
		<div id="_viewPage" class="app-content" style="display:none;"></div>
		<div id="_editPage" class="app-content" style="display:none;"></div>
		
		<!-- End area content -->

	    <a href="javascript:;" class="btn btn-icon btn-circle btn-success btn-scroll-to-top" data-toggle="scroll-to-top"><i class="fa fa-angle-up"></i></a>

	</div>
	<!-- modal-lg-dialog start -->
	<div class="modal fade" id="modal-dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="display:block;">
					<div>
					<h4 class="modal-title"></h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					</div>
					<div class="modal_description"></div>
				</div>
				<div class="modal-body">
				</div>
			</div>
		</div>
	</div>
	<!-- modal-dialog end -->
	
	<!-- BEGIN #loader -->
	<div id="content-loader-id" class="app-loader" style="opacity: 0.5; display:none" >
	  <span class="spinner"></span>
	</div>
<!-- END #loader -->
</body>
<tiles:insertAttribute name="footer" />
</html>