<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

<!-- ================== BEGIN PAGE LEVEL HTML ================== -->
<html>
	<head>
	<link href="./assets/css/workman_admin.css" rel="stylesheet">
		<style>
			/* pdf 출력 */
			body {
				overflow-x: hidden;
			}
			
			#download_pdf {
				position: fixed;
				left: 50%;
				bottom: 30px;
				z-index: 99;
				padding: 15px 30px;			
				box-shadow: 1px 1px 1px 1px rgba(0,0,0,0.2);
				border-radius: 50px;
				font-weight: bold;
				transform: translate(-50%,-50%);
			}	
			@media print {
			    #download_pdf {
			   		display: none;
			   	}	
			   	/* 프린트 */
			   	.print-a4 {			   		
			   		height:371mm 
			   	}
			   	/* pdf사이즈 */
			   	@page {
			   		size: a4;
			   	}
			}		   			
		</style>
	</head>
<button type="button" class="btn btn-primary" id="download_pdf" >PDF 출력</button> 
<h1 class="page-header">
	견적서<span class="ms-3 fw-bold">코드관리</span>
</h1>
<body>
	<div id="pdf-area" class="a4" >
	<!-- 프린트용 table start -->
		<table style="display: block; width: 980px; height: 0 !important; opacity: 0;">
			<tbody>
				<tr>
					<td>1</td>
				</tr>
			</tbody>
		</table>
		<!-- 프린트용 table end -->
		<body class="bg-white">
			<div class="card print-a4">
				<div class="coverTitle">
					<span>견적서</span><span class="rightSmall">Quotation Proposal</span>
				</div>
				<div class="coverContent">
					<div class="row align-items-end justify-content-between mb-5">
						<div class="col-4">				 	
							<h1 class="border-bottom-2 fw-bolder pb-3 mb-5" style="border-bottom: 2px solid #000 !important">${data.req_name}<span class="small ms-3">귀하</span></h1>
							<h3 class="customer_id">${data.customer_name}&nbsp;/&nbsp;<span>${data.branch_name}<span></h3>
							<h4 class="fw-normal" >${data.work_addr}</h4>
						</div>
						<div class="col-4">
							<ul class="estimate">
								<li>문서번호</li>
								<li class="doc_num">${data.doc_version_no}</li>
								<li>작성일자</li>
								<li class="update_date">${data.update_date}</li>
								<li>작성자</li>
								<li>${data.manager_admin_name}</li>
							</ul>
						</div>
					</div>
					<h3 class="border-bottom-2 pb-3 mb-5" style="border-bottom:2px solid #000 !important">${data.location_name}
						인테리어 공사</h3>
					<table class="table cover" id="cover-table">
						<thead>
							<tr>
								<th>No.</th>
								<th>내역</th>
								<th>자재비</th>
								<th>인건비</th>
								<th>공과잡비</th>
								<th>기타</th>
								<th>소계</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td>
									<h4 class="m-0" >
										직접공사비 계<span class="d-block small">각 공사별 상세 내역은 상세견적 참조</span>
									</h4>
									</td>
										<td class="m_cost comma1 text-end">
											0
										</td>
										<td class="p_cost comma2 text-end">
											0
										</td>
										<td class="" >										
										</td>
										<td class="" >									
										</td>
								<td id="direct_total_price" class="text-end fw-bold comma3" >0</td>
							</tr>
						</tbody>
								<td colspan="5" class="border-0 pt-4 pb-5 ">
									<p class="m-0 info_txt">
										1. 견적서에 명시되지 않은 사항은 별도 공사로 간주하며, 실비 정산을 원칙으로 합니다. <br> 2.
										본 견적서의 총 금액은 부가세를 포함하고 있지 않으며, 부가세는 10% 별도입니다.
									</p>
								</td>
								<td class="border-0"></td>
								<td class="text-end border-0 pt-4 pb-5 ">
									<h3 class="m-0 comma10" id="estiamte_total_sum" >
										0
									</h3>
									<p class="m-0 border-0 d-block pb-5" style = "opacity: 0.7;">부가세 10% 별도</p>
								</td>			 
					</table>
					<hr>
					<div class="row mt-5" >
						<div class="col-6">
							<div class="coverLogo" >
							</div>
						</div>
						<div class="col-6">
							<h4>주식회사 워커맨</h4>
							<ul class="coverFooter">
								<li>대표이사</li>
								<li>이용규</li>
								<li>주소</li>
								<li>서울시 서초구 식유촌길 51-3 (우면동, 이안리타워) 2층</li>
								<li>사업자번호</li>
								<li>406 - 88 - 01127</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
	</div>
	<!-- 상세 견적 -->
	<div >
	<table style="display: block; width: 980px;height: 0 !important; opacity: 0;">
    <tbody>
        <tr>
            <td>1</td>
        </tr>
    </tbody>
</table>
</body>
<!--  -->
	<body class="bg-white detail">
	    <div class="card " style="background-color: #fff">
	     	<div class="coverTitle detail"><span>견적 세부 산출 내역</span><span class="rightSmall">${data.doc_version_no}<br><p class="update_date2">${data.update_date}</p></span></div>
	        <div class="coverContent">
	       <c:forEach var="work" items="${workList}">
	            <div class="detailTitle">${work.work_id } <span>${work.location_name}</span></div>
	            <!--  table도 반복 삽입 그리고 그안에 tr 반복삽입-->
	            <table class="table cover mb-5">
	                <colgroup>
	                    <col>
	                    <col>
	                    <col width="20%">
	                    <col width="20%">
	                    <col>
	                    <col>
	                    <col>
	                    <col>
	                </colgroup>
	                <thead>
	                    <tr>
	                        <th>No.</th>
	                        <th>구분<span class="small d-block fw-light">Type</span></th>
	                        <th>내역<span class="small d-block fw-light">Description</span></th>
	                        <th>규격<span class="small d-block fw-light">Standard</span></th>
	                        <th>단위<span class="small d-block fw-light">Unit</span></th>
	                        <th>수량<span class="small d-block fw-light">Quantity</span></th>
	                        <th>단가<span class="small d-block fw-light">Unit Cost</span></th>
	                        <th>금액<span class="small d-block fw-light">Amount</span></th>
	                    </tr>
	                </thead>
	                <tbody>
	                <c:set var="estimate_map" value="estimate_${work.work_no }" scope="request"></c:set>
				    <c:forEach var="item" items="${requestScope[estimate_map]}" varStatus="status">
	                <!-- html 반복삽입 -->
	                    <tr>
	                        <td>${status.count}</td>
	                        <td class="resource_type">${item.code_name}</td>
	                        <td>${item.resource_name}</td>
	                        <td>${item.resource_standard}</td>
	                        <td>${item.unit_cd_name}</td>
	                        <td class="text-end">${item.resource_count}</td>
	                        <td class="text-end" >${item.t_unit_price}</td>
	                        <td class="text-end fw-bold" >${item.t_total_price}</td>                        
	                    </tr>                    
	                    </c:forEach>
	                     <tr class="table-light">
	                        <td colspan="7" class="fw-bold">공정 합계</td>
	                        <td class="text-end fw-bold" id="list_total">${work.list_total}</td>
	                    </tr>
	                </tbody>
	            </table>
	         </c:forEach>
	        </div>
	    </div>
	</body>
</div>
<!--  -->
</html>


<!-- ================== END PAGE LEVEL HTML ================== -->

<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<!-- ================== END PAGE LEVEL JS ================== -->

<script>
	/* init page */	
	$(function() {
		/* 견적서 자재비, 인건비, 기타 견적 총합 */
		
	    let m_cost = $('.m_cost').text();
	    let p_cost = $('.p_cost').text(); 

		/* json 데이터 작업 */
		
		let data = '${price}' 
		let parseData = JSON.parse(data);
		
		let job_etc = 0;
		
		
		/* for (let j = 0; j < parseData.length; j++ ){
			if(parseData[j].stat) { // 승인된 견적서만 필터링
				apply_estimate.push(parseData[j]);
				/* if(parseData[j].resource_name="nego"){ // resource_name으로 분류하는 작업 보류
					nego += parseData[j].total_price ;
					$('#nego').text(nego);
					$('#nego_sum').text(nego);
				} else if(parseData[j].resource_name.includes('기업이윤')){
					profit += parseData[j].total_price ;
					$('#profit_sum').text(profit);
					$('#profit_etc').text(profit);
				} else if(parseData[j].resource_name.includes('공과잡비')){
					job_etc += parseData[j].total_price;
					$('#job_etc').text(job_etc);
					$('#job_b_sum').text(job_etc);
				}  
			}
		}; */
	
		
		/*  resource_type - 01 : 자재비 , 02 : 인건비, 03 : 공과잡비, 99 : 기타 */
		/*  견적 종류에 따른 견적합  */
		let m_cost_sum = 0;
		let p_cost_sum = 0;
		let etc_cost_sum = 0;
		let etc_list = []; // 기타 작업들은 따로 리스트로 만들어서 반복문으로 append
		let job_b_sum = 0; // 공과잡비 총합
		let job_b_list = []; // 공과잡비는 따로 종합해서 cover에 기입
		
		let est_total_price = 0; // 견적서 전체 금액
	
			for (let x = 0; x < parseData.length; x++ ){
				est_total_price += parseData[x].total_price;
				
				if( parseData[x].resource_type == 01 ){ // 자재비			
					m_cost_sum += parseData[x].total_price;
				} else if (parseData[x].resource_type == 02) { // 인건비
					p_cost_sum += parseData[x].total_price;
				} else if (parseData[x].resource_type == 03) {
					job_b_sum += parseData[x].total_price;
				} else {
					etc_list.push(parseData[x]);
				}
			};

			/* 견적서 전체 금액 계산 */
			$('#estiamte_total_sum').text(new Intl.NumberFormat().format(est_total_price)+" 원");

			
			/* 값이 0인 데이터는 출력 안한다 & - 띄워쓰기*/
			let zeroData = (price_data) => {
				if (String(price_data).includes('-')) {
					return String(price_data).replace('-','- ')
				}
				if(price_data != 0) {		
					return price_data
				} else {
					return ""
				}
			};
	
			/* 공과잡비와 기타금액의 기입위치 조건을 주기 위해서 만든 변수 */
			var job_b_r = 0;
			var job_b_total = 0;
			var etc_r = 0;
			var comma_cnt = 4; //comma붙이기 반복문
			
			var job_b_ins = 
						'<tr>'
						+'<td>'+
						  2
					    +'</td>'
						+'<td>'	
					    +'<h4 class="m-0">'
					    +'공과잡비'
						+'</h4></td>'
						+ '<td class="comma text-end">'
						+'</td>'
						+ '<td class="comma text-end">'
						+'</td>'	
						+'<td class="text-end">'
						+ zeroData(new Intl.NumberFormat().format(job_b_sum))
						+'</td>'
						+ '<td class="comma text-end" id="">'							
						+'</td><td class="comma text-end fw-bold " id="">'
						+ zeroData(new Intl.NumberFormat().format(job_b_sum))
						'</td></tr>';
			
			$('#cover-table').append(job_b_ins);
			
				for (let i = 0; i < etc_list.length; i++ ){
				   if(etc_list[i].resource_type == 03) { // 공과잡비라면
					   etc_r = etc_list[i].total_price
				   } 
					   
				   var insTag = 
						'<tr>'
						+'<td>'+
						  parseInt(i+3)
					    +'</td>'
						+'<td>'					
					    +'<h4 class="m-0">'
						+ etc_list[i].resource_name
						+'</h4></td>'
						+ '<td class="comma text-end">'
						+'</td>'
						+ '<td class="comma text-end">'
						+'</td>'
						+ etc_list[i].resource_name
						+'<td class="text-end">'
						+'</td>'
						+ '<td class="comma text-end" id="">'				
						+ zeroData(new Intl.NumberFormat().format((etc_r + etc_list[i].total_price)))	
						+'</td><td class="comma text-end fw-bold " id="">'
						+ zeroData(new Intl.NumberFormat().format(etc_list[i].total_price))
						'</td></tr>'
						
						$("#cover-table").append(insTag); 
						
				   job_b_r = 0; // 반복문을 한바퀴 돌면 초기화 해준다
				   etc_r =0;
			   }; 
		
		/* 	
		if(direct_stat){ // 승인된 견적서에 대해서만 반영
		for (let x = 0; x < apply_estimate.length; x++ ){
			if( apply_estimate[x].resource_type == 01 ){ // 자재비
				m_cost_sum = parseInt(m_cost) + apply_estimate[x].total_price;
			} else if (apply_estimate[x].resource_type == 02) { // 인건비
				p_cost_sum = parseInt(p_cost) + apply_estimate[x].total_price;
			} else if (apply_estimate[x].resource_type == 99) { // 기타
				etc_cost_sum = parseInt(etc_cost) + apply.estimate[x].total.price;
			} else if (apply_estimate[x].resource_type == 03 ){ // 공과잡비
				job_b =	job_b + apply.estimate[x].total.price;
			}
		};
		} */
		
		$('.m_cost').text(new Intl.NumberFormat().format(m_cost_sum));
		$('.p_cost').text(new Intl.NumberFormat().format(p_cost_sum));
		
	
		// 공과잡비 금액
		/* $('.job_b').text(job_b);
		$('#job_b_sum').text(job_b); */
		/* $('.etc_cost').text(etc_cost_sum); */ // 기타 처리된 항목은 소계만 계산되어서 나타남	

		/* 직접공사비 소계 */
		let direct_con_sum = m_cost_sum + p_cost_sum ;
		
		$('#direct_total_price').text(new Intl.NumberFormat().format(direct_con_sum));
		
		/* 개인 고객일 경우 고객사명 이름란을 비운다 */
		let customer_id = $('.customer_id').text();
		
		 if (customer_id.trim().length == 1){
			 $('.customer_id').text(""); 
		 } 
		
		/* save data */
		$("#move_edit").on("click", function(e) {
			let param = {
				partner_no : $(this).data("partner_no")
			}
			postPage("/code/partner/form", param);
		});

	
		let update_date = $(".update_date").text();
		let update_date2 = $(".update_date2").text();
		$(".update_date").text(update_date + " " + getInputDayLabel(update_date)); 
		$(".update_date2").text(update_date + " " + getInputDayLabel(update_date));
		
		/* 요일 구하기 */
		function getInputDayLabel(date) {
		    
		    var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');
		    
		    var today = new Date(date).getDay();
		    var todayLabel = week[today];
		    
		    return "("+todayLabel.substr(0,1)+")";
		}
		
		
		/* 프린트 출력 */
		$('#download_pdf').click(function() {
			  window.print();
		});	
	});
</script>