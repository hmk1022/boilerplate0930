package com.workerman.vo;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("WorkResCategoryDataVo")
public class WorkResCategoryDataVo {

	@ApiModelProperty(value = "이미지URL") private String image_url;
	@ApiModelProperty(value = "카테고리명") private String name;
	@ApiModelProperty(value = "1차경로") private String path1;
	@ApiModelProperty(value = "2차경로") private String path2;
	
}
