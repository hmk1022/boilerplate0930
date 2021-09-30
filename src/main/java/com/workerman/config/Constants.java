package com.workerman.config;

public class Constants {

	/****************** BEGIN profile ******************************************************************/
    public static final String SPRING_PROFILE_DEVELOPMENT = "dev";
    public static final String SPRING_PROFILE_STAGE = "stage";
    public static final String SPRING_PROFILE_LOCAL = "local";
    public static final String SPRING_PROFILE_PRODUCTION = "prod";
    /****************** END profile ******************************************************************/

    /****************** BEGIN AWS ******************************************************************/
	public static final long ACCESS_TOKEN_VALIDITY_SECONDS = 300*60*60;
    public static final String SIGNING_KEY = "dnjzjaos123!";
    public static final String HEADER_STRING = "Authorization";
    public static final String TOKEN_PREFIX = "Bearer ";

    public static final String ERROR_EMPTY_KEY = "조회를 위한 key값이 누락 됐습니다.";

    /* S3 CONSTANTS */
    // TODO : 명칭 정리 필요함. properties 처리...
    public final static String WORK_UPLOAD_BUCKET_NAME = "workerman-upload-real";
    public final static String WORK_ACCESSKEY = "AKIAXLTLQLVZ7VRTHP6Y";
    public final static String WORK_SECRETKEY = "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";
    /****************** BEGIN END ******************************************************************/

    /****************** Begin Image Type ******************************************************************/
    public final static String IMG_TYPE_SAMPLE = "SAMPLE";	// sample
    public final static String IMG_TYPE_CUSTOMER = "CUSTOMER";	// 고객사업자등록증사본
    //public final static String IMG_TYPE_CUSTOMER_BRANCH = "CUSTOMER_BRANCH"; // 고객지점사업자등록증사본
    public final static String IMG_TYPE_PARTNER_BUSS = "IMG_TYPE_PARTNER_BUSS";	// 사업자번호 사본
    public final static String IMG_TYPE_PARTNER_ACCT = "PARTNER_ACCT";	// 파트너 통장사본

    public final static String IMG_TYPE_CUSTOMER_BUSS = "IMG_TYPE_CUSTOMER_BUSS";	// 사업자번호 사본
    public final static String IMG_TYPE_CUSTOMER_BRANCH_BUSS = "IMG_TYPE_CUSTOMER_BRANCH_BUSS";	// 사업자번호 사본
    public final static String IMG_TYPE_CUSTOMER_BRANCH_ACCT = "IMG_TYPE_CUSTOMER_BRANCH_ACCT";	// 통장 사본
    public final static String IMG_TYPE_VENDOR_BUSS = "IMG_TYPE_VENDOR_BUSS"; // 거래처 사업자등록증사본
    public final static String IMG_TYPE_VENDOR_ACCT = "IMG_TYPE_VENDOR_ACCT"; // 거래처 통장사본

    public final static String IMG_TYPE_MATERIAL = "IMG_TYPE_MATERIAL"; // 자재 이미지
    public final static String IMG_TYPE_MATERIAL_REQ = "IMG_TYPE_MATERIAL_REQ"; // 자재 요청 이미지

    public final static String IMG_TYPE_DISBURSEMENT = "IMG_TYPE_DISBURSEMENT"; // 지출결의 영수증 이미지
    public final static String IMG_TYPE_EXPENSES = "IMG_TYPE_EXPENSES"; // 비용처리 증빙 이미지
    public final static String IMG_TYPE_PAYMENT = "IMG_TYPE_PAYMENT"; // 매출관리 증빙 이미지
    public final static String IMG_TYPE_MATERIAL_PCS = "IMG_TYPE_MATERIAL_PCS"; //구매거래명세서 이미지

    public final static String IMG_TYPE_DAILY_REPORT = "IMG_TYPE_DAILY_REPORT";	// 작업일지 이미지
    public final static String IMG_TYPE_WORK_REG = "IMG_TYPE_WORK_REG";	// 작업등록 이미지
    
    public final static String IMG_TYPE_ADMIN = "IMG_TYPE_ADMIN";	// 어드민프로필 이미지
    
    /****************** End Image Type ******************************************************************/

    /****************** BEGIN 이벤트 처리 메시지 ******************************************************************/
    public static final String EVENT_DELETE_SUCCESS = "삭제 됐습니다.";
    public static final String EVENT_SAVE_SUCCESS 	= "저장되었습니다.";
    public static final String EVENT_UPDATE_SUCCESS = "수정 됐습니다.";
    public static final String EVENT_SELECT_SUCCESS = "조회 됐습니다.";
    /****************** END 이벤트 처리 메시지 ******************************************************************/

    /****************** BEGIN return code ******************************************************************/
    public static final String RETURN_SUCCESS = "00";
    public static final String RETURN_ERROR = "99";
    /****************** END return code ******************************************************************/

    /****************** BEGIN init code vlaue ******************************************************************/
    public static final String STATE_NORMAL = "00";
    public static final String DELETED = "Y";
    public static final String NOT_DELETED = "N";
    /****************** END init code vlaue ******************************************************************/

    /****************** BEGIN req stat : 자재요청상태 ******************************************************************/
    public static final String REQ_STAT_REG = "01";	// 등록
    public static final String REQ_STAT_PCS = "02";	// 구매
    public static final String REQ_STAT_OUT = "03";	// 출고
    public static final String REQ_STAT_READY = "04";	// 중비오나료

    /****************** END req stat ******************************************************************/

    /****************** BEGIN pcs stat : 구매요청상태 ******************************************************************/
    public static final String PCS_STAT_INPUT 		= "01";	// 등록
    public static final String PCS_STAT_REQ_PAY 	= "02";	// 결제요청
    public static final String PCS_STAT_REQ_COMP 	= "03";	// 결제완료
    public static final String PCS_STAT_INCOME 		= "04";	// 입고
    /****************** END pcs stat ******************************************************************/

    /****************** BEGIN 입출고타입 code ******************************************************************/
    public static final String BOUND_TYPE_IN = "01";
    public static final String BOUND_TYPE_OUT = "02";
    /****************** END 입출고타입 code ******************************************************************/

    /****************** BEGIN 결제범위 code ******************************************************************/
    public static final String PAY_SCOPE_ALL = "01";
    public static final String PAY_SCOPE_PART = "02";
    /****************** END 입출고타입 code ******************************************************************/

    /****************** BEGIN 자재요청목적 text ******************************************************************/
    public static final String MATERIAL_DOC_REQ_USAGE = "작업 시공 자재";
    /****************** END 자재요청목적 text ******************************************************************/

    public static final String CONDITION_PARAM_KEY = "q.";

}