package com.workerman.vo;

import java.util.List;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class BoardListVo {

	@ApiModelProperty(value = "게시물목록") private List<BoardListDataVo> list;
	
}
