package com.workerman.commons;

import org.springframework.http.HttpStatus;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ErrorResponse {

	public ErrorResponse(HttpStatus unauthorized, int status2, Object message, String message2) {
		// TODO Auto-generated constructor stub
	}
	@JsonIgnore
	@ApiModelProperty(value = "상태코드") private HttpStatus status;
	
	@ApiModelProperty(value = "결과코드") private int result_code;
	@ApiModelProperty(value = "결과메시지") private String result_msg;
	@ApiModelProperty(value = "결과메시지상세") private String result_msg_detail;

}