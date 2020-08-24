<!DOCTYPE html>
<html>
<head>
    <#assign PAGE_TITLE = "会员加/扣款"/>
    <#include "/manage/common/head-res.ftl"/>
</head>
<body class="hold-transition">
<div class="wrapper">
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <form class="form-horizontal jeesns_form" role="form" action="${managePath}/member/increaseMoney/${member.id}" method="post" callback="parentReload">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">会员用户名</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="name" name="name" data-type="require" value="${member.name}" disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">会员余额</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" data-type="require" value="${member.money}" disabled>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">加/扣款金额</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="money" name="money" data-type="require,double">
                            加款输入正数，扣款输入负数
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