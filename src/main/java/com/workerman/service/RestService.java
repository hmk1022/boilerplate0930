package com.workerman.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class RestService {
	
    private RestTemplate restTemplate;
    
    @Autowired
    public RestService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
 
    public ResponseEntity<?> get(String url, HttpHeaders httpHeaders) {
        return callApiEndpoint(url, HttpMethod.GET, httpHeaders, null, (Class<?>)Object.class);
    }
 
    public ResponseEntity<?> get(String url, HttpHeaders httpHeaders, Class<?> clazz) {
        return callApiEndpoint(url, HttpMethod.GET, httpHeaders, null, clazz);
    }
 
    public ResponseEntity<?> post(String url, HttpHeaders httpHeaders, Object body) {
        return callApiEndpoint(url, HttpMethod.POST, httpHeaders, body,(Class<?>)Object.class);
    }
 
    public ResponseEntity<?> post(String url, HttpHeaders httpHeaders, Object body, Class<?> clazz) {
        return callApiEndpoint(url, HttpMethod.POST, httpHeaders, body, clazz);
    }
 
    private ResponseEntity<?> callApiEndpoint(String url, HttpMethod httpMethod, HttpHeaders httpHeaders, Object body, Class<?> clazz) {
        return restTemplate.exchange(url, httpMethod, new HttpEntity<>(body, httpHeaders), clazz);
    }

}
