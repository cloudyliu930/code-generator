package ${packagePath}.controller.converter;

import ${packagePath}.vo.${entityList[0].upperCaseHumpName}Vo;
import ${packagePath}.result.${entityList[0].upperCaseHumpName}Result;
import ${packagePath}.po.${entityList[0].upperCaseHumpName}Entity;
import com.rltx.framework.util.BeanHelper;

/**
 * ${entityList[0].tableName} controller转换类
 * @author
 */
public class ${entityList[0].upperCaseHumpName}ControllerConverter {

    /**
    * 转换vo
    * @param result ${entityList[0].upperCaseHumpName}Result
    * @return ${entityList[0].upperCaseHumpName}Vo
    */
    public static ${entityList[0].upperCaseHumpName}Vo toVo(${entityList[0].upperCaseHumpName}Result result) {
        ${entityList[0].upperCaseHumpName}Vo vo = new ${entityList[0].upperCaseHumpName}Vo();
        BeanHelper.copyWithRuntimeException(vo, result);
        return vo;
    }

    /**
    * 转换result
    * @param entity ${entityList[0].upperCaseHumpName}Entity
    * @return ${entityList[0].upperCaseHumpName}Result
    */
    public static ${entityList[0].upperCaseHumpName}Result toResult(${entityList[0].upperCaseHumpName}Entity entity) {
        ${entityList[0].upperCaseHumpName}Result result = new ${entityList[0].upperCaseHumpName}Result();
        BeanHelper.copyWithRuntimeException(result, entity);
        return result;
    }

}
