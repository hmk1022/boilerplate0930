package com.workerman.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString
public class AppVersionResVo extends ResultVo {

	private AppVersionDataVo result_data;

}
