package com.workerman.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.embedded.tomcat.TomcatConnectorCustomizer;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@Configuration
@EnableConfigurationProperties
@ConfigurationProperties(prefix="workman")
public class ApplicationConfig {

    private String fileRootPath;
    private String fileUploadPath;

    
    // RFC 3986 규격 
    @Configuration
    public class TomcatWebCustomConfig implements WebServerFactoryCustomizer<TomcatServletWebServerFactory> {

        @Override
        public void customize(TomcatServletWebServerFactory factory) {
            factory.addConnectorCustomizers((TomcatConnectorCustomizer)
                    connector -> connector.setAttribute("relaxedQueryChars", "<>[\\]^`{|}"));
        }
    }
}

