<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- <body class="p-3"> -->
    <div class="card">
        <!-- <div class="card-header">
            <h3>자재요청서<span class="text-muted small d-block">각 일정별로 필요한 자재들을 요청할 수 있습니다</span></h3>
        </div> -->
        <div class="card-body">
            <h5>기본 정보 입력</h5>
			<div class="row">
			    <div class="col-12 mb-3">
			        <div class="card">
			        	<div class="card-header">
							<h3 class="mb-0">자재요청서</h3>
						</div>
			            <div class="card-body ">
			                <div class="row">
			                	<input type="hidden" id="material_doc_no" name="material_doc_no" value="${data.material_doc_no }" >
			                	<div class="col-md-4 col-12">
									<label class="form-label text-muted">자재요청ID</label>
									<h5>${data.material_doc_id }</h5>
								</div>
			                	<div class="col-md-4 col-12">
									<label class="form-label text-muted">작업정보</label>
									<h5>${data.work_id }</h5>
								</div>
			                	<div class="col-md-4 col-12">
									<label class="form-label text-muted">사용일(수령일)</label>
									<div class ="input-group">
										<h5 date>${data.use_date }</h5>
										<h5>${data.use_hh }:${data.use_mm }</h5>
									</div>
								</div>
			<hr>					
			                	<div class="col-md-4 col-12">
									<label class="form-label text-muted">고객(사)명</label>
									<h5>${data.req_name }</h5>
								</div>					 
			                	<div class="col-md-4 col-12">
									<label class="form-label text-muted">현장주소</label>
									<h5>${data.work_addr1 } ${data.work_addr2 }</h5>
								</div>					
			                	<div class="col-md-4 col-12">
									<label class="form-label text-muted">담당자</label>
									<h5>${data.manager_name }</h5>
								</div>					
			<hr>				
			                	<div class="col-md-4 col-12">
									<label class="form-label text-muted">수령방법</label>
									<h5><tags:code-name code_gb="receive_type" value="${data.receive_type}"/></h5>
								</div>
			                	<div class="col-md-4 col-12">
									<label class="form-label text-muted">상태</label>
									<h5><tags:code-name code_gb="doc_stat" value="${data.doc_stat}"/></h5>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 자재목록 -->
			<div class="card mt-4">
			    <div class="card-header">
			        <h3>자재목록</h3>
				    <div class="d-flex align-items-center justify-content-between">
				        <p class="mb-0 small"></p>
			        </div>
			    </div>
			    <div class="table-responsive">
			        <table class="table table-striped">
			            <thead>
			                <tr>
			                    <th style="width:15%">품번</th>
			                    <th style="width:25%">품명</th>
			                    <th>브랜드</th>
			                    <th style="width:12%">수량</th>
			                    <th style="width:12%">공급가</th>
			                    <th style="width:12%">총 금액</th>
			                    <th style="width:12%">상태</th>
			                </tr>
			            </thead>
			            <tbody id="material_doc_list">
							<tr>
								<td colspan="13">등록된 자재가 없습니다.</td>
							</tr>	               
			            </tbody>
			        </table>
			    </div>
			</div>
			<!-- - -->
		</div>
    </div>
    <!-- </div>	 -->
<script>
	/* init page */
	$(function(){
		
		console.log('page script !!!! ');
		console.log('테스트!!!');
		/* save data */
		$("#move_edit").on("click", function(e){
			let param = {material_doc_no: $(this).data("material_doc_no")}
			postPage("/material/doc/form", param);
		});
		
	    /* 자재목록 조회 */
	    listMaterialReq();
	    
	    /* 자재요청 상태 변경 */
	    $("[name=doc_stat]").on("click", function(e){
	    	let _doc_stat = $(this).data("doc_stat");
	    	
			const _name = "자재요청 상태 변경";	// ajax name
			const _url = "/material/doc/stat/save/ajax";	// ajax url
			
			let _param = {};
			_param.doc_stat = _doc_stat;
			_param.material_doc_no = $("#material_doc_no").val();
			_param.delivery_name = $("#delivery_name").val();
			_param.remarks = $("#remarks").val();
			
			$(this).siblings().removeClass("btn-primary").addClass("btn-outline-primary");
			$(this).removeClass("btn-outline-primary").addClass("btn-primary");

			/* multi form insert */
			Utils.requestAjax(_name, _url, _param, {
	            success:  function(data) {
	            	alert(Message.SAVE);  
	            },
	            complete:  function(response) {
	            	console.log('complete!!!');
	            }
			});
	    	
		});
	    
	    
	    /* 자재 상태 update */
	    $("[name=btn_req_stat]").on("click", function(e){
	    	/*
	    		등록: 자재마스터에 없는 경우만 가능, 자재마스터로 저장.
	    		구매: 자재마스터에 있는 경우만 가능, 구매로 저장.
	    		출고: 출고전표 생성.
	    	*/
	    	
	    	let _req_stat = $(this).data("req_stat");
	    	let _receive_type = $(this).data("receive_type"); // 수령방법
	    	let _go = true;
	    	
			const _name = "자재요청 자재상태 변경";	// ajax name
			const _url = "/material/req/stat/save/ajax"; // ajax url
						
			let _param = {};
			let _material_req_no ="";
			
			if($("[name=material_req_no]:checked").length == 0){
				alert('자재를 선택하세요.');
				return;
			}
			
			$("[name=material_req_no]:checked").each(function(e){
				
				let _material_no = $(this).data("material_no");
				let _req_stat_tmp = $(this).data("req_stat");
				let _material_pcs_no = $(this).data("material_pcs_no");
				let _material_bound_no = $(this).data("material_bound_no");
				
				if(_req_stat =='01' && !Utils.isEmpty(_material_no)){
					alert('이미 등록된 자재가 포함되어있습니다.');
					_go = false;
					return false;
				}
				else if(_req_stat =='02' && Utils.isEmpty(_material_no)){
					alert('등록 되지않은 자재가 포함되어있습니다.');
					_go = false;
					return false;
				}
				else if(_req_stat =='02' && _req_stat_tmp =='02'){
					alert('이미 구매중인 자재가 포함되어있습니다.');
					_go = false;
					return false;
				}
				else if(_req_stat =='03' && Utils.isEmpty(_material_no)){
					alert('등록 되지않은 자재가 포함되어있습니다.');
					_go = false;
					return false;						
				}
				else if(_req_stat =='03' && !Utils.isEmpty(_material_bound_no)){
					alert('이미 출고중인 자재가 포함되어있습니다.');
					_go = false;
					return false;						
				}
				else if(_req_stat =='04' && _req_stat_tmp !='03'){
					alert('출고 되지않은 자재가 포함되어있습니다.');
					_go = false;
					return false;
				}
				else {
					_material_req_no += $(this).val()+"^";
				}
			});
			
			if(!_go){
				console.log("상태값과 자재 상태가 맞지않음.");
				return;
			}
					
			_param.req_stat = _req_stat;
			_param.material_doc_no = $("#material_doc_no").val();
			_param.material_req_no_str = _material_req_no;
			_param.receive_type = _receive_type;

			
			Utils.requestAjax(_name, _url, _param, {
	            success:  function(data) {
	            	
	            	// 구매 후 처리.
	            	if(_req_stat =='02'){
	            		console.log("data:", data);
	            		boundPage("/material/doc/bound/form/pcs", data);
	    			}
	            	else {
	            		alert(Message.SAVE);
		            	listMaterialReq();
		            	console.log("data:", data);
	            	}
	            },
	            complete:  function(response) {
	            	console.log('complete!!!');
	            }
			});
			
			/**
			if(_req_stat =='01'){
				boundPage("/material/doc/bound/form/reg", _param)	
			} else {
				Utils.requestAjax(_name, _url, _param, {
		            success:  function(data) {
		            	alert(Message.SAVE);
		            	listMaterialReq()
		            },
		            complete:  function(response) {
		            	console.log('complete!!!');
		            }
				});
			}
			*/			

	    	
		});	    
	});

	function boundPage(_url, _param){

		if(Utils.isEmpty(_url)) return ;
		console.log("menu :", _url);

		let param = Utils.isEmpty(_param) ? null : _param;

	  	$.ajax({
	    	type: "GET",
	    	dataType: "html",
	    	timeout: 3 * 60 * 1000,
	    	url: _url,
	    	data:param,
			beforeSend : function(xhr){
	            xhr.setRequestHeader("Authorization", getAuthToken());
	        },
	    	success: function(response) {
	      		$("#modal_id").empty();
	      		$("#modal_id").html(response);
	      		
				$('#modal-dialog').modal({backdrop: 'static', keyboard: false}) ;
				$("#modal-dialog").modal("show");
	   	 	},
		    error: function(request, status, error) {},
		    complete: function(response) {}
	  	});
	};
	
	function listMaterialReq(){
		
		if(Utils.isEmpty($("#material_doc_no").val())) return ;
		
		const _name = "자재구매요청 조회";	// ajax name
		const _url = "/material/req/list/ajax";	// ajax url
		let _param = {};	// ajax param
		_param['material_doc_no'] = $("#material_doc_no").val();
		
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	
	          	let tmp = '';
	          	if(Utils.isEmpty(data.data)){
	          		tmp = '<tr><td colspan="14">등록된 데이터가 없습니다.</td></tr>';
	          	} else {
	          		$.each(data.data, function(idx, item){
	          			let _disabled = item.req_stat=='04'?'disabled':'';
	          			
	          			tmp += '<tr>'+
	    				'<td>'+Utils.nvl(item.material_id,'-')+'</td>'+
	    				'<td style="text-align:left">'+Utils.nvl(item.material_name)+'</td>'+
	    				'<td style="text-align:left">'+Utils.nvl(item.brand_name)+'</td>'+
	    				'<td style="text-align:right">'+Utils.nvl(item.material_cnt)+' '+getCodeNm('unit_cd',item.unit_cd)+'</td>'+
	    				'<td style="text-align:right">'+Utils.comma(item.workerman_price)+'</td>'+
	    				'<td style="text-align:right">'+Utils.comma(item.material_cnt * item.workerman_price)+'</td>'+
	    				'<td>'+getCodeNm('req_stat',item.req_stat)+'</td>'+
	    				//'<td>'+getCodeNm('receive_type',item.receive_type)+'</td>'+
	    				//'<td class="with-btn" nowrap=""><a href="#" class="btn btn-sm btn-white width-60" id="del-material" data-material_req_no="'+item.material_req_no+'">Delete</a></td>'+
	    				'</tr>';
	          		});
	          	}
	          	
    			$("#material_doc_list").html(tmp);
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}	
</script>