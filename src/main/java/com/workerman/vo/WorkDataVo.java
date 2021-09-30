package com.workerman.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class WorkDataVo {
	
	@ApiModelProperty(value = "작업번호") private Long work_no;
	@ApiModelProperty(value = "주소") private String work_addr1;
	@ApiModelProperty(value = "상세주소") private String work_addr2;
	@ApiModelProperty(value = "휴대폰") private String req_hp;
	@ApiModelProperty(value = "이름") private String req_name;
	@ApiModelProperty(value = "요청사항") private String req_content;
	
}
