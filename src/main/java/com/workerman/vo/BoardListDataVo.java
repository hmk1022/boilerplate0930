package com.workerman.vo;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("BoardListDataVo")
public class BoardListDataVo {

	@ApiModelProperty(value = "게시물번호") private Long board_no;
	@ApiModelProperty(value = "제목") private String title;
	@ApiModelProperty(value = "내용") private String content;
	@ApiModelProperty(value = "날짜") private String create_date;
	
}
