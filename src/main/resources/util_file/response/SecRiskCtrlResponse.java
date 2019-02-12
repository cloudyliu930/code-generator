package com.ygts.security.riskcontrol.common.response;

import java.io.Serializable;

/**
 * @author
 * @createTime 2018/9/29
 * @description Controller返回响应体
 */
public class SecRiskCtrlResponse<T> implements Serializable {

	private static final long serialVersionUID = 1L;

	private T result;

	private String code;

	private String message;
	
	private String sessionKey;

	private Boolean isSuccess;
	
	private String imgBase64;
	
	public SecRiskCtrlResponse() {
		
	}
	

	public T getResult() {
		return result;
	}

	public void setResult(T result) {
		this.result = result;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Boolean getIsSuccess() {
		return isSuccess;
	}

	public void setIsSuccess(Boolean isSuccess) {
		this.isSuccess = isSuccess;
	}
	
	public String getSessionKey() {
		return sessionKey;
	}

	public void setSessionKey(String sessionKey) {
		this.sessionKey = sessionKey;
	}

	public String getImgBase64() {
		return imgBase64;
	}

	public void setImgBase64(String imgBase64) {
		this.imgBase64 = imgBase64;
	}

	public static <T> com.ygts.security.riskcontrol.common.response.SecRiskCtrlResponse<T> code(String code, Boolean isSuccess, String message, T result) {
		com.ygts.security.riskcontrol.common.response.SecRiskCtrlResponse<T> response = new com.ygts.security.riskcontrol.common.response.SecRiskCtrlResponse<T>();
		response.setCode(code);
		response.setIsSuccess(isSuccess);
		response.setMessage(message);
		response.setResult(result);
		return response;
	}

	
	
	@Override
	public String toString() {
		return "SecRiskCtrlResponse{" +
				"result=" + result +
				", code=" + code +
				", message='" + message + '\'' +
				", isSuccess=" + isSuccess +
				'}';
	}

}
