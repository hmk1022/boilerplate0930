package com.workerman.vo;

import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AdminLoginReqVo {

	@ApiModelProperty(value = "회원아이디", required = true, allowEmptyValue = false) @NotNull private String admin_id;
	@ApiModelProperty(value = "비밀번호", required = true, allowEmptyValue = false) @NotNull private String password;

}
