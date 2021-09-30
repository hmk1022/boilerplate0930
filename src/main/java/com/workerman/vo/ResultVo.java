package com.workerman.vo;

import com.workerman.commons.CommonCode;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ResultVo {
	
	@ApiModelProperty(value = "결과코드") private long result_code;
	@ApiModelProperty(value = "결과메시지") private String result_msg;
	
	public void setErrorNone() {
		this.result_code = Long.parseLong(CommonCode.RETURN_COMPLETE_PROCESS.getCode());
		this.result_msg = CommonCode.RETURN_COMPLETE_PROCESS.getMessage();
	}
	
	public void setErrorCode(String result_code, String result_msg) {
		this.result_code = Long.parseLong(result_code);
		this.result_msg = result_msg;
	}

}

