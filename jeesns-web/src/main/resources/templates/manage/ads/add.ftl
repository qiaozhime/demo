<!DOCTYPE html>
<html>
<head>
    <#assign PAGE_TITLE = "添加广告"/>
    <#include "/manage/common/head-res.ftl"/>
</head>
<body class="hold-transition">
<div class="wrapper">
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <form class="form-horizontal jeesns_form" role="form" action="${managePath}/ads/save" method="post" callback="parentReload">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="name" name="name" data-type="require">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">类型</label>
                        <div class="col-sm-8">
                            <label onclick="typeClick(this)" type="1"><input type="radio" value="1" name="type" class="flat-red" checked>图片链接</label>
                            <label onclick="typeClick(this)" type="2"><input type="radio" value="2" name="type" class="flat-red">文字链接</label>
                            <label onclick="typeClick(this)" type="3"><input type="radio" value="3" name="type" class="flat-red">代码广告</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" id="contentName">图片地址</label>
                        <div class="col-sm-8">
                            <textarea rows="3" class="form-control" id="content" name="content" data-type="require"></textarea>
                        </div>
                    </div>
                    <div class="form-group" id="linkDiv">
                        <label class="col-sm-2 control-label">链接</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="link" name="link" data-type="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">开始时间</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" readonly id="startTime" name="startDateTime" data-type="require" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="background-color: #fff;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">结束时间</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" readonly id="endTime" name="endDateTime" data-type="require" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="background-color: #fff;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">状态</label>
                        <div class="col-sm-8">
                            <select class="form-control" name="status" data-type="selected">
                                <option value="0">禁用</option>
                                <option value="1" selected>启用</option>
                            </select>
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
<script>
    $(document).ready(function () {
        $('input[type="radio"].flat-red').iCheck({
            radioClass: 'iradio_flat-green'
        });

    })
    function typeClick(_this) {
        var type = $(_this).attr("type");
        if (type == 1){
            $("#contentName").html("图片地址");
            $("#linkDiv").css("display","block");
        }else if (type == 2){
            $("#contentName").html("文字");
            $("#linkDiv").css("display","block");
        }else if (type == 3){
            $("#contentName").html("代码");
            $("#linkDiv").css("display","none");
        }
    }
</script>
</body>
</html>