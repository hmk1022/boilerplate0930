package com.workerman.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class CategoryInfoVo {

	@ApiModelProperty(value = "카테고리정보") private WorkResCategoryDataVo info;
	
}
