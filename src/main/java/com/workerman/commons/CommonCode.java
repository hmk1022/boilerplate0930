package com.workerman.commons;

public enum CommonCode {

	RETURN_COMPLETE_PROCESS("200", "처리가 완료되었습니다."),
	RETURN_FAIL_SYSTEM_ERROR("500", "시스템 오류가 있습니다."),
	RETURN_FAIL_AUTH_EMPTY("503", "권한이 없습니다."),
	RETURN_FAIL_INVALID_INPUT("100", "입력값에 오류가 있습니다."),
	RETURN_FAIL_AUTH("401", "인증이 실패되었습니다. 처리가 중단됩니다."),
	RETURN_FAIL_AUTH_USER("402", "권한이없는 요청입니다. 처리가 중단됩니다."),
	RETURN_FAIL_AUTH_PW("403", "비밀번호가 일치하지않습니다."),
	RETURN_EMPTY_DATA("404", "데이터가 존재하지않습니다."),
//	RETURN_FAIL_DUPLICATE_ID("201", "이미사용중인 아이디입니다."),
	RETURN_FAIL_EMPTY_MEMBER("202", "회원정보가 존재하지않습니다."),
	RETURN_FAIL_CERTY("203", "인증코드가 일치하지않습니다."),
	RETURN_FAIL_CERTY_EXP("204", "인증코드가 만료되었습니다."),
	RETURN_FAIL_CANCEL("205", "취소할수없는 작업입니다."),
	RETURN_FAIL_ALREADY("206", "이미처리된 요청입니다."),
	
	RETURN_FAIL_ID_NOT_EXIST("1000", "아이디가 존재하지않습니다."),
	RETURN_FAIL_ADMIN_EMPTY("10001", "아이디 또는 비밀번호를 확인해주세요."),
	RETURN_FAIL_ADMIN_PW("10002", "비밀번호가 일치하지 않습니다."),
	RETURN_FAIL_DUPLICATE_ID_APP("10003", "이미 등록된 계정입니다."),
	
	JOIN_TYPE_NOMAL("01", "자체가입"),
	JOIN_TYPE_FACEBOOK("02", "페이스북"),
	JOIN_TYPE_KAKAO("03", "카카오"),
	JOIN_TYPE_NAVER("04", "네이버"),
	
	MEMBER_TYPE_NOMAL("01", "일반"),
	MEMBER_TYPE_CORPORATE("02", "법인"),
	MEMBER_TYPE_INDIVIDUAL("03", "개인 사업자"),
	
	WORK_STAT10("10", "접수완료"),
	WORK_STAT20("20", "현장답사"),
	WORK_STAT30("30", "작업중"),
	WORK_STAT40("40", "결제요청"),
	WORK_STAT50("50", "작업완료"),
	WORK_STAT19("19", "접수취소"),
	WORK_STAT99("99", "작업취소"),
	
	PASSWORD_RESET("PASSWORD", "비밀번호 초기화 인증코드");
	;

	private String code;
	private String message;

	CommonCode(String code, String message) {
		this.code = code;
		this.message = message;
	}

	public String getMessage() {
		return this.message;
	}

	public static String getMessage(String code) {
		for (CommonCode errorCode : CommonCode.values()) {
			if (errorCode.getCode() == code) {
				return errorCode.getMessage();
			}
		}

		return "";
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}

