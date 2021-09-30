<%@ tag body-content="empty" pageEncoding="utf-8" %>
<%@ tag import="org.apache.commons.collections.map.CaseInsensitiveMap" %>
<%@ tag import="java.util.*" %>
<%@ tag trimDirectiveWhitespaces="false" %>
<%@ attribute name="codeList" required="true" type="java.util.List" %>
<%@ attribute name="selected" required="false" type="java.lang.String" %>
<%@ attribute name="defaultValue" required="false" type="java.lang.String" %>

<%
if(defaultValue!=null) {
%>
<option value="">${defaultValue }</option>
<%
}
if(codeList!=null) {
	for(int i=0; i < codeList.size() ; i++){

		Map<String, Object> code = new HashMap<String, Object>();
		code = (Map<String, Object>)codeList.get(i);

		if(selected != null && (((String)code.get("code_value")).equals(selected))) {
		%>
		<option value="<%= (String)code.get("code_value")%>" selected="selected"><%= (String)code.get("code_name")%></option>
		<% } else { %>
		<option value="<%= (String)code.get("code_value")%>"><%= (String)code.get("code_name")%></option>
		<% } 
	}
}
%>