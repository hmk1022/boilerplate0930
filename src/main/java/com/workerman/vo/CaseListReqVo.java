package com.workerman.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class CaseListReqVo {

	@ApiModelProperty(value = "마지막게시물일자", required = false, allowEmptyValue = true) private String create_date;
	@ApiModelProperty(value = "게시물수", required = true, allowEmptyValue = false) @NotNull @Min(value = 1) private Integer page_size;
	
}
