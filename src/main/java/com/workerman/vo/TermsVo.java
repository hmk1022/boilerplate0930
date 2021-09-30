package com.workerman.vo;

import java.util.List;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class TermsVo {

	@ApiModelProperty(value = "약관내용") private TermsDataVo terms;
	@ApiModelProperty(value = "약관목록") private List<TermsDataVo> terms_list;
	
}
