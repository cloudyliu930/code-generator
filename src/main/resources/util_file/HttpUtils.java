


import org.springframework.http.HttpMethod;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.Objects;

/**
 * @author
 * @createTime 2018/10/8
 * @description Http工具类
 */
public class HttpUtils {

	/**
	 * 将request 中的所有参数输出，用于debug
	 * @param request servlet请求
	 * @return String
	 */
	public static String debugRequestParams(HttpServletRequest request) {
		StringBuffer sb = new StringBuffer(request.getMethod() + ":" + request.getRequestURL());
		sb.append(Objects.isNull(request.getQueryString()) ? "" : "?" + request.getQueryString());
		sb.append("\n");
		if (HttpMethod.POST.name().equals(request.getMethod())) {
			Enumeration<String> it = request.getParameterNames();
			while (it.hasMoreElements()) {
				String key = it.nextElement();
				String value = request.getParameter(key);
				sb.append( key + "=" + value + "\n");
			}
		}
		String ret = sb.toString();
		return ret;
	}

	/**
	 * 获取用户IP地址
	 * @param request http请求
	 * @return String ip地址
	 */
	public static String getIPAddress(HttpServletRequest request) {
		String ip = null;
		// X-Forwarded-For：Squid 服务代理
		String ipAddresses = request.getHeader("X-Forwarded-For");

		if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
			// Proxy-Client-IP：apache 服务代理
			ipAddresses = request.getHeader("Proxy-Client-IP");
		}

		if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
			// WL-Proxy-Client-IP：weblogic 服务代理
			ipAddresses = request.getHeader("WL-Proxy-Client-IP");
		}

		if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
			// HTTP_CLIENT_IP：有些代理服务器
			ipAddresses = request.getHeader("HTTP_CLIENT_IP");
		}

		if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
			// X-Real-IP：nginx服务代理
			ipAddresses = request.getHeader("X-Real-IP");
		}

		// 有些网络通过多层代理，那么获取到的ip就会有多个，一般都是通过逗号（,）分割开来，并且第一个ip为客户端的真实IP
		if (ipAddresses != null && ipAddresses.length() != 0) {
			ip = ipAddresses.split(",")[0];
		}

		// 还是不能获取到，最后再通过request.getRemoteAddr();获取
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
			ip = request.getRemoteAddr();
		}

		return ip;
	}

	/**
	 * 读取cookie记录
	 * @param request
	 * @param cookieName
	 * @return
	 */
	public static Cookie getCookie(HttpServletRequest request, String cookieName) {
		javax.servlet.http.Cookie cookies[] = request.getCookies();
		if (cookies != null) {
			for (javax.servlet.http.Cookie cookie : cookies) {
				if (cookie.getName().equals(cookieName)) {
					return cookie;
				}
			}
		}
		return null;
	}

	/**
	 * 从path中读取jsessionId
	 * @param request
	 * @param paramName
	 * @return
	 */
	public static String getUriPathSegmentParamValue(HttpServletRequest request, String paramName) {
		String uri = request.getRequestURI();
		if (uri == null) {
			return null;
		}

		int queryStartIndex = uri.indexOf('?');
		// get rid of the query string
		if (queryStartIndex >= 0) {
			uri = uri.substring(0, queryStartIndex);
		}

		// now check for path segment parameters:
		int index = uri.indexOf(';');
		if (index < 0) {
			//no path segment params - return:
			return null;
		}

		// there are path segment params, let's get the last one that may exist:
		final String TOKEN = paramName + "=";

		// uri now contains only the path segment params
		uri = uri.substring(index+1);

		// we only care about the last JSESSIONID param:
		index = uri.lastIndexOf(TOKEN);
		if (index < 0) {
			// no segment param:
			return null;
		}

		uri = uri.substring(index + TOKEN.length());

		// strip off any remaining segment params:
		index = uri.indexOf(';');
		if(index >= 0) {
			uri = uri.substring(0, index);
		}

		return uri;
	}
	
}
