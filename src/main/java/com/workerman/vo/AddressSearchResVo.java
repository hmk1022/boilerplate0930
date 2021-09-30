package com.workerman.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString
public class AddressSearchResVo extends ResultVo{

	@ApiModelProperty(value = "리턴결과-외부API이므로 리턴값의 형태를 파악후 개발을 진행하기바람.") private Object result_data;
	
}
