package com.workerman.config;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Stream;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.util.ContentCachingRequestWrapper;
import org.springframework.web.util.ContentCachingResponseWrapper;

import lombok.val;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@Configuration
public class LoggingFilterConfig extends OncePerRequestFilter {
    private static final List<MediaType> VISIBLE_TYPES = Arrays.asList(
        MediaType.valueOf("text/*"),
        MediaType.APPLICATION_FORM_URLENCODED,
        MediaType.APPLICATION_JSON,
        MediaType.APPLICATION_XML,
        MediaType.valueOf("application/*+json"),
        MediaType.valueOf("application/*+xml"),
        MediaType.MULTIPART_FORM_DATA
    );

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
		if (isAsyncDispatch(request)) {
			filterChain.doFilter(request, response);
		} else {
			doFilterWrapped(wrapRequest(request), wrapResponse(response), filterChain);
		}
    }

    protected void doFilterWrapped(ContentCachingRequestWrapper request, ContentCachingResponseWrapper response, FilterChain filterChain) throws ServletException, IOException {
        try {
            beforeRequest(request, response);
            filterChain.doFilter(request, response);
        }
        finally {
            afterRequest(request, response);
            response.copyBodyToResponse();
        }
    }

    protected void beforeRequest(ContentCachingRequestWrapper request, ContentCachingResponseWrapper response) {
        if (log.isInfoEnabled()) {
            logRequestHeader(request, request.getRemoteAddr() + "|########### START ");
        }
    }

    protected void afterRequest(ContentCachingRequestWrapper request, ContentCachingResponseWrapper response) {
        if (log.isInfoEnabled()) {
        	logRequestBody(request, request.getRemoteAddr() + "|INPUT");
            //logResponse(response, request.getRemoteAddr() + "|OUTPUT");
            logRequestHeader(request, request.getRemoteAddr() + "|########### END ");
        }
    }

    private static void logRequestHeader(ContentCachingRequestWrapper request, String prefix) {
        val queryString = request.getQueryString();
        if (queryString == null) {
            log.info("{} {} {}", prefix, request.getMethod(), request.getRequestURI());
        } else {
            log.info("{} {} {}?{}", prefix, request.getMethod(), request.getRequestURI(), queryString);
        }
//        Collections.list(request.getHeaderNames()).forEach(headerName ->
//            Collections.list(request.getHeaders(headerName)).forEach(headerValue ->
//            log.info("{} {}: {}", prefix, headerName, headerValue)));
//        log.info("{}", prefix);
    }

    private static void logRequestBody(ContentCachingRequestWrapper request, String prefix) {
        val content = request.getContentAsByteArray();
//        if (content.length > 0 && content.length < 1000) { // 1000바이트를 넘으면 이미지 바이너리가 포함된것이기때문에 로그를 남기지 않는다.
            logContent(content, request.getContentType(), request.getCharacterEncoding(), prefix);
//        }
    }

    private static void logResponse(ContentCachingResponseWrapper response, String prefix) {
//        val status = response.getStatus();
//        log.info("{} {} {}", prefix, status, HttpStatus.valueOf(status).getReasonPhrase());
//        response.getHeaderNames().forEach(headerName ->
//            response.getHeaders(headerName).forEach(headerValue ->
//                log.info("{} {}: {}", prefix, headerName, headerValue)));
//        log.info("{}", prefix);
        val content = response.getContentAsByteArray();
//        if (content.length > 0 && content.length < 1000) { // 1000바이트를 넘으면 이미지 바이너리가 포함된것이기때문에 로그를 남기지 않는다.
            logContent(content, response.getContentType(), response.getCharacterEncoding(), prefix);
//        }
    }

    private static void logContent(byte[] content, String contentType, String contentEncoding, String prefix) {

    	if(contentType == null || contentType.equals("null")) {
    		return;
    	}

        val mediaType = MediaType.valueOf(contentType);
        val visible = VISIBLE_TYPES.stream().anyMatch(visibleType -> visibleType.includes(mediaType));
        if (visible) {
            try {
                val contentString = new String(content, contentEncoding);
                Stream.of(contentString.split("\r\n|\r|\n")).forEach(line -> log.info("{} {}", prefix, line));
            } catch (UnsupportedEncodingException e) {
                log.info("{} [{} bytes content]", prefix, content.length);
            }
        } else {
            log.info("{} [{} bytes content]", prefix, content.length);
        }
    }

    private static ContentCachingRequestWrapper wrapRequest(HttpServletRequest request) {
        if (request instanceof ContentCachingRequestWrapper) {
            return (ContentCachingRequestWrapper) request;
        } else {
            return new ContentCachingRequestWrapper(request);
        }
    }

    private static ContentCachingResponseWrapper wrapResponse(HttpServletResponse response) {
        if (response instanceof ContentCachingResponseWrapper) {
            return (ContentCachingResponseWrapper) response;
        } else {
            return new ContentCachingResponseWrapper(response);
        }
    }
}