package com.workerman.vo;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("FaqListDataVo")
public class FaqListDataVo {

	@ApiModelProperty(value = "faq번호") private Long faq_no;
	@ApiModelProperty(value = "질문") private String faq_question;
	@ApiModelProperty(value = "답변") private String faq_answer;
	
}
