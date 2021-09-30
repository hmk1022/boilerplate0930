package com.workerman.utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;

import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;

public class StringUtil extends StringUtils{
	public static String replaceNull(String value, String repStr) {
		if (isNull2(value) || value.equals("") )
			return repStr;

		return getStripHtml(value.trim());
	}

	public static boolean isNull2(String value) {
		if (value == null
			|| value.trim().equals("")
			|| value.toUpperCase().trim().equals("NULL"))
			return true;

		return false;
	}

	/**
	 * 입력받은 문자열에서 HTML을 벗겨버리는 메소드
	 * @param buffer
	 * @return
	 */
	public static String getStripHtml(String buffer) {
		if (buffer == null)
			return "";
		if (buffer.indexOf("<") < 0)
			return buffer;
		int bufLen = buffer.length();
		StringBuffer result = new StringBuffer();
		int i = 0,j = 0,k = 0;

		for (; i < bufLen;) {
			j = buffer.indexOf("<", j);
			if (j >= 0) {
				result.append(buffer.substring(i, j));
				k = j;
				j = buffer.indexOf(">", j);
				if(j < 0){
					result.append(buffer.substring(k+1));
					break;
				}
				i = j+1;
			} else
				break;
		}
		result.append(buffer.substring(i));
		return result.toString();
	}
	/**
	 * @param str 문자열
	 * @return
	 * str이 null 또는 length가 0이라면 true, 아니라면 false
	 */
	public static boolean isEmpty(String str) {
		return str == null || str.length() == 0;
	}

	/**
	 * @param str 문자열
	 * @return
	 * str이 null이 아니고 length가 0보다 크다면 true, 아니라면 false
	 */
	public static boolean isNotEmpty(String str) {
		return (str != null && str.length() > 0);
	}

	/**
	 * @param str 문자열
	 * @param strict 공백을 제거한 후 검사를 진행할 것인지 여부
	 * @return
	 * strict가 true라면 str의 공백을 제거하고 검사 진행, false라면 isEmpty(String str)과 동일
	 *
	 */
	public static boolean isEmpty(String str, boolean strict) {
		boolean isEmpty = isEmpty(str);
		if(!strict || isEmpty) return isEmpty;
		else str = str.replaceAll("\\s", "");
		return isEmpty(str);
	}

	/**
	 * @author 김준혁
	 * @param source 랜덤으로 나타낼 문자 배열
	 * @param loop 랜덤 문자열의 길이
	 * @return
	 * source에 있는 문자 배열을 loop번 만큼 선택함
	 */
	public static String randomString(char[] source, int loop) {
		Random random = new Random();
		String result = "";
		for(int i=0; i<loop; i++)
			result += source[random.nextInt(source.length)];
		return result;
	}

	public static String randomString(int loop) {
		char[] source = new char[] {
			    '0','1','2','3','4','5','6','7','8','9'
			    ,'a','b','c','d','e','f','g','h','i','j','k','l','m'
			    ,'n','o','p','q','r','s','t','u','v','w','x','y','z'};

		Random random = new Random();
		String result = "";
		for(int i=0; i<loop; i++)
			result += source[random.nextInt(source.length)];
		return result;
	}


	public static String ifNull(String str, String str2){
		if ( str == null )	return str2;
		else if ( str == "null" )	return str2;
		else if ( str == "" )	return str2;
		else	return str;
	}
	public static String isNull(String str){
		if ( str == null )	return "";
		else if ( str == "null" )	return "";
		else	return str;
  	}
	public static String isSpace(String str){
		if (StringUtil.isNull(str).equals(""))	return null;
		else	return str;
  	}
	public static String isNotNull(String str, String prestr){
		if ( str == null )	return "";
		else if ( str == "null" )	return "";
		else	return prestr+str;
  	}
	public static String isNullZero(String str){
		if ( str == null || str.equals("") || str.equals("null"))	return "0";
		else	return str;
  	}
  	public static String isNullReplace(String str, String rep){
		if ( str == null || str.equals("") || str.equals("null"))	return rep;
		else	return str;
  	}
  	public static String isNullMax(String str){
		if ( str == null || str.equals(""))	return "9999";
		else	return str;
  	}
  	public static String addComma(int num) {

        String str = num + "";
        StringBuffer sb = new StringBuffer(str);
        StringBuffer rsb = new StringBuffer();
        sb = sb.reverse();
        int p = 0;

        for (int i = 0; i < str.length(); i++) {
            p = i % 3;

            if (i > 0)
                if (p == 0)
                    rsb.append(",");

            rsb.append(sb.substring(i, (i + 1)));
        }

        return (rsb.reverse()).toString();
    }

  	public static String shorUrl(String text) {
		String ret="";
		String clientId = "lo1Iz64MUBF4DJx2fAvm";//애플리케이션 클라이언트 아이디값";
	    String clientSecret = "FIA4O0lYAJ";//애플리케이션 클라이언트 시크릿값";


	    try {

	        String apiURL = "https://openapi.naver.com/v1/util/shorturl?url=" + text;
	        URL url = new URL(apiURL);
	        HttpURLConnection con = (HttpURLConnection)url.openConnection();
	        con.setRequestMethod("POST");
	        con.setRequestProperty("X-Naver-Client-Id", clientId);
	        con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	        int responseCode = con.getResponseCode();
	        BufferedReader br;
	        if(responseCode==200) { // 정상 호출
	            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	        } else {  // 에러 발생
	            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	        }
	        String inputLine;
	        StringBuffer response = new StringBuffer();
	        while ((inputLine = br.readLine()) != null) {
	            response.append(inputLine);
	        }
	        br.close();
	        ret=response.toString();
	        Gson gosn=new Gson();
	        LinkedTreeMap map=(LinkedTreeMap)gosn.fromJson(ret, LinkedTreeMap.class);

	        LinkedTreeMap map2=(LinkedTreeMap)map.get("result");
	        ret=(String)map2.get("url");

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return ret;
	}

	/**
	 * @author dw.kwon
	 * @param str
	 * @param tag 마지막구분자
	 * @return tag 이 후 문자열.
	 *
	 */
	public static String substrIndex(String str, String tag ) {
		if(str == null) {
			return null;
		} else {
			return str.substring(str.lastIndexOf(tag)+1, str.length());
		}
	}
	
	/**
	 * @author dw.kwon
	 * @param str 
	 * @param tag 
	 * @return tag .
	 *  
	 */
	public static String nvl(String str, String tag ) {
		if(str == null) {
			return tag;
		} else {
			return str;
		}
	}

	public static String stringToMd5(String str) throws NoSuchAlgorithmException {
		byte[] md5 = MessageDigest.getInstance("MD5").digest(str.getBytes());

		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < md5.length; i++) {
			sb.append(Integer.toString((md5[i] & 0xf0) >> 4, 16));
			sb.append(Integer.toString(md5[i] & 0x0f, 16));
		}

		return sb.toString();
	}

    
    /**
     * <p>Removes all occurrences of a substring from within the source string.</p>
     *
     * <p>A {@code null} source string will return {@code null}.
     * An empty ("") source string will return the empty string.
     * A {@code null} remove string will return the source string.
     * An empty ("") remove string will return the source string.</p>
     *
     * <pre>
     * StringUtils.remove(null, *)        = null
     * StringUtils.remove("", *)          = ""
     * StringUtils.remove(*, null)        = *
     * StringUtils.remove(*, "")          = *
     * StringUtils.remove("queued", "ue") = "qd"
     * StringUtils.remove("queued", "zz") = "queued"
     * </pre>
     *
     * @param str  the source String to search, may be null
     * @param remove  the String to search for and remove, may be null
     * @return the substring with the string removed if found,
     *  {@code null} if null String input
     * @since 2.1
     */
    public static String remove(final Object str, final String remove) {
    	if(str == null || remove == null) return null;
    	String strTmp = (String)str;
        if (isEmpty(strTmp) || isEmpty(remove)) {
            return strTmp;
        }
        return replace(strTmp, remove, EMPTY, -1);
    }
    
    public static String onlyNumStr(final Object str) {
    	if(str == null ) return null;
    	String strTmp = (String)str;
        if (isEmpty(strTmp)) {
            return strTmp;
        }
        return strTmp.replaceAll("[^0-9]", "");
    }
    
	/**
	 * 01063196622 --> 010-****-6622
	 * @param input
	 * @return
	 */
	public static String scrPhone(String str) {
		if(str == null) return null;
		str = replace(str, "-", "");
		if(str.length() == 11)
			return str.substring(0, 3) + "-****-" +  str.substring(7);
		else if(str.length() == 10)
			return str.substring(0, 3) + "-***-" +  str.substring(6);
		else 
			return str ;
	}
	
	public static Long toLong(Object str) {
		Long val = null;	
		if(str == null) return null;
		else {
			return Long.parseLong(str.toString());
		}
	}

	public static String toNull(String str){
		if ( str == null )	return null;
		else if ( str == "null" )	return null;
		else if ( str == "" )	return null;
		else if ( str.equals(""))	return null;
		else	
			return str;
	}
	

	public static Object toNull(Object str){
		if ( str == null )	return null;
		else if ( str == "null" )	return null;
		else if ( str == "" )	return null;
		else if ( str.equals(""))	return null;
		else	
			return str;
	}
	

    /**
     * <p>Checks if a CharSequence is empty (""), null or whitespace only.</p>
     *
     * <p>Whitespace is defined by {@link Character#isWhitespace(char)}.</p>
     *
     * <pre>
     * StringUtils.isBlank(null)      = true
     * StringUtils.isBlank("")        = true
     * StringUtils.isBlank(" ")       = true
     * StringUtils.isBlank("bob")     = false
     * StringUtils.isBlank("  bob  ") = false
     * </pre>
     *
     * @param cs  the CharSequence to check, may be null
     * @return {@code true} if the CharSequence is null, empty or whitespace only
     * @since 2.0
     * @since 3.0 Changed signature from isBlank(String) to isBlank(CharSequence)
     */
    public static boolean isBlank(final CharSequence cs) {
        final int strLen = length(cs);
        if (strLen == 0) {
            return true;
        }
        if (cs == "null") {
            return true;
        }
        for (int i = 0; i < strLen; i++) {
            if (!Character.isWhitespace(cs.charAt(i))) {
                return false;
            }
        }
        
        return true;
    }
    
//    
//    public static String onlyNumStyle(final String str) {
//    	if(str == null ) return null;
//    	String strTmp = (String)str;
//        if (isEmpty(strTmp)) {
//            return strTmp;
//        }
//        return strTmp.replaceAll("[^0-9]", "");
//    }
    
    
}
