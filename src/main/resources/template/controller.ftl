package ${packagePath}.controller;

import ${packagePath}.controller.converter.*;
import ${packagePath}.service.*;
import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;
import ${packagePath}.model.Limit;
import ${packagePath}.model.Page;
import ${packagePath}.model.request.PayRequest;
import ${packagePath}.model.response.PayResponse;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.groups.Default;
import java.math.BigDecimal;

import javax.annotation.Resource;
import java.util.*;
import ${packagePath}.vo.${entityList[0].upperCaseHumpName}Vo;
import ${packagePath}.entity.${entityList[0].upperCaseHumpName}Entity;
import ${packagePath}.result.${entityList[0].upperCaseHumpName}Result;
import ${packagePath}.result.${entityList[0].upperCaseHumpName}Result;
import ${packagePath}.controller.base.BaseController;

/**
 * ${entityList[0].tableRemark}
 * @author
 */
@Api(value = "${entityList[0].upperCaseHumpName}", description = "${entityList[0].tableRemark}服务")
@RestController
@RequestMapping(value = "/${entityList[0].humpName}")
public class ${entityList[0].upperCaseHumpName}Controller extends BaseController {

    @Resource(name = "${entityList[0].humpName}Service")
    private I${entityList[0].upperCaseHumpName}Service ${entityList[0].humpName}Service;

    @ApiOperation(value = "${entityList[0].tableRemark}列表")
    @RequestMapping(value = "/list", method = RequestMethod.POST, consumes = "application/json")
    public PayResponse<Page<${entityList[0].upperCaseHumpName}Result>> list(@Validated({ PayRequest.Page.class, Default.class }) @RequestBody PayRequest<${entityList[0].upperCaseHumpName}Vo> params) {
        // 构建分页对象
        Limit limit = new Limit(params.getPage(), params.getSize());
        // 统计${entityList[0].tableRemark}数据条数
        Long count = ${entityList[0].humpName}Service.count(params.getParams());
        // 查询${entityList[0].tableRemark}数据列表
        List<${entityList[0].upperCaseHumpName}Result> ${entityList[0].humpName}ResultList = new ArrayList<${entityList[0].upperCaseHumpName}Result>();
        if (BigDecimal.ZERO.intValue() != count) {
            List<${entityList[0].upperCaseHumpName}Entity> list = ${entityList[0].humpName}Service.list(params.getParams(), limit.getStartRecord(), limit.getPageSize());
            list.forEach((${entityList[0].humpName} -> {
                ${entityList[0].upperCaseHumpName}Result ${entityList[0].humpName}Result = ${entityList[0].upperCaseHumpName}ControllerConverter.toResult(${entityList[0].humpName});
                ${entityList[0].humpName}ResultList.add(${entityList[0].humpName}Result);
            }));
        }

        // 封装返回对象
        Page<${entityList[0].upperCaseHumpName}Result> page = new Page<${entityList[0].upperCaseHumpName}Result>(${entityList[0].humpName}ResultList, count.intValue(), params.getSize(), params.getPage());
        PayResponse<Page<${entityList[0].upperCaseHumpName}Result>> response = new PayResponse<Page<${entityList[0].upperCaseHumpName}Result>>();
        response.setResult(page);
        response.setIsSuccess(Boolean.TRUE);
        return response;
    }

    @ApiOperation(value = "获取${entityList[0].tableRemark}")
    @RequestMapping(value = "/get", method = RequestMethod.POST, consumes = "application/json")
    public PayResponse<${entityList[0].upperCaseHumpName}Result> get(@Validated({ Default.class }) @RequestBody PayRequest<${entityList[0].upperCaseHumpName}Vo> params) {
        // 获取${entityList[0].tableRemark}
        ${entityList[0].upperCaseHumpName}Entity entity = ${entityList[0].humpName}Service.get(params.getParams().getCode());
        if (Objects.isNull(entity)) {
            return toResult(Boolean.TRUE);
        }

        ${entityList[0].upperCaseHumpName}Result ${entityList[0].humpName}Result = ${entityList[0].upperCaseHumpName}ControllerConverter.toResult(entity);

        PayResponse<${entityList[0].upperCaseHumpName}Result> response = new PayResponse<${entityList[0].upperCaseHumpName}Result>();
        response.setResult(${entityList[0].humpName}Result);
        response.setIsSuccess(Boolean.TRUE);
        return response;
    }

    @ApiOperation(value = "新建${entityList[0].tableRemark}信息")
    @RequestMapping(value = "/add", method = RequestMethod.POST, consumes = "application/json")
    public PayResponse<${entityList[0].upperCaseHumpName}Result> add(@Validated({ Default.class, ${entityList[0].upperCaseHumpName}Vo.Create.class, ${entityList[0].upperCaseHumpName}Vo.Update.class }) @RequestBody PayRequest<${entityList[0].upperCaseHumpName}Vo> params) {
        // 新建${entityList[0].tableRemark}
        ${entityList[0].upperCaseHumpName}Entity entity = ${entityList[0].humpName}Service.insert(params.getParams(), super.getCommParams());
        ${entityList[0].upperCaseHumpName}Result viewModel = ${entityList[0].upperCaseHumpName}ControllerConverter.toResult(entity);

        PayResponse<${entityList[0].upperCaseHumpName}Result> response = new PayResponse<${entityList[0].upperCaseHumpName}Result>();
        response.setResult(viewModel);
        response.setIsSuccess(Boolean.TRUE);
        return response;
    }

    @ApiOperation(value = "编辑${entityList[0].tableRemark}信息")
    @RequestMapping(value = "/modify", method = RequestMethod.POST, consumes = "application/json")
    public PayResponse<${entityList[0].upperCaseHumpName}Result> modify(@Validated({ Default.class, ${entityList[0].upperCaseHumpName}Vo.Create.class, ${entityList[0].upperCaseHumpName}Vo.Update.class }) @RequestBody PayRequest<${entityList[0].upperCaseHumpName}Vo> params) {
        // 编辑${entityList[0].tableRemark}
        ${entityList[0].upperCaseHumpName}Entity entity = ${entityList[0].humpName}Service.modify(params.getParams(), super.getCommParams());
        ${entityList[0].upperCaseHumpName}Result viewModel = ${entityList[0].upperCaseHumpName}ControllerConverter.toResult(entity);

        PayResponse<${entityList[0].upperCaseHumpName}Result> response = new PayResponse<${entityList[0].upperCaseHumpName}Result>();
        response.setResult(viewModel);
        response.setIsSuccess(Boolean.TRUE);
        return response;
    }

    @ApiOperation(value = "删除${entityList[0].tableRemark}信息")
    @RequestMapping(value = "/delete", method = RequestMethod.POST, consumes = "application/json")
    public PayResponse<${entityList[0].upperCaseHumpName}Result> delete(@Validated({ Default.class, ${entityList[0].upperCaseHumpName}Vo.Delete.class}) @RequestBody PayRequest<${entityList[0].upperCaseHumpName}Vo> params) {
        // 删除${entityList[0].tableRemark}
        ${entityList[0].upperCaseHumpName}Entity entity = ${entityList[0].humpName}Service.delete(params.getParams().getCode(), super.getCommParams());
        ${entityList[0].upperCaseHumpName}Result viewModel = ${entityList[0].upperCaseHumpName}ControllerConverter.toResult(entity);

        PayResponse<${entityList[0].upperCaseHumpName}Result> response = new PayResponse<${entityList[0].upperCaseHumpName}Result>();
        response.setResult(viewModel);
        response.setIsSuccess(Boolean.TRUE);
        return response;
    }

    private PayResponse toResult(Boolean success) {
        PayResponse response = new PayResponse();
        response.setIsSuccess(success);
        return response;
    }

}
