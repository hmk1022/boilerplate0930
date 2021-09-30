<%@ tag body-content="empty" pageEncoding="utf-8" %>
<%@ tag import="java.util.*" %>
<%@ tag trimDirectiveWhitespaces="true" %>

<%@ attribute name="checkBox" required="true" type="java.lang.String" %>
<%@ attribute name="checkName" required="true" type="java.lang.String" %>
<%@ attribute name="checkValue" required="false" type="java.lang.String" %>

<%

	String [] checkBoxA = null;
	checkBoxA = checkBox.split(":");

	String [] checkNameA = null;
	checkNameA = checkName.split(":");

	String [] checkValueA = null;
	checkValueA = checkValue.split(":");

	for(int i=0; i < checkBoxA.length ; i++){

		if(checkValueA != null && checkBoxA.length == checkValueA.length && checkValueA[i].equals("Y")){
%>
		<div class="checkbox checkbox-css checkbox-inline">
			<input type="checkbox" id="<%=checkBoxA[i]%>"  name="<%=checkBoxA[i]%>" checked="checked" value="Y">
			<label for="<%=checkBoxA[i]%>"><%=checkNameA[i]%></label>
		</div>
<%
		} else {
%>
		<div class="checkbox checkbox-css checkbox-inline">
			<input type="checkbox" id="<%=checkBoxA[i]%>"  name="<%=checkBoxA[i]%>" value="Y">
			<label for="<%=checkBoxA[i]%>"><%=checkNameA[i]%></label>
		</div>
<%
		}
	}

%>
