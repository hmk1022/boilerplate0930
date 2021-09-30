package com.workerman.vo;

import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class MemberPasswordUpdateReqVo {

	@ApiModelProperty(value = "기존비밀번호", required = true, allowEmptyValue = false) @NotNull private String password;
	@ApiModelProperty(value = "신규비밀번호", required = true, allowEmptyValue = false) @NotNull private String new_password;
	@ApiModelProperty(value = "회원번호", required = false, allowEmptyValue = true, hidden = true) private Long member_no;
	
}
