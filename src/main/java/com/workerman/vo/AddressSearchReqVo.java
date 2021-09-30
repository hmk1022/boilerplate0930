package com.workerman.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AddressSearchReqVo {

	@ApiModelProperty(value = "검색어", required = true, allowEmptyValue = false) @NotNull private String keyword;
	@ApiModelProperty(value = "페이지번호", required = true, allowEmptyValue = false) @NotNull @Min(value = 1) private Integer start_p;
	@ApiModelProperty(value = "가져올수", required = true, allowEmptyValue = false) @NotNull @Min(value = 1) private Integer count;
	
}
