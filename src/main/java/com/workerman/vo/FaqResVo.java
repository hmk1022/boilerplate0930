package com.workerman.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString
public class FaqResVo extends ResultVo{

	private FaqListVo result_data;
	
}
