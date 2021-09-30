package com.workerman.vo;

import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AuthNumberReqVo {

	@ApiModelProperty(value = "전화번호", required = true, allowEmptyValue = false) @NotNull private String req_hp;

}
