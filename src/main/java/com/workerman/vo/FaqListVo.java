package com.workerman.vo;

import java.util.List;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class FaqListVo {

	@ApiModelProperty(value = "faq목록") private List<FaqListDataVo> list;
	
}
