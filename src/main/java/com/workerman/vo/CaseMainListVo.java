package com.workerman.vo;

import java.util.List;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class CaseMainListVo {

	@ApiModelProperty(value = "시공사례목록") private List<CaseMainListDataVo> list;
	
}
