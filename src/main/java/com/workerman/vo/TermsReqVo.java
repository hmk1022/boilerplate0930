package com.workerman.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class TermsReqVo {

	@ApiModelProperty(value = "약관번호", required = false, allowEmptyValue = true) private Long p_no;
	
}
