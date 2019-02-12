

import java.util.Arrays;

import static java.util.stream.Collectors.toList;

/**
 * @author
 * @createTime 2019/1/7
 * @description
 */
public class ExceptionUtils {

    /**
     * 遍历返回堆栈信息
     * @param exception 异常
     * @return String 堆栈字符串
     */
    public static String getException(Exception exception) {
        return Arrays.stream(exception.getStackTrace()).map(exa -> exa.toString()).collect(toList()).toString();
    }

}
