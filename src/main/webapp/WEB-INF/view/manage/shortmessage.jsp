<%--
  Created by IntelliJ IDEA.
  User: chenny
  Date: 2017/9/29
  Time: 22:00
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String prefix = request.getContextPath();
    request.setAttribute("prefix", prefix);
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>个人中心</title>
    <link href="${prefix}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${prefix}/css/nav.css" rel="stylesheet">
    <link href="${prefix}/css/layout.css" rel="stylesheet">
    <link href="${prefix}/css/font-awesome.min.css" rel="stylesheet">
    <link href="${prefix}/css/icheck/red.css" rel="stylesheet">

    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<jsp:include page="/rest/header"></jsp:include>

<div class="container">
    <div id="topic" class="row">
        <div style="padding-left: 60px;width: 100%;">
            <h3>个人中心</h3>
            <a href="#">返回首页</a>
        </div>
    </div>
    <div class="row">
        <div id="nav" class="col-md-2">
            <ul>
                <li>
                    <a href="notice.jsp"><i class="fa fa-user-o nav_icon"></i>我的资料</a>
                </li>
                <li>
                    <a href="banner.jsp"><i class="fa fa-file-o nav_icon"></i>班级信息</a>
                </li>
                <li class="nav_active">
                    <a href="shortmessage.jsp"><i class="fa fa-send-o nav_icon"></i>短信通知</a>
                </li>
                <li>
                    <a href="share.jsp"><i class="fa fa-bookmark-o nav_icon"></i>我的分享</a>
                </li>
                <li>
                    <a href="reply.jsp"><i class="fa fa-commenting-o nav_icon"></i>我的留言</a>
                </li>
                <li>
                    <a href="${prefix}/rest/user/updatePwd"><i class="fa fa-file-o nav_icon"></i>修改密码</a>
                </li>
            </ul>
        </div>
        <div id="contentPanel" class="pull-left" style=" margin-left: 30px;width: 910px">

            <h4 style="background-color: #f5f5f5; height: 35px; line-height: 35px;margin: 0px; padding-left: 10px; color:  #555555; font-size: 16px;margin-bottom: 20px;">
                <i class="fa fa-commenting-o" style="padding: 0 10px;color: #ff8f2b"></i>短信通知</h4>
            <div class="main">
                <form style="width: 900px;overflow: hidden">
                    <div id="leftReceiverOperationDiv" style="float: left">
                        <label for="all"><input id="all"  type="checkbox">全选</label>
                        <ul id="receiverSelectList">
                            <li>
                                <label for="receiver1">陈思聪<input id="receiver1" name="receiver" type="checkbox"></label>
                            </li>
                            <li>
                                <label for="receiver2">陈思聪<input id="receiver2" name="receiver" type="checkbox"></label>
                            </li>
                            <li>
                                <label for="receiver3">陈思聪<input id="receiver3" name="receiver" type="checkbox"></label>
                            </li>
                            <li>
                                <label for="receiver4">陈思聪<input id="receiver4" name="receiver" type="checkbox"></label>
                            </li>
                            <li>
                                <label for="receiver5">陈思聪<input id="receiver5" name="receiver" type="checkbox"></label>
                            </li>
                            <li>
                                <label for="receiver6">陈思聪<input id="receiver6" name="receiver" type="checkbox"></label>
                            </li>
                            <li>
                                <label for="receiver7">陈思聪<input id="receiver7" name="receiver" type="checkbox"></label>
                            </li>
                            <li>
                                <label for="receiver8">陈思聪<input id="receiver8" name="receiver" type="checkbox"></label>
                            </li>
                            <li>
                                <label for="receiver9">陈思聪<input id="receiver9" name="receiver" type="checkbox"></label>
                            </li>
                            <li>
                                <label for="receiver10">陈思聪<input id="receiver10" name="receiver" type="checkbox"></label>
                            </li>
                            <li>
                                <label for="receiver11">陈思聪<input id="receiver11" name="receiver" type="checkbox"></label>
                            </li>
                            <li>
                                <label for="receiver12">陈思聪<input id="receiver12" name="receiver" type="checkbox"></label>
                            </li>
                            <li>
                                <label for="receiver13">陈思聪<input id="receiver13" name="receiver" type="checkbox"></label>
                            </li>
                            <li>
                                <label for="receiver14">陈思聪<input id="receiver14" name="receiver" type="checkbox"></label>
                            </li>
                            <li>
                                <label for="receiver15">陈思聪<input id="receiver15" name="receiver" type="checkbox"></label>
                        </ul>
                    </div>
                    <div class="pull-right" style="width: 700px;margin-top: 50px">
                        <div class="form-group" >
                            <label  class="col-md-4 control-label" style="margin-right: 15px;">上传Excel数据文件(非必填项)</label>
                            <label class="radio-inline" >
                                <input type="file"  name="excelFile" accept="application/vnd.ms-excel" >
                            </label>

                        </div>
                        <div class="form-group" >
                            <label  class=" col-md-2 control-label" style="margin-right: 15px;">选择消息模板</label>
                            <label class="radio-inline" data-toggle="tooltip" data-placement="top" title="Tooltip on top消息模板消息模板消息模板消息模板">
                                <input type="radio"  name="template"  value="模板1" > 模板1
                            </label>
                            <label class="radio-inline" data-toggle="tooltip" data-placement="top" title="Tooltip on top消息模板消息模板消息模板消息模板消息模板">
                                <input type="radio"  name="template"  value="模板2"> 模板2
                            </label>
                        </div>
                        <textarea class="form-control" rows="9" placeholder="请填写消息,可以使用\${}符号来添加占位符"></textarea>
                        <div class="pull-right" style="margin-top: 40px;">
                            <button type="button" class="btn btn-warning " style="margin-right:20px;display: inline-block">查看历史消息</button>
                            <button type="button" class="btn btn-success " style="display: inline-block">发送消息</button>
                        </div>
                    </div>
                </form>

            </div>

        </div>
    </div>
</div>

<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="${prefix}/js/bootstrap.min.js"></script>
<script src="${prefix}/js/icheck.min.js"></script>
<script src="${prefix}/js/shortMessage.js"></script>

<script>
    $(document).ready(function(){
        $('input').iCheck({
            checkboxClass: 'icheckbox_flat-red',
            radioClass: 'iradio_flat-red'
        });
    });
</script>
</body>
</html>