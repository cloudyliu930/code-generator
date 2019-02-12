package ${packagePath}.po;

import java.util.Date;

/**
 * ${entityList[0].tableName} 表 Entity
 * @author
 */
public class ${entityList[0].upperCaseHumpName}Entity {

    <#list entityList as entity>
    <#if entity.lowerFieldName == 'disabled' || entity.lowerFieldName == 'deleted'>
    /**
     * ${entity.remark}
     */
    private Boolean ${entity.lowerFieldName};
    <#else>
    /**
     * ${entity.remark}
     */
    private ${entity.fieldType} ${entity.lowerFieldName};
    </#if>
    </#list>

    <#list entityList as entity>

    <#if entity.lowerFieldName == 'disabled' || entity.lowerFieldName == 'deleted'>
    /**
     * set ${entity.remark}
     * @param ${entity.lowerFieldName} ${entity.remark}
     */
    public void set${entity.upperFieldName}(Boolean ${entity.lowerFieldName}) {
        this.${entity.lowerFieldName} = ${entity.lowerFieldName};
    }

    /**
     * get ${entity.remark}
     * @return Boolean ${entity.remark}
     */
    public Boolean get${entity.upperFieldName}() {
        return ${entity.lowerFieldName};
    }
    <#else>
    /**
     * set ${entity.remark}
     * @param ${entity.lowerFieldName} ${entity.remark}
     */
    public void set${entity.upperFieldName}(${entity.fieldType} ${entity.lowerFieldName}) {
        this.${entity.lowerFieldName} = ${entity.lowerFieldName};
    }

    /**
     * get ${entity.remark}
     * @return ${entity.fieldType} ${entity.remark}
     */
    public ${entity.fieldType} get${entity.upperFieldName}() {
        return ${entity.lowerFieldName};
    }
    </#if>


    </#list>

    @Override
    public String toString() {
        return "${entityList[0].upperCaseHumpName}Entity{" +
        <#list entityList as entity>
            <#if entity.fieldType == 'String'>
                ", ${entity.lowerFieldName}='" + ${entity.lowerFieldName} + '\'' +
            <#else>
                ", ${entity.lowerFieldName}=" + ${entity.lowerFieldName} +
            </#if>
        </#list>
                '}';
    }
}
