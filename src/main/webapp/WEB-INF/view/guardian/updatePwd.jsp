<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                    <a href="${prefix}/rest/guardian/info"><i class="fa fa-user-o nav_icon"></i>我的资料</a>
                </li>
                <li>
                    <a href="${prefix}/rest/guardian/collect"><i class="fa fa-star-o nav_icon"></i>我的收藏</a>
                </li>
                <li>
                    <a href="${prefix}/rest/guardian/share"><i class="fa fa-bookmark-o nav_icon"></i>我的分享</a>
                </li>
                <li >
                    <a href="${prefix}/rest/guardian/reply"><i class="fa fa-commenting-o nav_icon"></i>我的留言</a>
                </li>
                <li  >
                    <a href="${prefix}/rest/guardian/message"><i class="fa fa-envelope-o nav_icon"></i>我的消息</a>
                </li>
                <li class="nav_active">
                    <a href="${prefix}/rest/user/updatePwd"><i class="fa fa-file-o nav_icon"></i>修改密码</a>
                </li>
            </ul>
        </div>
        <div id="contentPanel" class="pull-left" style=" margin-left: 30px;width: 910px">
            <h4 style="background-color: #f5f5f5; height: 35px; line-height: 35px;margin: 0px; padding-left: 10px; color:  #555555; font-size: 16px;margin-bottom: 20px;">
                <i class="fa fa-commenting-o" style="padding: 0 10px;color: #ff8f2b"></i>修改密码</h4>
            <div class="main">
                <form class="form-horizontal" method="post" action="${prefix}/rest/user/updatePwd" >
                    <div class="form-group">
                        <label for="oldPwd" class="col-sm-2 control-label">原密码</label>
                        <div class="col-sm-4">
                            <input type="password" class="form-control" name="oldPwd" id="oldPwd" placeholder="请输入原密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="newPwd" class="col-sm-2 control-label">新密码</label>
                        <div class="col-sm-4">
                            <input type="password" class="form-control" name="newPwd" id="newPwd" placeholder="请输入新密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-7">
                            <button type="submit" class="btn btn-success">更改密码</button>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="${prefix}/js/bootstrap.min.js"></script>
<script>
    function showModal(obj) {
        $('#commentModal .modal-body').text(obj.innerText);
        $('#commentModal').modal('show');
    }
    <c:if test="${msg ne null}">
     alert('${msg}');
    </c:if>
</script>

</body>
</html>