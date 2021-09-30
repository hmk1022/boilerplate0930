//package com.workerman.config;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.security.web.AuthenticationEntryPoint;
//
//@Configuration
//@EnableResourceServer
//public class CommonSecurityConfig extends ResourceServerConfigurerAdapter {
//
//    @Override
//    public void configure(ResourceServerSecurityConfigurer resources) throws Exception {
//        resources.authenticationEntryPoint(customAuthEntryPoint());
//    }
//
//    @Bean
//    public AuthenticationEntryPoint customAuthEntryPoint(){
//        return new AuthFailureHandler();
//    }
//}