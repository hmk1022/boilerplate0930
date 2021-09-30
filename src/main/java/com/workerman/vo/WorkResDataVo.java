package com.workerman.vo;

import java.util.List;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class WorkResDataVo {
	
	@ApiModelProperty(value = "작업정보") private WorkDataVo work;
	@ApiModelProperty(value = "첨부파일목록") private List<WorkResFileDataVo> file_list;
	@ApiModelProperty(value = "카테고리정보") private WorkResCategoryDataVo category;
	
}
