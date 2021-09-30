package com.workerman.vo;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@Alias("AddressListDataVo")
@ToString
public class AddressListDataVo {

	@ApiModelProperty(value = "주소번호") private Long address_no;
	@ApiModelProperty(value = "회원번호") private Long member_no;
	@ApiModelProperty(value = "주소명") private String address_name;
	@ApiModelProperty(value = "우편번호") private String zip;
	@ApiModelProperty(value = "주소") private String address1;
	@ApiModelProperty(value = "상세주소") private String address2;
	@ApiModelProperty(value = "주소코드") private String addr_cd;
	@ApiModelProperty(value = "주소코드명") private String addr_cd_name;
	
}
