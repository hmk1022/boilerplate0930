<%@ tag body-content="empty" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ attribute name="name" required="true" %>
<%@ attribute name="value" type="java.util.List" required="false" %>
<%@ attribute name="maxFileCount" required="false" %>
<%@ attribute name="required" type="java.lang.Boolean" required="false" %>
<%@ attribute name="type" required="false" %>
<%@ attribute name="category" required="true" %>


<c:if test="${!empty value }">
	<c:set var="listCnt" value="${fn:length(value)}"/>
	<c:set var="maxFileCount" value="${maxFileCount + listCnt }"/>
	<%-- <c:if test="${maxFileCount >  0 }">
		<c:set var="required" value="false"/>
	</c:if> --%>
</c:if>

<div class="form-group">
<div class="file-loading">
<input
	id="${name }"
	name="${name }"
	multiple type="file"
	accept="image/*"
	data-browse-on-zone-click="true"
	category="BUSS_DATA"
	<%-- ${ required ? 'data-parsley-required="true"' : '' } --%>
	data-parsley-error-message="파일을 선택해주세요."
	data-parsley-errors-container="#validation_file_upload_error"
	data-theme="fas"
>
</div>
</div>
<input type="hidden" name="category_${name }" value="${category }"/>
<span id="validation_file_upload_error"></span>

<c:if test="${empty maxFileCount }">
<c:set var="maxFileCount" value="1"/>
</c:if>

<!-- file upload css, script END -->
<script defer>
$(function(){
	/* console.log("# maxFileCount:", "${maxFileCount}"); */
	/* console.log("# required:", "${required}"); */

	//$('#${name }').fileinput('reset');
	//$('#${name }').fileinput('clear');
	//$('#${name }').fileinput('refresh');
	//$('#${name }').fileinput('clearFileStack');
	
	initFileUloadForm();
	
	<c:if test="${ required}">
	// 필수처리
	$(".file-caption-name.form-control.kv-fileinput-caption").attr('data-parsley-required', 'true');
	$(".file-caption-name.form-control.kv-fileinput-caption").attr("data-parsley-error-message", "파일을 선택해주세요.");
	$(".file-caption-name.form-control.kv-fileinput-caption").attr("data-parsley-errors-container", "#validation_file_upload_error");
	</c:if>
	
	$('#${name }').on('fileselect', function(event, numFiles, label) {
	    console.log('File fileselect');
	    //$(".file-caption-name.form-control.kv-fileinput-caption").parsley().reset();
	    
	    $(".file-caption-name.form-control.kv-fileinput-caption").removeClass("parsley-error");
	    $("#validation_file_upload_error").hide();
	    
	});
	
	$("#${name}").on('fileuploaded', function(event, previewId, index, fileId) {
	    console.log('File Uploaded', 'ID: ' + fileId + ', Thumb ID: ' + previewId);
	}).on('fileuploaderror', function(event, previewId, index, fileId) {
	    console.log('File Upload Error', 'ID: ' + fileId + ', Thumb ID: ' + previewId);
	}).on('filebatchuploadcomplete', function(event, preview, config, tags, extraData) {
		console.log('File Batch Uploaded', preview, config, tags, extraData);
	}).on( 'filesorted', function (e, params) {
	    console.log ( 'filesorted', params);
	}).on('filebeforedelete', function() {
		let aborted = !window.confirm('해당 파일을 삭제 하시겠습니까?');
        if (aborted) {
            //window.alert('File deletion was aborted! ' + krajeeGetCount('${name }'));
        };
        return aborted;
    }).on('filedeleted', function() {
        setTimeout(function() {
            //window.alert('File deletion was successful! ' + krajeeGetCount('${name }'));
        	window.alert('삭제 됐습니다! ');
        }, 500);
    }).on('filepreupload', function() {
        //$('#kv-success-box').html('');
    	console.log ( 'filepreupload');
    }).on('dropFiles', function(e, files) {
        //$('#kv-success-box').html('');
    	console.log ( 'dragover');
    });
	
})

function initFileUloadForm(){
	
	console.log("* upload image:", '${name }');
	
	/* image config list */
	let fileList = []; // image url list
	let fileConfig = [];	// img config
	let imgList = [];	// img list temp

	//console.log("", '${value}');
	//console.log("", JSON.stringify('${value}'));

	let _temp_preview_array = {};
	<c:forEach var="item" items="${value}" varStatus="status">
	_temp_preview_array = {};
	_temp_preview_array['caption'] = '${item.img_name}';
	_temp_preview_array['type'] = 'image';
	_temp_preview_array['size'] = '${item.img_size}';
	_temp_preview_array['key'] = '${item.img_no}';
	_temp_preview_array['img_url'] = '${item.img_url}';
	fileConfig.push(_temp_preview_array);
	</c:forEach>
	
	
	//console.log("fileList :", fileList);
	//console.log("fileConfig :", fileConfig);
	//console.log("imgList :", imgList);

	/* file list */
	$.each(fileConfig, function(idx, item){
		fileList.push(item.img_url);
	});
	
	let fileinput = {};
	fileinput = {
	    uploadUrl: "",	// not empty ajax mode
	    autoOrientImage: true,
	    //previewFileIcon: '<i class="fas fa-file"></i>',
	    allowedFileExtensions : ['jpg', 'jpeg', 'png', 'gif', 'pdf'],
		//allowedFileTypes: ['image', 'video', 'flash'],
		overwriteInitial : false,
		//initialPreviewShowDelete : true,
		maxFileSize : 20000,
		//maxFilesNum : 10,
		uploadAsync: false,
		maxFileCount : ${maxFileCount},
		enctype: 'multipart/form-data',
		fileActionSettings: {
			showUpload: false, // Removing upload button from action settings
		},
		showUpload: false,
	    showClose: false,
	    showCaption: true,
		slugCallback : function(filename) {
			return filename.replace('(', '_').replace(']', '_');
		},
		theme: 'fas',	// theme
		initialPreview: fileList,	// 초기 이미지 목록
	    initialPreviewAsData: true, // defaults markup
		initialPreviewConfig: fileConfig,	// file config list
	    deleteUrl : "/file/delete",			// file delete url
	    preferIconicPreview: false,	// file content or icon view
	}
	
	$("#${name}").fileinput(fileinput);
/* 
	$("#${name}").fileinput(fileinput).on('fileuploaded', function(event, previewId, index, fileId) {
	    console.log('File Uploaded', 'ID: ' + fileId + ', Thumb ID: ' + previewId);
	}).on('fileuploaderror', function(event, previewId, index, fileId) {
	    console.log('File Upload Error', 'ID: ' + fileId + ', Thumb ID: ' + previewId);
	}).on('filebatchuploadcomplete', function(event, preview, config, tags, extraData) {
		console.log('File Batch Uploaded', preview, config, tags, extraData);
	}).on( 'filesorted', function (e, params) {
	    console.log ( 'filesorted', params);
	}).on('filebeforedelete', function() {
		let aborted = !window.confirm('해당 파일을 삭제 하시겠습니까?');
        if (aborted) {
            //window.alert('File deletion was aborted! ' + krajeeGetCount('${name }'));
        };
        return aborted;
    }).on('filedeleted', function() {
        setTimeout(function() {
            //window.alert('File deletion was successful! ' + krajeeGetCount('${name }'));
        	window.alert('삭제 됐습니다! ');
        }, 500);
    }).on('filepreupload', function() {
        //$('#kv-success-box').html('');
    	console.log ( 'filepreupload');
    });
*/
	
	var krajeeGetCount = function(id) {
		let cnt = $('#' + id).fileinput('getFilesCount');
		return cnt === 0 ? 'You have no files remaining.' : 'You have ' +  cnt + ' file' + (cnt > 1 ? 's' : '') + ' remaining.';
	};
	
}
</script>