<%@tag import="org.springframework.util.StringUtils"%>
<%@ tag body-content="empty" pageEncoding="utf-8" %>
<%@ tag import="org.apache.commons.collections.map.CaseInsensitiveMap" %>
<%@ tag import="java.util.*" %>
<%@ tag trimDirectiveWhitespaces="true" %>

<%@ attribute name="codeList" required="true" type="java.util.List" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>
<%@ attribute name="checked" required="false" type="java.lang.String" %>
<%@ attribute name="initValue" required="false" type="java.lang.String" %>
<%@ attribute name="inline" required="false" type="java.lang.Boolean" %>
<%@ attribute name="required" type="java.lang.Boolean" required="false" %>
<%@ attribute name="displayCode" type="java.lang.String" required="false" %>

<% String maskNm = Long.toString(System.nanoTime()); %>

<div style="margin-top: 3px;">
<%
if(codeList == null) {
%>
<font class="text-danger">Empty Code List!!!</font>
<%
} else {
	for(int i=0; i < codeList.size() ; i++) {
		Map<String, Object> code = new HashMap<String, Object>();
		code = (Map<String, Object>)codeList.get(i);
		if( displayCode == null || String.valueOf(code.get("code_value")).matches(displayCode) ){
			if(initValue != null && (StringUtils.isEmpty(checked))) checked = initValue;

			if(checked != null && (code.get("code_value").equals(checked))) {
			%>
			<div class="form-check form-check-inline ${inline ? 'radio-inline':''}" ${required ? 'data-parsley-required="true"':'' }>
	            <input class="form-check-input" type="radio" id="<%= name%>_<%=code.get("code_value")%>" name="<%= name%>" value="<%=code.get("code_value")%>" checked="checked" />
	            <label class="form-check-label" for="<%= name%>_<%=code.get("code_value")%>"><%=code.get("code_name")%></label>
	        </div>
			<% } else { %>
			<div class="form-check form-check-inline ${inline ? 'radio-inline':''}" ${required ? 'data-parsley-required="true"':'' }>
	            <input class="form-check-input" type="radio" id="<%= name%>_<%=code.get("code_value")%>" name="<%= name%>" value="<%=code.get("code_value")%>" />
	            <label class="form-check-label" for="<%= name%>_<%=code.get("code_value")%>"><%=code.get("code_name")%></label>
	        </div>
<% 			}
		}
	}
}
%>
</div>