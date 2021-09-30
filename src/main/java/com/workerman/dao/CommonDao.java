package com.workerman.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.workerman.encrypt.EncryptionInterface;

/**
 * 데이터베이스 연결클래스
 */
@Repository("commonDao")
public class CommonDao {
	
	@Autowired 
	@Qualifier("sqlSessionTemplate")
	private SqlSession sessionTemplate;

	protected final Log log = LogFactory.getLog(getClass());

	/**
	 * 암호화메서드
	 */
	public void encrypt(Object obj){
		if(obj instanceof EncryptionInterface){
			((EncryptionInterface)obj).encrypt();
		}
	}
	
	/**
	 * 암호화메서드
	 */
	public void encrypt(Object obj, boolean isEncrypt){
		if(isEncrypt && obj instanceof EncryptionInterface){
			((EncryptionInterface)obj).encrypt();
		}
	}
	
	/**
	 * 복호화메서드
	 */
	public void decrypt(Object obj){
		if(obj instanceof EncryptionInterface){
			((EncryptionInterface)obj).decrypt();
		}
	}
	
	/**
	 * 복호화메서드 
	 */
	public void decryptList(List<?> objectList){
		for (Object object : objectList) {
			decrypt(object);
		}
	}
	
	/**
	 * 쿼리조회 - 오브젝트리턴
	 */
//	public Object queryForObject(String qureyId){
//		
//		Object object = sessionTemplate.selectOne(qureyId);
//
//		decrypt(object);
//		
//		return object;
//	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> queryForObject(String qureyId){
		
		Object object = sessionTemplate.selectOne(qureyId);

		decrypt(object);
		
		return (Map<String, Object>)object;
	}
	
	public Object queryForObjectNoCast(String qureyId, Object obj){
		
		Object object = sessionTemplate.selectOne(qureyId, obj);

		decrypt(object);
		
		return object;
	}
	
	/**
	 * 쿼리조회 - 오브젝트리턴
	 */
//	public Object queryForObject(String qureyId, Object obj){
//		
//		encrypt(obj);
//		
//		Object object = sessionTemplate.selectOne(qureyId, obj);
//
//		decrypt(object);
//		
//		return object;
//	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> queryForObject(String qureyId, Object obj){
		
		encrypt(obj);
		
		Object object = sessionTemplate.selectOne(qureyId, obj);

		decrypt(object);
		
		return (Map<String, Object>)object;
	}
	
	public String queryForString(String qureyId, Object obj){
		
		encrypt(obj);
		
		Object object = sessionTemplate.selectOne(qureyId, obj);
		
		decrypt(object);
		
		return (String)object;
	}
	
	public int queryForInt(String qureyId, Object obj){
		
		encrypt(obj);
		
		Object object = sessionTemplate.selectOne(qureyId, obj);
		
		decrypt(object);
		
		return (int)object;
	}
	
	public float queryForFloat(String qureyId, Object obj){
		
		encrypt(obj);
		
		Object object = sessionTemplate.selectOne(qureyId, obj);
		
		decrypt(object);
		
		return (float)object;
	}
	
	/**
	 * 
	 * 쿼리조회 - 리스트 오브젝트리턴
	 */
	@SuppressWarnings("rawtypes")
	public List queryForList(String qureyId, Object obj){
		
		encrypt(obj);
		
		List<?> objectList = sessionTemplate.selectList(qureyId, obj);
		
		decryptList(objectList);
		
		return objectList; 
	}
	
	/**
	 * 쿼리조회 - 리스트 오브젝트리턴
	 */
	@SuppressWarnings("rawtypes")
	public List queryForList(String qureyId){
		
		List<?> objectList = sessionTemplate.selectList(qureyId);
		
		decryptList(objectList);
		
		return objectList; 
	}
	
	/**
	 * 암호화 - 세션템플릿 update 값 리턴
	 */
	public int update(String qureyId, Object obj){
		
		encrypt(obj, true);
		
		return sessionTemplate.update(qureyId, obj);
	}
	
	/**
     * 암호화 - 세션템플릿 insert 값 리턴
     */
	public int insert(String qureyId, Object obj){
		
		encrypt(obj, true);
		
		return sessionTemplate.insert(qureyId, obj);
	}
	
	/**
     * 암호화 - 세션템플릿 delete 값 리턴
     */
	public int delete(String qureyId, Object obj){
		
		encrypt(obj, true);
		
		return sessionTemplate.delete(qureyId, obj);
	}
	
	public int delete(String qureyId){
		return sessionTemplate.delete(qureyId);
	}

}
