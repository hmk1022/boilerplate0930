package com.workerman.vo;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("CaseListWorkImgDataVo")
public class CaseListWorkImgDataVo {

	@ApiModelProperty(value = "이미지URL") private String file_url;
	@ApiModelProperty(value = "이미지타입 - 01:전 02:후") private String img_type;
	
}
