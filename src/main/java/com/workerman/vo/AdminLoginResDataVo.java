package com.workerman.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AdminLoginResDataVo{

	@ApiModelProperty(value = "로그인토큰") private String token;
	@ApiModelProperty(value = "회원번호") private Long admin_no;
	@ApiModelProperty(value = "알림수") private Integer activity_new_cnt;
	
}
