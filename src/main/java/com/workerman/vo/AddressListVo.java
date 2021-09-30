package com.workerman.vo;

import java.util.List;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AddressListVo {

	@ApiModelProperty(value = "결과목록") private List<AddressListDataVo> list;
	
}
