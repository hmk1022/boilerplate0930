<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- <%@ taglib prefix="dateUtil" uri="/WEB-INF/tlds/function_dateUtil.tld"  %>
<%@ taglib prefix="stringUtil" uri="/WEB-INF/tlds/function_stringUtil.tld" %> --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>

<jsp:useBean id="toDay" class="java.util.Date" />
<%-- <fmt:formatDate value='${toDay}' pattern='yyyyMMddHH' var="nowDate"/> --%>


<%-- 작업상태 --%>
<c:set var="WORK_STAT_REQ" 			value="00"/> <%-- 작업요청 --%>
<c:set var="WORK_STAT_RECP" 		value="10"/> <%-- 접수완료 --%>
<c:set var="WORK_STAT_REQ_CNCL" 	value="19"/> <%-- 작업요청취소 --%>
<c:set var="WORK_STAT_VST_ASSN" 	value="20"/> <%-- 답사배정 --%>
<c:set var="WORK_STAT_VST_STT" 		value="21"/> <%-- 답사시작 --%>
<c:set var="WORK_STAT_VST_END" 		value="25"/> <%-- 답사종료 --%>
<c:set var="WORK_STAT_WRK_ASSN" 	value="30"/> <%-- 작업배정 --%>
<c:set var="WORK_STAT_WRK_STT" 		value="31"/> <%-- 작업시작 --%>
<c:set var="WORK_STAT_WRK_END" 		value="35"/> <%-- 작업종료 --%>
<c:set var="WORK_STAT_WRK_RLGT" 	value="40"/> <%-- 이관 --%>
<c:set var="WORK_STAT_WRK_CNCL" 	value="99"/> <%-- 작업취소 --%>

<%-- 결제상태 --%>
<c:set var="PAY_STAT_REQ" value="01"/>
<c:set var="PAY_STAT_COMP" value="10"/>
<c:set var="PAY_STAT_FAIL" value="88"/>
<c:set var="PAY_STAT_CNCL" value="99"/>


<c:set var="MASK_MONEY" value="data-mask='000,000,000,000,000' data-mask-reverse='true'"/>

<%!
	final static String MENU_LOGIN = "/login";
	final static String MENU_LOGOUT = "/logout";
	final static String MENU_MAIN = "/main/index";
 
	// temp vaiable
	final static String[] TMP_HH = {"04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"};
	final static String[] TMP_MM = {"00","10","20","30","40","50"};
%>
<%
	request.setAttribute("TMP_HH", TMP_HH);
	request.setAttribute("TMP_MM", TMP_MM);
%>