package com.workerman.vo;

import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ChatMsgAddReqVo {

	@ApiModelProperty(value = "회원번호", required = false, allowEmptyValue = true, hidden = true) private Long member_no;
	@ApiModelProperty(value = "메시지", required = true, allowEmptyValue = false) @NotNull private String msg;
	@ApiModelProperty(value = "메시지유형 - 0:일반텍스트메시지 1:이미지 10:인사메시지 20:서비스특징 30:작업가능분야 40:고객센터 50:오시는길", required = true, allowEmptyValue = false) @NotNull private int msg_type;
	@ApiModelProperty(value = "요청메시지여부 - Y:요청메시지 N:응답메시지", required = true, allowEmptyValue = false) @NotNull private String req_yn;
	
}
