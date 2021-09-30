<%@tag import="org.springframework.util.StringUtils"%>
<%@ tag body-content="empty" pageEncoding="utf-8" %>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ attribute name="value" required="false" type="java.lang.String" %>
<% String maskNm = Long.toString(System.nanoTime()); %>
<span id="cd_id_<%=maskNm%>"></span><script>$(function(){$("#cd_id_<%=maskNm%>").text(maskCurrency('${value}'));})</script>