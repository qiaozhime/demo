<!DOCTYPE html>
<html>
<head>
    <#assign PAGE_TITLE = "发布文章"/>
    <#include "/manage/common/head-res.ftl"/>
    <script src="${basePath}/res/plugins/ckeditor/ckeditor.js"></script>
    <script type="text/javascript">
        $(function () {
            CKEDITOR.replace('content');
        });
        var basePath = "${basePath}";
        var uploadServer = "${managePath}/uploadImage";
    </script>
    <script src="${basePath}/res/plugins/webuploader/upload.js"></script>
</head>
<body class="hold-transition">
<div class="wrapper">
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <form class="form-horizontal jeesns_form" role="form" action="${managePath}/cms/article/save" method="post" onsubmit="ckUpdate();" callback="parentReload">
                    <div class="form-group">
                        <label class="col-sm-1 control-label">栏目</label>
                        <div class="col-sm-3">
                            <select class="form-control" name="cateId" data-type="selected" alt="栏目">
                                <option value="" selected>=请选择栏目=</option>
                            <#list cateList as mainMenu>
                                <option value="${mainMenu.id}">${mainMenu.name}</option>
                            </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">标题</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="title" name="title" placeholder="标题" data-type="require">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">缩略图</label>
                        <div class="col-sm-10">
                            <div id="uploader" class="wu-example">
                                <!--用来存放文件信息-->
                                <input type="hidden" id="thumbnail" name="thumbnail">
                                <div id="preview" class="uploader-list"></div>
                                <div id="imagesList" class="uploader-list"></div>
                                <div class="btns">
                                    <div id="picker">选择文件</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">描述</label>
                        <div class="col-sm-8">
                            <textarea class="form-control" rows="3" name="description" alt="描述"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">内容</label>
                        <div class="col-sm-10">
                            <textarea class="ckeditor" cols="80" id="content" name="content" rows="10"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-1 control-label">来源</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="source" name="source">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">作者</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="writer" name="writer">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">浏览数</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="viewCount" name="viewCount" placeholder="浏览数" value="0" data-type="integer">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-1 col-sm-10">
                            <button type="submit" class="btn btn-info jeesns-submit">保存</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
</div>
</body>
</html>