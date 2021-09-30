package com.workerman.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import com.workerman.commons.ErrorCode;

@Component
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
 
	@Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
        response.setContentType("application/json;charset=UTF-8");
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        response.getWriter().println("{ \"message\" : \"" + ErrorCode.ERROR_BAD_REQUEST.getMessage()
                + "\", \"status\" : " + ErrorCode.ERROR_BAD_REQUEST.getStatus()
                + ", \"errors\" : [ ] }");
    }
	
}