package com.workerman.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString
public class MemberInfoResVo extends ResultVo{

	private MemberInfoDataVo result_data;
	
}
