<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test Error Page!</title>
</head>
<body>
	<div class="errorPage">
		<span class="errorHead">Error!</span><br />
		<p>
			request_uri :
			<c:out value="${requestScope['javax.servlet.error.request_uri']}" />
		</p>
		<p>
			status_code :
			<c:out value="${requestScope['javax.servlet.error.status_code']}" />
		</p>
		<p>
			servlet_name :
			<c:out value="${requestScope['javax.servlet.error.servlet_name']}" />
		</p>
		<p>
			exception :
			<c:out value="${requestScope['javax.servlet.error.exception']}" />
		</p>
		<p>
			servlet_name :
			<c:out value="${requestScope['javax.servlet.error.servlet_name']}" />
		</p>
		<p>
			message :
			<c:out value="${requestScope['javax.servlet.error.message']}" />
		</p>
	</div>
</body>
</html>

