package ${packagePath}.service.converter;

import ${packagePath}.entity.${entityList[0].upperCaseHumpName}Entity;
import ${packagePath}.vo.${entityList[0].upperCaseHumpName}Vo;
import ${packagePath}.model.CommParams;
import ${packagePath}.util.BeanLocalUtils;

/**
 * ${entityList[0].tableName} service转换类
 * @author
 */
public class ${entityList[0].upperCaseHumpName}ServiceConverter {

    /**
     * 转换Entity
     * @param vo 基本信息
     * @param commParams 公共参数
     * @return ${entityList[0].upperCaseHumpName}Entity
     */
    public static ${entityList[0].upperCaseHumpName}Entity toEntity(${entityList[0].upperCaseHumpName}Vo vo, CommParams commParams) {
        ${entityList[0].upperCaseHumpName}Entity entity = new ${entityList[0].upperCaseHumpName}Entity();
        if (vo != null) {
            BeanLocalUtils.copyWithRuntimeException(entity, vo);
        }
        BeanLocalUtils.copyWithRuntimeException(entity, commParams);

        return entity;
    }

    /**
     * 转换Entity
     * @param entity 基本信息
     * @param vo 基本信息
     * @param commParams 公共参数
     * @return ${entityList[0].upperCaseHumpName}Entity
     */
    public static ${entityList[0].upperCaseHumpName}Entity package${entityList[0].upperCaseHumpName}EntityByModify(${entityList[0].upperCaseHumpName}Entity entity, ${entityList[0].upperCaseHumpName}Vo vo, CommParams commParams) {
        entity.setUpdator(commParams.getUpdator());
        entity.setUpdateTime(commParams.getUpdateTime());

        return entity;
    }

    /**
     * 转换Entity
     * @param entity 基本信息
     * @param commParams 公共参数
     * @return ${entityList[0].upperCaseHumpName}Entity
     */
    public static ${entityList[0].upperCaseHumpName}Entity package${entityList[0].upperCaseHumpName}EntityByDelete(${entityList[0].upperCaseHumpName}Entity entity, CommParams commParams) {

        entity.setDisabled(Boolean.TRUE);
        entity.setUpdator(commParams.getUpdator());
        entity.setUpdateTime(commParams.getUpdateTime());

        return entity;
    }

}
