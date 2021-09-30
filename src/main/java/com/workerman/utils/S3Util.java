package com.workerman.utils;

import java.io.File;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.PutObjectResult;

@Component("s3Util")
public class S3Util {
	
	private AmazonS3 amazonS3;
	
	@Autowired
	private Properties systemProp;
	
	public void fileUpload(String bucket_name, String key, File file, CannedAccessControlList permission) {
		
		BasicAWSCredentials creds = new BasicAWSCredentials(systemProp.getProperty("work.s3.accessKey"), systemProp.getProperty("work.s3.secretKey")); 
		amazonS3 = AmazonS3ClientBuilder.standard().withCredentials(new AWSStaticCredentialsProvider(creds)).withRegion(Regions.AP_NORTHEAST_2).build();
		
		if(permission == null) {
			permission = CannedAccessControlList.PublicRead;
		}
		if (amazonS3 != null) {
            try {
                PutObjectRequest putObjectRequest =
                        new PutObjectRequest(bucket_name, key, file);
                putObjectRequest.setCannedAcl(permission); // file permission
                PutObjectResult p = amazonS3.putObject(putObjectRequest); // upload file
                 
            } catch (AmazonServiceException ase) {
                ase.printStackTrace();
            } catch (Exception e) {
            	e.printStackTrace();
            } finally {
                amazonS3 = null;
            }
        }
	}

}