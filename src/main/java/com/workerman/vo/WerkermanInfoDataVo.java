package com.workerman.vo;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("WerkermanInfoDataVo")
public class WerkermanInfoDataVo {

	@ApiModelProperty(value = "프로필URL") private String profile_url;
	@ApiModelProperty(value = "작업번호") private Long work_no;
	@ApiModelProperty(value = "워커맨명") private String admin_name;
	@ApiModelProperty(value = "워커맨번호") private Long admin_no;
	@ApiModelProperty(value = "회원번호") private Long member_no;
	
}
