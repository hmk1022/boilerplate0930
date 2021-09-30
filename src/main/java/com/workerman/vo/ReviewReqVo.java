package com.workerman.vo;

import java.util.Map;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ReviewReqVo {

	@ApiModelProperty(value = "작업번호", required = true, allowEmptyValue = false) @NotNull @Min(value = 1) private Long work_no;
	@ApiModelProperty(value = "리뷰내용", required = false, allowEmptyValue = true) private String content;
	@ApiModelProperty(value = "리뷰정보 - Key:String, Value:int - 01:친절도,02:숙련도,03:청결도,04:비용도 - 0~5 Scope" , required = true, allowEmptyValue = false) 
	@NotNull private Map<String, Object> review;
	
}
