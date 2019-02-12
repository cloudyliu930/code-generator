

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author
 * @createTime 2019/1/4
 * @description 时间工具类
 */
public class DateUtils {

    public static final String YYYY_MM_DD_HH_MM_SS_SSS = "yyyy-MM-dd HH:mm:ss SSS";
    public static final String YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";
    public static final String YYYY_MM_DD = "yyyy-MM-dd";
    public static final String YYYYMMDD = "yyyyMMdd";

    /**
     * 校验时间格式
     * @param strDate 时间字符串
     * @param pattern 模式
     * @return boolean
     */
    public static Boolean isValidDate(String strDate, String pattern) {
        SimpleDateFormat format = new SimpleDateFormat(pattern);
        try {
            // 设置lenient为false. 否则SimpleDateFormat会比较宽松地验证日期，比如2018-02-29会被接受，并转换成2018-03-01
            format.setLenient(Boolean.FALSE);
            format.parse(strDate);
        } catch (Exception e) {
            // 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
            return false;
        }

        return true;
    }

    /**
     * 格式化日期
     * @param date 事件
     * @param pattern 模式
     * @return String 时间字符串
     */
    public static String formatDate(Date date, String pattern) {
        SimpleDateFormat format = new SimpleDateFormat(pattern);
        return format.format(date);
    }

    /**
     * 字符串转时间
     * @param value 时间字符串
     * @param pattern 格式
     * @return Date
     */
    public static Date parseDate(String value, String pattern) {
        SimpleDateFormat format = new SimpleDateFormat(pattern);
        try {
            return format.parse(value);
        } catch (ParseException e) {
            return null;
        }
    }
}
