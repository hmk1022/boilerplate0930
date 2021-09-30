package com.workerman.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class CaseMainListReqVo {

	@ApiModelProperty(value = "게시물수", required = true, allowEmptyValue = false) @NotNull @Min(value = 1) private Integer size;
	
}
