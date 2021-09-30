package com.workerman.vo;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("CategoryListDataVo")
public class CategoryListDataVo {

	@ApiModelProperty(value = "작업시간(분)") private Integer working_time;
	@ApiModelProperty(value = "상위카테고리번호") private Long p_category_no;
	@ApiModelProperty(value = "이미지URL") private String image_url;
	@ApiModelProperty(value = "가격") private Integer price;
	@ApiModelProperty(value = "이름") private String name;
	@ApiModelProperty(value = "카테고리번호") private Long category_no;
	@ApiModelProperty(value = "태그") private String tag;
	@ApiModelProperty(value = "작업인원") private Integer people_number;
	
}
