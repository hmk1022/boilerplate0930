package com.workerman.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

public class DateUtil {
	
	public static final String TIMEZONE_ID_KOREA = "KST";
	public static final int YEAR = 1;
	public static final int MONTH = 2;
	public static final int DAY = 3;

	/**
	 * 현재 날짜 정보를 반환한다.
	 * @return Date
	 */
	public static Date getCurrentDate() {
		return GregorianCalendar.getInstance(getTimeZone()).getTime();
	}

	/**
	 * 디폴트로 지정된 TimeZone을 얻는다.
	 * @return SimpleTimeZone
	 */
	public static TimeZone getTimeZone() {
		return TimeZone.getDefault();
	}

	/**
	 * 현재의 시간을 주어진 format 스트링으로  얻는다.
	 * @param formatter : yyyyMMdd....
	 * @return String
	 */
	public static String getCurrentTime(String formatter) {
		SimpleDateFormat fmt = new SimpleDateFormat(formatter);
		fmt.setTimeZone(getTimeZone());

		return fmt.format(getCurrentDate());
	}
	
	public static String addDate(String date, String format,  int field, int amount) throws Exception {
		SimpleDateFormat fmt = new SimpleDateFormat(format);
		
		Calendar calendar = Calendar.getInstance();
        calendar.setTime(fmt.parse(date));
        calendar.add(field, amount);
        
        return fmt.format(calendar.getTime());
	}
	
	public static Date addDate(Date date, int field, int amount) throws Exception {
		
		Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(field, amount);
                
        return calendar.getTime();
	}

	/**
	 * "yyyy/MM/dd"형식의 현재 날짜를 반환한다.
	 * @return "yyyy/MM/dd"형식의 현재 날짜
	 */
	public static String getCurrentDateString() {
		return getCurrentTime("yyyy/MM/dd");
	}

	/**
	 * "yyyyMMdd"형식의 현재 날짜를 반환한다.
	 * @return "yyyy/MM/dd"형식의 현재 날짜
	 */
	public static String getCurrentDateStr() {
		return getCurrentTime("yyyyMMdd");
	}
	
	/**
	 * "HHmmss.SSS" 형식의 현재시간(24H)를 반환한다.
	 * @return "HHmmss.SSS" 형식의 현재시간(24H)
	 */
	public static String getCurrentTimeString() {
		return getCurrentTime("HH:mm:ss.SSS");
	}

	/**
	 * "yyyy" 형식의 현재 년도(4자리)를 반환한다.
	 * @return String
	 */
	public static String getCurrentYear() {
		return getCurrentTime("yyyy");
	}

	/**
	 * "MM" 형식의 현재 월(2자리)를 반환한다.
	 * @return String
	 */
	public static String getCurrentMonth() {
		return getCurrentTime("MM");
	}

	/**
	 * "dd" 형식의 현재 날짜(2자리)를 반환한다.
	 * @return String
	 */
	public static String getCurrentDay() {
		return getCurrentTime("dd");
	}

	/**
	 * 지정된 형식으로 전달된 time에서 날짜 문자열을 반환한다.
	 * @param time 날짜로 변환할 밀리세컨드
	 * @param format ex : "yyyyMMddHHmmss"
	 * @return 날짜 문자열
	 */
	public static String getDateString(long time, String format) {
		Date date = new Date(time);
		SimpleDateFormat fmt = new SimpleDateFormat(format);
		return fmt.format(date);
	}
	
	/**
	 * 지정된 형식으로 전달된 문자열을 날짜 문자열로 반환한다.
	 * @param timeString	날짜를 나타내는 문자열
	 * @param format ex : "yyyyMMddHHmmss"
	 * @return 날짜 문자열
	 */
	public static String getDateString(String timeString, String format) {
		Date date = new Date(new Long(timeString).longValue());
		SimpleDateFormat fmt = new SimpleDateFormat(format);
		return fmt.format(date);
	}
	
	/**
	 * 지정된 형식으로 전달된 문자열을 날짜 문자열로 반환한다.
	 * @param timeString	날짜를 나타내는 문자열
	 * @param format ex : "yyyyMMddHHmmss"
	 * @return 날짜 문자열
	 */
	public static String getDateString(String timeString, String format, Locale locale) {
		Date date = new Date(new Long(timeString).longValue());
		return (new SimpleDateFormat(format, locale).format(date));
	}
	
	public static String getDateString(Date date) {
		return getDateString(date, "yyyy/MM/dd hh:mm:ss");
	}
	
	/**
	 * 전달된 date에서 지정된 포맷의 날짜 문자열을 반환한다.
	 * @param date
	 * @param format ex : "yyyyMMddHHmmss"
	 * @return String
	 */
	public static String getDateString(Date date, String format)
	{
		if(date == null) return "";
		return (new SimpleDateFormat(format).format(date));	
	}
	
	/**
	 * 전달된 date에서 지정된 포맷의 날짜 문자열을 반환한다.
	 * @param date
	 * @param format ex : "yyyyMMddHHmmss"
	 * @return String
	 */
	public static String getDateString(Date date, String format, Locale locale)
	{
		if(date == null) return "";
		return (new SimpleDateFormat(format, locale).format(date));	
	}	
	
	/**
	 * 지정된 날짜에 대응하는 Date 객체를 반환한다.
	 * @param year  0 ~ 2004 ~ ....
	 * @param month 1 ~ 12
	 * @param date  1 ~ 31
	 * @param hour  0 ~ 23
	 * @param min   0 ~ 59
	 * @param sec   0 ~ 59
	 * @return Date
	 */
	public static Date getDate(int year, int month, int date, int hour, int min, int sec) {
		Calendar calendar = new GregorianCalendar();

//		SimpleTimeZone kst = new SimpleTimeZone( 9 * 60 * 60 * 1000, "KST" );
//		Calendar calendar = Calendar.getInstance();
		
		

		calendar.set(year, month-1, date, hour, min, sec);
		return calendar.getTime();
	}

	/**
	 * 년, 월, 일, 시, 분, 초 값을 이용해서 Date 객체로 변환
	 * 
	 * @param year	년
	 * @param month	월
	 * @param date	일
	 * @param hour	시
	 * @param min	븐
	 * @param sec	초
	 * @param milliSec	밀리세컨드 
	 * @return 변환된  Date 객체
	 */
	public static Date getDate(int year, int month, int date, int hour, int min, int sec, int milliSec) {
		Calendar calendar = new GregorianCalendar();
		calendar.set(year, month-1, date, hour, min, sec);
		calendar.set(Calendar.MILLISECOND, milliSec);
		return calendar.getTime();
	}

	/**
	 * yyyyMMddHHmmss 포맷의 문자열을 Date 객체로 변환
	 * 
	 * @param yyyyMMdd	포맷의 문자열
	 * @param HHmmss	포맷의 문자열 
	 * @return 날짜 문자열로 생성된 Date 객체
	 */	
	public static Date getDate(String yyyyMMdd, String HHmmss) {
		int year = 1970;
		int month = 1;
		int day = 1;

		int hour = 0;
		int min = 0;
		int sec = 0;

		try {
			year = Integer.parseInt(yyyyMMdd.substring(0, 4));
			month = Integer.parseInt(yyyyMMdd.substring(4, 6));
			day = Integer.parseInt(yyyyMMdd.substring(6, 8));

			hour = Integer.parseInt(HHmmss.substring(0, 2));
			min = Integer.parseInt(HHmmss.substring(2, 4));
			sec = Integer.parseInt(HHmmss.substring(4, 6));
		} catch (NumberFormatException e) {
			throw e;
		}

		return getDate(year, month, day, hour, min, sec);
	}

	/**
	 * yyyyMMdd 포맷의 문자열을 Date 객체로 변환
	 * 
	 * @param yyyyMMdd	yyyyMMdd 포맷의 문자열
	 * @return 날짜 문자열로 생성된 Date 객체
	 */
	public static Date getDate(String yyyyMMdd) {
		int year = 1970;
		int month = 1;
		int day = 1;

		try {
			year = Integer.parseInt(yyyyMMdd.substring(0, 4));
			month = Integer.parseInt(yyyyMMdd.substring(4, 6));
			day = Integer.parseInt(yyyyMMdd.substring(6, 8));
		} catch (NumberFormatException e) {
			throw e;
		}

		return getDate(year, month, day, 0, 0, 0);
	}
	
	/**
	 * 요일 리턴
	 * @param date
	 * @param dateType
	 * @return
	 * @throws Exception
	 */
	public static Integer getDateDay(String date, String dateType) throws Exception {
		 
	     
	    SimpleDateFormat dateFormat = new SimpleDateFormat(dateType) ;
	    Date nDate = dateFormat.parse(date) ;
	     
	    Calendar cal = Calendar.getInstance() ;
	    cal.setTime(nDate);
	     
	    int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;	//1 일, 2 월 ...7 
	     
	     
	     
	    return dayNum ;
	}
	
	public static String getDayOfweek() {
		
		String[] week = { "일", "월", "화", "수", "목", "금", "토" };
		
		Calendar cal = Calendar.getInstance();
		try {
			cal.setTime(new Date());
			int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
			return week[w];
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "";
	}
	
}

