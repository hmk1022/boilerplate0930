package com.workerman.aws;

import java.io.IOException;

import javax.annotation.PostConstruct;

import org.springframework.context.annotation.Configuration;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.workerman.config.Constants;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
public class AWSClient {

	private AmazonS3 amazonS3 = null;

//	@Autowired
//	private MessageSourceAccessor messageSourceAccessor;

	@PostConstruct
	protected void postConstruct() throws IOException {
		
		//log.debug("accessKey:::" + messageSourceAccessor.getMessage("work.s3.accessKey"));

		
		
//		BasicAWSCredentials creds = new BasicAWSCredentials(messageSourceAccessor.getMessage("work.s3.accessKey"), messageSourceAccessor.getMessage("work.s3.secretKey"));
		
		BasicAWSCredentials creds = new BasicAWSCredentials(Constants.WORK_ACCESSKEY, Constants.WORK_SECRETKEY);
		
		amazonS3 = AmazonS3ClientBuilder.standard().withCredentials(new AWSStaticCredentialsProvider(creds)).withForceGlobalBucketAccessEnabled(true).withRegion(Regions.DEFAULT_REGION).build();
		// amazonS3.setRegion(Region.getRegion(Regions.AP_NORTHEAST_2));
		// dynamoClient = new AmazonDynamoDBClient(propertiesCredentials);
		log.info("aws s3 initialize success.");
		log.info("aws dynamoClient initialize success.");
		
	}

	/**
	 * get amazon s3 client
	 * 
	 * @return
	 */
	public AmazonS3 getAmazonS3() {
		return amazonS3;
	}

}
