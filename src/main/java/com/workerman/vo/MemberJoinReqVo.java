package com.workerman.vo;

import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class MemberJoinReqVo {

	@ApiModelProperty(value = "회원아이디", required = true, allowEmptyValue = false) @NotNull private String member_id;
	@ApiModelProperty(value = "비밀번호", required = false, allowEmptyValue = true) private String password;
	@ApiModelProperty(value = "이름", required = true, allowEmptyValue = false) @NotNull private String name;
	@ApiModelProperty(value = "가입유형 (01:자체가입,02:페이스북,03:카카오,04:네이버,05:구글,06:애플)", required = true, allowEmptyValue = false) @NotNull private String join_type;
	@ApiModelProperty(value = "이용약관동의", required = true, allowEmptyValue = false) @NotNull private String agree_yn;
	@ApiModelProperty(value = "개인정보동의", required = true, allowEmptyValue = false) @NotNull private String personal_yn;
	@ApiModelProperty(value = "프로필URL, SNS일경우", required = false, allowEmptyValue = true) private String profile_url;
	
	@ApiModelProperty(value = "회원구분", required = false, allowEmptyValue = true, hidden = true) private String mem_type;
	

}
