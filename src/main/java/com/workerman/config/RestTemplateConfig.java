package com.workerman.config;

import java.nio.charset.Charset;
import java.time.Duration;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.BufferingClientHttpRequestFactory;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.client.RestTemplate;

@Configuration
public class RestTemplateConfig {
 
    @Bean
    public RestTemplate restTemplate(RestTemplateBuilder restTemplateBuilder) {
        return restTemplateBuilder
                .requestFactory(() -> new BufferingClientHttpRequestFactory(new SimpleClientHttpRequestFactory()))
                .setConnectTimeout(Duration.ofMillis(5000)) // connection-timeout
                .setReadTimeout(Duration.ofMillis(5000)) // read-timeout
                .additionalMessageConverters(new StringHttpMessageConverter(Charset.forName("UTF-8")))
                .build();
    }
    
//    @Autowired
//    private CloseableHttpClient httpClient;	
//	
//	/**
//	 * @return 
//	 * https://bluepoet.me/2017/09/06/resttemplate-%EC%82%AC%EC%9A%A9%EC%8B%9C-%EC%A3%BC%EC%9D%98%EC%82%AC%ED%95%AD/
//	 */
//	@Bean
//	public RestTemplate restTemplate() {
//		HttpComponentsClientHttpRequestFactory httpRequestFactory = new HttpComponentsClientHttpRequestFactory();
//		httpRequestFactory.setHttpClient(httpClient);
//		
//		HttpHeaders headers = new HttpHeaders(); 
//		Charset utf8 = Charset.forName("UTF-8"); 
//		MediaType mediaType = new MediaType("application", "json", utf8); 
//		headers.setContentType(mediaType);
//		
//		RestTemplate restTemplate = new RestTemplate(httpRequestFactory);
//		//restTemplate.setErrorHandler(new CustomErrorResponseHandler());
//		restTemplate.getMessageConverters().add(new GsonHttpMessageConverter());
//		
//		List interceptors = restTemplate.getInterceptors();
//		interceptors.add(new HeaderContextInterceptor());
//		restTemplate.setInterceptors(interceptors);
//		
//		restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(Charset.forName("UTF-8")));
//		
//		return restTemplate;
//	}
//	
//	@Bean
//	public RestTemplate restTemplateHttps() throws KeyStoreException, NoSuchAlgorithmException, KeyManagementException {
//		//TrustStrategy acceptingTrustStrategy = (X509Certificate[] chain, String authType) -> true;
//		//SSLContext sslContext = org.apache.http.ssl.SSLContexts.custom().loadTrustMaterial(null, acceptingTrustStrategy).build();
//		//SSLConnectionSocketFactory csf = new SSLConnectionSocketFactory(sslContext);
//		//CloseableHttpClient httpClient = HttpClients.custom().setSSLSocketFactory(csf).build();
//		CloseableHttpClient httpClient = HttpClients.custom().setSSLHostnameVerifier(new NoopHostnameVerifier()).build();	
//		HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory();		
//		
//		requestFactory.setHttpClient(httpClient);
//		RestTemplate restTemplate = new RestTemplate(requestFactory);
//		
//		List interceptors = restTemplate.getInterceptors();
//		interceptors.add(new HeaderContextInterceptor());
//		restTemplate.setInterceptors(interceptors);		
//		
//		restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(Charset.forName("UTF-8")));
//		
//		return restTemplate;
//	}
    
}


