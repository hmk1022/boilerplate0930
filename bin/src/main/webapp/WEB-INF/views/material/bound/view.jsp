<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>
<!-- ================== BEGIN PAGE LEVEL HTML ================== -->
<h1 class="page-header">구매<span class="ms-3 fw-bold">자재관리</span></h1>

<div class="row">
    <div class="col-12 mb-3">
        <div class="card">
            <div class="card-body ">
                <div class="row">
                	<input type="hidden" id="material_bound_no" name="material_bound_no" value="${data.material_bound_no }" >
                	
                	<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">수령방법</label>
						<h5><tags:code-name code_gb="bound_reason" value="${data.bound_reason}"/></h5>
					</div>
                	<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">구매번호</label>
						<h5>${data.material_bound_id }</h5>
					</div>
                	<div class="col-md-4 col-12 mt-3">
						<label class="form-label text-muted">구매상태</label>
						<div class ="form-inline">
							<h5><tags:code-name code_gb="bound_stat" value="${data.bound_stat}"/></h5> 
						</div>
					</div>					
<c:if test="${data.bound_reason eq '01'}">
<hr>
                	<div class="col-md-4 col-12">
						<label class="form-label text-muted">작업선택</label>
						<h5>${data.work_id } | ${data.req_name }</h5>
					</div>
                	<div class="col-md-4 col-12">
						<label class="form-label text-muted">자재요청서번호</label>
						<h5>${data.material_doc_no }</h5>
					</div>
                	<div class="col-md-4 col-12">
						<label class="form-label text-muted">요청자</label>
						<h5>${data.material_doc_admin_name }</h5>
					</div>
</c:if>
<c:if test="${data.bound_reason eq '99'}">
<hr>
                	<div class="col-md-3 col-12">
						<label class="form-label text-muted">기타사유</label>
						<h5>${data.etc_remarks }</h5>
					</div>
</c:if>
<hr>					
                	<div class="col-md-4 col-12">
						<label class="form-label text-muted">매입거래처</label>
						<h5>${data.vendor_name }</h5>
					</div>
                	<div class="col-md-4 col-12">
						<label class="form-label text-muted">연락처</label>
						<h5 phone>${data.vendor_hp1 }</h5>
					</div>
<hr>					
                	<div class="col-md-4 col-12">
						<label class="form-label text-muted">결제정보</label>
						<div class ="form-inline">
							<h5><tags:code-name code_gb="vacct_bank_code" value="${data.bank_code}"/></h5> / 
							<h5>${data.acct}</h5>
						</div>
					</div>
                	<div class="col-md-4 col-12">
						<label class="form-label text-muted">지출증빙</label>
						<h5 busno>${data.evidence }</h5>
					</div>
<hr>					
                	<div class="col-md-4 col-12">
						<label class="form-label text-muted">결제요청일</label>
						<h5 date>${data.pay_req_date }</h5>
					</div>
                	<div class="col-md-4 col-12">
						<label class="form-label text-muted">부가세 포함여부</label>
						<h5>${data.vat_yn eq 'Y'?'부가세포함':'부가세제외' }</h5>
					</div>
<hr>					
                	<div class="col-md-12 col-12">
						<label class="form-label text-muted">메모</label>
						<h5>${data.remarks }</h5>
					</div>
				</div>
			</div>
		</div>
		
		<div class="d-flex justify-content-center mt-4">
			<!-- evnet -->
        	<button class="btn btn-gray" name="moveBack">list</button>
        	<c:if test="${data.bound_reason ne '01'}">
            <button class="btn btn-primary ms-2" id="move_edit" data-material_bound_no="${data.material_bound_no }">edit</button>
			</c:if>
			<!-- bsussiness -->
			<c:if test="${data.bound_reason eq '01'}">
            <button class="btn btn-primary ms-2" name="bound_stat" data-bound_stat="02" data-material_bound_no="${data.material_bound_no }">결제요청</button>
            </c:if>
            <c:if test="${data.bound_reason eq '03'}">
            <button class="btn btn-primary ms-2" name="bound_stat" data-bound_stat="04" data-material_bound_no="${data.material_bound_no }">입고</button>
            </c:if>
            
        </div>
	</div>
</div>

<%--
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
					<c:forEach items="${bound_stat }" var="item">
					<c:set value="btn-outline-primary" var="btnCls"/>
					<c:if test="${item.code_value eq data.bound_stat }">
					<c:set value="btn-primary" var="btnCls"/>
					</c:if>
					<button class="btn ${btnCls }" name="bound_stat" data-bound_stat="${item.code_value }">${item.code_name }</button>&nbsp;
					</c:forEach>
				</div>
			</div>
        </div>    
    </div>
</div>
<!-- 물류센터 입력 부분 -->
 --%>
        
<!-- 자재목록 -->
<div class="card mt-4">
    <div class="card-header">
        <h3>자재목록</h3>
        <!-- 
	    <div class="d-flex align-items-center justify-content-between">
	        <p class="mb-0 small"></p>
            <p class="mb-0 small">
	            <button class="btn-sm btn-primary" name="btn_req_stat" data-req_stat='02'>구매</button>
	            <button class="btn-sm btn-primary" name="btn_req_stat" data-req_stat='03'>출고</button>
	            <button class="btn-sm btn-primary" name="btn_req_stat" data-req_stat='04'>준비완료</button>
            </p>
        </div>
         -->
    </div>
    <div class="table-responsive">
        <table class="table table-striped" style="width:1600px">
            <thead>
                <tr>
                	<!-- <th style="width:3%"></th> -->
                    <th style="width:12%">품번</th>
                    <th style="width:15%">품명</th>
                    <th>브랜드</th>
                    <th style="width:7%">수량</th>
                    <th style="width:7%">단가</th>
                    <th style="width:7%">공급가</th>
                    <th style="width:7%">총 금액</th>
                    <th style="width:6%">사진</th>
                    <th style="width:6%">링크</th>
                    <th style="width:8%">현재고(물류/성수/르노)</th>
                    <!-- <th style="width:8%">자재관리</th> -->
                    <!-- <th style="width:8%">전표</th> -->
                    <!-- <th style="width:6%">상태</th> -->
                </tr>
            </thead>
            <tbody id="material_bound_list">
				<tr>
					<td colspan="13">등록된 자재가 없습니다.</td>
				</tr>	               
            </tbody>
        </table>
    </div>
</div>
<!-- - -->
<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<!-- ================== END PAGE LEVEL JS ================== -->
	
<script>
	/* init page */
	$(function(){
		console.log('page script !!!! ');
		console.log('테스트!!!');
		/* save data */
		$("#move_edit").on("click", function(e){
			let param = {material_bound_no: $(this).data("material_bound_no")}
			postPage("/material/bound/form", param);
		});
		
	    /* 자재목록 조회 */
	    listMaterialBoundItem();
	    
	    /* 구매 상태 변경 */
	    $("[name=bound_stat]").on("click", function(e){
	    	let _bound_stat = $(this).data("bound_stat");
	    	let _material_bound_no = $(this).data("material_bound_no");
	    	
			const _name = "구매 상태 변경";	// ajax name
			const _url = "/material/bound/stat/save/ajax";	// ajax url
			
			let _param = {};
			_param.bound_stat = _bound_stat;
			_param.material_bound_no = _material_bound_no;
			
			//$(this).siblings().removeClass("btn-primary").addClass("btn-outline-primary");
			//$(this).removeClass("btn-outline-primary").addClass("btn-primary");

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
	    /* $("[name=btn_req_stat]").on("click", function(e){
	    	let _req_stat = $(this).data("req_stat");
	    	
			const _name = "구매 자재상태 변경";	// ajax name
			const _url = "/material/bound/item/stat/save/ajax";	// ajax url
						
			let _param = {};
			let _material_bound_item_no ="";
			
			if($("[name=material_bound_item_no]:checked").length == 0){
				alert('자재를 선택하세요.');
				return;
			}
			
			$("[name=material_bound_item_no]:checked").each(function(e){
				_material_bound_item_no += $(this).val()+"^";
			});
			
			_param.req_stat = _req_stat;
			_param.material_bound_no = $("#material_bound_no").val();
			_param.material_bound_item_no_str = _material_bound_item_no;

			//multi form insert
			Utils.requestAjax(_name, _url, _param, {
	            success:  function(data) {
	            	alert(Message.SAVE);
	            	listMaterialBoundItem()
	            },
	            complete:  function(response) {
	            	console.log('complete!!!');
	            }
			});
		}); */
	    
	    
	});

	
	function listMaterialBoundItem(){
		
		if(Utils.isEmpty($("#material_bound_no").val())) return ;
		
		const _name = "자재구매요청 조회";	// ajax name
		const _url = "/material/bound/item/list/ajax";	// ajax url
		let _param = {};	// ajax param
		_param['material_bound_no'] = $("#material_bound_no").val();
		
		Utils.requestAjax(_name, _url, _param, {
            success:  function(data) {
	          	
	          	let tmp = '';
	          	if(Utils.isEmpty(data.data)){
	          		tmp = '<tr><td colspan="14">등록된 데이터가 없습니다.</td></tr>';
	          	} else {
	          		let _total_purchased_price = 0;
	          		$.each(data.data, function(idx, item){
	          			tmp += '<tr>'+
	          			/* '<td><input type="checkbox" name="material_bound_item_no" value="'+item.material_bound_item_no+'"/></td>'+ */
	    				'<td>'+Utils.nvl(item.material_id)+'</td>'+
	    				'<td style="text-align:left">'+Utils.nvl(item.material_name)+'</td>'+
	    				'<td style="text-align:left">'+Utils.nvl(item.brand_name)+'</td>'+
	    				'<td style="text-align:right">'+Utils.nvl(item.item_cnt)+' '+getCodeNm('unit_cd',item.unit_cd)+'</td>'+
	    				'<td style="text-align:right">'+Utils.comma(item.purchased_price)+'</td>'+
	    				'<td style="text-align:right">'+Utils.comma(item.workerman_price)+'</td>'+
	    				'<td style="text-align:right">'+Utils.comma(item.total_purchased_price)+'</td>'+
	    				'<td>-</td>'+
	    				'<td>-</td>'+
	    				'<td>'+Utils.nvl(item.house_cnt,0)+"/"+Utils.nvl(item.sba_cnt,0)+"/"+Utils.nvl(item.vehicle_cnt,0)+'</td>'+
	    				/* '<td></td>'+ */
	    				/* '<td></td>'+ */
	    				/* '<td>'+getCodeNm('item_stat',item.item_stat)+'</td>'+ */
	    				//'<td>'+getCodeNm('receive_type',item.receive_type)+'</td>'+
	    				//'<td class="with-btn" nowrap=""><a href="#" class="btn btn-sm btn-white width-60" id="del-material" data-material_bound_item_no="'+item.material_bound_item_no+'">Delete</a></td>'+
	    				'</tr>';
	          			_total_purchased_price += item.total_purchased_price;
	          		});
	          		tmp +='<tr class="table-success"><td colspan="9" class="fw-bold">소계</td><td class="text-end fw-bold">'+Utils.comma(_total_purchased_price)+' 원</td></tr>';
	          	}
	          	
            
    			$("#material_bound_list").html(tmp);
            },
            complete:  function(response) {
            	console.log('complete!!!');
            }
		});
	}	
</script>