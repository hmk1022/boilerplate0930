package com.workerman.vo;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("WorkResFileDataVo")
public class WorkResFileDataVo {

	@ApiModelProperty(value = "파일번호") private Long file_no;
	@ApiModelProperty(value = "파일URL") private String file_url;
	@ApiModelProperty(value = "작업번호") private Long work_no;
	
}
