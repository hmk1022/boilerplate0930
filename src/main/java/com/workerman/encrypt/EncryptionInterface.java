package com.workerman.encrypt;

/**
 * 암호화/복호화 인터페이스
 */
public interface  EncryptionInterface {

	/**
	 * 암호화
	 */
	public abstract void encrypt();
	
	/**
	 * 복호화
	 */
	public abstract void decrypt();
	
}