package com.workerman.vo;

import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AppVersionDataVo {

	@ApiModelProperty(value = "앱버전", required = true, allowEmptyValue = false) @NotNull private String app_v;

}
