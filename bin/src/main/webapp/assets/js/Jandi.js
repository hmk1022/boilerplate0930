/* Jandi incomming webhook message utils script */


// 비용처리(결제완료 / 일부결제)
/*
	비용처리 요청서 #{상태값} (#{문서번호})
	
	#{요청자}님이 올린 비용처리 요청서가 #{상태값}되었습니다.
	
	[요청내역]
	- 요청일: #{요청일}
	- 작업정보: #{작업일련번호} (#{고객사명})
	- 사용일: #{사용일}
	- 비용집행내역: #{비용분류} / #{비용용도} / #{사용처}
	- 결제요청금액: #{결제대상금액}
	
	[처리내역]
	- 결제완료금액: #{결제완료금액}
	- 결제완료일: #{결제완료일}
	- 미결제금액: #{미결제금액} (다음 결제예정일: #{결제예정일})
	- 처리자: #{처리자명}


// 비용처리(반려)

	비용처리 요청서 반려 (#{문서번호})
	
	#{요청자}님이 올린 비용처리 요청서가 반려되었습니다. 
	아래 내용 확인 후 다시 등록해 주세요.
	⋇ 비용처리가 반려될 경우 실행가에서 제외됩니다. 
	
	[요청내역]
	- 요청일: #{요청일}
	- 작업정보: #{작업일련번호} (#{고객사명})
	- 사용일: #{사용일}
	- 비용집행내역: #{비용분류} / #{비용용도} / #{사용처}
	- 결제요청금액: #{결제대상금액}
	
	[처리내역]
	- 반려사유: #{반려사유카테고리} / #{반려상세사유}
	- 처리자: #{반려처리자}
*/


	var Jandi =  {
		INCOMMINT_TEAM_WEBHOOK_URL :'https://wh.jandi.com/connect-api/team-webhook/19457514/4220e8f10dbd5af50286ee61f4e637b2',
		/*
			지출결의서 반려 (#{문서번호})
		
			#{기안자}님이 올린 지출결의서가 반려되었습니다. 
			아래 내용 확인 후 다시 등록해 주세요.
		
			- 기안일: #{기안일}
			- 지출일: #{지출일}
			- 지출내역: #{지출비용성격} / #{지출비용용도} / #{지출금액} 원
			- 반려사유: #{반려사유카테고리} / #{반려상세사유}
			- 처리자: #{반려처리자}
		*/
	    sendWebHookDisb: function(param) {
			
			console.log("jandi param: ", param);
			
			if(param.disb_stat != '99'){
				return;
			}
			
			if(Utils.isEmpty(param.jandi_id)){
				alert('잔디 메신저ID가 존재하지 않습니다.');
				return;
			}

			let _send_email = param.jandi_id;	// 전송 jandi id.
			let _title = "";		// 타이틀.
			// title				
			if(Utils.isNotEmpty(param.disb_id)){
				_title += Utils.replace('지출결의서 반려 (#{문서번호})', '#{문서번호}', param.disb_id);
			}
			// description
			let _description = "";
			if(Utils.isNotEmpty(param.admin_name)){
				_description += Utils.replace('#{기안자}님이 올린 지출결의서가 반려되었습니다.\\n', '#{기안자}', param.admin_name);
			}
			_description += '아래 내용 확인 후 다시 등록해 주세요.\\n'
			if(Utils.isNotEmpty(param.create_date)){
				_description += Utils.replace('- 기안일: #{기안일} \\n', '#{기안일}', Utils.getDatetime(param.create_date));
			}				
			if(Utils.isNotEmpty(param.disb_date)){
				_description += Utils.replace('- 지출일: #{지출일} \\n', '#{지출일}', Utils.getDate(param.disb_date));
			}
			if(Utils.isNotEmpty(param.disb_type)){
				_description += '- 지출내역: #{지출비용성격} / #{지출비용용도} / #{지출금액} 원\\n';
				_description = Utils.replace(_description, '#{지출비용성격}', getCodeNm('disb_type', param.disb_type));
				_description = Utils.replace(_description, '#{지출비용용도}', getCodeNm('disb_usage', param.disb_usage));
				_description = Utils.replace(_description, '#{지출금액}', Utils.comma(param.disb_amt));
			}
			if(Utils.isNotEmpty(param.disb_reject)){
				_description += Utils.replace('- 반려사유: #{반려사유카테고리} ', '#{반려사유카테고리}', getCodeNm('disb_reject', param.disb_reject));
				if(Utils.isNotEmpty(param.reject_remark)){
					_description += Utils.replace('\\n- 반려상세사유: #{반려상세사유}', '#{반려상세사유}', param.reject_remark);
				}
			}
			if(Utils.isNotEmpty(param.confirm_admin_name)){
				_description += Utils.replace('\\n- 처리자: #{반려처리자}', '#{반려처리자}', param.confirm_admin_name);
			}

			// sending data
			let _data = '{' +  
			    '"email":"'+_send_email+'",' +
			    '"body":"※ 지출결의서가 반려 변경되었습니다.",' +
			    '"connectColor":"#FF0000",' +
			    '"connectInfo":[  ' +
			    '  {  ' +
			    '     "title":"'+_title+'",' +
			    '     "description":"'+_description+'"' +
			    //'     "description":"'+_description+'",' +
			    //'     "imageUrl":"http://www.jandi.com/image.jpg"' +
			    '  }' +
				']' +
			'}';
 
 			console.log('jandi message :', _data);
 			
			$.ajax({
			    url : Jandi.INCOMMINT_TEAM_WEBHOOK_URL,
			    method : 'POST',
			    data : _data,
			    accepts : "application/vnd.tosslab.jandi-v2+json",
			    contentType: "application/json; charset=utf-8",
			    success : function(data) {
			        console.log("return:", data.validEmails);
			        if((data.validEmails).indexOf(_send_email) > -1){
						alert(param.admin_name + '님에게 잔디 메세지가 발송됐습니다.');
					} else {
						alert(param.admin_name + '님에게 잔디 메세지가 발송되지 않았습니다.');
					}
			    },
			    error : function(e) {
			        console.log("error", e)
			        // return false;
			        alert('JANDI 메세지 송신중 오류가 발생했습니다.');
			    }
			});
	    },
		// 자재요청서
		/*
			자재요청서 상태 변경 → #{상태값} (#{문서번호})
		
			#{요청자}님이 올린 자재요청서의 상태가 #{상태값}(으)로 변경되었습니다.
			
			[요청내역]
			요청일: #{요청일}
			요청자재: #{자재명} 외 #{요청자재건수}건
			수령일시: #{수령일시}
			수령방법: #{수령방법}
			
			[처리내역]
			상태: #{상태값} (#{배송담당자})	//==> 상태가 배송예정일 경우에 한해서 "배송담당자" 표시.
			처리자: #{처리자명}
		*/
	    sendWebHookMaterial: function(param) {
			
			let _send_email = param.jandi_id;	// 전송 jandi id.
			
			console.log("jandi param: ", param);
			if(Utils.isEmpty(param.jandi_id)){
				alert('잔디 메신저ID가 존재하지 않습니다.');
				return;
			}
			
			// title	
			let _title = "";			
			_title = '자재요청서 상태 변경 → #{상태값} (#{문서번호})';
			_title = Utils.replace(_title, '#{상태값}', param.doc_stat_name);
			_title = Utils.replace(_title, '#{문서번호}', param.material_doc_id);
			
			// description
			let _description = "";
			
			_description = '#{요청자}님이 올린 자재요청서의 상태가 #{상태값}(으)로 변경되었습니다.' +
				'\\n\\n[요청내역]'+
				'\\n- 요청일: #{요청일}' +
				'\\n- 요청자재: #{자재명} ';
			// 자재 2건 이상인 경우.
			if(!Utils.isEmpty(param.material_cnt ) && param.material_cnt > 1) {
				_description += ' 외 #{요청자재건수}건';
			}

			_description += '\\n- 수령일시: #{수령일시}'+
				'\\n- 수령방법: #{수령방법}'+
				'\\n\\n[처리내역]'+
				'\\n- 상태: #{상태값}';
			
			// 배송담당자가 있는 경우.	
			if(!Utils.isEmpty(param.delivery_name )){
				_description += ' (#{배송담당자})';
			}
			_description += '\\n- 처리자: #{처리자명}';
			
			_description = Utils.replace(_description, '#{요청자}', param.create_name);
			_description = Utils.replace(_description, '#{상태값}', param.doc_stat_name);
			_description = Utils.replace(_description, '#{요청일}', param.create_str_date);
			_description = Utils.replace(_description, '#{자재명}', param.material_name);
			_description = Utils.replace(_description, '#{요청자재건수}', (param.material_cnt-1));
			
			if(!Utils.isEmpty(param.material_cnt ) && param.material_cnt > 1){
				_description = Utils.replace(_description, '#{요청자재건수}', (param.material_cnt-1));
			}
			
			_description = Utils.replace(_description, '#{수령일시}', param.use_date);
			_description = Utils.replace(_description, '#{수령방법}', param.receive_type);
			_description = Utils.replace(_description, '#{상태값}', param.doc_stat_name);
			
			if(!Utils.isEmpty(param.delivery_name )){ // 배송상태인 경우.
				_description = Utils.replace(_description, '#{배송담당자}', param.delivery_name);
			}
			
			_description = Utils.replace(_description, '#{처리자명}', param.confirm_admin_name);
			
			// sending data
			let _data = '{' +  
			    '"email":"'+_send_email+'",' +
			    '"body":"※ 자재요청서 상태가 변경되었습니다.",' +
			    '"connectColor":"#FAC11B",' +
			    '"connectInfo":[  ' +
			    '  {  ' +
			    '     "title":"'+_title+'",' +
			    '     "description":"'+_description+'"' +
			    //'     "imageUrl":"http://www.jandi.com/image.jpg"' +
			    '  }' +
				']' +
			'}';
 
 			console.log("data:", _data);
 			
 			let create_name = param.create_name;
 			
			$.ajax({
			    url : Jandi.INCOMMINT_TEAM_WEBHOOK_URL,
			    method : 'POST',
			    //data : JSON.stringify(_data),
			    data : _data,
			    accepts : "application/vnd.tosslab.jandi-v2+json",
			    contentType: "application/json; charset=utf-8",
			    success : function(data) {
			        console.log("return:", data.validEmails);
			        if((data.validEmails).indexOf(_send_email) > -1){
						alert(create_name + '님에게 잔디 메세지가 발송됐습니다.');
					} else {
						alert(create_name + '님에게 잔디 메세지가 발송되지 않았습니다.');
					}
			    },
			    error : function(e) {
			        console.log("error", e)
			        // return false;
			        alert('JANDI 메세지 송신중 오류가 발생했습니다.');
			    }
			});
	    },
	    // 비용처리(결제완료, 반려)
	    sendWebHookExp: function(param) {
			
			let _send_email = param.jandi_id;	// 전송 jandi id.
			console.log("jandi param: ", param);
			if(Utils.isEmpty(param.jandi_id)){
				alert('잔디 메신저ID가 존재하지 않습니다.');
				return;
			}
			
			let _title = "";
			// title
			_title = '비용처리 요청서 #{상태값} (#{문서번호})';
			_title = Utils.replace(_title, '#{상태값}', getCodeNm('exp_stat', param.exp_stat));
			_title = Utils.replace(_title, '#{문서번호}', param.exp_id);

			// description
			let _description = "";
			let _refuse = param.exp_stat==='99' ? true: false;
			_description = '#{요청자}님이 올린 비용처리 요청서가 #{상태값}되었습니다.' ;
			
			// 반련인 경우.
			if(_refuse){ 
				_description += '\\n아래 내용 확인 후 다시 등록해 주세요.';
				_description += '\\n⋇ 비용처리가 반려될 경우 실행가에서 제외됩니다.' ;
			}
			_description += '\\n\\n[요청내역]';
			_description += '\\n- 요청일: #{요청일}';
			if(!Utils.isEmpty(param.work_id)){
				_description += '\\n- 작업정보: #{작업일련번호} (#{고객사명})';
			}
			_description += '\\n- 사용일: #{사용일}';
			_description += '\\n- 비용집행내역: #{비용분류} / #{비용용도} / #{사용처}';
			_description += '\\n- 결제요청금액: #{결제대상금액}';
			_description += '\\n\\n[처리내역]';
			
			if(_refuse){ 
				_description += '\\n- 반려사유: #{반려사유카테고리} / #{반려상세사유}';
			}
			
			if(!_refuse){
				_description += '\\n- 결제완료금액: #{결제완료금액}';
				_description += '\\n- 결제완료일: #{결제완료일}';
				_description += '\\n- 미결제금액: #{미결제금액}';
			}
			
			if(param.exp_stat != '03' && !_refuse){
				_description += ' (다음 결제예정일: #{결제예정일})';
			}
			
			_description += '\\n- 처리자: #{처리자명}';
			
			_description = Utils.replace(_description, '#{요청자}', param.admin_name);
			_description = Utils.replace(_description, '#{상태값}', getCodeNm('exp_stat', param.exp_stat));
			_description = Utils.replace(_description, '#{요청일}', Utils.getDatetime(param.create_date));
			
			_description = Utils.replace(_description, '#{작업일련번호}', param.work_id);
			
			if(!Utils.isEmpty(param.branch_name)){
				_description = Utils.replace(_description, '#{고객사명}', param.customer_name+"/"+param.branch_name);
			}else{
				_description = Utils.replace(_description, '#{고객사명}', param.req_name);
			}
			_description = Utils.replace(_description, '#{사용일}', Utils.getDate(param.st_date));
			_description = Utils.replace(_description, '#{비용분류}', getCodeNm('exp_type', param.exp_type));
			_description = Utils.replace(_description, '#{비용용도}', param.exp_usage);
			
			let _name = "";
			if(param.exp_type == '01'||param.exp_type == '02'){
				_name = param.partner_name;
			}
			else if(param.exp_type == '03'){
				_name = param.vendor_name;
			}
			else if(param.exp_type == '04'){
				_name = param.exp_target;
			}
			_description = Utils.replace(_description, '#{사용처}', _name);
			_description = Utils.replace(_description, '#{결제대상금액}', Utils.comma(param.pay_req_amt));
			if(_refuse){ 
				_description = Utils.replace(_description, '#{반려사유카테고리}', getCodeNm('exp_reject', param.exp_reject));
				_description = Utils.replace(_description, '#{반려상세사유}', !Utils.isEmpty(param.remarks) ? param.remarks:'');
			}
			
			if(!_refuse){ 
				_description = Utils.replace(_description, '#{결제완료금액}', Utils.comma(param.paid_amt));
				_description = Utils.replace(_description, '#{결제완료일}', Utils.getDate(param.paid_date));
				_description = Utils.replace(_description, '#{미결제금액}', Utils.comma(param.unsett_amt));
			}
				
			_description = Utils.replace(_description, '#{결제예정일}', Utils.getDate(param.pay_req_date));
			
			if(_refuse){ 
				_description = Utils.replace(_description, '#{처리자명}', param.refuse_admin_name);
			}else{
				_description = Utils.replace(_description, '#{처리자명}', param.confirm_admin_name);
			}
			
			let _connectColor = "#FAC11B";
			if(_refuse){ 
				_connectColor = "#FF0000";
			} 
			// sending data
			let _data = '{' +  
			    '"email":"'+_send_email+'",' +
			    '"body":"※ 비용처리 상태가 변경되었습니다.",' +
			    '"connectColor":"'+ _connectColor +'",' +
			    '"connectInfo":[  ' +
			    '  {  ' +
			    '     "title":"'+_title+'",' +
			    '     "description":"'+_description+'"' +
			    //'     "imageUrl":"http://www.jandi.com/image.jpg"' +
			    '  }' +
				']' +
			'}';
 
			$.ajax({
			    url : Jandi.INCOMMINT_TEAM_WEBHOOK_URL,
			    method : 'POST',
			    //data : JSON.stringify(_data),
			    data : _data,
			    accepts : "application/vnd.tosslab.jandi-v2+json",
			    contentType: "application/json; charset=utf-8",
			    success : function(data) {
			        console.log("return:", data);
			        if((data.validEmails).indexOf(_send_email) > -1){
						alert(param.admin_name + '님에게 잔디 메세지가 발송되었습니다.');
					} else {
						alert(param.admin_name + '님에게 잔디 메세지가 발송되지 않았습니다.');
					}
			    },
			    error : function(e) {
			        console.log("error", e)
			        // return false;
			        alert('JANDI 메세지 송신중 오류가 발생했습니다.');
			    }
			});
	    },
	    
	}
