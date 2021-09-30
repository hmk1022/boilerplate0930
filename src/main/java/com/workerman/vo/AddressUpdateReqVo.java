package com.workerman.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AddressUpdateReqVo {

	@ApiModelProperty(value = "회원번호", required = false, allowEmptyValue = true, hidden = true) private Long member_no;
	
	@ApiModelProperty(value = "주소번호", required = true, allowEmptyValue = false) @NotNull @Min(value = 1) private Long address_no;
	@ApiModelProperty(value = "주소명", required = true, allowEmptyValue = false) @NotNull private String address_name;
	@ApiModelProperty(value = "우편번호", required = true, allowEmptyValue = false) @NotNull private String zip;
	@ApiModelProperty(value = "주소1", required = true, allowEmptyValue = false) @NotNull private String address1;
	@ApiModelProperty(value = "주소2", required = true, allowEmptyValue = false) @NotNull private String address2;
}
