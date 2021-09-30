package com.workerman.vo;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("ChatMsgDataVo")
public class ChatMsgDataVo {

	@ApiModelProperty(value = "멘트번호") private Long ment_no;
	@ApiModelProperty(value = "타이틀") private String title;
	@ApiModelProperty(value = "응답메시지") private String msg;
	
}
