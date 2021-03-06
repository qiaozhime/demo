<!DOCTYPE html>
<html>
<head>
    <#assign PAGE_TITLE = "修改积分规则"/>
    <#include "/manage/common/head-res.ftl"/>
</head>
<body class="hold-transition">
<div class="wrapper">
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <form method="post" action="${managePath}/system/scoreRule/update" class="jeesns_form" callback="parentReload">
                    <div class="box-body">
                        <input type="hidden" class="form-control" name="id" value="${scoreRule.id}">
                        <div class="form-group">
                            <label class="col-sm-1 control-label">名称</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" value="${scoreRule.name}" disabled>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label">描述</label>
                            <div class="col-sm-8">
                                <textarea class="form-control" rows="3" disabled>${scoreRule.remark}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label">变动积分</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="score" name="score" placeholder="变动积分" data-type="require" value="${scoreRule.score}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label">周期</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" value='<#if scoreRule.type=="day">一天一次<#elseif scoreRule.type=="week">一周一次<#elseif scoreRule.type=="month">一月一次<#elseif scoreRule.type=="year">一年一次<#elseif scoreRule.type=="one">一次<#elseif scoreRule.type=="unlimite">不限</#if>' disabled>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-1 col-sm-10">
                                <button type="submit" class="btn btn-info jeesns-submit">保存</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
</div>
</body>
</html>