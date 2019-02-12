
import org.apache.commons.beanutils.BeanMap;
import org.springframework.beans.BeanUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * @author
 * @createTime 2018/9/26
 * @description bean 拷贝工具类
 */
public class BeanLocalUtils extends BeanUtils {

	
	public static void copyWithRuntimeException(Object dst, Object src) {
		try {
			org.apache.commons.beanutils.BeanUtils.copyProperties(dst, src);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * Map转Bean
	 * @param map
	 * @param beanClass
	 * @return
	 * @throws Exception
	 */
	public static Object mapToObject(Map<String, Object> map, Class<?> beanClass) throws Exception {    
		if (map == null) {
			return null;
		}

		Object obj = beanClass.newInstance();  
		org.apache.commons.beanutils.BeanUtils.populate(obj, map);  
		return obj;  
	}    

	/**
	 * Bean转Map
	 * @param obj
	 * @return
	 */
	public static Map<String, Object> objectToMap(Object obj) {
		if(obj == null) {
			return null;
		}

		BeanMap beanMap = new BeanMap(obj);
		Map<String,Object> map = new HashMap<String,Object>();
		
		for(Object key:beanMap.keySet()) {
			map.put(String.valueOf(key), beanMap.get(key));
		}
		return map;  
	}   

}
