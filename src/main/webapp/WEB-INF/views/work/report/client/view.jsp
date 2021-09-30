<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/commons/taglibs.jsp"%>

<html>
	<head>
	<link href="./assets/css/workman_admin.css" rel="stylesheet">
	<link href="./assets/css/cover.css" rel="stylesheet">
		<style>
			body {
				overflow-x: hidden;
			}
			/* pdf 출력 */
			#download_pdf{
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
			   	.coverLogo {
			   		background-size: 250px auto;
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
        <div class="coverTitle complete"><span>완료보고서</span><span class="rightSmall">Completion Report</span></div>
        <div class="coverContent">
            <div class="row align-items-end justify-content-between mb-5">
                <div class="col-4">
                    <h1 class="border-bottom-2 pb-3 mb-5" style="border-bottom: 2px solid #000 !important">${clientReport.customer_name }<span class="small ms-3">귀하</span></h1>
                    <h3>${data.customer_name} ${data.branch_name }</h3>
                    <h4 class="fw-normal">${data.work_addr1} ${data.work_addr2 }</h4>
                </div>
                <div class="col-4">
                    <ul class="estimate">
                        <li>문서번호</li>
                        <li>#${data.work_no}</li>
                        <li>작성일자</li>
                        <li>${clientReport.create_day}(${clientReport.day_of_week })</li>
                        <li>작성자</li>
                        <li>${data.manager_admin_name }</li>
                    </ul>
                </div>
            </div>
            <h3 class="border-bottom-2 pb-3 mb-5" style="border-bottom: 2px solid #000 !important">${clientReport.report_name }</h3>
            <table class="table cover">
                <thead>
                    <tr>
                        <th>공사기간</th>
                        <th>현장 책임자</th>
                        <th>시공 담당자</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${data.st_working_date} ~ ${data.ed_working_date }</td>
                        <td>${clientReport.supervisor_admin_no }</td>
                        <td>${clientReport.workerman_admin_name }</td>
                    </tr>
                </tbody>
            </table>
            <table class="table cover">
                <thead>
                    <tr>
                        <th>공사 내역</th>
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
                       	    >${clientReport.report_memo}</textarea>
                        </td>
                    </tr>
                </tbody>
            </table>
              <ul class="pdf-list">
                <li><a href="#">공사 현장의 전/후 사진 첨부 (다음 장)</a></li>
            </ul>
            <div class="d-flex align-items-center flex-column mt-5">
                <h5 class="text-center">위와 같이 모든 작업이 완료되었음을 보고합니다.
                	<div class="d-block fw-normal text-muted mt-2 update_date">${clientReport.update_date}</div>
                </h5>
                <div class="stamp">
                    <h5>주식회사 워커맨</h5>
                </div>    
            </div>
            <div class="row justify-content-end mt-2">
                <div class="col-4">
                    <div class="coverLogo"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- 현장 사진 -->
    <div class="card">
        <div class="coverTitle detail"><span>사진 자료</span><span class="rightSmall">#${data.work_no}<br>${clientReport.create_day}(${clientReport.day_of_week })</span></div>
        <div class="coverContent">
            <h3 class="border-bottom-2 pb-3 mb-3" style="border-bottom: 2px solid #000 !important">공사 전</h3>
            <ul class="pic mb-5 before">
            </ul>
            	<h3 class="border-bottom-2 pb-3 mb-3" style="border-bottom: 2px solid #000 !important">공사 중</h3>
            <ul class="pic mb-5 ing">          
            </ul>
           	 	<h3 class="border-bottom-2 pb-3 mb-3" style="border-bottom: 2px solid #000 !important">공사 후</h3>
            <ul class="pic mb-5 after">
            </ul>
        </div>
    </div>
</body>
</html>
<script>
	/* init page */	
	$(function() { 
		let data = '${reportImg}' 
		let parseData = JSON.parse(data);
		console.log('parseData',parseData);
		
		let insTag
		
		for (let i = 0; i < parseData.length; i++){
			if(parseData[i].img_type === 'IMG_TYPE_REPORT_BEFORE'){
				insTag =  "<li><img src='" + parseData[i].img_url + "'></li>"
				$('.before').append(insTag);
			} else if (parseData[i].img_type === 'IMG_TYPE_REPORT_ING') {
				insTag =  "<li><img src='" + parseData[i].img_url + "'></li>"
				$('.ing').append(insTag);
			} else if (parseData[i].img_type === 'IMG_TYPE_REPORT_AFTER') {
				insTag =  "<li><img src='" + parseData[i].img_url + "'></li>"
				$('.after').append(insTag);
			};
		};  
		
		/* yyyy월 mm월 dd일 형식 */
		var update_date = $('.update_date').text().substr(0,10);
		
		let day_arr = update_date.split('-');	
		
		let day_format = day_arr[0]+'년' + ' '+ parseInt(day_arr[1])+'월' + ' ' +  parseInt(day_arr[2])+'일';
			
		$('.update_date').text(day_format);
		
		$('#download_pdf').click(function() {
			  window.print();
		});		 
		
		/*  text-area rows 자동조종 */
		function adjustHeight() {
			  var textEle = $('textarea');
			  textEle[0].style.height = 'auto';
			  var textEleHeight = textEle.prop('scrollHeight');
			  textEle.css('height', textEleHeight);
			};

		adjustHeight(); // 함수를 실행하면 자동으로 textarea의 높이 조절
	});
</script>
















