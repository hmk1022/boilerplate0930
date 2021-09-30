package com.workerman;

import java.io.IOException;
import java.net.InetAddress;
import java.util.Arrays;
import java.util.Collection;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.env.Environment;
import org.springframework.core.env.SimpleCommandLinePropertySource;
import org.springframework.scheduling.annotation.EnableScheduling;

import com.workerman.config.Constants;



@SpringBootApplication
//@ComponentScan({"kr.or.crefia.exnet"})
//@MapperScan("kr.or.crefia.exnet")
//@EnableAutoConfiguration
//@EnableScheduling
//@EnableConfigurationProperties({ CrefiaExProperties.class })
public class WorkermanAbcApplication {

	private static final Logger log = LoggerFactory.getLogger(WorkermanAbcApplication.class);

    @Inject
    private Environment env;

	public static void main(String[] args) {

//        SpringApplication app = new SpringApplication(WorkermanAbcApplication.class);
//        SimpleCommandLinePropertySource source = new SimpleCommandLinePropertySource(args);
//        addDefaultProfile(app, source);

//        Environment env = app.run(args).getEnvironment();
//        log.info("Access URLs:\n----------------------------------------------------------\n\t" +
//                        "Local: \t\thttp://127.0.0.1:{}\n\t" +
//                        "External: \thttp://{}:{}\n----------------------------------------------------------",
//                env.getProperty("server.port"),
//                InetAddress.getLocalHost().getHostAddress(),
//                env.getProperty("server.port"));

		SpringApplication.run(WorkermanAbcApplication.class, args);
	}

    @PostConstruct
    public void initApplication() throws IOException {
        if (env.getActiveProfiles().length == 0) {
            log.warn("No Spring profile configured, running with default configuration");
        } else {
            log.info("Running with Spring profile(s) : {}", Arrays.toString(env.getActiveProfiles()));
            Collection<String> activeProfiles = Arrays.asList(env.getActiveProfiles());
            if (activeProfiles.contains(Constants.SPRING_PROFILE_DEVELOPMENT) && activeProfiles.contains(Constants.SPRING_PROFILE_PRODUCTION)) {
                log.error("You have misconfigured your application! " +
                        "It should not run with both the 'dev' and 'prod' profiles at the same time.");
            }
        }
    }

    /**
     * If no profile has been configured, set by default the "dev" profile.
     */
    private static void addDefaultProfile(SpringApplication app, SimpleCommandLinePropertySource source) {
        if (!source.containsProperty("spring.profiles.active") &&
                !System.getenv().containsKey("SPRING_PROFILES_ACTIVE")) {

            app.setAdditionalProfiles(Constants.SPRING_PROFILE_DEVELOPMENT);
        }
    }

}
