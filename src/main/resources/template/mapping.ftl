<#assign maxLength=1 />
<#list entityList as entity>
    <#if (entity.columnName?length) gt maxLength>
        <#assign maxLength= (entity.columnName?length)/>
    </#if>
</#list>
<#function getSpace columnLength maxLength>
    <#assign spaceLength = maxLength - columnLength + 1/>
    <#assign space = "" />
    <#list 1..spaceLength as l>
        <#assign space = space + " "/>
    </#list>
    <#return space>
</#function>
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packagePath}.dao.${entityList[0].upperCaseHumpName}Mapper">


    <!-- Start Auto Common -->

    <select id="select" resultType="${packagePath}.entity.${entityList[0].upperCaseHumpName}Entity">
        SELECT
        <#list entityList as entity>
        <#if entity_has_next>
            ${entity.columnName}${getSpace(entity.columnName?length, maxLength)}AS ${entity.lowerFieldName},
        <#else>
            ${entity.columnName}${getSpace(entity.columnName?length, maxLength)}AS ${entity.lowerFieldName}
        </#if>
        </#list>
        FROM
            ${entityList[0].databaseName}.${entityList[0].tableName}
        WHERE
            code = ${r'#'}{code}
        AND
            disabled = 0
    </select>

    <select id="selectList" resultType="${packagePath}.entity.${entityList[0].upperCaseHumpName}Entity">
        SELECT
        <#list entityList as entity>
        <#if entity_has_next>
            ${entity.columnName}${getSpace(entity.columnName?length, maxLength)}AS ${entity.lowerFieldName},
        <#else>
            ${entity.columnName}${getSpace(entity.columnName?length, maxLength)}AS ${entity.lowerFieldName}
        </#if>
        </#list>
        FROM
            ${entityList[0].databaseName}.${entityList[0].tableName}
        <where>
            disabled = 0
        <#list entityList as entity>
        <#if entity_index lt (entityList?size - 17)>
        <#if entity.fieldType == "String">
        <if test="params.${entity.lowerFieldName} != null and params.${entity.lowerFieldName} != ''">
        AND
            ${entity.columnName} = ${r'#'}{params.${entity.lowerFieldName}}
        </if>
        <#else>
        <if test="params.${entity.lowerFieldName} != null ">
        AND
            ${entity.columnName} = ${r'#'}{params.${entity.lowerFieldName}}
        </if>
        </#if>
        </#if>
        </#list>
        </where>
        ORDER BY id DESC
        <if test="params.start != null and params.size != null">
        LIMIT
            ${r'#'}{params.start}, ${r'#'}{params.size}
        </if>
    </select>

    <select id="selectCount" resultType="java.lang.Long">
        SELECT
            COUNT(*)
        FROM
            ${entityList[0].databaseName}.${entityList[0].tableName}
        <where>
            disabled = 0
        <#list entityList as entity>
        <#if entity_index lt (entityList?size - 17)>
        <#if entity.fieldType == "String">
        <if test="params.${entity.lowerFieldName} != null and params.${entity.lowerFieldName} != ''">
        AND
            ${entity.columnName} = ${r'#'}{params.${entity.lowerFieldName}}
        </if>
        <#else>
        <if test="params.${entity.lowerFieldName} != null ">
        AND
            ${entity.columnName} = ${r'#'}{params.${entity.lowerFieldName}}
        </if>
        </#if>
        </#if>
        </#list>
        </where>
    </select>


    <insert id="insert" useGeneratedKeys="true" keyProperty="entity.id">
        INSERT INTO
            ${entityList[0].databaseName}.${entityList[0].tableName}
        (
            <#list entityList as entity>
            <#if entity_has_next>
            ${entity.columnName},
            <#else>
            ${entity.columnName}
            </#if>
            </#list>
        )
        VALUES (
            <#list entityList as entity>
            <#if entity_has_next>
            ${r'#'}{entity.${entity.lowerFieldName}},
            <#else>
            ${r'#'}{entity.${entity.lowerFieldName}}
            </#if>
            </#list>
        )
    </insert>

    <update id="update">
        UPDATE
            ${entityList[0].databaseName}.${entityList[0].tableName}
        SET
        <#list entityList as entity>
        <#if entity_index gt 0 && entity_index lt (entityList?size - 14)>
        <#if entity.fieldType == "String">
        <if test="entity.${entity.lowerFieldName} != null and entity.${entity.lowerFieldName} != ''">
            ${entity.columnName} = ${r'#'}{entity.${entity.lowerFieldName}},
        </if>
        <#else>
        <if test="entity.${entity.lowerFieldName} != null">
            ${entity.columnName} = ${r'#'}{entity.${entity.lowerFieldName}},
        </if>
        </#if>
        </#if>
        </#list>
            modify_by = ${r'#'}{entity.modifyBy},
            modify_time = ${r'#'}{entity.modifyTime}
        WHERE
            code = ${r'#'}{entity.code}
    </update>

    <update id="delete">
        UPDATE
            ${entityList[0].databaseName}.${entityList[0].tableName}
        SET
            disabled = 1,
            modify_by = ${r'#'}{entity.modifyBy},
            modify_time = ${r'#'}{entity.modifyTime}
        WHERE
            code = ${r'#'}{entity.code}
    </update>

    <!-- End Auto Common  -->

</mapper>


