<%@ tag body-content="empty" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ attribute name="imageList" type="java.util.List" required="true" %>
<%@ attribute name="emptyMsg" type="java.lang.String" required="false" %>

<%-- <c:forEach var="item" items="${imageList}" varStatus="status"> --%>
<%-- <a class="media-left" href="javascript:;">
	<img src="${item.img_url }" style="background-image: url(${item.img_url })" style="width:120px">
</a> --%>
<%--                    <div class="form-group">
                       <div class="border p-3 my-3 gallery" id="gallery">
                       	<c:forEach var="item" items="${imageList }">     
                        <div class="image gallery-group-4">
							<div class="image-inner">
								<a href="${item.img_url }" data-lightbox="${item.img_name }">
									<div class="img" style="background-image: url(${item.img_url })"></div>
								</a>
							</div>
						</div>
						</c:forEach>
                       </div>
                   </div> --%>
<%-- </c:forEach> --%>

<div class="border p-3 my-3">
    <ul class="registered-users-list clearfix">
    	<c:forEach var="item" items="${imageList }">   
        <li>
			<a class="example-image-link" href="${item.img_url }" data-lightbox="example-set" data-title="${item.img_name } | ${item.img_date}"><img class="example-image" src="${item.img_url }" alt=""/></a>            
        </li>
        </c:forEach>
        <c:if test="${empty imageList }"><li>${emptyMsg }</li></c:if>
    </ul>
</div>