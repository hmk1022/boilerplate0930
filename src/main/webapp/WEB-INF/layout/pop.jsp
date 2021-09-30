<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

<c:set scope="session" var="active"><tiles:getAsString name="active"/></c:set>

<% String uri = (String)request.getAttribute("javax.servlet.forward.request_uri");	%>

<!doctype html>
<html lang="ko">
<head>
	<tiles:insertAttribute name="header" />
	<link href="/assets/plugins/lightbox2/dist/css/lightbox.css" rel="stylesheet" />
</head>
<body>
<!-- wrap -->
<div id="wrap">
	<!-- loading 팝업  -->
	<div class="pop-wrap active" id="loadingPop" style="display: none; z-index:1000">
		<div class="pop-in middle">
			<div class="pop-cont">
				<div class="pop-body pd-0 bg-transparent">
					<div class="loading-area ta-center">
						<div class="lds-default"></div>
						<p class="state-msg">잠시만 기다려주세요.</p>
					</div>
				</div>
			</div>
		</div>
		<div class="dim"></div>
	</div>
	<!-- contents -->
	<tiles:insertAttribute name="body" />
	<!-- contents -->
</div>
<!--// wrap -->
</body>
<tiles:insertAttribute name="footer" />
<script>
$(function(){
	$(".page-header").remove();
})
</script>
</html>
