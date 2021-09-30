package com.workerman.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class WorkDetailReqVo {

	@ApiModelProperty(value = "회원번호", required = false, allowEmptyValue = true, hidden = true) private Long member_no;
	@ApiModelProperty(value = "작업번호", required = false, allowEmptyValue = true, hidden = true) private Long work_no;
	
}
