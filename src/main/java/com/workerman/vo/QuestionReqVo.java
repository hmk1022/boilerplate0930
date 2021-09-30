package com.workerman.vo;

import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class QuestionReqVo {
	
	@ApiModelProperty(value = "이름", required = true, allowEmptyValue = false) @NotNull private String name;
	@ApiModelProperty(value = "전화번호", required = true, allowEmptyValue = false) @NotNull private String hp;
	@ApiModelProperty(value = "이메일", required = true, allowEmptyValue = false) @NotNull private String email;
	@ApiModelProperty(value = "내용", required = true, allowEmptyValue = false) @NotNull private String content;
	
}
