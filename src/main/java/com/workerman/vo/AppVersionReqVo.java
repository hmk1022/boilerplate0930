package com.workerman.vo;

import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AppVersionReqVo {

	@ApiModelProperty(value = "디바이스유형( android / ios )", required = true, allowEmptyValue = false) @NotNull private String os_type;
	@ApiModelProperty(value = "구분코드", required = false, allowEmptyValue = true, hidden = true)  private String code_gb;

}
