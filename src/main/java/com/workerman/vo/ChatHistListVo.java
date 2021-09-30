package com.workerman.vo;

import java.util.List;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ChatHistListVo {

	@ApiModelProperty(value = "대화목록") private List<ChatHistDataVo> list;
	
}
