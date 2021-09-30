package com.workerman.vo;

import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class PasswordResetReqVo {

	@ApiModelProperty(value = "이메일", required = true, allowEmptyValue = false) @NotNull private String email;
	@ApiModelProperty(value = "회원아이디", required = false, allowEmptyValue = true, hidden = true) private String member_id;
	@ApiModelProperty(value = "가입유형", required = false, allowEmptyValue = true, hidden = true) private String join_type;

}
