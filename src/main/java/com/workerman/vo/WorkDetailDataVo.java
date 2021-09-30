package com.workerman.vo;

import java.sql.Timestamp;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonFormat;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class WorkDetailDataVo {

	@JsonFormat(shape = JsonFormat.Shape.NUMBER)
	@ApiModelProperty(value = "등록일자") private Timestamp create_date;
	@ApiModelProperty(value = "작업번호") private Long work_no;
	@ApiModelProperty(value = "회원번호") private Long member_no;
	@ApiModelProperty(value = "작업상태코드 - 10:접수완료 20:배정완료(현장답사) 30:작업중 40:결제요청 50:작업완료 19:접수취소 99:작업취소") private String work_stat;
	@ApiModelProperty(value = "작업상태명") private String work_stat_name; 
	@ApiModelProperty(value = "요청자명") private String req_name;
	@ApiModelProperty(value = "전화번호") private String req_hp;
	@ApiModelProperty(value = "주소") private String work_addr1;
	@ApiModelProperty(value = "상세주소") private String work_addr2;
	@ApiModelProperty(value = "요청사항") private String req_content;
	@ApiModelProperty(value = "방문일시") private String st_visit_confirm_date_str;
	@ApiModelProperty(value = "작업일시") private String st_working_confirm_date_str;
	@ApiModelProperty(value = "작업아이디") private String work_id;
	
	public WorkDetailDataVo(Map<String, Object> map) {
		create_date = map.get("create_date") != null ? Timestamp.valueOf(map.get("create_date")+"") : null;
		work_no = map.get("work_no") != null ? Long.parseLong(map.get("work_no")+"") : null;
		member_no = map.get("member_no") != null ? Long.parseLong(map.get("member_no")+"") : null;
		work_stat = map.get("work_stat") != null ? map.get("work_stat")+"" : null;
		work_stat_name = map.get("work_stat_name") != null ? map.get("work_stat_name")+"" : null;
		req_name = map.get("req_name") != null ? map.get("req_name")+"" : null;
		req_hp = map.get("req_hp") != null ? map.get("req_hp")+"" : null;
		work_addr1 = map.get("work_addr1") != null ? map.get("work_addr1")+"" : null;
		work_addr2 = map.get("work_addr2") != null ? map.get("work_addr2")+"" : null;
		req_content = map.get("req_content") != null ? map.get("req_content")+"" : null;
		st_visit_confirm_date_str = map.get("st_visit_confirm_date_str") != null ? map.get("st_visit_confirm_date_str")+"" : null;
		st_working_confirm_date_str = map.get("st_working_confirm_date_str") != null ? map.get("st_working_confirm_date_str")+"" : null;
		work_id = map.get("work_id") != null ? map.get("work_id")+"" : null;
	}
}
