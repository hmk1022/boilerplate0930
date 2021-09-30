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
	<c:if test="${maxFileCount >  0 }">
		<c:set var="required" value="false"/>
	</c:if>
</c:if>

<input
	id="${name }"
	name="${name }"
	multiple type="file"
	accept="image/*"
	data-browse-on-zone-click="true"
	category="BUSS_DATA"
	${ required ? 'data-parsley-required="true"' : '' }
	data-parsley-error-message="파일을 선택해주세요."
	data-parsley-errors-container="#validation_file_upload_error"
>
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
	
})

function initFileUloadForm(){

	
	console.log("* upload image:", '${name }');
	
	/* image config list */
	let fileList = []; // image url list before
	let fileList2 = []; // image url list ing	
	let fileList3 = []; // image url list after
	
	let fileConfig = [];	// img config
	
	let fileInfo = [];
	let fileInfo2 = [];
	let fileInfo3 = [];
	
	let imgList = [];	// img list temp

	console.log("value??????", '${value}');
	//console.log("", JSON.stringify('${value}'));
	/* value 담당 하는곳... */
	let _temp_preview_array = {};
	<c:forEach var="item" items="${value}" varStatus="status">
	_temp_preview_array = {};
	_temp_preview_array['caption'] = '${item.img_name}';
	_temp_preview_array['type'] = 'image';
	_temp_preview_array['size'] = '${item.img_size}';
	_temp_preview_array['key'] = '${item.img_no}';
	_temp_preview_array['img_url'] = '${item.img_url}';
	_temp_preview_array['img_type'] = '${item.img_type}' 
	fileConfig.push(_temp_preview_array);
	</c:forEach>
	
	console.log("fileList :", fileList);
	console.log("fileConfig :", fileConfig);
	console.log("imgList :", imgList);

	/* file list */
	$.each(fileConfig, function(idx, item){
		// 이미지 타입별로 다른 fileList
		if(item.img_type == 'IMG_TYPE_REPORT_BEFORE'){
			fileList.push(item.img_url);
			fileInfo.push(item)
			console.log('이건 before : ',item)
		} else if (item.img_type == 'IMG_TYPE_REPORT_ING') {
			fileList2.push(item.img_url);
			fileInfo2.push(item)
			console.log('이건 ing : ',item)
		} else if (item.img_type == 'IMG_TYPE_REPORT_AFTER') {
			fileList3.push(item.img_url);
			fileInfo3.push(item)
			console.log('이건 after : ',item)
		}
		
		console.log('item',item)
	});
	
	let fileinput = {};
	
	fileinput = {
	    uploadUrl: "/file/upload",
	    autoOrientImage: true,
	    //previewFileIcon: '<i class="fas fa-file"></i>',
	    allowedFileExtensions : ['jpg', 'jpeg', 'png', 'gif'],
		//allowedFileTypes: ['image', 'video', 'flash'],
		overwriteInitial : true,
		//initialPreviewShowDelete : true,
		maxFileSize : 10000,
		//maxFilesNum : 10,
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
		initialPreviewConfig: fileInfo,	// file config list
	    deleteUrl : "/file/delete",			// file delete url
	    preferIconicPreview: false,	// file content or icon view
	}
	fileinput2 = {
		    uploadUrl: "/file/upload",
		    autoOrientImage: true,
		    //previewFileIcon: '<i class="fas fa-file"></i>',
		    allowedFileExtensions : ['jpg', 'jpeg', 'png', 'gif'],
			//allowedFileTypes: ['image', 'video', 'flash'],
			overwriteInitial : true,
			//initialPreviewShowDelete : true,
			maxFileSize : 10000,
			//maxFilesNum : 10,
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
			initialPreview: fileList2,	// 초기 이미지 목록
		    initialPreviewAsData: true, // defaults markup
			initialPreviewConfig: fileInfo2,	// file config list
		    deleteUrl : "/file/delete",			// file delete url
		    preferIconicPreview: false,	// file content or icon view
		}
	fileinput3 = {
		    uploadUrl: "/file/upload",
		    autoOrientImage: true,
		    //previewFileIcon: '<i class="fas fa-file"></i>',
		    allowedFileExtensions : ['jpg', 'jpeg', 'png', 'gif'],
			//allowedFileTypes: ['image', 'video', 'flash'],
			overwriteInitial : true,
			//initialPreviewShowDelete : true,
			maxFileSize : 10000,
			//maxFilesNum : 10,
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
			initialPreview: fileList3,	// 초기 이미지 목록
		    initialPreviewAsData: true, // defaults markup
			initialPreviewConfig: fileInfo3,	// file config list
		    deleteUrl : "/file/delete",			// file delete url
		    preferIconicPreview: false,	// file content or icon view
		}
		
	fileinputList = [fileinput,fileinput2,fileinput3];
	
	for (let i = 1; i < 4; i++){
		$("#upLoadFile"+i).fileinput(fileinputList[i-1]).on('fileuploaded', function(event, previewId, index, fileId) {
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
	}  
}
</script>