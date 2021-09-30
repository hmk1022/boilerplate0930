package com.workerman.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.core.env.Environment;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.workerman.commons.LabelValue;
import com.workerman.config.Constants;



/**
 * Controller에서 공통으로 사용하는 메소드 정의
 */
@Configuration
public class BaseController{

	protected final Log log = LogFactory.getLog(getClass());
	
	@Autowired
	private Environment env;
	
	public final String RET = "return";
	
	
	/* begin ***/
	public static final String MESSAGES_KEY = "successMessages";
	
	protected String cancelView;
    protected String successView;

    private MessageSourceAccessor messages;
    private ServletContext servletContext;


    @Autowired
    public void setMessages(MessageSource messageSource) {
        messages = new MessageSourceAccessor(messageSource);
    }
	

    @SuppressWarnings("unchecked")
    public void saveError(String error) {
        HttpServletRequest request = request();
        List errors = (List) request.getSession().getAttribute("errors");
        if (errors == null) {
            errors = new ArrayList();
        }
        errors.add(error);
        request.getSession().setAttribute("errors", errors);
    }

    @SuppressWarnings("unchecked")
    public void saveMessage(String msg) {
        HttpServletRequest request = request();
        List messages = (List) request.getSession().getAttribute(MESSAGES_KEY);

        if (messages == null) {
            messages = new ArrayList();
        }

        messages.add(msg);
        request.getSession().setAttribute(MESSAGES_KEY, messages);
    }

    /**
     * Convenience method for getting a i18n key's value.  Calling
     * getMessageSourceAccessor() is used because the RequestContext variable
     * is not set in unit tests b/c there's no DispatchServlet Request.
     *
     * @param msgKey
     * @param locale the current locale
     * @return
     */
    public String getText(String msgKey, Locale locale) {
        return messages.getMessage(msgKey, locale);
    }

    /**
     * Convenient method for getting a i18n key's value with a single
     * string argument.
     *
     * @param msgKey
     * @param arg
     * @param locale the current locale
     * @return
     */
    public String getText(String msgKey, String arg, Locale locale) {
        return getText(msgKey, new Object[] { arg }, locale);
    }

    /**
     * Convenience method for getting a i18n key's value with arguments.
     *
     * @param msgKey
     * @param args
     * @param locale the current locale
     * @return
     */
    public String getText(String msgKey, Object[] args, Locale locale) {
        return messages.getMessage(msgKey, args, locale);
    }


    public final BaseController setCancelView(String cancelView) {
        this.cancelView = cancelView;
        return this;
    }

    public final String getCancelView() {
        // Default to successView if cancelView is invalid
        if (this.cancelView == null || this.cancelView.length()==0) {
            return getSuccessView();
        }
        return this.cancelView;
    }

    public final String getSuccessView() {
        return this.successView;
    }

    public final BaseController setSuccessView(String successView) {
        this.successView = successView;
        return this;
    }

    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    protected ServletContext getServletContext() {
        return servletContext;
    }
    
    /* end ***/
    
    
    
    
	protected String getMessage(String code) {
		return env.getProperty(code);
	}
	
	/**
	 * Ajax 공통리턴용
	 * @param input
	 * @return
	 */
	public Map<String, Object> returnResult(String input) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("result", input);
		return result;
	}
	
	/**
	 * 공통 Null 체크용
	 * @param input
	 * @return
	 */
	public boolean isEmpty(String input){
		return input == null || input.equals("");
	}
	
	public boolean isEmpty(int input){
		return input == 0;
	}
	
	public boolean isEmpty(Object input){
		return input == null || input.equals("");
	}
	
	public boolean equals(Object target, Object input) {
		return target != null && input != null && target.equals(input);
	}
	
	/**
	 * 널체크
	 * @param param
	 * @param key
	 * @return
	 */
	public boolean isNull(Map<String, Object> param, String... keys) {
		for (String key : keys) {
			if (param == null || param.get(key) == null || param.get(key).equals("")) { 
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 인트형반환
	 * @param param
	 * @param key
	 * @return
	 */
	public int getIntValue(Map<String, Object> param, String key) {
		return Integer.parseInt(param.get(key)+"");
	}
	
	/**
	 * 부울형반환
	 * @param param
	 * @param key
	 * @return
	 */
	public boolean getBooleanValue(Map<String, Object> param, String key) {
		return Boolean.parseBoolean(param.get(key)+"");
	}

	/**
	 * get admin_no
	 * @return admin_no
	 */
    public Long getAdminNo() {
        HttpServletRequest request = request();
        if(request.getAttribute("admin_no") == null) {
        	return null;
        } else {
        	return Long.valueOf(request.getAttribute("admin_no").toString());
        }
    }

    /**
     * get admin_name
     * @return admin_name
     */
    public String getAdminName() {
    	HttpServletRequest request = request();
    	if(request.getAttribute("admin_no") == null) {
    		return null;
    	} else {
    		return (String)request.getAttribute("admin_name");
    	}
    }
    
    /**
     * get admin_id
     * @return admin_id
     */
    public String getAdminId() {
    	HttpServletRequest request = request();
    	if(request.getAttribute("admin_no") == null) {
    		return null;
    	} else {
    		return (String)request.getAttribute("admin_id");
    	}
    }
    
    private HttpServletRequest request() {
        return ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
    }
    
    /**
     * Gets the query map.
     *
     * @return the query map
     */
    @SuppressWarnings("unchecked")
	public Map<String, Object> getQueryMap() {
        HttpServletRequest request = request();
		Map<String, String[]> parameterMap = request.getParameterMap();
		Map<String, Object> condMap = new HashMap<String, Object>();

		Map<String, LabelValue> dynamicMap = new HashMap<String, LabelValue>();

		for (String key : parameterMap.keySet()) {
			if(key.startsWith(Constants.CONDITION_PARAM_KEY)) {
				String[] values = parameterMap.get(key);
				// remove 'q.' prefix
				String conditionKey = key.substring(Constants.CONDITION_PARAM_KEY.length());

				// cond.dynamic.key.1 or cond.dynamic.value.1
				if(StringUtils.startsWith(conditionKey, "dynamic")) {
					String[] parsedData = StringUtils.split(conditionKey, '.');
					if(StringUtils.equals(parsedData[1], "key")) {
						LabelValue lv = dynamicMap.get(parsedData[2]);
						if(lv == null) {
							lv = new LabelValue();
							dynamicMap.put(parsedData[2], lv);
						}

						lv.setLabel(values[0]);
					}else {
						LabelValue lv = dynamicMap.get(parsedData[2]);
						if(lv == null) {
							lv = new LabelValue();
							dynamicMap.put(parsedData[2], lv);
						}

						lv.setValue(values[0]);
					}
				}else {
					if(values.length > 1){
						List<String> valueChk = new ArrayList<String>();
						for(String value : values){
							if(StringUtils.isNotBlank(value)) {
								valueChk.add(value);
							}
						}
						condMap.put(conditionKey, valueChk.toArray(new String[valueChk.size()]));
					}else{
						if(StringUtils.isNotBlank(values[0])) {
							condMap.put(conditionKey, values[0]);
						}
					}
				}
			}
		}

		if(!dynamicMap.isEmpty()) {
			for(LabelValue lv : dynamicMap.values()) {
				if(StringUtils.isNotBlank(lv.getValue())) {
					condMap.put(lv.getLabel(), lv.getValue());
				}
			}
		}

		if(condMap.isEmpty()) {
			condMap.put("EMPTYCOND", "EMPTYCOND");
		}

		condMap.put("create_no", getAdminNo()); // admin_no
		condMap.put("update_no", getAdminNo()); // admin_no
		
		return condMap;
	}
    
    
    
    
}
