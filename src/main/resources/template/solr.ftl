package ${packagePath}.bo;

import org.apache.solr.client.solrj.beans.Field;
import org.springframework.data.solr.core.mapping.Dynamic;
import org.springframework.data.solr.core.mapping.SolrDocument;

import java.util.Date;
import java.util.List;
import java.util.Map;


@SolrDocument(solrCoreName="${entityList[0].humpName}")
public class ${entityList[0].upperCaseHumpName}SolrEntity {

    <#list entityList as entity>
    <#if entity.lowerFieldName == 'disabled' || entity.lowerFieldName == 'deleted'>
    // ${entity.remark}
    @Field("${entity.lowerFieldName}")
    private Boolean ${entity.lowerFieldName};
    <#else>
    // ${entity.remark}
    @Field("${entity.lowerFieldName}")
    private ${entity.fieldType} ${entity.lowerFieldName};
    </#if>
    </#list>

    <#list entityList as entity>
    <#if entity.lowerFieldName == 'disabled' || entity.lowerFieldName == 'deleted'>
    public void set${entity.upperFieldName}(Boolean ${entity.lowerFieldName}) {
        this.${entity.lowerFieldName} = ${entity.lowerFieldName};
    }
    public Boolean get${entity.upperFieldName}() {
        return ${entity.lowerFieldName};
    }
    <#else>
    public void set${entity.upperFieldName}(${entity.fieldType} ${entity.lowerFieldName}) {
        this.${entity.lowerFieldName} = ${entity.lowerFieldName};
    }

    public ${entity.fieldType} get${entity.upperFieldName}() {
        return ${entity.lowerFieldName};
    }
    </#if>

    </#list>

    @Override
    public String toString() {
        return "${entityList[0].upperCaseHumpName}Solr{" +
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
