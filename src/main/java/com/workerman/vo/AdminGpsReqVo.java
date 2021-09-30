package com.workerman.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AdminGpsReqVo {

	@ApiModelProperty(value = "관리자번호", required = true, allowEmptyValue = false) @NotNull @Min(value = 1) private Long admin_no;
	@ApiModelProperty(value = "위도", required = true, allowEmptyValue = false) @NotNull private String latitude;
	@ApiModelProperty(value = "경도", required = true, allowEmptyValue = false) @NotNull private String longitude;

}
