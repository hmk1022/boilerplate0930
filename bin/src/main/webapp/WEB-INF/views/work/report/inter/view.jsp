<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

<!-- ================== BEGIN PAGE LEVEL HTML ================== -->
<html>
	<head>
	<link href="./assets/css/workman_admin.css" rel="stylesheet">
		<style>
			body {
				overflow-x: hidden;
			}
			/* pdf 출력 */
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
<table style="display: block; width: 980px;height: 0 !important; opacity: 0;">
    <tbody>
        <tr>
            <td>1</td>
        </tr>
    </tbody>
</table>
<!-- 프린트용 table end -->
<body class="bg-white ">
    <div class="card print-a4">
        <div class="coverTitle complete"><span>완료보고서<span class="small">내부 보고용</span></span></div>
                <c:choose>
					<c:when test="${!empty excutePriceDailyList }">
						<c:forEach var="expenseData" items="${excutePriceDailyList }" varStatus="cnt">
							<c:set var="total_price" value="${total_price+expenseData.total_price }" />
								<c:set var="total_price_01" value="${total_price_01+expenseData.total_price_01 }" />
								<c:set var="total_price_02" value="${total_price_02+expenseData.total_price_02 }" />
								<c:set var="total_price_03" value="${total_price_03+expenseData.total_price_03 }" />
								<c:set var="total_price_04" value="${total_price_04+expenseData.total_price_04 }" />
						</c:forEach>
					</c:when>
				</c:choose>
			${total_price}
	        <div class="coverContent complete">
	            <h3 class="border-bottom-2 pb-3 mb-5" style="border-bottom: 2px solid #000 !important"><span class="small me-3">${data.work_id}</span>${data.location_name}</h3>
	            <table class="table cover">
	                <colgroup>
	                    <col width="50%">
	                    <col width="50%">
	                </colgroup>
	                <thead>
	                    <tr>
	                        <th>고객(사)명</th>
	                        <th>현장주소</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <tr>
	                        <td class="cust_name">
	                        	<span class="customer">${data.customer_name} ${data.branch_name}</span> / ${data.manager_name} 매니저</td>
	                        <td>${data.work_addr1} ${data.work_addr2}</td>          
	                    </tr>
	                </tbody>
	            </table>
	            <table class="table cover">
	                <colgroup>
	                    <col width="25%">
	                    <col width="25%">
	                    <col width="25%">
	                    <col width="25%">
	                </colgroup>
	                <thead>
	                    <tr>
	                        <th>공사기간</th>
	                        <th>공무</th>
	                        <th>감리</th>
	                        <th>워커맨</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <tr>
	                        <td>2021-04-16 ~ 2021-04-25</td>
	                        <td>${data.manager_admin_name}</td>
	                        <td>${data.supervisor_admin_name }</td>
	                        <td>${data.workerman_admin_name }</td>
	                    </tr>
	                </tbody>
	            </table>
	            <h2 class="mt-5 mb-4 fw-bolder">집행 비용 및 매출 이익 요약</h2>
	            <table class="table cover">
	                <colgroup>
	                    <col width="15%">
	                    <col width="17%">
	                    <col width="17%">
	                    <col width="17%">
	                    <col width="17%">
	                    <col width="17%">
	                </colgroup>
	                <thead>
	                    <tr>
	                        <th>구분</th>
	                        <th>견적금액</th>
	                        <th>실행예상액</th>
	                        <th>예상 매출 이익</th>
	                        <th>실 집행 비용</th>
	                        <th>매출 이익</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <tr>
	                        <td>인건비</td>
	                        <td class="text-end total_p"></td> 
	                        <td class="text-end total_p_est"></td>
	                        <td class="text-end total_p_profit"> </td>
	                        <td class="text-end real_p_est">${total_price_01}</td>
	                        <td class="text-end total_p_profit2"></td>
	                    </tr>
	                    <tr>
	                        <td>외주업체비용</td>
	                        <td class="text-end">-</td>
	                        <td class="text-end">-</td>
	                        <td class="text-end">-</td>
	                        <td class="text-end os_price ">${total_price_02}</td>
	                        <td class="text-end os_total"></td>
	                    </tr>
	                    <tr>
	                        <td>자재비</td>
	                        <td class="text-end total_m"></td>
	                        <td class="text-end total_m_est"></td>
	                        <td class="text-end total_m_profit" ></td>
	                        <td class="text-end real_m_est">${total_price_03}</td>
	                        <td class="text-end total_m_profit2"></td>
	                    </tr>
	                    <tr>
	                        <td>공과잡비</td>
	                        <td class="text-end total_job">-</td>
	                        <td class="text-end total_job_est">-</td>
	                        <td class="text-end total_job_profit"></td>
	                        <td class="text-end real_job_est">${total_price_04 }</td>
	                        <td class="text-end total_job_profit2"><span class="text-primary ms-2"></span></td>
	                    </tr>
	                     <tr>
	                        <td>기타</td>
	                        <td class="text-end total_exp">${exp_price.exp_price }</td>
	                        <td class="text-end ">-</td>
	                        <td class="text-end ">-</td>
	                        <td class="text-end ">-</td>
	                        <!-- ${exp_price.est_exp_price } -->
	                        <td class="text-end exp_total"><span class="text-primary ms-2"></span></td>
	                    </tr>
	                    <tr>
	                        <td>합계</td>
	                        <td class="text-end fw-bold total_e">${estimate_total.price}</td>
	                        <td class="text-end fw-bold pay_price"></td>
	                        <td class="text-end fw-bold e_profit"></td>
	                        <!--  -->
	                        <td class="text-end fw-bold total_pay_price"></td>
	                        <td class="text-end fw-bold bg-light total_profit"></td>
	                    </tr>
	                </tbody>
	            </table>
	         </div>
         </div>   
         
         <div class="card">	   
         	<div class="coverContent">
	            <h2 class="mt-5 mb-4 fw-bolder">공정 일자별 자금 집행 요약</h2>
		            <table class="table cover">
		                <colgroup>
		                    <col width="20%">
		                    <col width="20%">
		                    <col width="10%">
		                    <col width="10%">
		                    <col width="10%">
		                    <col width="10%">
		                    <col width="10%">
		                    <col width="10%">
		                </colgroup>
		                <thead>
		                    <tr>
		                        <th>작업일</th>
		                        <th>공사요약</th>
		                        <th>인건비</th>
		                        <th>외주업체비</th>
		                        <th>자재비</th>
		                        <th>공과잡비</th>
		                        <th>합계</th>
		                        <th>잔액</th>
		                    </tr>
		                </thead>
		                <tbody>
		                	<%-- <h3>${excutePriceDailyList}</h3> --%>
		                	<!-- excutePriceDailyList에 resource_type 추가 -->
		                	<c:set var="remainAmount" value="${estimateData.total_unit_price}" /> 
		                	<c:choose>              
		                		<c:when test="${!empty excutePriceDailyList }"> 
				                	<c:forEach var="price" items="${excutePriceDailyList}">
				                		<c:set var="remainAmount" value="${remainAmount-price.total_price }" />
						                    <tr>
						                        <td>
						                      		<tags:str-date value ="${price.st_date_ymd}" hasDayOfWeek="true"/>
						                        </td>
						                        <td>${price.location_name }</td>
						                        <td class="text-end">
						                        	<tags:code-currency value="${price.total_price_01}"/>
						                        </td>
						                        <td class="text-end">
						                        	<tags:code-currency value="${price.total_price_02}"/>	
						                        </td>
						                        <td class="text-end">
						                        	<tags:code-currency value="${price.total_price_03}"/>	
						                        </td>
						                        <td class="text-end">
						                        	<tags:code-currency value="${price.total_price_04}"/>
						                        </td>
						                        <td class="text-end text-success">
						                        	<tags:code-currency value="${price.total_price}"/>
						                        </td>
						                        <td class="text-end">
						                        	<tags:code-currency value="${remainAmount}" />
						                        </td>
						                    </tr>   
				                    </c:forEach>
			                	</c:when>
				                	<c:otherwise>
										<div class="border p-2 rounded my-3 bg-default">일정이 존재 하지않습니다.</div>
									</c:otherwise>
			                </c:choose>	         
		                </tbody>
		            </table>
		             <table class="table cover">
		                <thead>
		                    <tr>
		                        <th>특이사항</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr>
		                        <td class="py-4">
		                       	    <textarea 
		                       	    class="textarea"
		                       	    style="background-color:white !important; width:100%; border:none;
		                       	    resize: none " 
		                       	  	disabled
		                       	    >${exp_memo.report_memo}</textarea>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>													
		         <%--    
		            <h2 class="mt-5 mb-4 fw-bolder">특이사항</h2>
		            <div class="border-top border-bottom bodyfont py-4">
		                ${exp_memo.report_memo}
		            </div> --%>
		          	
		                 <ul class="pdf-list top">
			                <li class="top">
			                    <a href="#">첨부서류
			                        <span>1. 일일 작업일보<br>2. 업체별 견적서</span>
			                    </a>
			                </li>
			            </ul>
		            <div class="d-flex align-items-end flex-column mt-5">
		                <h5 class="text-end">위와 같이 모든 작업이 완료되었음을 보고합니다. <span class="d-block fw-normal text-muted mt-2 update_date">${exp_memo.update_date}</span></h5>
		            </div>
	            <div class="req_name">${data.req_name }</div>
            </div>
        </div>
</body>
</html>


<!-- ================== END PAGE LEVEL HTML ================== -->

<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<!-- ================== END PAGE LEVEL JS ================== -->

<script>
	/* init page */	
	$(function() {
		console.log('확인',$('.real_p_est').text());
		/* 개인 고객일 경우 고객사 명과 직책 대신 req_name을 넣는다*/
		$('.req_name').css('display','none')
				
		let customer = $('.customer').text();
		
		if(!customer.trim()){
			$('.cust_name').text($('.req_name').text());
		}
		/* 전체 견적금액 */
		let total_estm = $('.total_estm').text();

		let total_est_num = total_estm.replace(".","").replace("E7","0000");
		$('.total_estm').text(new Intl.NumberFormat().format(total_est_num));
		
		
		/* 집행 비용 및 매출 이익 요약 */
		let summaryData = '${payList}'
		let payList = JSON.parse(summaryData)
			
		console.log('payList',payList);
		
		let total_m = 0; // 자재비 총합
		let total_p = 0; // 인건비 총합
		let total_job = 0; // 공과잡비 총합 
		
		/* 실행예상 금액 */
		let total_m_est = 0;
		let total_p_est = 0;
		//let total_p_est = $('.total_p_est').val;
		let total_job_est = 0;
		
		for(let i = 0; i < payList.length; i++){
			if(payList[i].resource_type == '01') {			
				total_m += payList[i].price;
				total_m_est += payList[i].est_price;
			} else if (payList[i].resource_type =='02'){			
				total_p += payList[i].price;
				total_p_est += payList[i].est_price;
			} else if (payList[i].resource_type == '03'){
				total_job += payList[i].price;
				total_job_est += payList[i].est_price;
			} else {
				
			}
		};
		
		/* 실행가 총합 */	
		let exc_price_total = '${total_price}' ;
		//let exc_price_total = '${totalexcutePrice}' ;
		console.log('exc_price_total',exc_price_total)
	
		$('.total_pay_price').text(new Intl.NumberFormat().format(exc_price_total));
		
		/*  */
		
		let = $('.total_p').text(new Intl.NumberFormat().format(total_p)); 
		let = $('.total_m').text(new Intl.NumberFormat().format(total_m));
		let = $('.total_job').text(new Intl.NumberFormat().format(total_job));
		
		/* 실행예상 금액 */
		let = $('.total_p_est').text(new Intl.NumberFormat().format(total_p_est)); 
		let = $('.total_m_est').text(new Intl.NumberFormat().format(total_m_est));
		let = $('.total_job_est').text(new Intl.NumberFormat().format(total_job_est));
		
		/* 매출이익 견적 - 실행가 */
		let total_p_profit = new Intl.NumberFormat().format(total_p-total_p_est);
		let total_m_profit = new Intl.NumberFormat().format(total_m-total_m_est);
		let total_job_profit = new Intl.NumberFormat().format(total_job - total_job_est);
		
		console.log('이게 왜 마이너스?',total_job - total_job_est);
		/* let = $('.total_p_profit').text(total_p_profit); */ 
		/* $('.total_m_profit').text(total_m_profie);  */
		/* $('.total_job_profit').text(total_job_profit);  */
		
		
		/* 합계 */
		let est_price = total_p+total_m+total_job;
		let pay_price = total_p_est+total_m_est+total_job_est;
		$('.est_price').text(new Intl.NumberFormat().format(est_price)); //견적금액 합계
		$('.pay_price').text(new Intl.NumberFormat().format(pay_price));
				
		
		/* 비용과 퍼센트를 같이 html로 넣어주기 */
		
		/* 인건비 */
		let real_p_est =  $('.real_p_est').text(); // 실제 집행비용
		
		let p_sales = (total_p-total_p_est)/total_p*100;
		let p_sales2 = isNaN((total_p-real_p_est)/total_p*100) ? 0 : (total_p-real_p_est)/total_p*100 ;
		
		console.log('p_sales2',total_p-real_p_est, total_p*100);
		let p_real_pf = p_sales2 > 0 ? String(p_sales2).substr(0,4)+"%" :  String(p_sales2).substr(0,5)+"%";
		
		if(total_p === 0 && real_p_est > 0 ){
			p_real_pf = "100% "
		}
		
		let p_sales_str
		
		/* 0%인 경우 표시하지 않는다 */
		if(isNaN(String(p_sales).substr(0,4))){
			p_sales_str = '';
		} else if (p_sales < 0) {
			p_sales_str = String(p_sales).substr(0,5)+"%";
		} else {
			p_sales_str = String(p_sales).substr(0,4)+"%";
		}
		//console.log('real',$('.real_p_est').val());
		
		let pInsTag = "<span class="+"+text-muted ms-2"+">"+new Intl.NumberFormat().format(total_p-total_p_est)+"&nbsp"
		+ "<span class="+"text-muted ms-2"+">"+p_sales_str+"</span>"
		
		// 실제 매출이익
		let pinsTag2
		if(total_p-real_p_est > 0 ){
			pinsTag2 = "<span class="+"+text-muted ms-2"+">"+new Intl.NumberFormat().format(total_p - real_p_est)+"&nbsp"
			+ "<span class="+"text-danger ms-2"+">"+p_real_pf+"</span>" // 총견적 - 실집행 퍼센트 계산
		} else {
			pinsTag2 = "<span class="+"+text-muted ms-2"+">"+new Intl.NumberFormat().format(total_p - real_p_est)+"&nbsp"
			+ "<span style="+"color:#348fe2 "+" class="+"ms-2"+">"+p_real_pf+"</span>" // 총견적 - 실집행 퍼센트 계산
		}
		
		 		
		$('.total_p_profit').append(pInsTag);
		$('.total_p_profit2').append(pinsTag2);
		
		/* 외주업체 비용  */
		console.log('외주asdsad업체',$('.os_price').text());
		let osTag
		
		if ($('.os_price').text() == 0.0) {
			$('.os_price').text(new Intl.NumberFormat().format($('.os_price').text()));
			
			osTag = 0;
			
			$('.os_total').append(osTag);
			
		} else if(!isNaN($('.os_price').text())){
			//let os_price = parseInt($('.os_price').text().replace("E7", "").replace(".",""));
			
			$('.os_price').text(new Intl.NumberFormat().format($('.os_price').text())); // total 실집행 비용
			
			
			osTag = "<span class="+"+text-muted ms-2"+">"+$('.os_price').text() +"&nbsp"
			+ "<span style="+"color:#348fe2 "+" class="+"ms-2"+">"+"-100% "+"</span>"
			
			$('.os_total').append(osTag);
		} else {
			$('.os_price').text('-');
		}  
		
		
		/* 자재비 */

		let real_m_est =  $('.real_m_est').text();
		//let p_sales = (total_p-total_p_est)/total_p*100;
		let m_sales = (total_m-total_m_est)/total_m*100;
		let m_sales2 = (total_m-real_m_est)/real_m_est*100;
		let m_sales_str
		
		console.log('m_sales',m_sales);
		
		let m_profit_per = (total_m-real_m_est)/real_m_est*100 > 0 ? (total_m-real_m_est)/total_m*100 : 0;
		let m_real_pf = String(m_profit_per).substr(0,4)+"%";
		
		console.log('자재비', (total_m-real_m_est)/total_m*100 , m_sales2)
		
		/* 0%인 경우 표시하지 않는다 */
		if(isNaN(String(m_sales).substr(0,4))){
			m_sales = 0;
		} else if ( m_sales2 < 0) {
			m_sales = String(m_sales).substr(0,5)+"%";
		} else {
			m_sales = String(m_sales).substr(0,4)+"%";
		}
		
		/* 0%인 경우 표시하지 않는다 */
		if(isNaN(String(m_sales2).substr(0,4))){
			m_sales_str = '';
		} else if ( m_sales2 < 0) {
			m_sales_str = String(m_sales2).substr(0,5)+"%";
		} else {
			m_sales_str = String(m_sales2).substr(0,4)+"%";
		}
		
		let mInsTag = "<span class="+"+text-muted ms-2"+">"+new Intl.NumberFormat().format(total_m-total_m_est)+"&nbsp"
		+ "<span class="+"text-muted ms-2"+">"+m_sales+"</span>"
		
		let minsTag2 
		if( total_m-real_m_est > 0){
			minsTag2 = "<span class="+"+text-muted ms-2"+">"+new Intl.NumberFormat().format(total_m - $('.real_m_est').text())+"&nbsp"
			+ "<span class="+"text-danger ms-2"+">"+" "+m_real_pf+"</span>"
		} else {
			minsTag2 = "<span class="+"+text-muted ms-2"+">"+new Intl.NumberFormat().format(total_m - $('.real_m_est').text())+"&nbsp"
			+ "<span style="+"color:#348fe2 "+" class="+"ms-2"+">"+m_sales_str+"</span>"
		}
		
		
		$('.total_m_profit').append(mInsTag);
		$('.total_m_profit2').append(minsTag2);
		
		
		/* 공과잡비 */
		let real_job_est =  $('.real_job_est').text(); // 실 집행 비용
	
		//let j_sales = isNaN((total_job-total_job_est)/total_job*100) ? 0 : (total_job-total_job_est)/total_job*100 ;
		let j_sales = (total_job-total_job_est)/total_job_est*100;
		let j_sales_str 
		
		let job_profit_per = (total_job - real_job_est)/real_job_est*100;
		let job_real_pf = job_profit_per > 0 ? String(job_profit_per).substr(0,4)+"%" : String(job_profit_per).substr(0,5)+"%";
		
		/* 실집행비용이 0 이고 견적금액이 있는경우는 100% */
		if(real_job_est == 0 && total_job > 0) {
			job_real_pf = "100%";
		};
		
		
		/* 0%인 경우 표시하지 않는다 */
		if(isNaN(String(j_sales).substr(0,4))){
			j_sales_str = '';
		} else {
			j_sales_str = String(j_sales).substr(0,4)+"%";
		};
		
	
		//let p_sales2 = isNaN((total_p-real_p_est)/total_p*100) ? 0 : (total_p-real_p_est)/total_p*100 ;
		
		let jInsTag = "<span class="+"+text-muted ms-2"+">"+new Intl.NumberFormat().format(total_job-total_job_est)+"&nbsp"
		+ "<span class="+"text-muted ms-2"+">"+j_sales_str+"</span>"
		
		
		let jInsTag2;
		console.log('asd',total_job - $('.real_job_est').text());
		if((total_job-$('.real_job_est').text()) > 0){
			console.log('공과잡비on')
			jInsTag2 = "<span class="+"+text-muted ms-2"+">"+new Intl.NumberFormat().format(total_job - $('.real_job_est').text())+"&nbsp"
			+ "<span class="+"text-danger ms-2"+">"+job_real_pf+"</span>"
		} else if ((total_job-$('.real_job_est').text()) == 0){
			jInsTag2 = "<span class="+"+text-muted ms-2"+">"+"0"+"</span>"
		} else {
			jInsTag2 = "<span class="+"+text-muted ms-2"+">"+new Intl.NumberFormat().format(total_job - $('.real_job_est').text())+"&nbsp"
			+ "<span style="+"color:#348fe2 "+" class="+" ms-2"+">"+ job_real_pf +"</span>"
		}

		
		$('.total_job_profit').append(jInsTag);
		$('.total_job_profit2').append(jInsTag2);
		
		/* 기타금액 매출이익 */
		
		let expInsTag = "<span class="+"+text-muted ms-2"+">"+new Intl.NumberFormat().format('${exp_price.exp_price }')+"&nbsp&nbsp"
		+ "<span class="+"text-danger ms-2"+">"+"100%"+"</span>"
		
		if ('${exp_price.exp_price }' == 0){
			expInsTag = "<span class="+"+text-muted ms-2"+">"+"0"+"</span>"
		} 
		$('.exp_total').append(expInsTag)
		
		
		/* 합계 */
		
		
		/* 매출이익 총합 */

		let est_total = '${estimate_total.price}'.replace(/,/gi,"");
		
		let total_profit = est_total - exc_price_total; 
	
		
		let t_sales = (est_price-pay_price)/est_price*100;
		let t_sales_str;
		
		let real_profit_per = (est_total - exc_price_total)/exc_price_total*100;
		console.log('real_profit_per ',real_profit_per);
		let total_real_pf = real_profit_per > 0 ? String(real_profit_per).substr(0,4)+"%" : String(real_profit_per).substr(0,5)+"%";
		
		
		/* 0%인 경우 표시하지 않는다 */
		if(isNaN(String(t_sales).substr(0,4))){
			t_sales_str = '';
		} else {
			t_sales_str = String(t_sales).substr(0,4)+"%";
		}
		
		
		let tInsTag = "<span class="+"+text-muted ms-2"+">"+new Intl.NumberFormat().format((total_p-total_p_est)+(total_m-total_m_est)+(total_job -total_job_est))+"&nbsp"
		+ "<span class="+"text-muted ms-2"+">"+t_sales_str+"</span>"
		
		let tInsTag2 = real_profit_per > 0 ?  
				 "<span class="+"+text-muted ms-2"+">"+ new Intl.NumberFormat().format(total_profit) +"&nbsp"
				+ "<span class="+"text-danger ms-2"+">"+total_real_pf+"</span>"
				:"<span class="+"+text-muted ms-2"+">"+ new Intl.NumberFormat().format(total_profit) +"&nbsp"
				+ "<span style="+"color:#348fe2 "+" class="+" ms-2"+">"+  total_real_pf+"</span>" 
		
		$('.e_profit').append(tInsTag);
		$('.total_profit').append(tInsTag2);	
		
		
		/* comma 처리  */
		$('.real_p_est').text(new Intl.NumberFormat().format($('.real_p_est').text()));
		$('.real_m_est').text(new Intl.NumberFormat().format($('.real_m_est').text()));
		$('.real_job_est').text(new Intl.NumberFormat().format($('.real_job_est').text()));
		$('.total_exp').text(new Intl.NumberFormat().format($('.total_exp').text()));
		
		
		/* yyyy월 mm월 dd일 형식 */
		var update_date = $('.update_date').text().substr(0,10);
		
		let day_arr = update_date.split('-')	
		
		let day_format = day_arr[0]+'년' + ' '+ day_arr[1]+'월' + day_arr[2]+'일';
			
		 $('.update_date').text(day_format);
		
		 $('#download_pdf').click(function() {
			  window.print();
		});	
		 
		function adjustHeight() {
			  var textEle = $('textarea');
			  textEle[0].style.height = 'auto';
			  var textEleHeight = textEle.prop('scrollHeight');
			  textEle.css('height', textEleHeight);
			};

		adjustHeight(); // 함수를 실행하면 자동으로 textarea의 높이 조절 
	});
	

</script>