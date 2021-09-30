package com.workerman.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class WorkDetailFileDataVo {

	@ApiModelProperty(value = "파일번호") private Long file_no;
	@ApiModelProperty(value = "파일URL") private String file_url; 
	
}
