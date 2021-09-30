<%@tag import="org.springframework.util.StringUtils"%>
<%@ tag body-content="empty" pageEncoding="utf-8" %>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ attribute name="value" required="false" type="java.lang.String" %>
<%@ attribute name="hasDayOfWeek" required="false" type="java.lang.Boolean" %>
<% String maskNm = Long.toString(System.nanoTime()); %>
<span id="date_id_<%=maskNm%>"></span>
<script>
var dateStr = Utils.getDate('${value}');
<%if(hasDayOfWeek!=null && hasDayOfWeek){%>
dateStr += '('+ Utils.getDayOfWeek(Utils.getDate('${value}')) +')';
<%}%>
$("#date_id_<%=maskNm%>").text(dateStr);
</script>