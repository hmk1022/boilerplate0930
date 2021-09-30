package com.workerman.vo;

import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class MemberUpdatePushTokenReqVo {

	@ApiModelProperty(value = "디바이스유형( android / ios )", required = true, allowEmptyValue = false) @NotNull private String os_type;
	@ApiModelProperty(value = "다바이스아이디", required = true, allowEmptyValue = false) @NotNull private String device_id;
	@ApiModelProperty(value = "푸쉬토큰", required = true, allowEmptyValue = false) @NotNull private String push_token;
	
	@ApiModelProperty(value = "상태값", required = false, allowEmptyValue = true, hidden = true) private String stat;
	@ApiModelProperty(value = "회원번호", required = false, allowEmptyValue = true, hidden = true) private Long member_no;

}
