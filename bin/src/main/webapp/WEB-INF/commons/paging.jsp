<%@ page language="java" contentType="text/html;charset=UTF-8"  errorPage="/common/error.jsp" %>
<%@ include file="/WEB-INF/views/comm/main.jsp" %>

<c:set var="pageGroup" value="10" />
<c:set var="functionName" value="${!empty param['functionName'] ? param['functionName'] : 'pageMove'}"  />

<ul class="pagination pagination-sm ">			
<fmt:parseNumber var= "nowPage" integerOnly="true" value= "${param['nowPage']}" />
<fmt:parseNumber var= "totalPage" integerOnly="true" value= "${param['totalPage']}" />

	<cms:Paging totalPage="${totalPage}" nowPage="${nowPage}" pageGroup="${pageGroup}">
	
		<!-- 이전 -->
		<cms:Previous>
			<c:choose>
				<c:when test="${nowPage > 1}">
					<li><a href="javascript:${functionName}(1);">처음</a></li>
					<li><a href="javascript:${functionName}(${nowPage-1});">이전</a></li>
				</c:when>
				<c:otherwise>
					<li class="disabled"><a href="#">처음</a></li>
					<li class="disabled"><a href="#">이전</a></li>
				</c:otherwise>
			</c:choose>
		</cms:Previous>
		
		<!-- 인덱스 -->
		<cms:PageIndex>
			${(pageNumber%pageGroup==1) ? "" : ""}
			<c:choose>
				<c:when test="${nowPage != pageNumber}">
					<li><a href="javascript:${functionName}(${pageNumber})"><c:out value="${pageNumber}" /></a></li>
				</c:when>
				<c:otherwise>
					<li class="active"><a href="#"><c:out value="${pageNumber}" /></a></li>
				</c:otherwise>
			</c:choose>
		</cms:PageIndex>
		
		<!-- 다음 -->
		
		<cms:Next>
			<c:choose>
				<c:when test="${totalPage > nowPage}">
					<li><a href="javascript:${functionName}(${nowPage+1});">다음</a></li>
					<li><a href="javascript:${functionName}(${totalPage});">끝</a></li>
				</c:when>
				<c:otherwise>
					<li class="disabled"><a href="#">다음</a></li>
					<li class="disabled"><a href="#">끝</a></li>
				</c:otherwise>
			</c:choose>
		</cms:Next>
		
	</cms:Paging>
</ul>