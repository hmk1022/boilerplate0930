package com.workerman.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString
public class ChatMsgResVo extends ResultVo {

	private ChatMsgDataVo result_data;
	
}
