package com.workerman.vo;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("ActivityListDataVo")
public class ActivityListDataVo {

	@ApiModelProperty(value = "랜딩타입 - 01 : 작업상세  02 : 워커맨 후기 03:워커맨일정이동 04:현장신용카드결제 05:견적서상세 06:업무보고서 상세") private String landing_type;
	@ApiModelProperty(value = "작업번호") private Long work_no;
	@ApiModelProperty(value = "제목") private String title;
	@ApiModelProperty(value = "내용") private String content;
	@ApiModelProperty(value = "표시날짜") private String create_date_str;
	
}
