<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

	<!-- begin page-header -->
	<h1 class="page-header">고객사/지점 <small>코드관리</small></h1>
	<!-- end page-header -->
	<!-- begin panel -->
	<div class="panel panel-inverse">
		<div class="panel-heading">
			<h4 class="panel-title">고객사/지점 목록</h4>
			<div class="panel-heading-btn">
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-success" data-click="panel-reload"><i class="fa fa-redo"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
			</div>
		</div>
		<div class="panel-body" style="">
			<form class="form-horizontal form-bordered" data-parsley-validate="true" name="frm" id="frm" novalidate="" enctype="multipart/form-data">
			
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="branch_name">지점명 * </label>
				<div class="col-md-8 col-sm-8">
					<input class="form-control " type="text" id="branch_name" name="branch_name" placeholder="지점명" data-parsley-required="true" data-parsley-id="1" aria-describedby="parsley-id-1">
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="branch_name">코드선택 * </label>
				<div class="col-md-4 col-sm-8">
					<select class="form-control parsley-success" id="select-required" name="customer_no" data-parsley-required="true" data-parsley-id="21">
						<tags:code-select
							codeList="${work_cate }" 
							selected="03"
						/>
					</select>
					
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="comp_number">코드선택 *</label>
				<div class="col-md-8 col-sm-8">
					<tags:code-radio
						name="work_cate" 
						codeList="${work_cate }" 
						checked="03"
						initValue="01"
					/>
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="comp_number">사업자번호 *</label>
				<div class="col-md-8 col-sm-8">
					<input class="form-control " type="text" id="comp_number" name="comp_number" data-parsley-type="" placeholder="사업자번호" data-parsley-required="true" data-parsley-id="2" aria-describedby="parsley-id-2" busno>
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="email">담당자 *</label>
				<div class="col-md-8 col-sm-8">
					<input class="form-control " type="text" id="email" name="manager_name" data-parsley-type="manager_name" placeholder="담당자" data-parsley-required="true" data-parsley-id="3" aria-describedby="parsley-id-3">
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="manager_email">이메일 *</label>
				<div class="col-md-8 col-sm-8">
					<input class="form-control " type="text" id="manager_email" name="manager_email" data-parsley-type="email" placeholder="Email" data-parsley-required="true" data-parsley-id="4" aria-describedby="parsley-id-4">
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="manager_hp1">연락처1 *</label>
				<div class="col-md-8 col-sm-8">
					<input class="form-control" type="url" id="manager_hp1" name="manager_hp1" data-parsley-type="url" placeholder="연락처" data-parsley-id="5" phone>
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="manager_hp2">연락처2 *</label>
				<div class="col-md-8 col-sm-8">
					<input class="form-control" type="url" id="manager_hp2" name="manager_hp2" data-parsley-type="url" placeholder="연락처" data-parsley-id="6" phone>
				</div>
			</div>
			
			<div class="form-group row date">
				<label class="col-md-2 col-sm-4 col-form-label" for="select_date">날짜선택</label>
				<div class="col-md-4 col-sm-8 input-group">
					<input type="text" class="form-control" name="select_date" id="select_date" placeholder="select date" datepicker/>
				</div>
			</div>

			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="select_date">날짜선택</label>
				<div class="col-md-4 col-sm-8 input-group date" id="datepicker-disabled-past" data-date-format="yyyy-mm-dd" data-date-start-date="Date.default">
					<input type="text" class="form-control" placeholder="Select Date">
					<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
				</div>
			</div>
						
			<div class="form-group row ">
				<label class="col-md-2 col-sm-4 col-form-label" for="manager_hp2">파일업로드</label>
				<div class="col-md-8 col-sm-8">
			        <!-- AUTO IMAGE ORIENTATION -->


					<tags:image-upload name="upLoadFile"
                                       value="${imageList}"
                                       maxFileCount = "1"
                                       required = "true"
                                       category = "SAMPLE"
                                       type="image"
                    />
					<!-- 
					<div class="checkbox">
					    <label>
					    <input id="toggleOrient" name="tog" type="checkbox" checked>
					    Toggle Auto Orientation
					    </label>
					</div>
					 -->
					<div id="togStatus" class="hint-block"></div>
					
					
	

	
					<script defer>
						
						/* image url list */ 
						var fileList = [];
						
						/* fileList[0] = 'https://kartik-v.github.io/bootstrap-fileinput-samples/samples/SampleTextFile_10kb.txt';
						fileList[1] = 'https://kartik-v.github.io/bootstrap-fileinput-samples/samples/pdf-sample.pdf';
						fileList[2] = 'https://kartik-v.github.io/bootstrap-fileinput-samples/samples/small.mp4';
						 */
						//fileList[0] = "https://s3.ap-northeast-2.amazonaws.com//workerman-upload-real/work_img/20210608153117604_2_a96.jpg";
						//fileList[1] = "https://s3.ap-northeast-2.amazonaws.com//workerman-upload-real/work_img/20210608152820045_2_qkv.jpg";
							
						/* image config list */
						var fileConfig = [];
						
						$("#input-file-1").fileinput({
						    uploadUrl: "/sample/sample3/upload3/ajax",
						    autoOrientImage: true,
						    previewFileIcon: '<i class="fas fa-file"></i>',
 						    //allowedPreviewTypes: null, // set to empty, null or false to disable preview for all types
						    /* previewFileIconSettings: {
						        'docx': '<i class="fas fa-file-word text-primary"></i>',
						        'xlsx': '<i class="fas fa-file-excel text-success"></i>',
						        'pptx': '<i class="fas fa-file-powerpoint text-danger"></i>',
						        'jpg': '<i class="fas fa-file-image text-warning"></i>',
						        'pdf': '<i class="fas fa-file-pdf text-danger"></i>',
						        'zip': '<i class="fas fa-file-archive text-muted"></i>',
						    },  */
						  	//defaultPreviewContent: '<img src="/samples/default-avatar-male.png" alt="Your Avatar">',
						    allowedFileExtensions : [ 'jpg', 'jpeg', 'png', 'gif', 'war' ],
							//allowedFileTypes: ['image', 'video', 'flash'],
							overwriteInitial : false,
							maxFileSize : 10000,
							//maxFilesNum : 1,
							maxFileCount:1,
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
					        /* initialPreviewConfig: [
					            {caption: "Lorem Ipsum.txt", type: "image", size: 1430, key: 12}, 
					            {caption: "PDF Sample.pdf", type: "image", size: 8000, key: 14}, 
					            //{caption: "Krajee Sample.mp4", type: "video", size: 375000, filetype: "video/mp4", key: 15} 
					        ], */
					        deleteUrl : "/file/delete",
					        preferIconicPreview: false,	// 파일 내용 보여주던지, icon으로 대체 하던지.
					        //maxImageWidth: 200,
					        //maxImageHeight: 150,
					        //resizeImage: true,
					        //resizeIfSizeMoreThan: 1000,
					        //resizePreference: 'height',
						}).on('fileuploaded', function(event, data) {
					        //console.log('File Uploaded', 'ID: ' + fileId + ', Thumb ID: ' + previewId);
							 $('#kv-success-box').append(data.response.link);
							    $('#kv-success-modal').modal('show');
					    }).on('fileuploaderror', function(event, previewId, index, fileId) {
					        console.log('File Upload Error', 'ID: ' + fileId + ', Thumb ID: ' + previewId);
					    }).on('filebatchuploadcomplete', function(event, preview, config, tags, extraData) {
					        console.log('File Batch Uploaded', preview, config, tags, extraData);
					    }).on( 'filesorted', function (e, params) {
					        console.log ( '파일 정렬 변수', params);
					    }).on('filepreupload', function() {
					        //$('#kv-success-box').html('');
					    	console.log ( 'filepreupload');
					    }).on('filebeforedelete', function() {
					        var aborted = !window.confirm('Are you sure you want to delete this file?');
					        if (aborted) {
					            window.alert('File deletion was aborted! ' + krajeeGetCount('file-5'));
					        };
					        return aborted;
					    }).on('filedeleted', function() {
					        setTimeout(function() {
					            window.alert('File deletion was successful! ' + krajeeGetCount('file-5'));
					        }, 900);
					    });

						 var krajeeGetCount = function(id) {
						        var cnt = $('#' + id).fileinput('getFilesCount');
						        return cnt === 0 ? 'You have no files remaining.' :
						            'You have ' +  cnt + ' file' + (cnt > 1 ? 's' : '') + ' remaining.';
						    };
						    
						/*
						$("#toggleOrient").on('change', function() {
						    var val = $(this).prop('checked');
						    $("#input-file-1").fileinput('refresh', {
						        uploadUrl: "/file-upload-batch/2",
						        autoOrientImage: val
						    });
						    $('#togStatus').html('Fileinput is reset and <samp>autoOrientImage</samp> is set to <em>' + (val ? 'true' : 'false') + '</em>. Retry by selecting images again.');
						});*/
					</script>
				</div>
			</div>
			
			<div class="form-group row m-b-0">
				<label class="col-md-2 col-sm-4 col-form-label">&nbsp;</label>
				<div class="col-md-8 col-sm-8">
					<a href="#" class="btn btn-primary" id="_dev-save">저장</a>
				</div>
			</div>
			</form>
			
		</div>
	</div>
	<!-- end panel -->
	

    
    
	<!-- page script -->
	<script>
	var curPage;
	
	/* init page */
	$(function(){
		
		App.setPageTitle('Sample | input');
		App.restartGlobalFunction();
		
		console.log('page script !!!! ');
		console.log('테스트!!!');
		
		setInputMask();	// set masking
		
		/* save data */
		$("#_dev-save").on("click", function(e){
			
			e.preventDefault();
			//$("#frm").validate(); // validate
			
			const _name = "고객사-지점 저장";	// ajax name
			
			const _url = "/sample/file/upload/ajax";	// ajax url - only one file upload.!!!
			//const _url = "/sample/sample3/upload/ajax";	// ajax url - only one file upload.!!!
			//const _url = "/sample/sample5/upload/ajax";	// ajax url - multi file upload
			
			//let _param = $("#frm").serializeObject();	// ajax param
			
			/* var form = $('#frm')[0];
			var formData = new FormData(form);

	        $.ajax({
	            cache : false,
	            url : "/sample/sample3/upload/ajax", // 요기에
	            type : 'POST', 
	            data : formData, 
	            enctype: 'multipart/form-data',
	            contentType: false,
	            success : function(data) {
	                var jsonObj = JSON.parse(data);
	            }, // success 
	    
	            error : function(xhr, status) {
	                alert(xhr + " : " + status);
	            }
	        }); */ //  
	        
	        
	        var frm = $('#frm')[0];
	        var data = new FormData(frm);
	        
	        $.ajax({
	            type: "POST",
	            enctype: 'multipart/form-data',
	            url: _url,
	            data: data,
	            processData: false,
	            contentType: false,
	            cache: false,
	            timeout: 600000,
	            beforeSend : function(xhr){
	                xhr.setRequestHeader("req_type", "ajax");
	            },
	            success: function (data) {
	            	alert('success')
	            },
	            error: function (e) {
	                alert('fail');
	            }
	        });
	        
		 /* 

		    return $.ajax({
		        type: "POST",
		        enctype: 'multipart/form-data',
		        url: _url,
		        data: fd,
		        processData: false,
		        contentType: false,
		        cache: false,
		        timeout: 600000,
		        beforeSend : function(xhr){
		            xhr.setRequestHeader("req_type", "ajax");
		        },
		        success: function (data) {
		        },
		        error: function (msg) {
		        }
		    }); */
		    
			// desc, url, param, callback, asyncYn
			/* Utils.requestAjax(_name, _url, _param, {
				beforeSend: function(){},
	            success:  function(data) {
		          	alert(Message.SAVE);
	            },
	            complete:  function(response) {}
			}); */
		});
		
		
		
		
	});

	</script>
	
	
<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<script>
	App.setPageTitle('Color Admin | Form Validation');
	App.restartGlobalFunction();

	$.when(
		$.getScript('/assets/plugins/parsleyjs/dist/parsley.min.js'),
		$.getScript('/assets/plugins/highlight.js/highlight.min.js'),
		$.Deferred(function( deferred ){
			$(deferred.resolve);
		})
	).done(function() {
		$.getScript('/assets/js/demo/render.highlight.js'),
		$.Deferred(function( deferred ){
			$(deferred.resolve);
		})
	});
</script>
<!-- ================== END PAGE LEVEL JS ================== -->