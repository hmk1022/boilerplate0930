package com.workerman.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("CaseListDataVo")
public class CaseListDataVo {

	@ApiModelProperty(value = "등록일자") private String create_date;
	@ApiModelProperty(value = "태그,로구분처리") private String tag;
	@ApiModelProperty(value = "제목") private String title;
	@ApiModelProperty(value = "작업내용") private String work_hist_detail;
	@ApiModelProperty(value = "주소") private String address;
	@ApiModelProperty(value = "주소타입명") private String addr_name;
	@ApiModelProperty(value = "날짜표시용") private String create_date_dp;
	@ApiModelProperty(value = "금액") private Integer pay_amount;
	@ApiModelProperty(value = "라벨,로구분처리") private String label;
	@ApiModelProperty(value = "카테고리번호") private Long category_no;
	@ApiModelProperty(value = "작업아이디") private String work_id;
	@ApiModelProperty(value = "작업번호") private Long work_no;
	
	@ApiModelProperty(value = "이미지목록") private List<CaseListWorkImgDataVo> img_list;
	
}
