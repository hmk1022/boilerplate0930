package com.workerman.vo;

import java.util.List;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class WorkListVo {
	
	@ApiModelProperty(value = "작업목록") private List<WorkListDataVo> list;

}
