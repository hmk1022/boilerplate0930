package com.workerman.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import com.workerman.commons.ErrorCode;
import com.workerman.commons.ErrorResponse;
import com.workerman.utils.Utils;

@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {

	@Override
    public void commence(HttpServletRequest request, HttpServletResponse response, 
    		AuthenticationException authException) throws IOException, ServletException {
        //response.sendError(HttpServletResponse.SC_UNAUTHORIZED, authException.getMessage());
        
		ErrorResponse er = new ErrorResponse(
        		HttpStatus.UNAUTHORIZED,
        		ErrorCode.ERROR_UNAUTHORIZED.getStatus(), 
        		ErrorCode.ERROR_UNAUTHORIZED.getMessage(),
        		authException.getMessage());
		ResponseEntity<?> re = new ResponseEntity<>(er, er.getStatus());
		
		String json = Utils.objectToJson(re.getBody());
        
		response.setCharacterEncoding("UTF-8");
        //response.setContentType("application/json;charset=utf-8");
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.getWriter().write(json);
    }
    
}