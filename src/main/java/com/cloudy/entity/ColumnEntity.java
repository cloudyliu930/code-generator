package com.cloudy.entity;

import com.cloudy.util.NameUtils;

/**
 * Created by Leo_Chan on 2016/9/27.
 */
public class ColumnEntity {

    /* 库名 */
    private String databaseName;
    /* 表注释 */
    private String tableRemark;
    /* 表名 */
    private String tableName;
    /* 表字段名 */
    private String columnName;
    /* 表字段类型 */
    private String columnType;
    /* 表字段 */
    private String remark;

    public String getDatabaseName() {
        return databaseName;
    }

    public void setDatabaseName(String databaseName) {
        this.databaseName = databaseName;
    }

    public String getTableRemark() {
        return tableRemark;
    }

    public void setTableRemark(String tableRemark) {
        this.tableRemark = tableRemark;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getColumnType() {
        return columnType;
    }

    public void setColumnType(String columnType) {
        this.columnType = columnType;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getHumpName(){
        return NameUtils.humpName(this.tableName);
    }

    public String getUpperCaseHumpName(){
        return NameUtils.upperCaseHumpName(this.tableName);
    }

    public String getFieldName(){
        return NameUtils.fieldName(this.columnName);
    }

    public String getUpperFieldName(){
        return NameUtils.upperFieldName(this.columnName);
    }

    public String getLowerFieldName(){
        return NameUtils.lowerFieldName(this.columnName);
    }

    public String getFieldType(){
        return NameUtils.fieldType(this.columnType);
    }

    public String getJavaType(){
        return NameUtils.javaType(this.columnType);
    }
}
