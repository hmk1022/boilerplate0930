package com.workerman.vo;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("MemberInfoDataItemVo")
public class MemberInfoDataItemVo {

	@ApiModelProperty(value = "회원번호") private Long member_no;
	@ApiModelProperty(value = "아이디") private String member_id;
	@ApiModelProperty(value = "비밀번호") private String password;
	@ApiModelProperty(value = "이름") private String name;
	@ApiModelProperty(value = "전화번호") private String mobile;
	@ApiModelProperty(value = "가입유형 - 01:자체가입 02:페북 03:카카오  04:네이버  05:구글  06:애플") private String join_type;
	@ApiModelProperty(value = "회원유형 - 01:일반 02:법인 03:개인사업자") private String mem_type;
	@ApiModelProperty(value = "알림수") private Integer activity_new_cnt;
	@ApiModelProperty(value = "주소") private String mem_addr1;
	@ApiModelProperty(value = "상세주소") private String mem_addr2;
	
}
