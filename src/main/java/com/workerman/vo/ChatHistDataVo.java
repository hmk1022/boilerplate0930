package com.workerman.vo;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("ChatHistDataVo")
public class ChatHistDataVo {

	@JsonFormat(shape = JsonFormat.Shape.NUMBER)
	@ApiModelProperty(value = "등록일자") private Timestamp create_date;
	@ApiModelProperty(value = "이력번호") private Long ch_no;
	@ApiModelProperty(value = "회원번호") private Long member_no;
	@ApiModelProperty(value = "멘트번호") private Long ment_no;
	@ApiModelProperty(value = "응답메시지") private String msg;
	@ApiModelProperty(value = "이미지경로") private String img_path;
	@ApiModelProperty(value = "메시지유형 - 0:일반텍스트메시지 1:이미지 10:인사메시지 20:서비스특징 30:작업가능분야 40:고객센터 50:오시는길") private int msg_type;
	@ApiModelProperty(value = "요청메시지여부 - Y:요청메시지 N:응답메시지") private String req_yn;
	
}
