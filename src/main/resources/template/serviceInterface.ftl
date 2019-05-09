package ${packagePath}.service;

import ${packagePath}.model.CommParams;
import ${packagePath}.entity.${entityList[0].upperCaseHumpName}Entity;
import ${packagePath}.vo.${entityList[0].upperCaseHumpName}Vo;

import java.util.List;
import java.util.Map;


/**
 * ${entityList[0].tableName} service interface
 * ${entityList[0].tableRemark}
 * @author
 */
public interface I${entityList[0].upperCaseHumpName}Service {

    /**
    * 新增记录
    * @param vo 记录vo
    * @param commParams 共通字段
    * @return ${entityList[0].upperCaseHumpName}Entity 记录po
    */
    ${entityList[0].upperCaseHumpName}Entity insert(${entityList[0].upperCaseHumpName}Vo vo, CommParams commParams);

    /**
    * 更新记录
    * @param vo 记录vo
    * @param commParams 共通字段
    * @return ${entityList[0].upperCaseHumpName}Entity 记录po
    */
    ${entityList[0].upperCaseHumpName}Entity modify(${entityList[0].upperCaseHumpName}Vo vo, CommParams commParams);

    /**
    * 查询记录总数
    * @param vo 查询条件
    * @return Long 记录条数
    */
    Long count(${entityList[0].upperCaseHumpName}Vo vo);

    /**
    * 获取记录列表
    * @param vo 查询vo
    * @param start 偏移量
    * @param size 获取数据长度
    * @return List<${entityList[0].upperCaseHumpName}Entity> 列表
    */
    List<${entityList[0].upperCaseHumpName}Entity> list(${entityList[0].upperCaseHumpName}Vo vo, Integer start, Integer size);

    /**
    * 查询记录
    * @param id 记录编码
    * @return ${entityList[0].upperCaseHumpName}Entity 记录po
    */
    ${entityList[0].upperCaseHumpName}Entity get(Long id);

    /**
    * 删除记录
    * @param id 记录编码
    * @param commParams 共通字段
    * @return ${entityList[0].upperCaseHumpName}Entity 记录po
    */
    ${entityList[0].upperCaseHumpName}Entity delete(Long id, CommParams commParams);

}