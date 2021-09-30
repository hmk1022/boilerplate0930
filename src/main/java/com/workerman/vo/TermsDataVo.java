package com.workerman.vo;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("TermsDataVo")
public class TermsDataVo {

	@ApiModelProperty(value = "약관번호") private Long p_no;
	@ApiModelProperty(value = "약관내용") private String content;
	@ApiModelProperty(value = "공고일자") private String g_date_str;
	@ApiModelProperty(value = "시행일자") private String s_date_str;
	
}
