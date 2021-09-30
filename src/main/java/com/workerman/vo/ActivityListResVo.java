package com.workerman.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString
public class ActivityListResVo extends ResultVo {

	@ApiModelProperty(value = "결과데이터") private ActivityListVo result_data;
	
}
