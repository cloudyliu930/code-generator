package ${packagePath}.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.util.Date;

/**
 * ${entityList[0].tableRemark}
 * @author
 */
@ApiModel("${entityList[0].tableRemark}")
public class ${entityList[0].upperCaseHumpName}Vo {

    /**
     * 用于分组校验 增删改查
     */
    public interface Create { }
    public interface Update { }
    public interface Delete { }

    <#list entityList as entity>
    <#if entity.lowerFieldName == 'code'>

    @ApiModelProperty("${entity.remark}")
    @NotNull(message = "${entity.remark}不能为空", groups = { ${entityList[0].upperCaseHumpName}Vo.Delete.class })
    private String ${entity.lowerFieldName};
    <#elseif entity.lowerFieldName == 'disabled' || entity.lowerFieldName == 'deleted'>

    @ApiModelProperty("${entity.remark}")
    private Boolean ${entity.lowerFieldName};
    <#else>

    @ApiModelProperty("${entity.remark}")
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
        return "${entityList[0].upperCaseHumpName}Vo{" +
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
