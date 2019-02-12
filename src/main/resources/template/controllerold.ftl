package ${packagePath}.controller;

import com.rltx.common.base.BaseContext;
import com.rltx.common.vo.CommParamsVo;
import ${packagePath}.controller.converter.*;
import ${packagePath}.service.*;
import com.wl.framework.page.taglibs.Page;
import com.wl.framework.result.ListResult;
import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;
import com.rltx.framework.log.support.BusinessException;

import javax.annotation.Resource;
import java.util.*;
import ${packagePath}.vo.${entityList[0].upperCaseHumpName}Vo;
import ${packagePath}.po.${entityList[0].upperCaseHumpName}Entity;
import ${packagePath}.result.${entityList[0].upperCaseHumpName}Result;

/**
 * ${entityList[0].tableRemark}
 * @author
 */
@Api(value = "${entityList[0].upperCaseHumpName}", description = "${entityList[0].tableRemark}服务")
@RestController
public class ${entityList[0].upperCaseHumpName}Controller extends BaseContext {

    @Resource(name = "${entityList[0].humpName}Service")
    private I${entityList[0].upperCaseHumpName}Service ${entityList[0].humpName}Service;

    @ApiOperation(value = "${entityList[0].tableRemark}列表")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "params", value = "查询条件", required = false, dataType = "String", paramType = "body"),
        @ApiImplicitParam(name = "mark", value = "上一次检索的结果中的mark值", required = false, dataType = "Long", paramType = "query"),
        @ApiImplicitParam(name = "page", value = "页码", required = false, dataType = "Integer", paramType = "query"),
        @ApiImplicitParam(name = "size", value = "页长", required = false, dataType = "Integer", paramType = "query")
    })
    @GetMapping(value = "/${entityList[0].databaseName}/${entityList[0].tableName}/list")
    public ListResult<${entityList[0].upperCaseHumpName}Result> list(@RequestParam(name = "mark", required = false) Long mark,
                                                                                @RequestParam(required = false) Map<String, Object> params,
                                                                                @RequestParam(name = "page", defaultValue = "1", required = false) Integer page,
                                                                                @RequestParam(name = "size", required = false) Integer size) {
        params.remove("mark");
        params.remove("page");
        params.remove("size");
        params.put("ownerOrgCode", super.getCurrentOrgCode());

        Page p = new Page(page, size);
        // 检索
        List<${entityList[0].upperCaseHumpName}Entity> entityList = ${entityList[0].humpName}Service.getList(params, mark, p.getStartRecord(), p.getPageSize());

        // 封装结果
        List<${entityList[0].upperCaseHumpName}Result> resultList = new ArrayList<>(entityList.size());
        for (${entityList[0].upperCaseHumpName}Entity entity : entityList) {
            ${entityList[0].upperCaseHumpName}Result result = ${entityList[0].upperCaseHumpName}ControllerConverter.toResult(entity);
            resultList.add(result);
        }

        Long count = ${entityList[0].humpName}Service.getCount(params);
        ListResult<${entityList[0].upperCaseHumpName}Result> result = new ListResult<>();
        result.setTotal(count);
        result.setList(resultList);
        return result;
    }

    @ApiOperation(value = "查询${entityList[0].tableRemark}")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "code", value = "记录编码", required = true, dataType = "String", paramType = "path")
    })
    @GetMapping(value = "/${entityList[0].databaseName}/${entityList[0].tableName}/{code}/get")
    public ${entityList[0].upperCaseHumpName}Result get(@PathVariable("code") String code){
        CommParamsVo commParamsVo = super.getCommParamsVo();

        // 查询实体
        ${entityList[0].upperCaseHumpName}Entity entity = ${entityList[0].humpName}Service.getEntity(code, commParamsVo.getOwnerOrgCode());
        if (entity == null) {
            throw new BusinessException("记录不存在");
        }

        // 转换entity对象为result对象
        ${entityList[0].upperCaseHumpName}Result result = ${entityList[0].upperCaseHumpName}ControllerConverter.toResult(entity);
        return result;
    }

    @ApiOperation(value = "删除${entityList[0].tableRemark}")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "code", value = "记录编码", required = true, dataType = "String", paramType = "path")
    })
    @PostMapping(value = "/${entityList[0].databaseName}/${entityList[0].tableName}/{code}/delete")
    public ${entityList[0].upperCaseHumpName}Result delete(@PathVariable("code") String code){
        CommParamsVo commParamsVo = super.getCommParamsVo();

        // 查询实体
        ${entityList[0].upperCaseHumpName}Entity entity = ${entityList[0].humpName}Service.getEntity(code, commParamsVo.getOwnerOrgCode());
        if (entity == null) {
            throw new BusinessException("记录不存在");
        }
        // 删除记录
        ${entityList[0].humpName}Service.updateDelete(code, commParamsVo);

        // 转换entity对象为result对象
        ${entityList[0].upperCaseHumpName}Result result = ${entityList[0].upperCaseHumpName}ControllerConverter.toResult(entity);
        return result;
    }

    @ApiOperation(value = "新增${entityList[0].tableRemark}")
    @ApiImplicitParams({
    <#list entityList as entity>
    <#if entity_index gt 1 && entity_index lt (entityList?size - 17)>
        @ApiImplicitParam(name = "${entity.lowerFieldName}", value = "${entity.remark}", required = false, dataType = "${entity.fieldType}", paramType = "form"),
    </#if>
    </#list>
    })
    @PostMapping(value = "/${entityList[0].databaseName}/${entityList[0].tableName}/add", consumes = {"application/x-www-form-urlencoded"})
        public ${entityList[0].upperCaseHumpName}Result add(@ApiParam(hidden = true) ${entityList[0].upperCaseHumpName}Result ${entityList[0].humpName}Result){
        // 转换result对象为vo对象
        ${entityList[0].upperCaseHumpName}Vo vo = ${entityList[0].upperCaseHumpName}ControllerConverter.toVo(${entityList[0].humpName}Result);

        // 新增记录
        CommParamsVo commParamsVo = super.getCommParamsVo();
        ${entityList[0].upperCaseHumpName}Entity entity = ${entityList[0].humpName}Service.add(vo, commParamsVo);

        // 转换entity对象为result对象
        ${entityList[0].upperCaseHumpName}Result result = ${entityList[0].upperCaseHumpName}ControllerConverter.toResult(entity);
        return result;
    }

    @ApiOperation(value = "修改${entityList[0].tableRemark}")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "code", value = "记录编码", required = true, dataType = "String", paramType = "path"),
    <#list entityList as entity>
    <#if entity_index gt 1 && entity_index lt (entityList?size - 17)>
        @ApiImplicitParam(name = "${entity.lowerFieldName}", value = "${entity.remark}", required = false, dataType = "${entity.fieldType}", paramType = "form"),
    </#if>
    </#list>
    })
    @PostMapping(value = "/${entityList[0].databaseName}/${entityList[0].tableName}/{code}/edit", consumes = {"application/x-www-form-urlencoded"})
        public ${entityList[0].upperCaseHumpName}Result edit(@PathVariable(value = "code") String code, @ApiParam(hidden = true) ${entityList[0].upperCaseHumpName}Result ${entityList[0].humpName}Result){

        CommParamsVo commParamsVo = super.getCommParamsVo();
        // 查询实体
        ${entityList[0].upperCaseHumpName}Entity entity = ${entityList[0].humpName}Service.getEntity(code, commParamsVo.getOwnerOrgCode());
        if (entity == null) {
            throw new BusinessException("记录不存在");
        }

                // 转换result对象为vo对象
        ${entityList[0].upperCaseHumpName}Vo vo = ${entityList[0].upperCaseHumpName}ControllerConverter.toVo(${entityList[0].humpName}Result);
        vo.setCode(code);

        // 更新记录
        entity = ${entityList[0].humpName}Service.update(vo, commParamsVo);

        // 转换entity对象为result对象
        ${entityList[0].upperCaseHumpName}Result result = ${entityList[0].upperCaseHumpName}ControllerConverter.toResult(entity);
        return result;
    }

}
