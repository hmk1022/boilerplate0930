package com.workerman.commons;

import lombok.Getter;

@Getter
public enum ErrorCode {
	
	ERROR_BAD_REQUEST(400, "잘못된 요청입니다."),
	ERROR_UNAUTHORIZED(401, "권한이 필요한 요청입니다."),
	ERROR_INPUT_VALUE(402, "입력값이 올바르지 않습니다."),
	ERROR_NOT_FOUND(404, "정의 되지않은 요청입니다."),
	ERROR_INTERNAL_SERVER_ERROR(500, "내부 서버 오류입니다.")
    ;
	
    private final String message;
    private int status;

    ErrorCode(final int status, final String message) {
        this.status = status;
        this.message = message;
    }
}