package com.workerman.vo;

import java.util.List;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ActivityListVo {

	@ApiModelProperty(value = "결과목록") private List<ActivityListDataVo> list;
	
}
