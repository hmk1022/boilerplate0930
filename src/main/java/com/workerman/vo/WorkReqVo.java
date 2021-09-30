package com.workerman.vo;

import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class WorkReqVo {

	@ApiModelProperty(value = "작업요청사항", required = true, allowEmptyValue = false) @NotNull private String req_content;
	@ApiModelProperty(value = "이름", required = true, allowEmptyValue = false) @NotNull private String req_name;
	@ApiModelProperty(value = "휴대폰번호", required = true, allowEmptyValue = false) @NotNull private String req_hp;
	@ApiModelProperty(value = "주소", required = true, allowEmptyValue = false) @NotNull private String work_addr1;
	@ApiModelProperty(value = "상세주소", required = true, allowEmptyValue = false) @NotNull private String work_addr2;
	@ApiModelProperty(value = "우편번호", required = true, allowEmptyValue = false) @NotNull private String work_zip;
	@ApiModelProperty(value = "카테고리번호", required = false, allowEmptyValue = true) private Integer category_no;
	@ApiModelProperty(value = "접수경로 - 01:앱, 02:콜센터, 03:홈페이지", required = false, allowEmptyValue = true) private String req_path;
	@ApiModelProperty(value = "작업희망 년월일(yyyymmdd)", required = true, allowEmptyValue = false) @NotNull private String req_w_date_ymd;
	@ApiModelProperty(value = "작업희망 시간", required = true, allowEmptyValue = false) @NotNull private String req_w_date_h;
	@ApiModelProperty(value = "작업희망 분", required = true, allowEmptyValue = false) @NotNull private String req_w_date_m;
	@ApiModelProperty(value = "폐기물 추가비용 동의여부", required = false, allowEmptyValue = true) private String garbage_agree_yn;
	
	@JsonIgnore
	@ApiModelProperty(value = "첨부파일1", required = false, allowEmptyValue = true) private MultipartFile img1;
	@JsonIgnore
	@ApiModelProperty(value = "첨부파일2", required = false, allowEmptyValue = true) private MultipartFile img2;
	@JsonIgnore
	@ApiModelProperty(value = "첨부파일3", required = false, allowEmptyValue = true) private MultipartFile img3;
	@JsonIgnore
	@ApiModelProperty(value = "첨부파일4", required = false, allowEmptyValue = true) private MultipartFile img4;
	@JsonIgnore
	@ApiModelProperty(value = "첨부파일5", required = false, allowEmptyValue = true) private MultipartFile img5;
	@JsonIgnore
	@ApiModelProperty(value = "첨부파일6", required = false, allowEmptyValue = true) private MultipartFile img6;

	//@ApiModelProperty(value = "방문일", required = false, allowEmptyValue = true, hidden = true) private String req_visit_date;
	//@ApiModelProperty(value = "방문타입", required = false, allowEmptyValue = true, hidden = true) private String req_visit_date_type;
	@ApiModelProperty(value = "회원번호", required = false, allowEmptyValue = true, hidden = true) private Long member_no;
	@ApiModelProperty(value = "안내메시지발송여부", required = false, allowEmptyValue = true, hidden = true) private String time_msg_yn;
}
