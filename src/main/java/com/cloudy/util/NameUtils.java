package com.cloudy.util;

/**
 * Created by Leo_Chan on 2016/9/30.
 */
public class NameUtils {

    public static String humpName(String tableName){
        return toHumpName(tableName);
    }

    public static String upperCaseHumpName(String tableName){
        String humpName = toHumpName(tableName);
        return humpName.substring(0, 1).toUpperCase() + humpName.substring(1);
    }

    /**
     * 获取XML文件名
     * @param tableName
     * @return
     */
    public static String xmlName(String tableName){
        return tableName.replaceAll("_", "") + "Mapping.xml";
    }


    /**
     * 获取Java类 字段名
     * @param columnName
     * @return
     */
    public static String fieldName(String columnName){
        return toHumpName(columnName);
    }


    /**
     * 获取Java类 字段名 头大写
     * @param columnName
     * @return
     */
    public static String upperFieldName(String columnName){
        String fieldName = fieldName(columnName);
        return fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1);
    }


    /**
     * 获取Java类 字段名 头小写
     * @param columnName
     * @return
     */
    public static String lowerFieldName(String columnName){
        String fieldName = fieldName(columnName);
        return fieldName.substring(0, 1).toLowerCase() + fieldName.substring(1);
    }



    /**
     * 获取Java字段类型
     * @param columnType
     * @return
     */
    public static String fieldType(String columnType){
        String javaType = javaType(columnType);
        return javaType.substring(javaType.lastIndexOf(".") + 1, javaType.length());
    }



    /**
     * 获取Java字段类型 全路径
     * @param columnType
     * @return
     */
    public static String javaType(String columnType){
        columnType = columnType.toUpperCase();
        switch (columnType){
            case "VARCHAR":
            case "VARCHAR2":
            case "CHAR":
                return "java.lang.String";
            case "TINYINT":
                return "java.lang.Integer";
            case "BIT":
                return "java.lang.Boolean";
            case "INT":
            case "SMALLINT":
            case "INTEGER":
                return "java.lang.Integer";
            case "BIGINT":
                return "java.lang.Long";
            case "DATETIME":
            case "TIMESTAMP":
            case "DATE":
                return "java.util.Date";
            case "DOUBLE":
            case "DECIMAL":
                return "java.lang.Double";
            default:
                return "java.lang.String";
        }
    }


    /**
     * 数据库 表名字段名 替换为 Java驼峰命名
     * @param name
     * @return
     */
    private static String toHumpName(String name){
        String[] split = name.split("_");
        String humpName = "";
        for (int x = 0; x < split.length; x++){
            if (x == 0){
                humpName += split[x];
            } else {
                humpName += split[x].substring(0, 1).toUpperCase() + split[x].substring(1);
            }
        }
        return humpName;
    }
}
