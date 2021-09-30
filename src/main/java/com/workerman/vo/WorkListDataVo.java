package com.workerman.vo;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("WorkListDataVo")
public class WorkListDataVo {

	@JsonFormat(shape = JsonFormat.Shape.NUMBER)
	@ApiModelProperty(value = "등록일자") private Timestamp create_date;
	@ApiModelProperty(value = "회원번호") private Long member_no;
	@ApiModelProperty(value = "작업번호") private Long work_no;
	@ApiModelProperty(value = "작업상태코드 - 10:접수완료 20:배정완료(현장답사) 30:작업중 40:결제요청 50:작업완료 19:접수취소 99:작업취소") private String work_stat;
	@ApiModelProperty(value = "작업번호") private String work_id;
	@ApiModelProperty(value = "주소") private String work_addr1;
	@ApiModelProperty(value = "상세주소") private String work_addr2;
	@ApiModelProperty(value = "작업상태명") private String work_stat_name;
	@ApiModelProperty(value = "이미지주소") private String image_url;

}
