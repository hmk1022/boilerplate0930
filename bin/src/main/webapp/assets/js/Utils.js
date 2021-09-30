	/* common utils script */
	var Utils =  {
		// is not empty
	    isNotEmpty: function(param) {
	      if(typeof param === "object"){
	        if(param == undefined || param == "" || param == null || param.length == 0){
	          return false;
	        }
	        else {
	          return true;
	        }
	      }
	      else {
	        if(param == undefined || param == "" || param == null){
	          return false;
	        }
	        else {
	          return true;
	        }
	      }
	    },
	    // is empty
	    isEmpty: function(param) {

	    	if(param == undefined || param == null){
		        return true;
		    }

	    	if(typeof param === "object"){
		        if(param == undefined || param == "" || param == null || param.length == 0){
		          return true;
		        }
		        else {
		          return false;
		        }
	      	}
	      	else {
	        	if(param == undefined || param == "" || param == null){
	          		return true;
	        	}
	        	else {
	          		return false;
	        	}
	      	}
	    },
	    // get param
		getParamByName: function(name, uri) {
			uri = uri || window.location.href;
	      	name = name.replace(/[\[\]]/g, "\\$&");
	      	var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),results = regex.exec(uri);
	      	if (!results) return null;
	      	if (!results[2]) return "";
	      	return decodeURIComponent(results[2].replace(/\+/g, " "));
	    },
	    // replace all
	    replace: function(str, trg, chg){
	    	if(str == 'undefined'||str == undefined||str == null) return '';
	    	str = str+"";
	    	return str.split(trg).join(chg);
	    },
	    // remove all
	    remove: function(str, trg){
	    	if(str == 'undefined'||str == undefined||str == null) return '';
	    	str = str+"";
	    	return str.split(trg).join('');
	    },
	    // remove comma
	    rmComma: function(str){
	    	if(str == 'undefined'||str == undefined||str == null) return '';
	    	str = str+"";
	    	return str.split(',').join('');
	    },
	    // round
	    round: function (num, st) {
			if(Utils.isEmpty(st)) return num;
			let e1 = "e+0";
			let e2 = "e-0";
			if(!Utils.isEmpty(st)) {
				e1 = "e+"+st;
				e2 = "e-"+st;
			}
		    return +(Math.round(num + e1)  + e2);
		},
	    // call ajax
		requestAjax: function(desc, url, param, callback, asyncYn) {

			var that = this, url;
			var returnData;	// only async false return value

			console.log("★★★★★★★★★★★★★★★★★★ call ajax ★★★★★★★★★★★★★★★★★★");
			console.log("★ desc :", desc);
			console.log("★ url :", url);
			console.log("★ param :", param);
			console.log("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");

		  	$.ajax({
		    	type: "POST",
		    	//dataType: "json",
		    	data: JSON.stringify(param),
		    	contentType: "application/json",
		    	async : asyncYn==undefined || asyncYn == null ? true:asyncYn,
		    	timeout: 3 * 60 * 1000,
		    	url: url,
		    	//xhrFields:{withCredentials: true},
		    	beforeSend : function(xhr){
					$("#content-loader-id").show();
		    		xhr.setRequestHeader("Authorization", getAuthToken());
		      		callback && callback.beforeSend && callback.beforeSend();
		    	},
		    	success: function(response) {
		      		//console.log("suc!!", response);
		      		//console.log(JSON.stringify(response))
			      	returnData = response;
					//console.log("request success", returnData['CATEGORY'].length);
			      	//if(response.ResponseCode && response.ResponseCode.code == 104){}
			      	callback && callback.success && callback.success(response);
		   	 	},
			    error: function(request, status, error) {
					$("#content-loader-id").hide();
					console.log("error",JSON.stringify(error));
					console.log("error",request.status);
					console.log("error",request.responseText);

			      	//callback && callback.error && callback.error();
			      	alert(desc + ' 실행중에 에러가 발생했습니다.\n관리자에게 문의하세요.');
			    },
			    complete: function(response) {
					$("#content-loader-id").hide();
			      	callback && callback.complete && callback.complete();
			    }
		  	});
		  	return returnData;
		},
	    // call multipart ajax
		requestMultiAjax: function(desc, url, formname, callback) {

			var that = this, url;
			var returnData;	// only async false return value

			console.log("★★★★★★★★★★★★★★★★★★ call ajax ★★★★★★★★★★★★★★★★★★");
			console.log("★ desc :", desc);
			console.log("★ url :", url);
			console.log("★ form name :", formname);
			console.log("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");

	        var frm = $('#'+formname)[0];
	        var data = new FormData(frm);

	        $.when(
	        $.ajax({
	            type: "POST",
	            enctype: 'multipart/form-data',
	            url: url,
	            data: data,
	            processData: false,
	            contentType: false,
	            cache: false,
	            timeout: 3 * 60 * 1000,
	            beforeSend : function(xhr){
					$("#content-loader-id").show();
	            	xhr.setRequestHeader("Authorization", getAuthToken());
	                //xhr.setRequestHeader("req_type", "ajax");
	            },
	            success: function (response) {
					$("#content-loader-id").hide();
	            	// alert('success')
	            	callback && callback.success && callback.success(response);
	            },
	            error: function (e) {
					$("#content-loader-id").hide();
	                // alert('fail');
	            }
	        })
	        ).then(function( data, textStatus, jqXHR ) {
	        	//alert( jqXHR.status ); // Alerts 200
	        	return 'success';
	        }).fail(function(result, status, responseobj){
				//alert('falield');
	        	return 'fail';
	        });
	        ;

		},
		// call multipart ajax
		AdminrequestMultiAjax: function(desc, url, formname, callback) {

			var that = this, url;
			var returnData;	// only async false return value

			console.log("★★★★★★★★★★★★★★★★★★ call ajax ★★★★★★★★★★★★★★★★★★");
			console.log("★ desc :", desc);
			console.log("★ url :", url);
			console.log("★ form name :", formname);
			console.log("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");

	        var frm = $('#'+formname)[0];
	        var data = new FormData(frm);

	        $.when(
	        $.ajax({
	            type: "POST",
	            enctype: 'multipart/form-data',
	            url: url,
	            data: data,
	            processData: false,
	            contentType: false,
	            cache: false,
	            timeout: 3 * 60 * 1000,
	            beforeSend : function(xhr){
	            	xhr.setRequestHeader("Authorization", getAuthToken());
	                //xhr.setRequestHeader("req_type", "ajax");
	            },
	            success: function (response) {
	            	// alert('success')
	            	callback && callback.success && callback.success(response);
	            },
	            error: function (e) {
	                alert('중복된 아이디 입니다.');
	            }
	        })
	        ).then(function( data, textStatus, jqXHR ) {
	        	//alert( jqXHR.status ); // Alerts 200
	        	return 'success';
	        }).fail(function(result, status, responseobj){
				alert('중복된 아이디 입니다.');
	        	return 'fail';
	        });
	        ;

		},
		// get today
		getToday :function(delimeter){

	        var changeDate = new Date();
	        var y = changeDate.getFullYear();
	        var m = changeDate.getMonth() + 1;
	        var d = changeDate.getDate();
	        if(m < 10)    { m = "0" + m; }
	        if(d < 10)    { d = "0" + d; }
	        var gubunja = delimeter || "";
	        var resultDate = y + gubunja + m + gubunja + d;
	        return resultDate;
	    },
	    // gen comma
	    comma :function(num){
	    	num = Utils.remove(num, ',');
	    	if( isNaN(num) ) return "0";
	    	return new Intl.NumberFormat().format(num);
	    },
	    // buss no
	    bussNo: function(val){
	    	if(val == undefined || val.length != 10) return val;
	    	else {
	    		return val.substr(0, 3) + "-" + val.substr(3, 2) + "-" + val.substr(5, 5);
	    	}
	    },
	    // phone number
	    phone: function(val){
	    	if(val == undefined || val.length != 11) {
	    		return val;
	    	} else {
	    		return val.substr(0, 3) + "-" + val.substr(3, 4) + "-" + val.substr(7, 4);
	    	}
	    },
	    // json string true/false
	    isJsonString: function(str) {
		  	try {
				var json = JSON.parse(str);
		    	return (typeof json === 'object');
		  	} catch (e) {
		    	return false;
		  	}
		},
		// nvl
	    nvl: function(str, replace) {
	    	try {
		    	if(Utils.isEmpty(str)) {
		    		if(Utils.isEmpty(replace)) {
		    			return '';
		    		}
		    		else {
		    			return replace;
		    		}
		    	} else {
		    		return str;
		    	}
	    	} catch (e) {
		    	return str;
		  	}
		},
		// link button create
	    linkButton: function(str) {

	    	try {
		    	if(Utils.isEmpty(str)) {
		    		return '';
		    	}
		    	else if(str.indexOf("http://") > -1) {
		    		let _link = str;
		    		let tmp = '<button onclick="window.open(\''+str+'\',\'window_name\',\'height=500,location=no,status=no,scrollbars=yes\');">button</button>';
		    		console.log("link", tmp);
		    		return tmp;
		    	}
		    	else {
		    		return str;
		    	}

	    	} catch (e) {
		    	return str;
		  	}
		},
		// datetime
	    getDatetime: function(str) {

	    	try {
	    		if(Utils.isEmpty(str)) return '';

		    	let date = new Date(str);
				let year = date.getFullYear();
				let month = date.getMonth()+1;
				let dt = date.getDate();
				hh = date.getHours();
				mm = date.getMinutes();

				if (dt < 10) { dt = '0' + dt;}
				if (month < 10) { month = '0' + month;}
				if (hh < 10) { hh = '0' + hh;}
				if (mm < 10) { mm = '0' + mm;}
				return year+"-"+month+"-"+dt+" "+hh+":"+mm;
	    	} catch (e) {
		    	return str;
		  	}
		},
		// date, datetime
 		getDate: function(str) {

	    	try {
	    		if(Utils.isEmpty(str)) return '';
	    		str = Utils.remove(str,"-");
	    		str = Utils.remove(str,".");
	    		if(str.length == 8){
					return str.substr(0, 4)+"-"+str.substr(4, 2)+"-"+str.substr(6, 2);
				}
	    		else if(str.length == 12){
					return str.substr(0, 4)+"-"+str.substr(4, 2)+"-"+str.substr(6, 2)+" "+str.substr(8, 2)+":"+str.substr(10, 2)
				}
				else return str;
	    	} catch (e) {
		    	return str;
		  	}
		},		// get today
		getDayOfWeek :function(str){
			let week = ['일', '월', '화', '수', '목', '금', '토'];
	        return week[new Date(str).getDay()];
	    },


	}
