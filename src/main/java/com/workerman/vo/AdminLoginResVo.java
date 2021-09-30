package com.workerman.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString
public class AdminLoginResVo extends ResultVo{

	private AdminLoginResDataVo result_data;
	
}
