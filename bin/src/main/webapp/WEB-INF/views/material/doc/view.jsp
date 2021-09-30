<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE LEVEL HTML ================== -->
<h1 class="page-header">자재요청<span class="ms-3 fw-bold">자재관리</span></h1>

<div class="row">
    <div class="col-12 mb-3">
        <div class="card">
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
						<h5>${not empty data.branch_name? data.customer_name.concat(' / ').concat(data.branch_name):data.req_name}</h5>
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
						<label class="form-label text-muted">자재요청목적</label>
						<h5>${data.req_usage }</h5>
					</div>	
				</div>
			</div>
		</div>
		<div class="d-flex justify-content-center mt-4">
        	<button 
			    type="button" 
			    class="btn btn-secondary" 
			    name="_button_page_list" 
			    data-to_url="/material/doc/list">list</button>
            <button class="btn btn-primary ms-2" id="move_edit" data-material_doc_no="${data.material_doc_no }">edit</button>
        </div>
	</div>
</div>

<!-- 물류센터 입력 부분 -->
<div class="card">
    <div class="card-header">
        <h3 class="mb-0">물류센터 입력</h3>
    </div>
    <div class="card-body">
		<div class="col-md-12 col-12">
		    <label class="form-label">메모<span class="text-danger"></span></label>
		    <input type="text" class="form-control" 
		    	placeholder="메모" 
		    	id="remarks" 
		    	name="remarks" 
		    	value="${data.remarks}" 
		    	data-parsley-required="false"
		    	/>
    	</div>
		<div class="col-md-4 col-12 mt-3">
        	<label class="form-label">배송담당자<span class="text-danger"></span></label>
            <input type="text" class="form-control" 
               	placeholder="배송담당자" 
               	id="delivery_name" 
               	name="delivery_name" 
               	value="${data.delivery_name}" 
    			data-parsley-required="false"
    		/>
		</div>
		<div class="col-md-8 col-12 mt-3">
		    <label class="form-label">요청상태 <span class="text-danger">*</span></label>
		    <div class ="input-group">
		    	<div class="d-flex justify-content-center">
					<tags:code-radio
						codeList="${doc_stat }"
						checked="${data.doc_stat }"
						name="doc_stat"
						required="false"
						initValue=""
					/>		    	
				</div>
			</div>
        </div>    
    </div>
</div>
<div class="d-flex justify-content-center mt-4">
    <button class="btn btn-primary ms-2 _but_doc_stat_save" data-material_doc_no="${data.material_doc_no }">save</button>
</div>
<!-- 물류센터 입력 부분 -->

        
<!-- 자재목록 -->
<div class="card mt-4">
    <div class="card-header">
        <h3>자재목록</h3>
	    <div class="d-flex align-items-center justify-content-between">
	        <p class="mb-0 small"></p>
            <p class="mb-0 small">
	            <button class="btn-sm btn-primary" name="btn_req_stat" data-req_stat='01' data-receive_type='${data.receive_type}'>신규자재 등록</button>
	            <button class="btn-sm btn-primary" name="btn_req_stat" data-req_stat='02'>구매</button>
	            <button class="btn-sm btn-primary" name="btn_req_stat" data-req_stat='03'>출고</button>
	            <button class="btn-sm btn-primary" name="btn_req_stat" data-req_stat='04'>준비완료</button>
            </p>
        </div>
    </div>
    <div class="table-responsive">
        <table class="table table-striped" style="width:1600px">
            <thead>
                <tr>
                	<th style="width:3%"><input type="checkbox" id="material_req_check_all"></th>
                    <th style="width:8%">품번</th>
                    <th style="width:16%">품명</th>
                    <th>브랜드</th>
                    <th style="width:7%">수량</th>
                    <th style="width:7%">단가</th>
                    <th style="width:7%">공급가</th>
                    <th style="width:7%">총 금액</th>
                    <th style="width:5%">사진</th>
                    <th style="width:5%">링크</th>
                    <th style="width:10%">현재고(물류/성수/르노)</th>
                    <!-- <th style="width:8%">자재관리</th> -->
                    <th style="width:8%">전표</th>
                    <th style="width:6%">상태</th>
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



<!-- ---------------------------- -->

<!-- begin modal -->
	<!-- 자재 추가 -->
	<div class="modal fade" id="modal-dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header" style="display:none " id="modal-dialog_header">
					<!-- <h4 class="modal-title">자재 추가하기</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
					<div style="margin-top: 10px; margin-left: 10px;">
					    <ul class="nav nav-pills" id="material_tabs">
					    </ul>
					</div>
				</div>
				<div class="modal-body" id="modal_id">
					<!--  -->
				</div>
				<!-- <div class="modal-footer">
					<a href="javascript:;" class="btn btn-white" data-dismiss="modal" id="close_material">닫기</a>
					<a href="javascript:;" class="btn btn-success" id="add_material">저장</a>
				</div> -->
			</div>
		</div>
	</div>
	
<!-- end modal -->

<!-- ---------------------------- -->
<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<!-- ================== END PAGE LEVEL JS ================== -->
	<!-- ================== BEGIN Jandi SCRIPT ================== -->
	<script type="text/javascript" src="/assets/js/Jandi.js"></script>
	<!-- ================== END Jandi SCRIPT ================== -->	
<script>
	/* init page */
	$(function(){
		console.log('page script !!!! ');
		/* save data */
		$("#move_edit").on("click", function(e){
			let param = {material_doc_no: $(this).data("material_doc_no")}
			postPage("/material/doc/form", param);
		});
		
	    /* 자재목록 조회 */
	    listMaterialReq();
	    
	    /* 자재요청 상태 변경 */
	    $("._but_doc_stat_save").on("click", function(e){
	    	let _doc_stat = $("[name=doc_stat]:checked").val();
	    	
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
	            	// send jandi message 
	            	let _data = {};
	            	_data.jandi_id 	= '${data.jandi_id }';
	            	_data.material_doc_id 	= '${data.material_doc_id }';
	            	_data.doc_stat_name 	= getCodeNm('doc_stat', $("[name=doc_stat]:checked").val());
	            	_data.create_name 		= '${data.create_name }';	// 요청자
	            	_data.create_str_date 	= '${data.create_str_date }';	// 요청자일
					
	            	_data.material_cnt 	= $("[name=material_req_no]").length;
	            	_data.material_name = $("[name=material_name]").eq(0).text();
	            	
	            	_data.use_date 	= Utils.getDate('${data.use_date }')+' '+'${data.use_hh }:${data.use_mm }';	// 수령일
	            	_data.receive_type 	= getCodeNm('receive_type', "${data.receive_type}");
	            	
	            	_data.delivery_name 	= $("#delivery_name").val();	// 배송담당자.
	            	_data.confirm_admin_name 	= data.confirm_admin_name;	// 처리자명
	            	
	            	console.log("return:", data)
	            	
	            	Jandi.sendWebHookMaterial(_data);
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
				else if(_req_stat =='03' && _req_stat_tmp =='03'){
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

    		// init new material tabs
    		$("#modal-dialog_header").hide();
			$("#material_tabs").html('');
			
			Utils.requestAjax(_name, _url, _param, {
	            success:  function(data) {
	            	
	            	// 구매 후 처리.
	            	if(_req_stat =='02'){
	            		boundPage("/material/doc/bound/form/pcs", data);
	    			}
	            	// 신규자재 후 처리.
	            	else if(_req_stat =='01'){
	            		boundPage("/material/doc/bound/form/reg", data);
	            		// material tabs list 
	            		// material_name, material_no, material_id
	            		console.log('등록 데이터:', data);
        				
	            		// view materila tabs
	            		if(data.materialList){
	            			let _matlist = data.materialList ;
	            			let _tmp = '';
	            			let _item = {};
	            			if(_matlist.length > 1){
	            				$.each(_matlist, function(idx, item){
	            					_item = item;
		            				_tmp += '<li class="nav-item ">' +
						            		'<a href="#MAT" data-toggle="tab" data-url="MAT" class="nav-link" aria-expanded="true" name="material_add_type" data-material_no="'+_item.material_no+'" '+_item.material_id+'>'+_item.material_id+'</a>' +
							        		'</li>';
	            				});
	            				$("#modal-dialog_header").show();
	            				$("#material_tabs").html(_tmp);
	            				$('[name="material_add_type"]['+_item.material_id+']').addClass("active");
	            			}	
	            		}
	    			} else {
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

	    // 자재 전체 선택.
	    $("#material_req_check_all").on("click", function(e){
	        let _all = $(this).prop("checked");
	        $("#material_doc_list").find("[name=material_req_no]:enabled").prop("checked", _all);
	    });
	    
	    // 자재 탭 클릭
	    $("#modal-dialog").on("click", "[name='material_add_type']", function(e){
	    	
	    	let _url = '/material/doc/bound/form/reg';
	    	let _param = {};
	    	_param.material_no = $(this).data('material_no');
	    	boundPage(_url, _param);
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
		
		const _req_no_str = $("[name='material_req_no']:checked"); // checked object.
		
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	
	          	let tmp = '';
	          	if(Utils.isEmpty(data.data)){
	          		tmp = '<tr><td colspan="14">등록된 데이터가 없습니다.</td></tr>';
	          	} else {
	          		$.each(data.data, function(idx, item){
	          			let _disabled = item.req_stat=='04'?'disabled':'';
	          			let _IMG_CATE = "IMG_TYPE_MATERIAL";
	          			let _KEY_NO = item.material_no;
	          			let _botton = '';
	          			if(Utils.isEmpty(item.material_no)){
	          				_IMG_CATE = "IMG_TYPE_MATERIAL_REQ";
		          			_KEY_NO = item.material_req_no;
	          			}
	          			_botton = '<button class="btn btn-xs btn-primary _button_img_pop" onclick="getImagePop(\''+ _IMG_CATE +'\', \''+ _KEY_NO +'\');" >확인</button>';
	          			tmp += '<tr>'+
	          			'<td><input type="checkbox" name="material_req_no" value="'+item.material_req_no+'" data-material_no="'+item.material_no+'" data-req_stat="'+item.req_stat+'" data-material_pcs_no="'+item.material_pcs_no+'" data-material_bound_no="'+item.material_bound_no+'" '+_disabled+'/></td>'+
	    				'<td>'+Utils.nvl(item.material_id,'-')+'</td>'+
	    				'<td style="text-align:left" name="material_name">'+Utils.nvl(item.material_name)+'</td>'+
	    				'<td style="text-align:left">'+Utils.nvl(item.brand_name)+'</td>'+
	    				'<td style="text-align:right">'+Utils.nvl(item.material_cnt)+' '+getCodeNm('unit_cd',item.unit_cd)+'</td>'+
	    				'<td style="text-align:right">'+Utils.comma(item.purchased_price)+'</td>'+
	    				'<td style="text-align:right">'+Utils.comma(item.workerman_price)+'</td>'+
	    				'<td style="text-align:right">'+Utils.comma(item.material_cnt * item.purchased_price)+'</td>'+
	    				'<td>'+_botton+'</td>'+
	    				'<td>'+'<button class="btn btn-xs btn-primary _button_img_pop" onclick="getLinkPop(\''+ item.material_link+ '\')" >확인</button></td>'+
	    				'<td>'+Utils.nvl(item.house_cnt,'0')+"/"+Utils.nvl(item.sba_cnt,'0')+"/"+Utils.nvl(item.vehicle_cnt,'0')+'</td>'+
	    				/* '<td></td>'+ */
	    				'<td>'+Utils.nvl(item.material_bound_id,'-')+'</td>'+
	    				'<td>'+getCodeNm('req_stat',item.req_stat)+'</td>'+
	    				//'<td>'+getCodeNm('receive_type',item.receive_type)+'</td>'+
	    				//'<td class="with-btn" nowrap=""><a href="#" class="btn btn-sm btn-white width-60" id="del-material" data-material_req_no="'+item.material_req_no+'">Delete</a></td>'+
	    				'</tr>';
	          		});
	          	}
	          	
    			$("#material_doc_list").html(tmp);
    			
    			$("#material_req_check_all").prop("checked", false); // 자재전체선택

            },
            complete:  function(response) {
            	
    			{// 선택된 항목 유지.	
    				$.each(_req_no_str, function(idx, item){
    					//console.log(">>>", this.value);
    					let _material_req_no = this.value;
	    				if(!Utils.isEmpty(_material_req_no)){
	    					let _disabled = $("[name=material_req_no][value='"+_material_req_no+"']").prop("disabled");
	    					if(_disabled) return;
	    					$("[name=material_req_no][value='"+_material_req_no+"']").prop("checked", true);
	    				}
    				});
    			}
            }
		});
	}	
</script>