package com.workerman.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.workerman.config.Constants;
import com.workerman.dao.CommonDao;
import com.workerman.utils.DateUtil;
import com.workerman.utils.S3Util;
import com.workerman.utils.StringUtil;

import ch.qos.logback.classic.pattern.Util;


/**
 * @author dwkwon
 * 고객사(지점) 관리
 *
 */
@Service("fileService")
public class FileService extends BaseService {

	@Autowired
	private CommonDao commonDao;

	@Autowired
	private S3Service s3Service;

	@Autowired
	private Properties systemProp;
	
	/**
	 * 고객사지점 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int upload(Map<String, Object> param) throws Exception{

		try {
			//param.put("branch_no", 123);
			MultipartFile[] img_arr = (MultipartFile[]) param.get("files");
			if(img_arr !=null) {
				//파일 업로드 후 w_work_facility_check_img insert
				for(MultipartFile img : img_arr) {
					if(img != null && !img.isEmpty()) {

						String fName = img.getOriginalFilename();
						String ext = fName.substring(fName.lastIndexOf(".")+1, fName.length());


						File uploadTempFile = new File(temp_dir + "/" + img.getOriginalFilename());

						System.out.println("work.upload.temp.dir : [" + temp_dir + "/" + img.getOriginalFilename() + "]");

					    img.transferTo(uploadTempFile);

						if(uploadTempFile.exists()) {

							String upload_key = "work_img/"
									.concat(DateUtil.getCurrentTime("yyyyMMddHHmmsss"))
									.concat("_")
									.concat((String)param.get("branch_no"))
									.concat("_")
									.concat(StringUtil.randomString(3))
									.concat(".")
									.concat(ext);

							s3Service.fileUpload(s3_bucket, upload_key , uploadTempFile, CannedAccessControlList.PublicRead);

			        		uploadTempFile.delete();

			        		String file_url = s3_url.concat("/").concat(s3_bucket).concat("/").concat(upload_key);

			        		/* insert image info */
			        		Map<String, Object> imgInfoMap = new HashMap<String, Object>();
			        		imgInfoMap.put("img_type", "BRANCH");
			        		imgInfoMap.put("img_url", file_url);
			        		imgInfoMap.put("key_no", (String)param.get("branch_no"));
			        		imgInfoMap.put("use_yn", "Y");
			        		imgInfoMap.put("del_yn", "N");
			        		imgInfoMap.put("create_no", param.get("create_no"));
			        		commonDao.insert("imgInfo.w_img_info", imgInfoMap);

			        	}
					}
				}
			}

		} catch (Exception e) {

		}
		return 1;
	}

	/**
	 * save image
	 * @param fileType
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> saveImgInfo(Map<String, Object> param) throws Exception {

		List<Map<String,Object>> resultList = new ArrayList<Map<String, Object>>();

		MultipartFile[] files = (MultipartFile[]) param.get("files");
		if(files == null) return resultList;



		for(MultipartFile img : files) {

			if(img != null && !img.isEmpty()) {
				System.out.println("img : "+ img);
				String img_type = (String)param.get("category_" + img.getName());	// get img_type

				String file_name = img.getOriginalFilename();
//				String ext = fName.substring(fName.lastIndexOf(".")+1, fName.length());
				String ext = StringUtil.substrIndex(file_name, ".");
				String temp_dir = getUpladPath();	// image upload directory
				String mask = String.valueOf(System.nanoTime());
				long img_size = img.getSize();

				File uploadTempFile = new File(temp_dir + mask + "." + ext);
				img.transferTo(uploadTempFile);

				String key_no = param.get("key_no").toString();

				Long create_no = 0L;
				
				if(param.get("create_no") != null) {
					create_no = Long.valueOf(param.get("create_no").toString()); 
				}else if(param.get("update_no") != null) {
					create_no = Long.valueOf(param.get("update_no").toString()); 
				}
						

				/* upload s3 start ****************************************/
				String upload_key = "work_img/"
						.concat(DateUtil.getCurrentTime("yyyyMMddHHmmssSSS"))
						.concat("_")
						.concat(key_no)
						.concat("_")
						.concat(StringUtil.randomString(3))
						.concat(".")
						.concat(ext);

				String s3_bucket = "workerman-upload-real";
				String s3_url = "https://s3.ap-northeast-2.amazonaws.com/";

				s3Service.fileUpload(s3_bucket, upload_key , uploadTempFile, CannedAccessControlList.PublicRead);

        		//uploadTempFile.delete();

        		String file_url = s3_url.concat("/").concat(s3_bucket).concat("/").concat(upload_key);
				/* upload s3 end *****************************************/

				/* insert image information */
				Map<String, Object> imgMap = new HashMap<String, Object>();
				imgMap.put("img_type", img_type); // image
				imgMap.put("img_name", file_name);
				imgMap.put("img_url", file_url);
				imgMap.put("img_size", img_size);
				imgMap.put("img_ext", ext);
				imgMap.put("key_no", key_no);
				imgMap.put("create_no", create_no);
				commonDao.insert("imgInfo.insertImgInfo", imgMap);
				resultList.add(imgMap);
				//TODO
				// file size 조절(aws 조절가능 여부 확인 필요.)
			}
		}

		return resultList;
	}

	/**
	 * image list
	 *
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> listImgInfo(Map<String, Object> param) {
		return commonDao.queryForList("imgInfo.listImgInfo", param);
	}

	/**
	 * image delete
	 *
	 * @param param
	 * @return
	 */
	public int deleteImgInfo(Map<String, Object> param) {
		return commonDao.delete("imgInfo.deleteImgInfo", param);
	}
}