<!DOCTYPE html>
<html>
<head>
    <#assign PAGE_TITLE = "群组管理"/>
    <#include "/manage/common/head-res.ftl"/>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
<#include "/manage/common/header.ftl"/>
    <div class="content-wrapper">
        <section class="content-header">
            <h1>群组管理(${list?size})</h1>
            <ol class="breadcrumb">
                <li><a href="${managePath}/index"><i class="fa fa-dashboard"></i> 主页</a></li>
                <li class="active">群组管理</li>
            </ol>
        </section>
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box box-primary">
                        <div class="box-header">
                            <h3 class="box-title">
                            </h3>
                            <div class="box-tools">
                                <form method="get" action="${managePath}/group/index">
                                    <div class="input-group input-group-sm" style="width: 350px;">
                                        <input type="text" name="key" class="form-control pull-right"
                                               placeholder="请输入关键词">
                                        <div class="input-group-btn">
                                            <button type="submit" class="btn btn-default"><i class="fa fa-search"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th width="50px">#</th>
                                    <th>群组名字</th>
                                    <th>创建人</th>
                                    <th>付费</th>
                                    <th>付费金额</th>
                                    <th>标签</th>
                                    <th>创建时间</th>
                                    <th>状态</th>
                                    <th width="50px">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#list list as group>
                                <tr>
                                    <td>${group.id}</td>
                                    <td><a href="${groupPath}/detail/${group.id}" target="_blank">${group.name}</a></td>
                                    <td>${group.creatorMember.name}</td>
                                    <td>${(group.followPay == 0)?string('免费','收费')}</td>
                                    <td>${group.payMoney}</td>
                                    <td>${group.tags}</td>
                                    <td>${group.createTime?string("yyyy-MM-dd HH:mm:ss")}</td>
                                    <td>
                                        <#if group.status==0>
                                            <a class="marg-l-5" target="_jeesnsLink" href="javascript:void(0)" data-href="${managePath}/group/changeStatus/${group.id}" callback="reload">
                                                <span class="label label-danger">未审核</span>
                                            </a>
                                        <#elseif group.status==1>
                                            <a class="marg-l-5" target="_jeesnsLink" href="javascript:void(0)" data-href="${managePath}/group/changeStatus/${group.id}" callback="reload">
                                                <span class="label label-success">已审核</span>
                                            </a>
                                        </#if>
                                    </td>
                                    <td>
                                        <a class="marg-l-5" target="_jeesnsLink"
                                           href="javascript:void(0)" data-href="${managePath}/group/delete/${group.id}" confirm="确定要删除群组吗？删除后群组文章都会被删除！" callback="reload">
                                            <span class="label label-danger"><i class="fa fa-trash red"></i></span>
                                        </a>
                                    </td>
                                </tr>
                                </#list>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
<#include "/manage/common/footer.ftl"/>
</div>
<script type="text/javascript">
    $(function () {
        $(".pagination").jeesns_page("jeesnsPageForm");
    });
</script>
</body>
</html>

