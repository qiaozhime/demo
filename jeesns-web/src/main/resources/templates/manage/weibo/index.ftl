<!DOCTYPE html>
<html>
<head>
    <#assign PAGE_TITLE = "微博管理"/>
    <#include "/manage/common/head-res.ftl"/>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
<#include "/manage/common/header.ftl"/>
    <div class="content-wrapper">
        <section class="content-header">
            <h1>微博管理(${model.page.totalCount})</h1>
            <ol class="breadcrumb">
                <li><a href="${managePath}/index"><i class="fa fa-dashboard"></i> 主页</a></li>
                <li class="active">微博管理</li>
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
                                <form method="get" action="${managePath}/weibo/index">
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
                                    <th width="120px">会员</th>
                                    <th>内容</th>
                                    <th width="50px">点赞数</th>
                                    <th width="100px">发布时间</th>
                                    <th width="80px">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#list model.data as weibo>
                                <tr>
                                    <td>${weibo.id}</td>
                                    <td>${weibo.member.name}</td>
                                    <td style="word-break: break-all">${weibo.content}</td>
                                    <td>${weibo.favor}</td>
                                    <td>${weibo.createTime?string("yyyy-MM-dd HH:mm:ss")}</td>
                                    <td>
                                        <a href="${weiboPath}/detail/${weibo.id}" target="_blank">
                                            <span class="label label-info">详情</span>
                                        </a>
                                        <a class="marg-l-5" target="_jeesnsLink"
                                           href="javascript:void(0)" data-href="${managePath}/weibo/delete/${weibo.id}" confirm="确定要删除微博吗？" callback="reload">
                                            <span class="label label-danger"><i class="fa fa-trash red"></i></span>
                                        </a>
                                    </td>
                                </tr>
                                </#list>
                                </tbody>
                            </table>
                        </div>
                        <div class="box-footer clearfix">
                            <ul class="pagination pagination-sm no-margin pull-right"
                                url="${managePath}/weibo/index?key=${key?default('')}"
                                currentPage="${model.page.pageNo}"
                                pageCount="${model.page.totalPage}">
                            </ul>
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


