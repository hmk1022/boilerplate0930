package com.workerman.utils;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.StringTokenizer;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONValue;

import com.drew.imaging.ImageMetadataReader;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.exif.ExifIFD0Directory;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/*
 * /**
 * 클래스, 인터페이스 메소드에 대한 설명을 기술합니다.
 *
 *   메소드의 경우는 다음 항목들을 기록하십시오:
 *      - 메소드의 작성의도
 *      - 메소드를 사용하기 위한 사전조건(pre condition) 과 사후조건(post condition)
 *      - 부작용
 *      - 종속성 (종속되는 라이브러리, 클래스, 메소드 등)
 *      - 사용시 주의해야 할 점
 *      - 누가 이 메소드를 호출하는가
 *      - 언제 이 메소드를 재정의해야 하는가
 *      - 메소드 재정의 시 어디서 부모 메소드를 호출해야 하는가(super 키워드를 사용하여)
 *      - 제어 흐름 및 상태 전이에 관련된 내용들
 *
 */
/**
 * 사용자 정의 함수
 * 
 * @author : hyun
 * @version : 1.0 2008. 01. 07
 */
public class Utils {
	
	private static final String DATEFORMATMILLI = "yyyy-MM-dd HH:mm:ss";
	private static final SimpleDateFormat formatter = new SimpleDateFormat(DATEFORMATMILLI);

	/**
	 * 페이징용 NO값 증가
	 * 
	 * @param totalRecord
	 *            : 전체 레코드수
	 * @param pageSize
	 *            : 페이지 사이즈
	 * @param nowPage
	 *            : 현재페이지
	 * @return : 현재페이지 시작 NO
	 */
	public static int getNumVal(int pageSize, int nowPage) {
		int numVal = pageSize * (nowPage - 1);
		return numVal;
	}

	/**
	 * 페이징용 NO값 감소
	 * 
	 * @param totalRecord
	 *            : 전체 레코드수
	 * @param pageSize
	 *            : 페이지 사이즈
	 * @param nowPage
	 *            : 현재페이지
	 * @return : 현재페이지 끝 NO
	 */
	public static int getNumValPre(int totalRecord, int pageSize, int nowPage) {
		int numVal = totalRecord - (pageSize * (nowPage - 1));
		// int numVal = pageSize * (nowPage - 1);
		return numVal;
	}

	/**
	 * 페이징용 - 전체페이지 개수 구하기
	 * 
	 * @param totalRecord
	 *            : 전체 레코드수
	 * @param pageSize
	 *            : 페이지 사이즈
	 * @return : 전체페이지 수
	 */
	public static int getTotalPage(int totalRecord, int pageSize) {
		int totalPage = 0;
		if (totalRecord > 0) {
			totalPage = totalRecord / pageSize;
			if (totalRecord % pageSize != 0){
				totalPage = totalPage + 1;
			}
		}

		// 레코드가 없으면 현재페이지와 전체페이지는 1
		if (totalPage == 0){
			totalPage = 1;
		}
		
		return totalPage;
	}

	/**
	 * 문자형을 숫자로 변환
	 * 
	 * @param strArg
	 *            : 문자
	 * @param defaultValue
	 *            : exception 경우 초기값
	 * @return : 숫자
	 */
	public static int parseInt(String strArg, int defaultValue) {
		int returnValue;

		try {
			if (StringUtils.isEmpty(StringUtils.trim(strArg)))
				returnValue = defaultValue;
			else
				returnValue = Integer.parseInt(StringUtils.trim(strArg));
		} catch (Exception e) {
			returnValue = defaultValue;
		}

		return returnValue;
	}

	/**
	 * Data 날짜를 원하는 String 형식으로 변경
	 * 
	 * @param date
	 *            : 날짜형
	 * @param format
	 *            : 형식 ex)'yyyy-mm-dd'
	 * @return String : 형식의 결과값값
	 */
	public static String getFormatDate(java.util.Date date, String format) {
		if (date == null || format == null)
			return "";

		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}
	

	/**
	 * 파일이름용 임시코드 구하기 - 6으로 시작하는 10자리 난수
	 * 
	 * @return String
	 */
	public static String getTempCode() {
		return "6" + StringUtils.rightPad(RandomStringUtils.randomNumeric(8), 9, "0");
	}

	/**
	 * byte단위 자르기 - 한글뷰를 위한 자르기용
	 * 
	 * @param : 입력 글자
	 * @param : byte 수
	 * @return : 출력 글자
	 */
	public static String getByteCut(String str, int sz) {
		if (StringUtils.isEmpty(str) || str.getBytes().length <= sz) {
			return str;
		}

		String a = str;
		int i = 0;
		String imsi = "";
		String rlt = "";
		imsi = a.substring(0, 1);

		while (i < sz) {
			byte[] ar = imsi.getBytes();
			i += ar.length;
			rlt += imsi;
			a = a.substring(1);
			if (a.length() == 1) {
				imsi = a;
			} else if (a.length() > 1) {
				imsi = a.substring(0, 1);
			}
		}
		return rlt + "..";
	}

	/**
	 * 유선전화번호 지역번호 체크
	 * 
	 * @param arg
	 *            : 전화번호
	 * @return : 유선전화 지역번호형식인 경우 true
	 */
	public static boolean isPhoneType(String arg) {
		boolean result = false;
		arg = StringUtils.trim(arg);

		String areaArg = StringUtils.substring(arg, 0, 3);

		if (StringUtils.equals(StringUtils.substring(arg, 0, 2), "02") && arg.length() >= 9 && arg.length() <= 10) {
			result = true;
		} else if (arg.length() >= 10 && arg.length() <= 11) {
			if ("031".equals(areaArg) || "032".equals(areaArg) || "033".equals(areaArg) || "041".equals(areaArg) || "042".equals(areaArg)
					|| "043".equals(areaArg)) {
				result = true;
			}

			if ("051".equals(areaArg) || "052".equals(areaArg) || "053".equals(areaArg) || "054".equals(areaArg) || "055".equals(areaArg)) {
				result = true;
			}

			if ("061".equals(areaArg) || "062".equals(areaArg) || "063".equals(areaArg) || "070".equals(areaArg)) {
				result = true;
			}
		}

		return result;
	}

	/**
	 * 휴대전화번호 체크
	 * 
	 * @param arg
	 *            전화번호
	 * @return 후대전화번호형식인 경우 true
	 */
	public static boolean isHpType(String arg) {
		boolean result = false;
		arg = StringUtils.trim(arg);

		String areaArg = StringUtils.substring(arg, 0, 3);

		if (StringUtils.equals(areaArg, "010") && arg.length() >= 10 && arg.length() <= 11) {
			result = true;
		} else if (StringUtils.equals(areaArg, "011") && arg.length() >= 10 && arg.length() <= 11) {
			result = true;
		} else if (StringUtils.equals(areaArg, "016") && arg.length() >= 10 && arg.length() <= 11) {
			result = true;
		} else if (StringUtils.equals(areaArg, "017") && arg.length() >= 10 && arg.length() <= 11) {
			result = true;
		} else if (StringUtils.equals(areaArg, "018") && arg.length() >= 10 && arg.length() <= 11) {
			result = true;
		} else if (StringUtils.equals(areaArg, "019") && arg.length() >= 10 && arg.length() <= 11) {
			result = true;
		}

		return result;
	}

	/**
	 * 전화번호 형식으로 바꿈
	 * 
	 * @param arg
	 *            : 전화번호(ex 021111111)
	 * @return : 전화번호 형식(ex 02-111-1111)
	 */
	public static String toPhoneType(String arg) {
		String str = "";
		if (arg != null && arg.length() > 8) {
			if (!StringUtils.isEmpty(arg)) {
				if (arg.length() > 12) {
					if (arg.substring(0, 2).equals("02")) {
						str = "02-" + arg.substring(2, arg.length() - 8);
					} else if (arg.substring(0, 4).equals("0502")) {
						str = "0502-" + arg.substring(4, arg.length() - 8);
					} else {
						str = arg.substring(0, 3) + "-" + arg.substring(3, arg.length() - 8);
					}

					str = str + "-" + arg.substring(arg.length() - 8, arg.length() - 4) + " ~ " + arg.substring(arg.length() - 4, arg.length());
				} else {
					if (arg.substring(0, 2).equals("02")) {
						str = "02-" + arg.substring(2, arg.length() - 4);
					} else if (arg.substring(0, 4).equals("0502")) {
						str = "0502-" + arg.substring(4, arg.length() - 4);
					} else {
						str = arg.substring(0, 3) + "-" + arg.substring(3, arg.length() - 4);
					}

					str = str + "-" + arg.substring(arg.length() - 4, arg.length());
				}
			}
		} else {
			str = arg;
		}
		return str;
	}

	/**
	 * 전화번호 분리
	 * 
	 * @param arg
	 * @return
	 */
	public static String[] getSplitPhone(String arg) {
		String[] arr = new String[3];

		if (arg.length() >= 9) {
			if ("02".equals(StringUtils.left(arg, 2))) {
				arr[0] = "02";
				arr[1] = arg.substring(2, arg.length() - 4);
			} else {
				arr[0] = StringUtils.left(arg, 3);
				arr[1] = arg.substring(3, arg.length() - 4);
			}
			arr[2] = StringUtils.right(arg, 4);
		}
		return arr;
	}

	/**
	 * 전화번호/핸드폰번호/이메일 등
	 * 리스트에 원하는 위치로 순서를 바꿔줌
	 * @param changeList
	 * @param changeName	
	 * @param orderIdx		
	 * @return
	 */
	public static List<String> changeOrderList(List<String> changeList, String changeName, int orderIdx) {
		changeList.remove(changeList.indexOf(changeName));
		changeList.remove(0);
		changeList.add(orderIdx, changeName);
		return changeList;
	}
	
	/**
	 * 유선전화번호 리스트
	 */
	public static List<String> getTelList() {
		List<String> areaNumList = new ArrayList<String>();
		areaNumList.add("선택");
		areaNumList.add("02");
		areaNumList.add("031");
		areaNumList.add("032");
		areaNumList.add("033");
		areaNumList.add("041");
		areaNumList.add("042");
		areaNumList.add("051");
		areaNumList.add("052");
		areaNumList.add("054");
		areaNumList.add("055");
		areaNumList.add("061");
		areaNumList.add("062");
		areaNumList.add("063");
		areaNumList.add("064");
		areaNumList.add("070");

		return areaNumList;
	}

	/**
	 * 휴대폰 리스트
	 */
	public static List<String> getHpList() {
		List<String> hpList = new ArrayList<String>();
		hpList.add("선택");
		hpList.add("010");
		hpList.add("011");
		hpList.add("016");
		hpList.add("017");
		hpList.add("018");
		hpList.add("019");
		return hpList;
	}

	/**
	 * 메일 리스트
	 */
	public static List<String> getMailList() {
		List<String> mailList = new ArrayList<String>();
		mailList.add("직접입력");
		mailList.add("paran.com");
		mailList.add("naver.com");
		mailList.add("chol.com");
		mailList.add("dreamwiz.com");
		mailList.add("empal.com");
		mailList.add("freechal.com");
		mailList.add("gmail.com");
		mailList.add("hanmail.net");
		mailList.add("hotmail.com");
		mailList.add("hanmir.com");
		mailList.add("korea.com");
		mailList.add("lycos.com");
		mailList.add("nate.com");
		mailList.add("yahoo.com");
		mailList.add("yahoo.co.kr");
		return mailList;
	}

	/**
	 * 질문 리스트
	 */
	public static List<String> getPwdFaqList() {
		List<String> questList = new ArrayList<String>();
		questList.add("초등학교 첫사랑 이름은?");
		questList.add("나만의 추억은 장소는?");
		questList.add("나의 좌우명은?");
		questList.add("내가 가장 좋아하는 색깔은?");
		questList.add("내가 가장 소중히 여기는 것은?");
		questList.add("내가 꼭 가보고 싶은 곳은?");
		questList.add("가장 인상깊게 본 영화는?");
		questList.add("나의 꿈은?");
		questList.add("나와 가장 닮은 연예인은?");
		questList.add("나와 가장 친한 친구는?");
		questList.add("내가 가장 좋아하는 노래는?");
		questList.add("출신 초등학교 이름은?");
		questList.add("내 생애 잊지못할 날은?");
		return questList;
	}

	/**
	 * 오늘날짜에서 이전 혹은 이후 날짜값을 받아온다.
	 * 
	 * 0인 경우 현재 날짜값이 반환된다. static method 이므로 객체 생성없이 바로 클래스 접근이 가능하다.
	 * 
	 * @param addDate
	 *            가감하고자 하는 날짜의 수.
	 * 
	 * @return String YYYYMMDD 포맷형식의 날짜값을 반환한다.
	 */
	@SuppressWarnings("static-access")
	public static String getDate(int addDate) {

		DecimalFormat df = new DecimalFormat("00");

		Calendar currentCalendar = Calendar.getInstance();

		currentCalendar.add(currentCalendar.DATE, addDate);

		String strYear = Integer.toString(currentCalendar.get(Calendar.YEAR));
		String strMonth = df.format(currentCalendar.get(Calendar.MONTH) + 1);
		String strDay = df.format(currentCalendar.get(Calendar.DATE));
		String strDate = strYear + strMonth + strDay;

		return strDate;
	}

	public static String getUUID() {
		SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHHmmss");
		return date.format(new Date()) + RandomStringUtils.randomNumeric(4);
	}
	
	/**
	 * 영대 + 영소 + 숫자 조합 = 조합문자열
	 * @param num
	 * @return
	 */
	public static String alphabetNumberMixing(int mixStrNum) {
		long[] alphaVal = {65, 97};
		String mixStr = "";
		for(int i=0; i<mixStrNum; i++) {
			long alphabetDist = (long)(Math.random() * 2);
			long num =(long)(Math.random() * 9)+1;
			long alphabet = alphaVal[(int)alphabetDist] + ((long)(Math.random() * 25)+1);
			if(((long)(Math.random() * mixStrNum)+1) == ((long)(Math.random() * mixStrNum)+1)) {
				mixStr += ""+num;
			}else {
				mixStr += ""+(char)(alphabet);
			}
		}
		return mixStr;
	}
	
	/**
	 * 원하는 최대 숫자  만큼 램덤수를 리턴
	 * @param maxNum
	 * @return
	 */
	public static long randomNumber(int maxNum) {
		return (long) (Math.random()*maxNum)+1;
	}
	
	/**
	 * 인증번호 리턴
	 * @param maxLength
	 * @return
	 */
	public static String authorizationNumber(int maxLength) {
		String nums = "";
		long[] numArry = new long[maxLength];
		for(int i=0; i<maxLength; i++) {
			numArry[i] = (long)(Math.random()*9)+1;
			nums += numArry[i];
		}
		return nums;
	}
	
	/**
	 * 저장할 파일경로 폴더 생성
	 * @param rootPath
	 * @param id
	 * @param ranNum
	 * @param alpaNum
	 * @return
	 */
	public static String makeDirectory(String rootPath, String id, String ranNum, String alpaNum) {
		StringBuilder makeDirStr = new StringBuilder();
		long timeMillis = Calendar.getInstance().getTimeInMillis();
		makeDirStr.append(rootPath);
		makeDirStr.append("/");
		makeDirStr.append(Utils.getFormatDate(new Date(), "yyyyMMdd"));
		makeDirStr.append("/");
		makeDirStr.append(Utils.randomNumber(Integer.parseInt(ranNum)));
		makeDirStr.append("/");
		makeDirStr.append(id);
		makeDirStr.append("_");
		makeDirStr.append(timeMillis);
		makeDirStr.append(Utils.alphabetNumberMixing(Integer.parseInt(alpaNum)));
		makeDirStr.append("/");
		File newDir = new File(makeDirStr.toString());
		if(!newDir.exists()) {
			boolean isMakes = newDir.mkdirs();
			if(isMakes) {
				return makeDirStr.toString();
			}else {
				return null;
			}
		}else {
			return makeDirStr.toString();
		}
	}
	
	/**
	 * 최상위경로 + 현재날짜 + 아이디 
	 * 조합 폴더 생성
	 * @param rootPath
	 * @param id
	 * @param datePattern
	 * @return
	 */
	public static String makeDirectory(String rootPath, String id, String datePattern) {
		StringBuilder makeDirStr = new StringBuilder();
		makeDirStr.append(rootPath);
		makeDirStr.append("/");
		makeDirStr.append(Utils.getFormatDate(new Date(), "yyyyMMdd"));
		makeDirStr.append("/");
		makeDirStr.append(id);
		makeDirStr.append("/");
		File newDir = new File(makeDirStr.toString());
		if(!newDir.exists()) {
			boolean isMakes = newDir.mkdirs();
			if(isMakes) {
				return makeDirStr.toString();
			}else {
				return null;
			}
		}else {
			return makeDirStr.toString();
		}
	}
	
	/**
	 * 최상위경로  + 아이디 
	 * 조합 폴더 생성
	 * @param rootPath
	 * @param id
	 * @return
	 */
	public static String makeDirectory(String rootPath, String id) {
		StringBuilder makeDirStr = new StringBuilder();
		makeDirStr.append(rootPath);
		makeDirStr.append("/");
		makeDirStr.append(id);
		makeDirStr.append("/");
		File newDir = new File(makeDirStr.toString());
		if(!newDir.exists()) {
			boolean isMakes = newDir.mkdirs();
			if(isMakes) {
				return makeDirStr.toString();
			}else {
				return null;
			}
		}else {
			return makeDirStr.toString();
		}
	}
	
	/**
	 * 파일 삭제
	 * @param filePath
	 * @return
	 */
	public static boolean removeFile(String filePath) {
		File file = new File(filePath);
		if(file.exists()) {
			file.delete();
			return true;
		}
		return false;
	}
	
	/**
	 *	파일  디렉토리 및 파일 삭제
	 *
	 * @param file
	 */
	public static void deleteSubFile(File file) {
		if (file.isDirectory()) {
			if (file.listFiles().length != 0) {
				File[] fileList = file.listFiles();
				for (int i = 0; i < fileList.length; i++) {

					// 디렉토리이고 서브 디렉토리가 있을 경우 리커젼을 한다...
					deleteSubFile(fileList[i]);
					file.delete();
				}
			} else {

				// 파일 트리의 리프까지 도달했을때 삭제...
				file.delete();
			}
		} else {

			// 파일 일 경우 리커젼 없이 삭제...
			file.delete();
		}
	}
	
	/**
	 * URL 인코딩
	 * @param uri
	 * @return
	 */
	public static String encodeUri(String uri) {
		String newUri = "";
		int skip = 0;
		StringTokenizer st = new StringTokenizer(uri, "/ ", true);
		while (st.hasMoreTokens()) {
			String tok = st.nextToken();
			if (tok.equals("/"))
				newUri += "/";
			else if (tok.equals(" "))
				newUri += "%20";
			else {
				if (skip > 0) {
					try {
						newUri += URLEncoder.encode(tok, "UTF-8");
					} catch (UnsupportedEncodingException uee) {
						uee.printStackTrace();
					};
				} else if (skip == 0) {
					newUri += tok;
				}
			}
			skip++;
		}
		return newUri;
	}
	
	/**
	 * 특수문자 및 공백제거
	 * @param str
	 * @return str
	 */
	public static String getSTRFilter(String str) {
		String str_imsi = "";
		String[] filter_word = { "", " ", "\\.", "\\?", "\\/", "\\>", "\\~",
				"\\!", "\\@", "\\#", "\\$", "\\%", "\\^", "\\&", "\\*", "\\(",
				"\\)", "\\_", "\\-", "\\+", "\\=", "\\|", "\\\\", "\\}", "\\]",
				"\\{", "\\[", "\\\"", "\\'", "\\:", "\\;", "\\<", "\\,", "\\>",
				"\\.", "\\?", "\\/", "\\`" };

		for (int i = 0; i < filter_word.length; i++) {
			str_imsi = str.replaceAll(filter_word[i], "");
			str = str_imsi;
		}
		return str;
	}
	
	public static Object jsonToObject(String json, Class<?> type) {
		Object ob = null;
		try {
			ob = new ObjectMapper().readValue(json, type);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ob;
	}
	
	public static String objectToJson(Object object) {
		String ob = null;
		try {
			ob = new ObjectMapper().writeValueAsString(object);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ob;
	}
	
	public static String mapToJson(Map<String, Object> data) {
		
		try {
				
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(SerializationFeature.INDENT_OUTPUT, true); // 로그 예쁘게 남기기
			return mapper.writeValueAsString(data);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public static Object mapToObject(Map<String, Object> data, Class<?> type) {
		
		try {
			ObjectMapper mapper = new ObjectMapper(); 
			return mapper.convertValue(data, type);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 주어진 날짜가 현재일보다 높은지 여부 판단 true 지나지않음, false 지난일자
	 * @param date
	 * @return
	 */
	public static boolean dateValidationCheck(String date){
		boolean result = false; 
		try {
			
			if(date == null){
				return false;
			}
			
			Date fromDate = formatter.parse(date);
			Date currentDate  = new Date();
			
			if(currentDate.getTime() < fromDate.getTime()){
				result = true;
			}else{
				result = false;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 현재시간에 주어진 시간값 만큼 더함
	 * @param addTime
	 * @return
	 */
	public static String getAddMinutes(long addTime) {
		
		String result = "";
		try {
			
			Date fromDate = new Date();
			
			long lCurTime = fromDate.getTime() + addTime;
			
			result = formatter.format(new Date(lCurTime));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * 현재일자구하기
	 * @return
	 */
	public static String getCurrentDate(){
		return formatter.format(new Date());
	}
	
	/**
	 * error=error_invalid_parameter&code=-113  ------> MAP
	 * @param input
	 * @return
	 */
	public static Map<String, String> paramToMap(String input){
		//error=error_invalid_parameter&code=-113
		Map<String, String> map = new HashMap<String, String>();
		
		if(input == null)
			return map;
		
		String array[] = input.split("&");
		for (String param : array) {
			String data[] = param.split("=");
			if(data != null && data.length == 2){
				map.put(data[0], data[1]);
			}
		}
		
		return map;
	}
	
	/**
	 * 주어진시간으로 부터 현재시간까지의 경과시간(초)
	 * @param fromDtm
	 * @return
	 */
	public static long diffTimeToCurTime(String fromDtm) {
		long lDiff = 0;
		try {
			if (fromDtm == null || fromDtm.equals("") || fromDtm.equals("null")) {
				return 0;
			}
			Date fromDate = null;
			Date toDate = new Date();
			
			if(fromDtm.indexOf(".") != -1){
				fromDtm = fromDtm.substring(0, fromDtm.indexOf("."));
			}
			System.out.println("fromDtm : "+fromDtm);
			System.out.println("curDtm : "+formatter.format(toDate));
			
			fromDate = formatter.parse(fromDtm);
			
			long lCurTime = fromDate.getTime();
			long lCurTimeTemp = toDate.getTime();
			lDiff = lCurTimeTemp - lCurTime;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lDiff / 1000;
	}
	
	public static String gpsToAddress(String gps){
		String method = "http://maps.googleapis.com/maps/api/geocode/json?latlng="+gps.replace(" ", "")+"&sensor=false&language=ko";
		try {
			String json = excutePost(method, "", true);

			JSONObject jsonobj = (JSONObject)JSONValue.parse(json);
			JSONArray result = (JSONArray)jsonobj.get("results");
			JSONObject dep1 = (JSONObject)result.get(0);
			String dep2 = (String)dep1.get("formatted_address");
			//System.out.println(dep2);
			return dep2;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
//	public static void main(String[] args) {
//		String test = "{\"respcode\":\"0\"}";
//		JSONObject jsonobj = (JSONObject)JSONValue.parse(test);
//		String respcode = (String)jsonobj.get("respcode");
//		System.out.println(respcode);
//	}
	
	public static String excutePost(String targetURL, String urlParameters, boolean isJson) {
		System.out.println("URL : "+targetURL);
		System.out.println("DATA : "+urlParameters);
		
		URL url;
		HttpURLConnection connection = null;
		try {
			// Create connection
			url = new URL(targetURL);
		      connection = (HttpURLConnection)url.openConnection();
		      connection.setRequestMethod("POST");
		      connection.setRequestProperty("Content-Type", isJson ? "application/json" : "application/x-www-form-urlencoded");
					
		      connection.setRequestProperty("Content-Length", "" + 
		               Integer.toString(urlParameters.getBytes().length));
		      connection.setRequestProperty("Content-Language", "UTF-8");  
		      
		      connection.setUseCaches (false);
		      connection.setDoInput(true);
		      connection.setDoOutput(true);
		      
			// Send request
			DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
			wr.write( urlParameters.getBytes("UTF-8") );
			wr.flush();
			wr.close();

			// Get Response
			InputStream is = connection.getInputStream();
			
			//System.out.println(connection.getHeaderFields());
			
			BufferedReader rd = new BufferedReader(new InputStreamReader(is, "UTF-8"));
			
			String line;
			StringBuffer response = new StringBuffer();
			while ((line = rd.readLine()) != null) {
				response.append(line);
				//response.append('\r');
			}
			rd.close();
			//System.out.println(response.toString());
			return response.toString();

		} catch (Exception e) {

			e.printStackTrace();
			return null;

		} finally {

			if (connection != null) {
				connection.disconnect();
			}
		}
	}
	
	/**
	 * 주어진 시간이 현재시간보다 앞인가?
	 * @param from
	 * @return
	 */
	public static boolean isValidData(String from){
		
		try {
			if(from == null){
				return false;
			}
			
			Date fromDate = formatter.parse(from);
			
			Date currentDate = new Date();
			
			if(fromDate.getTime() > currentDate.getTime()){
				return true;
			}else{
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * 두점사이거리측정
	 * @param lat1
	 * @param lon1
	 * @param lat2
	 * @param lon2
	 * @return
	 */
	public static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
		  int R = 6371; // km
		  double dLat = (lat2 - lat1)* Math.PI / 180;
		  double dLon = (lon2 - lon1)* Math.PI / 180; 
		  double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
		          Math.cos(lat1* Math.PI / 180) * Math.cos(lat2* Math.PI / 180) * 
		          Math.sin(dLon / 2) * Math.sin(dLon / 2); 
		  double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a)); 
		  double d = R * c;
		  return d;
	}
	

	
	public static String mapToUrlParam(Map<String, Object> data){
		
		String param = "";
		Set<String> keySet = data.keySet();
		
		for (String key : keySet) {
			param += key+"="+data.get(key)+"&";
		}
		return param;
	}
	
	public static String getFormatDate(String format) {
		if (format == null)
			return "";

		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(new Date());
	}
	
	/**
	 * 폰타입으로 변경
	 * @param input
	 * @return
	 */
	public static String formatToPhone(String input){
		
		if(input == null)
			return null;
		
		String tmp = "";
		if(input.startsWith("02") && input.length() == 10) {
			tmp = input.substring(0,2)+"-"+input.substring(2,6)+"-"+input.substring(6);
		}else if(input.length() == 10){
			tmp = input.substring(0,3)+"-"+input.substring(3,6)+"-"+input.substring(6);
		}else if(input.length() == 11){
			tmp = input.substring(0,3)+"-"+input.substring(3,7)+"-"+input.substring(7);
		}else{
			tmp = input;
		}
		
		return tmp;
	}

	public static long getCurrentTimeMillis() {
		try {
			return System.currentTimeMillis();
		} catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * 바이너리 스트링을 이미지로 저장(서버용)
	 * @param input
	 * @param savePath
	 */
	public static void Base64StringToImageSave(String input, String savePath) throws Exception{
		byte[] bytes = Base64.decodeBase64(input);

		FileOutputStream fos = null;
		fos = new FileOutputStream(savePath);

		fos.write(bytes);
		if (fos != null) {
			fos.close();
		}
	}
	
	/**
	 * 이미지를 바이너리 스트링으로 변환(단말용)
	 * @param path
	 * @return
	 */
	public static String ImageToBase64String(String path){
		String encodedString = null;
		try {
			
			InputStream inputStream = new FileInputStream(path);
			byte[] bytes;
			byte[] buffer = new byte[8192];
			int bytesRead;
			ByteArrayOutputStream output = new ByteArrayOutputStream();
			try {
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					output.write(buffer, 0, bytesRead);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			bytes = output.toByteArray();
			encodedString = Base64.encodeBase64String(bytes);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return encodedString;
	}
	
	/**
	 * 파일명확장자추출
	 * @param name
	 * @return
	 */
	public static String getExtensions(String name){
		if(name == null || name.equals("")){
			return name;
		}
		
		if(name.indexOf(".") != -1){
			return name.substring(name.lastIndexOf(".")+1);
		}else{
			return name;
		}
	}
	
	/**
	 * 두 GPS좌표간의 거리측정 1 = 1km, 0.1 = 100m
	 * @param startPointLon
	 * @param startPointLat
	 * @param endPointLon
	 * @param endPointLat
	 * @return
	 * @throws Exception
	 */
	public static String distance(String fromGps, String toGps) throws Exception {
		
		if(fromGps == null || toGps == null || fromGps.equals("") || toGps.equals("") 
				|| fromGps.indexOf(",") == -1 || toGps.indexOf(",") == -1){
			return "???";
		}
		
		double startPointLon = Double.parseDouble(fromGps.split(",")[0]); 
		double startPointLat = Double.parseDouble(fromGps.split(",")[1]); 
		double endPointLon = Double.parseDouble(toGps.split(",")[0]); 
		double endPointLat = Double.parseDouble(toGps.split(",")[1]);
		
		double d2r = Math.PI / 180;
		double dLon = (endPointLon - startPointLon) * d2r;
		double dLat = (endPointLat - startPointLat) * d2r;
		
		double a = Math.pow(Math.sin(dLat / 2.0), 2)
		            + Math.cos(startPointLat * d2r)
		            * Math.cos(endPointLat * d2r)
		            * Math.pow(Math.sin(dLon / 2.0), 2);
		
		double c = Math.atan2(Math.sqrt(a), Math.sqrt(1 - a)) * 2;
		    
	    double distance = c * 6378;
	    
	    return distance+"";
	}
	
	public static void shellCmd(String command) throws Exception {
        Runtime runtime = Runtime.getRuntime();
        Process process = runtime.exec(command);
        InputStream is = process.getInputStream();
        InputStreamReader isr = new InputStreamReader(is);
        BufferedReader br = new BufferedReader(isr);
        String line;
        while((line = br.readLine()) != null) {
                       System.out.println(line);
        }
	}
	
	public static String addressToGps(String address){
		String method = "http://maps.google.com/maps/api/geocode/json?address="+address.replace(" ", "")+"&sensor=false&language=ko";
		
		String json = excutePost(method, "", false);
		JSONObject jsonobj = (JSONObject)JSONValue.parse(json);
		JSONArray result = (JSONArray)jsonobj.get("results");
		JSONObject dep1 = (JSONObject)result.get(0);
		JSONObject dep2 = (JSONObject)dep1.get("geometry");
		JSONObject dep3 = (JSONObject)dep2.get("location");
		double lat = (Double)dep3.get("lat");
		double lng = (Double)dep3.get("lng");
		//System.out.println(dep2);
		return lat+", "+lng;
		
	}
	
	public static String addressToGpsDaum(String address){
		String method = "http://apis.daum.net/local/geo/addr2coord?apikey=69d40f0354ada9b850dd09d5530251b3&q="+address+"&output=json";
		
		String json = excutePost(method, "", false);
		JSONObject jsonobj = (JSONObject)JSONValue.parse(json);
		JSONObject channel = (JSONObject)jsonobj.get("channel");
		JSONArray item = (JSONArray)channel.get("item");
		JSONObject dep1 = (JSONObject)item.get(0);
		double lat = (Double)dep1.get("lat");
		double lng = (Double)dep1.get("lng");
		//System.out.println(dep2);
		return lat+", "+lng;
		
	}
	
	public static String gpsToAddressDaum(String gps){
		String result = "";
		if(gps == null || gps.equals("") || gps.indexOf(",") == -1){
			return null;
		}
		String gpsArray[] = gps.split(",");
		String latitude = gpsArray[0].replace(" ","");
		String longitude = gpsArray[1].replace(" ","");
		String method = "https://apis.daum.net/local/geo/coord2addr?apikey=69d40f0354ada9b850dd09d5530251b3&longitude="+longitude+"&latitude="+latitude+"&inputCoordSystem=WGS84&output=json";
		String json = excutePost(method, "", false);
		JSONObject jsonobj = (JSONObject)JSONValue.parse(json);
		result = (String)jsonobj.get("fullName");
		
		return result;
		
	}
	
	/**
	 * 난수생성
	 * @param min
	 * @param max
	 * @return
	 */
	public static int randInt(int min, int max) {

	    Random rand = new Random();
	    int randomNum = rand.nextInt((max - min) + 1) + min;

	    return randomNum;
	}
	
	/**
	 * 퍼센트에 의한 난수
	 * @param s_min 
	 * @param s_max
	 * @param per_s s변수 범위의 퍼센트 
	 * @param e_min
	 * @param e_max
	 * @return
	 */
	public static int randInt(int s_min, int s_max, int per_s, int e_min, int e_max) {

		int result = 0;
		
		int per = randInt(1,100);
		
		if(per <= per_s){
			result = randInt(s_min, s_max);
		}else{
			result = randInt(e_min, e_max);
		}
		
	    return result;
	}
	
	public static String HMAC_MD5_encode(String key, String message) throws Exception {

        SecretKeySpec keySpec = new SecretKeySpec(key.getBytes(), "HmacMD5");

        Mac mac = Mac.getInstance("HmacMD5");
        mac.init(keySpec);
        byte[] rawHmac = mac.doFinal(message.getBytes());

        return Hex.encodeHexString(rawHmac);
    }
	
	public static List<Object> parseProfilesJson(String jsonStr) {
        try {
            JSONArray nameArray = (JSONArray) JSONSerializer.toJSON(jsonStr);
            return toList(nameArray);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }
	
	public static Map<String, Object> jsonToMap(JSONObject json) throws JSONException {
	    Map<String, Object> retMap = new HashMap<String, Object>();

	    if(json != null) {
	        retMap = toMap(json);
	    }
	    return retMap;
	}
	
	@SuppressWarnings("unchecked")
	public static Map<String, Object> objectToMap(Object obj) throws JSONException {
	    ObjectMapper objectMapper = new ObjectMapper();
	    return objectMapper.convertValue(obj, Map.class);
	}

	@SuppressWarnings("unchecked")
	public static Map<String, Object> toMap(JSONObject object) throws JSONException {
	    Map<String, Object> map = new HashMap<String, Object>();

	    Set<String> keys = object.keySet();
	    Iterator<String> keysItr = keys.iterator();
	    while(keysItr.hasNext()) {
	        String key = keysItr.next();
	        Object value = object.get(key);

	        if(value instanceof JSONArray) {
	            value = toList((JSONArray) value);
	        }

	        else if(value instanceof JSONObject) {
	            value = toMap((JSONObject) value);
	        }
	        map.put(key, value);
	    }
	    return map;
	}

	public static List<Object> toList(JSONArray array) throws JSONException {
	    List<Object> list = new ArrayList<Object>();
	    for(int i = 0; i < array.size(); i++) {
	        Object value = array.get(i);
	        if(value instanceof JSONArray) {
	            value = toList((JSONArray) value);
	        }

	        else if(value instanceof JSONObject) {
	            value = toMap((JSONObject) value);
	        }
	        list.add(value);
	    }
	    return list;
	}
	
	public static String numberTwoLength(String input) {
		if(input.length() == 1) {
			input = "0"+input;
		}
		return input;
	}
	
	/**
	 * 두날짜 사이의 날짜목록 쿼리
	 * @param form
	 * @param to
	 * @return
	 */
	public static String getDayListQueary(String form, String to) {
		StringBuffer sb = new StringBuffer();
		
		try {
			final String DATE_PATTERN = "yyyy-MM-dd";
	        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
	        Date startDate = sdf.parse(form);
	        Date endDate = sdf.parse(to);
	        Date currentDate = startDate;
	        while (currentDate.compareTo(endDate) <= 0) {
	        	sb.append("select '"+sdf.format(currentDate)+"' as dates union ");
	            Calendar c = Calendar.getInstance();
	            c.setTime(currentDate);
	            c.add(Calendar.DAY_OF_MONTH, 1);
	            currentDate = c.getTime();
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return sb.toString().substring(0, sb.toString().length()-6);
	}
	
	/**
	 * 두날짜 사이의 월목록 쿼리
	 * @param form
	 * @param to
	 * @return
	 */
	public static String getMonthListQueary(String form, String to) {
		StringBuffer sb = new StringBuffer();
		
		try {
			final String DATE_PATTERN = "yyyy-MM-dd";
			final String DATE_PATTERN_RETURN = "yyyy-MM";
	        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
	        SimpleDateFormat sdfr = new SimpleDateFormat(DATE_PATTERN_RETURN);
	        Date startDate = sdf.parse(form);
	        Date endDate = sdf.parse(to);
	        Date currentDate = startDate;
	        while (currentDate.compareTo(endDate) <= 0) {
	        	sb.append("select '"+sdfr.format(currentDate)+"' as dates union ");
	            Calendar c = Calendar.getInstance();
	            c.setTime(currentDate);
	            c.add(Calendar.MONTH, 1);
	            currentDate = c.getTime();
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return sb.toString().substring(0, sb.toString().length()-6);
	}
	
	/**
	 * 두날짜사이의 년목록 쿼리
	 * @param form
	 * @param to
	 * @return
	 */
	public static String getYearListQueary(String form, String to) {
		StringBuffer sb = new StringBuffer();
		
		try {
			final String DATE_PATTERN = "yyyy-MM-dd";
			final String DATE_PATTERN_RETURN = "yyyy";
	        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
	        SimpleDateFormat sdfr = new SimpleDateFormat(DATE_PATTERN_RETURN);
	        Date startDate = sdf.parse(form);
	        Date endDate = sdf.parse(to);
	        Date currentDate = startDate;
	        while (currentDate.compareTo(endDate) <= 0) {
	        	sb.append("select '"+sdfr.format(currentDate)+"' as dates union ");
	            Calendar c = Calendar.getInstance();
	            c.setTime(currentDate);
	            c.add(Calendar.YEAR, 1);
	            currentDate = c.getTime();
	            sb.append("select '"+sdfr.format(currentDate)+"' as dates union ");
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return sb.toString().substring(0, sb.toString().length()-6);
	}
	
	public static String getHourListQueary() {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < 24; i++) {
			sb.append("select '"+numberTwoLength(i+"")+"' as dates union ");
		}
		return sb.toString().substring(0, sb.toString().length()-6);
	}
	
	/**
	 * IP추출
	 * @param request
	 * @return
	 */
	public static String getIP(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getHeader("Proxy-Client-IP");  
		}  
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getHeader("WL-Proxy-Client-IP");  
		}  
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getHeader("HTTP_CLIENT_IP");  
		}  
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
		}  
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getRemoteAddr();  
		}
		return ip;
	}
	
	/**
	 * 두날짜 사이의 날짜와 시간값을 1시간단위로 마지막날짜의 시간까지 쿼리로리턴한다.
	 * @param form
	 * @param to
	 * @return
	 */
	public static String getDateHourQueray(String form, String to) {
		
		if (form == null || to == null || form.equals("") || to.equals("")) {
			return "";
		}

		StringBuffer sb = new StringBuffer();

		try {
			final String DATE_PATTERN = "yyyy-MM-dd";
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
			Date startDate = sdf.parse(form);
			Date endDate = sdf.parse(to);
			Date currentDate = startDate;
			while (currentDate.compareTo(endDate) <= 0) {
				
				int stopHour = 24;
				
				if(currentDate.compareTo(endDate) == 0) {
					stopHour = Integer.parseInt(getFormatDate("HH"));
					if(stopHour < 23) {
						stopHour++;	
					}
				}
				
				for (int i = 0; i < stopHour; i++) {
					sb.append("select '" + sdf.format(currentDate)+" "+numberTwoLength(i + "") + "' as dates union ");
				}
				
				Calendar c = Calendar.getInstance();
				c.setTime(currentDate);
				c.add(Calendar.DAY_OF_MONTH, 1);
				currentDate = c.getTime();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return sb.toString().substring(0, sb.toString().length() - 6);
		
	}
	
	public static String getUrl(String input) {
		String sUrl="";
		String eUrl="";
		try {
			sUrl = input.substring(0, input.lastIndexOf("/")+1);
			eUrl = input.substring(input.lastIndexOf("/")+1, input.length()); // 한글과 공백을 포함한 부분 
			eUrl = URLEncoder.encode(eUrl,"UTF-8").replace("+", "%20");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return input = sUrl+ eUrl;
	}
	
	/**
	 * 이미지확장자검사
	 * @param name
	 * @return
	 */
	public static boolean isImg(String name) {
		if(name == null) return false;
		return ".jpg.gif.jpeg.png".indexOf(getExtensions(name).toLowerCase()) != -1; 
	}
//	public static void main(String[] args) {
//		System.out.println(getYearListQueary("2008-06-02","2018-05-30"));
////		System.out.println(getDayListQueary("2018-05-23","2018-05-30"));
////		System.out.println(getHourListQueary());
//	}

	
	public static String getRandomStr() {
		return Utils.getCurrentTimeMillis()+""+Utils.randInt(1000000000, 2000000000);
	}
	
	public static Map<String, String> splitQuery(String query) throws UnsupportedEncodingException {
	    Map<String, String> query_pairs = new LinkedHashMap<String, String>();
	    String[] pairs = query.split("&");
	    for (String pair : pairs) {
	        int idx = pair.indexOf("=");
	        query_pairs.put(URLDecoder.decode(pair.substring(0, idx), "UTF-8"), URLDecoder.decode(pair.substring(idx + 1), "UTF-8"));
	    }
	    return query_pairs;
	}
	
	public static String getBankNameByCode(String code) {
		
		Map<String, String> bank = new HashMap<String, String>();
		bank.put("03", "기업은행");
		bank.put("05", "외환은행");
		bank.put("11", "농협중앙회");
		bank.put("23", "SC제일은행");
		bank.put("32", "부산은행");
		bank.put("37", "전북은행");
		bank.put("53", "한국씨티은행");
		bank.put("81", "하나은행");
		bank.put("D1", "동양종합금융증권");
		bank.put("D3", "미래에셋증권");
		bank.put("D5", "우리투자증권");
		bank.put("D7", "HMC투자증권");
		bank.put("D9", "대신증권");
		bank.put("DB", "굿모닝신한증권");
		bank.put("DD", "유진투자증권");
		bank.put("DF", "신영증권");
		bank.put("04", "국민은행");
		bank.put("07", "수협중앙회");
		bank.put("20", "우리은행");
		bank.put("31", "대구은행");
		bank.put("34", "광주은행");
		bank.put("39", "경남은행");
		bank.put("71", "우체국");
		bank.put("88", "통합신한은행 (신한,조흥은행)");
		bank.put("D2", "현대증권");
		bank.put("D4", "한국투자증권");
		bank.put("D6", "하이투자증권");
		bank.put("D8", "SK증권");
		bank.put("DA", "하나대투증권");
		bank.put("DC", "동부증권");
		bank.put("DE", "메리츠증권");
		bank.put("BW", "뱅크월렛");
		
		return bank.get(code).toString();
	}
	
	@SuppressWarnings("unchecked")
	public static Map<String, Object> stringToMap(String json){
		
		Map<String, Object> resultMap = null;
		
		try {
			
			if(json == null){
				return null;
			}
			
			Object data = Utils.jsonToObject(json, Map.class);
			
			if(data == null){
				return null;
			}else{
				resultMap = (Map<String, Object>)data;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	public static String getFileName(String input) {
		if(input == null) {
			return null;
		}
		
		return input.substring(input.lastIndexOf("/")+1, input.length());
	}
	
	public static BufferedImage checkImage(File file,int orientation) throws IOException {
		BufferedImage bi = ImageIO.read(file);
		if(orientation == 1) {
			return bi;
		}else if(orientation == 6) {
			return rotateImage(bi,90);
		}else if(orientation == 3) {
			return rotateImage(bi,180);
		}else if(orientation == 8) {
			return rotateImage(bi,270);
		}else {
			return bi;
		}
	}
	
	public static int getOrientation(File file) throws Exception {
		int orientation = 1;
		Metadata metadata = ImageMetadataReader.readMetadata(file);
		try {
			Directory directory = metadata.getFirstDirectoryOfType(ExifIFD0Directory.class);
			if(directory != null) {
				orientation = directory.getInt(ExifIFD0Directory.TAG_ORIENTATION);
				
			}
		}catch(Exception ex) {
			
		}finally {
		}
		return orientation;
	}
	
	public static BufferedImage rotateImage(BufferedImage bi,int radians) {
		BufferedImage newImage;
		if(radians == 90 || radians == 270) {
			newImage = new BufferedImage(bi.getHeight(),bi.getWidth(),bi.getType());
		}else if(radians == 180) {
			newImage = new BufferedImage(bi.getWidth(),bi.getHeight(),bi.getType());
		}else {
			return bi;
		}
		
		Graphics2D graphics = (Graphics2D)newImage.getGraphics();
		graphics.rotate(Math.toRadians(radians),newImage.getWidth()/2,newImage.getHeight()/2);
		graphics.translate((newImage.getWidth()-bi.getWidth())/2, (newImage.getHeight()-bi.getHeight())/2);
		graphics.drawImage(bi,0,0,bi.getWidth(),bi.getHeight(),null);
		return newImage;
	}
	
	/**
	 * str to Long
	 * 
	 * @param str 
	 *            : String input value 
	 * @return : Long
	 */
	public static Long getLong(String str) {
		if(str == null) return null;
		else {
			try {
				return Long.valueOf(str);
			} catch(Exception e) {
				return null;
			}
		}
	}

}
