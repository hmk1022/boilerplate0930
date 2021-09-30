package com.workerman.vo;

import java.util.List;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class CategoryListVo {

	@ApiModelProperty(value = "카테고리목록") private List<CategoryListDataVo> list;
	
}
