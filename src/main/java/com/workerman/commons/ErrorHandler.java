package com.workerman.commons;

import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.validation.BindException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

@ControllerAdvice
@Order(Ordered.HIGHEST_PRECEDENCE)
public class ErrorHandler {

	 /**
     *  javax.validation.Valid or @Validated 으로 binding error 발생시 발생한다.
     *  HttpMessageConverter 에서 등록한 HttpMessageConverter binding 못할경우 발생
     *  주로 @RequestBody, @RequestPart 어노테이션에서 발생
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    protected ResponseEntity<ErrorResponse> handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {
        ErrorResponse response = new ErrorResponse(
        		HttpStatus.BAD_REQUEST,
        		ErrorCode.ERROR_INPUT_VALUE.getStatus(), 
        		ErrorCode.ERROR_INPUT_VALUE.getMessage(),
        		e.getBindingResult().toString());
        return new ResponseEntity<>(response, response.getStatus());
    }

    /**
     * @ModelAttribut 으로 binding error 발생시 BindException 발생한다.
     * ref https://docs.spring.io/spring/docs/current/spring-framework-reference/web.html#mvc-ann-modelattrib-method-args
     */
    @ExceptionHandler(BindException.class)
    protected ResponseEntity<ErrorResponse> handleBindException(BindException e) {
        ErrorResponse response = new ErrorResponse(
        		HttpStatus.BAD_REQUEST,
        		ErrorCode.ERROR_INPUT_VALUE.getStatus(), 
        		ErrorCode.ERROR_INPUT_VALUE.getMessage(),
        		e.getBindingResult().toString());
        return new ResponseEntity<>(response, response.getStatus());
    }

    /**
     * enum type 일치하지 않아 binding 못할 경우 발생
     * 주로 @RequestParam enum으로 binding 못했을 경우 발생
     */
    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    protected ResponseEntity<ErrorResponse> handleMethodArgumentTypeMismatchException(MethodArgumentTypeMismatchException e) {
        ErrorResponse response = new ErrorResponse(
        		HttpStatus.BAD_REQUEST,
        		ErrorCode.ERROR_BAD_REQUEST.getStatus(), 
        		ErrorCode.ERROR_BAD_REQUEST.getMessage(),
        		e.getMessage());
        return new ResponseEntity<>(response, response.getStatus());
    }

    /**
     * 지원하지 않은 HTTP method 호출 할 경우 발생
     */
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    protected ResponseEntity<ErrorResponse> handleHttpRequestMethodNotSupportedException(HttpRequestMethodNotSupportedException e) {
        ErrorResponse response = new ErrorResponse(
        		HttpStatus.NOT_FOUND,
        		ErrorCode.ERROR_NOT_FOUND.getStatus(), 
        		ErrorCode.ERROR_NOT_FOUND.getMessage(),
        		e.getMessage());
        return new ResponseEntity<>(response, response.getStatus());
    }

    /**
     * Authentication 객체가 필요한 권한을 보유하지 않은 경우 발생합
     */
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    @ExceptionHandler({AuthenticationException.class, AccessDeniedException.class})
    protected ResponseEntity<ErrorResponse> handleAccessDeniedException(AccessDeniedException e) {
        ErrorResponse response = new ErrorResponse(
        		HttpStatus.UNAUTHORIZED,
        		ErrorCode.ERROR_UNAUTHORIZED.getStatus(), 
        		ErrorCode.ERROR_UNAUTHORIZED.getMessage(),
        		e.getMessage());
        
        System.out.println("인증 에러가 발생 했습니다.!!!");
        
        return new ResponseEntity<>(response, response.getStatus());
    }
    
    /**
     * 내부서버오류
     */
    @ExceptionHandler(Exception.class)
    protected ResponseEntity<ErrorResponse> handleException(Exception e) {
        ErrorResponse response = new ErrorResponse(
        		HttpStatus.INTERNAL_SERVER_ERROR,
        		ErrorCode.ERROR_INTERNAL_SERVER_ERROR.getStatus(), 
        		ErrorCode.ERROR_INTERNAL_SERVER_ERROR.getMessage(),
        		e.getMessage());
        e.printStackTrace();
        return new ResponseEntity<>(response, response.getStatus());
    }
}