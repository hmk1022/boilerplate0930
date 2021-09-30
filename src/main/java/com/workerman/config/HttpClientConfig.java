package com.workerman.config;

import org.apache.http.client.config.RequestConfig;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class HttpClientConfig {
	
	@Value("${httppool.maxPerRoute}")
	private int maxPerRoute;
	
	@Value("${httppool.maxTotal}")
	private int maxTotal;
	
	@Value("${httppool.connectionRequestTimeout}")
	private int connectionRequestTimeout;
	
	@Value("${httppool.connectTimeout}")
	private int connectTimeout;
	
	@Value("${httppool.socketTimeout}")
	private int socketTimeout;

	@Bean
	public PoolingHttpClientConnectionManager poolingHttpClientConnectionManager() {
		PoolingHttpClientConnectionManager result = new PoolingHttpClientConnectionManager();
		result.setDefaultMaxPerRoute(maxPerRoute);
		result.setMaxTotal(maxTotal);
		return result;
	}

	@Bean
	public RequestConfig requestConfig() {
		RequestConfig result = RequestConfig.custom()
						.setConnectionRequestTimeout(connectionRequestTimeout)
						.setConnectTimeout(connectTimeout)
						.setSocketTimeout(socketTimeout)
						.build();
		return result;
	}

	@Bean
	public CloseableHttpClient httpClient(PoolingHttpClientConnectionManager poolingHttpClientConnectionManager, RequestConfig requestConfig) {
		CloseableHttpClient result = HttpClientBuilder.create()
						.setConnectionManager(poolingHttpClientConnectionManager)
						.setDefaultRequestConfig(requestConfig)
						.build();
		return result;
	}
}
