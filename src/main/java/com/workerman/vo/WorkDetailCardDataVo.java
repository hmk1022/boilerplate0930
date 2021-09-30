package com.workerman.vo;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("WorkDetailCardDataVo")
public class WorkDetailCardDataVo {

	@JsonFormat(shape = JsonFormat.Shape.NUMBER)
	@ApiModelProperty(value = "등록일자") private Timestamp create_date;
	@ApiModelProperty(value = "내용") private String content;
	@ApiModelProperty(value = "워커맨수") private Integer workerman_cnt;
	@ApiModelProperty(value = "청구서번호") private Long bill_no;
	@ApiModelProperty(value = "이력번호") private Long hist_no;
	@ApiModelProperty(value = "견적서번호") private Long estimate_no;
	@ApiModelProperty(value = "관리자번호") private Long admin_no;
	@ApiModelProperty(value = "이동URL") private String webview_url;
	@ApiModelProperty(value = "작업번호") private Long work_no;
	@ApiModelProperty(value = "워커맨명") private String workerman_name;
	@ApiModelProperty(value = "워커맨프로필URL") private String workerman_profile;

}
