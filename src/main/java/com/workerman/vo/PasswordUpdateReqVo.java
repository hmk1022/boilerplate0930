package com.workerman.vo;

import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class PasswordUpdateReqVo {

	@ApiModelProperty(value = "이메일", required = true, allowEmptyValue = false) @NotNull private String email;
	@ApiModelProperty(value = "인증코드", required = true, allowEmptyValue = false) @NotNull private String security_code;
	@ApiModelProperty(value = "비밀번호", required = true, allowEmptyValue = false) @NotNull private String password;
	
}
