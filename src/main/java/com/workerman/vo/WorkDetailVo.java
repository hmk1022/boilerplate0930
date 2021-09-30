package com.workerman.vo;

import java.util.List;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class WorkDetailVo {

	@ApiModelProperty(value = "작업정보") private WorkDetailDataVo work;
	@ApiModelProperty(value = "첨부파일목록") private List<WorkDetailFileDataVo> file_list;
	@ApiModelProperty(value = "작업카드목록") private List<WorkDetailCardDataVo> card_list;
	
}
