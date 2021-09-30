package com.workerman.vo;

import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ChatMsgReqVo {

	@ApiModelProperty(value = "회원번호", required = false, allowEmptyValue = true, hidden = true) private Long member_no;
	@ApiModelProperty(value = "메시지", required = true, allowEmptyValue = false) @NotNull private String msg;
	
}
