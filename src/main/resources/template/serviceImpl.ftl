package ${packagePath}.service.impl;

import ${packagePath}.model.CommParams;
import ${packagePath}.service.I${entityList[0].upperCaseHumpName}Service;
import ${packagePath}.dao.${entityList[0].upperCaseHumpName}Mapper;
import ${packagePath}.service.converter.${entityList[0].upperCaseHumpName}ServiceConverter;
import ${packagePath}.util.code.ResCode;
import ${packagePath}.vo.${entityList[0].upperCaseHumpName}Vo;
import ${packagePath}.entity.${entityList[0].upperCaseHumpName}Entity;
import org.springframework.stereotype.Service;
import ${packagePath}.exception.ServiceException;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;

/**
 * ${entityList[0].tableName} service implements
 * ${entityList[0].tableRemark}
 * @author
 */
@Service("${entityList[0].humpName}Service")
@Transactional(readOnly = false, rollbackFor = Exception.class)
public class ${entityList[0].upperCaseHumpName}ServiceImpl implements I${entityList[0].upperCaseHumpName}Service {

    @Resource(name = "${entityList[0].humpName}Mapper")
    private ${entityList[0].upperCaseHumpName}Mapper ${entityList[0].humpName}Mapper;

    @Override
    public ${entityList[0].upperCaseHumpName}Entity insert(${entityList[0].upperCaseHumpName}Vo vo, CommParams commParams) {
        // 参数校验

        ${entityList[0].upperCaseHumpName}Entity entity = ${entityList[0].upperCaseHumpName}ServiceConverter.toEntity(vo, commParams);
        entity.setDisabled(false);
        ${entityList[0].humpName}Mapper.insert(entity);

        return entity;
    }

    @Override
    public ${entityList[0].upperCaseHumpName}Entity modify(${entityList[0].upperCaseHumpName}Vo vo, CommParams commParams) {
        ${entityList[0].upperCaseHumpName}Entity oldEntity = this.get(vo.getId());
        if (Objects.isNull(oldEntity)) {
            throw new ServiceException(ResCode.ERR_NOEXIST.getCode(), String.format("参数：%s 共通参数：%s 错误信息：%s",
                    vo, commParams, ResCode.ERR_NOEXIST.getDesc()));
        }
        // 参数校验

        // 构建新的entity
        ${entityList[0].upperCaseHumpName}Entity entity = ${entityList[0].upperCaseHumpName}ServiceConverter.package${entityList[0].upperCaseHumpName}EntityByModify(oldEntity, vo, commParams);
        ${entityList[0].humpName}Mapper.update(entity);

        return entity;
    }

    @Override
    public Long count(${entityList[0].upperCaseHumpName}Vo vo) {
        Map<String, Object> map = new HashMap<>();

        return ${entityList[0].humpName}Mapper.selectCount(map);
    }

    @Override
    public List<${entityList[0].upperCaseHumpName}Entity> list(${entityList[0].upperCaseHumpName}Vo vo, Integer start, Integer size) {

        Map<String, Object> map = new HashMap<>();
        map.put("start", start);
        map.put("size", size);

        return ${entityList[0].humpName}Mapper.selectList(map);
    }

    @Override
    public ${entityList[0].upperCaseHumpName}Entity get(Long id) {
        ${entityList[0].upperCaseHumpName}Entity entity = ${entityList[0].humpName}Mapper.select(id);
        if (entity == null) {
            return null;
        }
        return entity;
    }

    @Override
    public ${entityList[0].upperCaseHumpName}Entity delete(Long id, CommParams commParams) {
        ${entityList[0].upperCaseHumpName}Entity oldEntity = this.get(id);
        if (Objects.isNull(oldEntity)) {
            throw new ServiceException(ResCode.ERR_NOEXIST.getCode(), String.format("参数：%s 共通参数：%s 错误信息：%s",
                    id, commParams, ResCode.ERR_NOEXIST.getDesc()));
        }

        ${entityList[0].upperCaseHumpName}Entity entity = ${entityList[0].upperCaseHumpName}ServiceConverter.package${entityList[0].upperCaseHumpName}EntityByDelete(oldEntity, commParams);
        entity.setId(id);
        ${entityList[0].humpName}Mapper.delete(entity);

        return entity;
    }
}