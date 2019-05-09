package com.cloudy.handler;

import com.cloudy.entity.ColumnEntity;
import com.cloudy.util.NameUtils;
import com.cloudy.util.TemplateUtils;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * Created by Leo_Chan on 2016/9/27.
 */
public class AutoCreateHandler {

    /**
     * 连接数据库
     */
    static {
        try {
            Properties prop = new Properties();
            String url = null;
            String username = null;
            String password = null;


            InputStream inputStream = AutoCreateHandler.class.getResourceAsStream("/systemConfig.properties");
//            InputStream inputStream = new FileInputStream(new File("").getCanonicalPath() + File.separator + "systemConfig.properties");

            try {
                prop.load(inputStream);
//                prop.load(resourceAsStream);
                url = prop.getProperty("jdbc.url").trim();
                username = prop.getProperty("jdbc.username").trim();
                password = prop.getProperty("jdbc.password").trim();
                packagePath = prop.getProperty("package.path").trim();
                outputPath = prop.getProperty("output.path").trim();
            } catch (IOException e) {
                e.printStackTrace();
            }
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* 数据库连接 */
    private static Connection connection;
    /* 包名全路径 */
    private static String packagePath;
    /* 输出路径 */
    private static String outputPath;
    /* 数据表名集合 */
    private static Map<String, String> tableMap = new HashMap<>();


    public static void main(String[] args) throws Exception {
        List<String> tableNames = getTableNames(connection);
        List<String> newTableNames = new ArrayList<>();
        List<String> excludeNames = Arrays.asList("tmp_OrderIDERP", "TMPID", "Fct_OriginalOrder_20171207", "Fct_ExpOrder_20171207");

        for (int i = 0; i < tableNames.size(); i++) {
            if (excludeNames.contains(tableNames.get(i))) {
                continue;
            }

            newTableNames.add(tableNames.get(i));
        }

        // List<String> tableNames = new ArrayList<>();
        // tableNames.add("waybill_base_info");
        start(connection, newTableNames, outputPath);

        System.out.println("Auto Create Success!");
    }


    /**
     * 其他数据库不需要这个方法 oracle和db2需要
     * @param conn
     * @return
     * @throws Exception
     */
    private static String getSchema(Connection conn) throws Exception {
        String schema;
        schema = conn.getMetaData().getUserName();
        if ((schema == null) || (schema.length() == 0)) {
            throw new Exception("ORACLE数据库模式不允许为空");
        }
        return schema.toUpperCase().toString();

    }


    /**
     * 获取数据库所有表名称
     * @param connection
     * @return
     * @throws java.sql.SQLException
     */
    private static List<String> getTableNames(Connection connection) throws SQLException {
        List<String> tableNames = new ArrayList<String>();
        ResultSet resultSet = connection.getMetaData().getTables(connection.getCatalog(), "root", null, new String[]{"TABLE"});
        while (resultSet.next()){
            tableNames.add(resultSet.getString("TABLE_NAME"));

        }
        return tableNames;
    }


    /**
     * 入口
     * @param connection
     * @param tableNames
     * @throws java.sql.SQLException
     */
    public static void start(Connection connection, List<String> tableNames, String filePath) throws Exception {
        ResultSet tableResultSet = connection.getMetaData().getTables(null, "%", "%", new String[] { "TABLE" });
        while (tableResultSet.next()){
            tableMap.put(tableResultSet.getString("TABLE_NAME"), tableResultSet.getString("REMARKS"));
        }
        for (String tableName : tableNames){
            String tableRemark = tableMap.get(tableName);
            // 获取表数据内容
            ResultSet resultSet = connection.getMetaData().getColumns(connection.getCatalog(), getSchema(connection), tableName, null);
            // 获取表中数据 并装入ColumnEntity
            List<ColumnEntity> columnToEntity = getColumnToEntity(resultSet, tableRemark);

            // 封装FreeMarker 写入参数
            Map<String, Object> map = new HashMap<>();
            map.put("packagePath", packagePath);
            map.put("entityList", columnToEntity);

            // 写入Entity
            writeFile(filePath + File.separator + "auto_create" + File.separator + "entity", NameUtils.upperCaseHumpName(columnToEntity.get(0).getTableName()) + "Entity.java", TemplateUtils.toString(map, "entity.ftl"));
            // 写入vo
            writeFile(filePath + File.separator + "auto_create" + File.separator + "vo", NameUtils.upperCaseHumpName(columnToEntity.get(0).getTableName()) + "Vo.java", TemplateUtils.toString(map, "vo.ftl"));
            // 写入vo
            writeFile(filePath + File.separator + "auto_create" + File.separator + "bo", NameUtils.upperCaseHumpName(columnToEntity.get(0).getTableName()) + "Bo.java", TemplateUtils.toString(map, "bo.ftl"));
            // 写入Dao
            writeFile(filePath + File.separator + "auto_create" + File.separator + "dao", NameUtils.upperCaseHumpName(columnToEntity.get(0).getTableName()) + "Mapper.java", TemplateUtils.toString(map, "dao.ftl"));
            // 写入Mapper
            writeFile(filePath + File.separator + "auto_create" + File.separator + "mapping", NameUtils.xmlName(columnToEntity.get(0).getTableName()), TemplateUtils.toString(map, "mapping.ftl"));
            // 写入controller
            writeFile(filePath + File.separator + "auto_create" + File.separator + "controller", NameUtils.upperCaseHumpName(columnToEntity.get(0).getTableName()) + "Controller.java", TemplateUtils.toString(map, "controller.ftl"));
            // 写入controller converter
            writeFile(filePath + File.separator + "auto_create" + File.separator + "controller" + File.separator + "converter", NameUtils.upperCaseHumpName(columnToEntity.get(0).getTableName()) + "ControllerConverter.java", TemplateUtils.toString(map, "controllerConverter.ftl"));
            // 写入result
            writeFile(filePath + File.separator + "auto_create" + File.separator + "result", NameUtils.upperCaseHumpName(columnToEntity.get(0).getTableName()) + "Result.java", TemplateUtils.toString(map, "result.ftl"));
            // 写入service converter
            writeFile(filePath + File.separator + "auto_create" + File.separator + "service" + File.separator + "converter", NameUtils.upperCaseHumpName(columnToEntity.get(0).getTableName()) + "ServiceConverter.java", TemplateUtils.toString(map, "serviceConverter.ftl"));
            // 写入service interface
            writeFile(filePath + File.separator + "auto_create" + File.separator + "service", "I" + NameUtils.upperCaseHumpName(columnToEntity.get(0).getTableName()) + "Service.java", TemplateUtils.toString(map, "serviceInterface.ftl"));
            // 写入service implements
            writeFile(filePath + File.separator + "auto_create" + File.separator + "service" + File.separator + "impl", NameUtils.upperCaseHumpName(columnToEntity.get(0).getTableName()) + "ServiceImpl.java", TemplateUtils.toString(map, "serviceImpl.ftl"));
            // 写入service implements
            // writeFile(filePath + File.separator + "auto_create" + File.separator + "solr", NameUtils.upperCaseHumpName(columnToEntity.get(0).getTableName()) + "SolrEntity.java", TemplateUtils.toString(map, "solr.ftl"));

        }

    }


    /**
     * 获取数据库 表名 字段名 以及 字段注释
     * @param resultSet
     * @return
     * @throws java.sql.SQLException
     */
    private static List<ColumnEntity> getColumnToEntity(ResultSet resultSet, String tableRemark) throws SQLException {
        List<ColumnEntity> list = new ArrayList<ColumnEntity>();
        while (resultSet.next()){
            ColumnEntity columnEntity = new ColumnEntity();
            String databaseName = resultSet.getString("TABLE_CAT"); //数据库名称
            String tableName = resultSet.getString("TABLE_NAME"); //表名称
            String columnName = resultSet.getString("COLUMN_NAME"); //字段名称
            String columnType = resultSet.getString("TYPE_NAME"); //字段类型
            String remark = resultSet.getString("REMARKS"); //字段注释

            columnEntity.setDatabaseName(databaseName);
            columnEntity.setTableRemark(tableRemark);
            columnEntity.setTableName(tableName);
            columnEntity.setColumnName(columnName);
            columnEntity.setColumnType(columnType);
            columnEntity.setRemark(remark);

            list.add(columnEntity);
        }
        return list;
    }


    /**
     * 写入文件
     * @param filePath
     * @param fileName
     * @param date
     */
    private static void writeFile(String filePath, String fileName, String date){
        File file = new File(filePath);
        FileOutputStream fileOutputStream = null;
        if (!file.exists()){
            file.mkdirs();
        }

        try {
            fileOutputStream = new FileOutputStream(new File(filePath, fileName));
            byte[] bytes = date.getBytes();
            fileOutputStream.write(bytes);

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (fileOutputStream != null){
                try {
                    fileOutputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }


}
