<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
	<ul class="nav">
		<li class="nav-profile">
			<a href="javascript:;" data-toggle="nav-profile">
				<div class="cover with-shadow"></div>
				<div class="image image-icon bg-black text-grey-darker" style="align-items: center"  >
					<c:set var="profile_url" value="${profile.profile_url }" />
					<c:choose>
					    <c:when test="${profile_url eq ''}">
					        <i class="fa fa-user"></i>
					    </c:when>							  
					    <c:otherwise>
					        <img src= "${profile.profile_url }" style="width: 100%; height: 100%; object-fit: fit">
					    </c:otherwise>
					</c:choose>
					<!--  <i class="fa fa-user"></i>  -->
					<%-- <img src= "${profile.profile_url }" style="width: 100%; height: 100%; object-fit: fit"> --%>
				</div>
				<div class="info">					
					<!-- <b class="caret pull-right"></b> --><span id="content_admin_id">${profile.admin_name }</span>
					<small> ${profile.department } / ${profile.authority } </small>
				</div>
			</a>
		</li>
	</ul>
	<ul class="nav" id="sideMenu">
	<li class="nav-header"></li>
	<li class=" ">
		 <a href="/account/disbursement/form">
			<!-- <b class="caret"></b> -->
			<i class="fa fa-envelope"></i>
			<span>지출결의서 작성</span>
		</a>
	</li>
	<c:set var="isOpen" value="N" />
	<c:forEach var="data" items="${menuTree}" varStatus="cnt">
        <c:choose>
			<c:when test="${data.level eq 1 && data.sub_cnt eq 0}"><!-- 상위메뉴이면서, 하위메뉴가 없을때 -->
				<!-- 태그닫기 -->
				<c:if test="${isOpen eq 'Y' }">
						</ul>
					</li>
					<c:set var="isOpen" value="N" />
				</c:if>
				<li class="">
					<a href="${data.url}">
						<i class="a fa-th-large">${data.icon}</i>
						<span>${data.name}</span>
					</a>
				</li>
			</c:when>
			<c:when test="${data.level eq 1 && data.sub_cnt ne 0}"><!-- 상위메뉴이면서, 하위메뉴가 존재할때 -->
				<!-- 태그닫기 -->
				<c:if test="${isOpen eq 'Y' }">
						</ul>
					</li>
					<c:set var="isOpen" value="N" />
				</c:if>

				<!-- 프리픽스 -->
				<c:if test="${!empty data.prefix}">
					<li class="header has-sub expand">${data.prefix}</li>
				</c:if>
				<li class="has-sub ">
					<a>
						<b class="caret"></b>
						<i class="fa fa-align-left">${data.icon}</i>
						<span>${data.name}</span>
					</a>
	             	<ul class="sub-menu" style="display:block;">

				<!-- 태그오픈 -->
				<c:set var="isOpen" value="Y" />
			</c:when>
			<c:otherwise><!-- 하위메뉴 -->
				<li class="has-sub">
					<a href="${data.url}">
						<b class="caret"></b>
						${data.name}
					</a>
				</li>
			</c:otherwise>
       	</c:choose>
	</c:forEach>
</ul>
<script>
$('#sideMenu a').on("click", function(e){
	e.preventDefault();
	let _url = $(this).attr("href");
	console.log('_url',_url);
	console.log(Utils.isEmpty(_url));
	if(Utils.isEmpty(_url) || _url == undefined) return ;

	// go back to list
	if(_url == '/material/list' || _url == '/code/customer/list') { 
		goListPage(_url, {});
	} else {
		getPage(_url, {});
	}
	
  	console.log('url',_url);
	pushState(_url, {},"getPage");

});

</script>