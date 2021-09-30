package com.workerman.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class CategoryInfoReqVo {

	@ApiModelProperty(value = "카테고리번호", required = true, allowEmptyValue = false) @NotNull @Min(value = 1) private Long category_no;
	
}
