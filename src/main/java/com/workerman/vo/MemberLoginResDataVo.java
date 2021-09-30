package com.workerman.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class MemberLoginResDataVo{

	@ApiModelProperty(value = "로그인토큰", required = true, allowEmptyValue = false) @NotNull private String token;
	@ApiModelProperty(value = "회원번호", required = true, allowEmptyValue = false) @NotNull @Min(value = 0) private Long member_no;
	@ApiModelProperty(value = "알림수", required = true, allowEmptyValue = false) @NotNull @Min(value = 0) private Integer activity_new_cnt;
	
}
