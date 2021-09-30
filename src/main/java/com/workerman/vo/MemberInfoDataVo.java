package com.workerman.vo;

import org.apache.ibatis.type.Alias;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@Alias("MemberInfoDataVo")
public class MemberInfoDataVo {

	@ApiModelProperty(value = "회원정보") private MemberInfoDataItemVo member;
}
