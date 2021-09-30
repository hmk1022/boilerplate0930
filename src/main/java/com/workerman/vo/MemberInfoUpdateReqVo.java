package com.workerman.vo;

import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class MemberInfoUpdateReqVo {

	@ApiModelProperty(value = "전화번호", required = true, allowEmptyValue = false) @NotNull private String mobile;
	@ApiModelProperty(value = "회원유형 - 01:일반 02:법인 03:개인사업자", required = true, allowEmptyValue = false) @NotNull private String mem_type;
	@ApiModelProperty(value = "회원번호", required = false, allowEmptyValue = true, hidden = true) private Long member_no;
	
}
