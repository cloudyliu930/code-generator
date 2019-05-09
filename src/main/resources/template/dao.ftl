package ${packagePath}.dao;

import ${packagePath}.entity.${entityList[0].upperCaseHumpName}Entity;
import org.springframework.stereotype.Repository;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * ${entityList[0].tableName} 表
 * ${entityList[0].tableRemark}
 * @author
 */
@Repository("${entityList[0].humpName}Mapper")
public interface ${entityList[0].upperCaseHumpName}Mapper {

    /**
     * 根据查询条件获取Entity
     * @param id => 记录编码
     * @return ${entityList[0].upperCaseHumpName}Entity  POJO类
     */
    ${entityList[0].upperCaseHumpName}Entity select(@Param("id") Long id);

    /**
     * 根据条件获取Entity List
     * @param params 查询条件
     * @return List<${entityList[0].upperCaseHumpName}Entity>  POJO类 集合
     */
    List<${entityList[0].upperCaseHumpName}Entity> selectList(@Param("params") Map<String, Object> params);

    /**
     * 根据条件获取Entity Count
     * @param params 查询条件
     * @return Long 记录数
     */
    Long selectCount(@Param("params") Map<String, Object> params);

    /**
     * 插入
     * @param entity  POJO类
     */
    void insert(@Param("entity") ${entityList[0].upperCaseHumpName}Entity entity);

    /**
     * 更新
     * @param entity  POJO类
     */
    void update(@Param("entity") ${entityList[0].upperCaseHumpName}Entity entity);

    /**
     * 删除
     * @param entity  POJO类
     */
    void delete(@Param("entity") ${entityList[0].upperCaseHumpName}Entity entity);

}