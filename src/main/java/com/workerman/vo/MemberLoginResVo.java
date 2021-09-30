package com.workerman.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString
public class MemberLoginResVo extends ResultVo{

	private MemberLoginResDataVo result_data;
	
}
