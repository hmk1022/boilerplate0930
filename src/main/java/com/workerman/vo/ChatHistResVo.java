package com.workerman.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString
public class ChatHistResVo extends ResultVo {

	private ChatHistListVo result_data;
	
}
