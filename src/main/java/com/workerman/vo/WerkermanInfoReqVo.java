package com.workerman.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class WerkermanInfoReqVo {

	@ApiModelProperty(value = "작업번호", required = true, allowEmptyValue = true, hidden = true) private Long work_no;
	
}
