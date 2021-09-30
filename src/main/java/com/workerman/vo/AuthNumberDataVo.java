package com.workerman.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString
public class AuthNumberDataVo {

	@ApiModelProperty(value = "인증번호") private String auth_number;

}
