package com.workerman.vo;

import java.util.List;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class CaseListVo {

	@ApiModelProperty(value = "시공사례목록") private List<CaseListDataVo> list;
	
}
