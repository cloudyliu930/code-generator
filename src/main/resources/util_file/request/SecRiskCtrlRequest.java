package com.ygts.security.riskcontrol.common.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import javax.validation.Valid;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * @author
 * @createTime 2018/9/29
 * @description Controller入参请求体
 */
@ApiModel(value = "Controller入参请求体")
public class SecRiskCtrlRequest<T> implements Serializable {

	private static final long serialVersionUID = 1L;

	public interface Page { }

	@ApiModelProperty(value = "请求体对象")
	@Valid
	@NotNull(message = "params不能为空")
	private T params;

	@ApiModelProperty(value = "当前页码")
	@Min(value = 1, message = "page不能小于1", groups = { com.ygts.security.riskcontrol.common.request.SecRiskCtrlRequest.Page.class })
	@Max(value = Integer.MAX_VALUE, message = "page不能大于" + Integer.MAX_VALUE, groups = { com.ygts.security.riskcontrol.common.request.SecRiskCtrlRequest.Page.class })
	@NotNull(message = "page不能为空", groups = { com.ygts.security.riskcontrol.common.request.SecRiskCtrlRequest.Page.class })
	private Integer page;

	@ApiModelProperty(value = "每页条数")
	@Min(value = 1, message = "size不能小于1", groups = { com.ygts.security.riskcontrol.common.request.SecRiskCtrlRequest.Page.class })
	@Max(value = Integer.MAX_VALUE, message = "size不能大于" + Integer.MAX_VALUE, groups = { com.ygts.security.riskcontrol.common.request.SecRiskCtrlRequest.Page.class })
	@NotNull(message = "size不能为空", groups = { com.ygts.security.riskcontrol.common.request.SecRiskCtrlRequest.Page.class })
	private Integer size;

	@ApiModelProperty(value = "客户端来源")
	private String clientSource;

	@ApiModelProperty(value = "IP地址")
	private String ipAddr;

	@ApiModelProperty(value = "设备指纹")
	private String fingerPrint;

	@ApiModelProperty(value = "会话key")
	private String sessionKey;

	@ApiModelProperty(value = "客户端请求发送时间")
	private Long clientReqTime;

	@ApiModelProperty(value = "事件类型")
	private String eventType;

	@ApiModelProperty(value = "用户名")
	private String userName;

	@ApiModelProperty(value = "访问地址")
	private String address;

	@ApiModelProperty(value = "风险等级")
	private Integer riskLevel;
	
	public T getParams() {
		return params;
	}

	public void setParams(T params) {
		this.params = params;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public String getClientSource() {
		return clientSource;
	}

	public void setClientSource(String clientSource) {
		this.clientSource = clientSource;
	}

	public String getIpAddr() {
		return ipAddr;
	}

	public void setIpAddr(String ipAddr) {
		this.ipAddr = ipAddr;
	}

	public String getFingerPrint() {
		return fingerPrint;
	}

	public void setFingerPrint(String fingerPrint) {
		this.fingerPrint = fingerPrint;
	}

	public String getSessionKey() {
		return sessionKey;
	}

	public void setSessionKey(String sessionKey) {
		this.sessionKey = sessionKey;
	}
	
	public Long getClientReqTime() {
		return clientReqTime;
	}

	public void setClientReqTime(Long clientReqTime) {
		this.clientReqTime = clientReqTime;
	}

	public static void main(String[] args) {
		System.out.println(System.currentTimeMillis());;
	}
	
	public String getEventType() {
		return eventType;
	}

	public void setEventType(String eventType) {
		this.eventType = eventType;
	}
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	public Integer getRiskLevel() {
		return riskLevel;
	}

	public void setRiskLevel(Integer riskLevel) {
		this.riskLevel = riskLevel;
	}
	
	@Override
	public String toString() {
		return "SecRiskCtrlRequest{" +
				"params=" + params +
				", page=" + page +
				", size=" + size +
				", clientSource='" + clientSource + '\'' +
				", ipAddr='" + ipAddr + '\'' +
				", fingerPrint='" + fingerPrint + '\'' +
				", sessionKey='" + sessionKey + '\'' +
				'}';
	}
}
