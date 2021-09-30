package com.workerman.vo;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("CaseMainListDataVo")
public class CaseMainListDataVo {

	@ApiModelProperty(value = "제목") private String title;
	@ApiModelProperty(value = "이미지URL") private String img_url;
	
}
