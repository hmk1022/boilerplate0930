<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
    <div class="card">
        <div class="card-header">
            <h3>
            	<c:if test="${!empty image_name && 'undefined' ne image_name}">
			    	${image_name }
		    	</c:if>
		    	<c:if test="${empty image_name || 'undefined' eq image_name}">
			    	이미지
		    	</c:if>
            </h3>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-12 mt-3">
                    <div class="form-group" >
                        <div class="border p-3 my-3 gallery" id="gallery"">
	                       	<c:forEach var="item" items="${imageList }">     
	                        <div class="image gallery-group-1" style="width: 600px height: 100%; ">
								<div class="image-inner" style="width:100%;">
									<a href="${item.img_url }" data-lightbox="gallery-group-4">
										<div class="img" style="background-image: url(${item.img_url }); height: 700px;  background-size: cover;" ></div>
									</a>
								</div>
							</div>
							</c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <button class="btn btn-primary btn-block" onclick="self.close();">닫기</button>
        </div>
    </div>
    <script>
	$(function(){
    	<c:if test="${empty imageList }">
	    	alert('등록된 이미지가 없습니다.');
            self.close();
    	</c:if>
	});
	</script>
 	<!-- ================== BEGIN PAGE LEVEL JS ================== -->
	<script src="/assets/plugins/isotope-layout/dist/isotope.pkgd.min.js"></script>
	<script src="/assets/plugins/lightbox2/dist/js/lightbox.min.js"></script>
	<script src="/assets/js/demo/gallery.demo.js"></script>
	<!-- ================== END PAGE LEVEL JS ================== -->