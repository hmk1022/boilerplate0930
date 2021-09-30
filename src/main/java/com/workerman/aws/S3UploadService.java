package com.workerman.aws;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.model.AccessControlList;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.GroupGrantee;
import com.amazonaws.services.s3.model.Permission;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.workerman.config.Constants;

@Configuration
public class S3UploadService {

	@Autowired
	private AWSClient awsClient;

//	@Autowired
//	private MessageSourceAccessor messageSourceAccessor;

	public String s3ImgUpload(MultipartFile file, String folderName, String uploadFileName, String ext) {
		String result = "";

		if (ext.toLowerCase().equals("jpg") || ext.toLowerCase().equals("jpeg") || ext.toLowerCase().equals("png")) {
			try {

				//String bucketName = messageSourceAccessor.getMessage("work.s3.bucket", Constants.WORK_UPLOAD_BUCKET_NAME);
				String bucketName = Constants.WORK_UPLOAD_BUCKET_NAME;
				AccessControlList acl = new AccessControlList();
				acl.grantPermission(GroupGrantee.AllUsers, Permission.Read);
				try {
					// upload s3
					awsClient.getAmazonS3().putObject(new PutObjectRequest(bucketName, folderName + "/" + uploadFileName, file.getInputStream(), null).withAccessControlList(acl));

				} catch (Exception e) {
					e.printStackTrace();
					result = "202";
					return result;
				}

				result = "00";

			} catch (Exception e) {
				e.printStackTrace();
				result = "203";
				return result;
			}
		} else {
			result = "204";
			return result;
		}
		return result;
	}
	
	public String s3FileUpload(MultipartFile file, String folderName, String uploadFileName, String ext) {
		String result = "";

		if (!ext.toLowerCase().equals("war") || !ext.toLowerCase().equals("html") || !ext.toLowerCase().equals("exe")
				|| !ext.toLowerCase().equals("php") || !ext.toLowerCase().equals("jar")
				|| !ext.toLowerCase().equals("c")) {
			try {

//				String bucketName = messageSourceAccessor.getMessage("work.s3.bucket", Constants.WORK_UPLOAD_BUCKET_NAME);
				String bucketName = Constants.WORK_UPLOAD_BUCKET_NAME;
				AccessControlList acl = new AccessControlList();
				acl.grantPermission(GroupGrantee.AllUsers, Permission.Read);
				try {
					// upload s3
					awsClient.getAmazonS3().putObject(new PutObjectRequest(bucketName, folderName + "/" + uploadFileName, file.getInputStream(), null).withAccessControlList(acl));

				} catch (Exception e) {
					e.printStackTrace();
					result = "202";
					return result;
				}

				result = "00";

			} catch (Exception e) {
				e.printStackTrace();
				result = "203";
				return result;
			}
		} else {
			result = "204";
			return result;
		}
		return result;
	}

	public String s3FileDelete(List<String> filelist, String folderName) {

		String result = "";

//		String bucketName = messageSourceAccessor.getMessage("work.upload.s3.bucket.name", Constants.WORK_UPLOAD_BUCKET_NAME);
		String bucketName = Constants.WORK_UPLOAD_BUCKET_NAME;
		try {
			for (String fname : filelist) {
				fname = fname.substring(fname.lastIndexOf("/") + 1, fname.length());
				awsClient.getAmazonS3().deleteObject(new DeleteObjectRequest(bucketName + "/" + folderName, fname));
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = "202";
			return result;
		}
		result = "00";
		return result;
	}

	public String s3FileDelete(String fname, String folderName) {
		String result = "";

//		String bucketName = messageSourceAccessor.getMessage("work.upload.s3.bucket.name", Constants.WORK_UPLOAD_BUCKET_NAME);
		String bucketName = Constants.WORK_UPLOAD_BUCKET_NAME;
		
		try {
			fname = fname.substring(fname.lastIndexOf("/") + 1, fname.length());
			awsClient.getAmazonS3().deleteObject(new DeleteObjectRequest(bucketName + "/" + folderName, fname));
		} catch (Exception e) {
			e.printStackTrace();
			result = "202";
			return result;
		}
		result = "00";
		return result;
	}
	
	public String s3FileDeleteByUrl(String url) {
		String result = "";

//		String bucketName = messageSourceAccessor.getMessage("work.upload.s3.bucket.name", Constants.WORK_UPLOAD_BUCKET_NAME);
		String bucketName = Constants.WORK_UPLOAD_BUCKET_NAME;
		try {
			
			String folderName = url.substring(0, url.lastIndexOf("/"));
			folderName = folderName.substring(folderName.lastIndexOf("/")+1);
			
			String fname = url.substring(url.lastIndexOf("/")+1);
			
			awsClient.getAmazonS3().deleteObject(new DeleteObjectRequest(bucketName + "/" + folderName, fname));
		} catch (Exception e) {
			e.printStackTrace();
			result = "202";
			return result;
		}
		result = "00";
		return result;
	}
	
}
