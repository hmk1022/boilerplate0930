package com.workerman.vo;

import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class BoardReqVo {

	@ApiModelProperty(value = "A:안드로이드, I:IOS", required = true, allowEmptyValue = false) @NotNull private String os_type;

}
