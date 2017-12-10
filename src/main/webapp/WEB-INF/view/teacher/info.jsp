<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: chenny
  Date: 2017/9/29
  Time: 16:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String prefix=request.getContextPath();
    request.setAttribute("prefix",prefix);
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
                    <li class="nav_active">
                        <a href="${prefix}/rest/teacher/info"><i class="fa fa-user-o nav_icon"></i>我的资料</a>
                    </li>
                    <li>
                        <a href="${prefix}/rest/teacher/class"><i class="fa fa-file-o nav_icon"></i>班级信息</a>
                    </li>
                    <li>
                        <a href="${prefix}/rest/teacher/message"><i class="fa fa-send-o nav_icon"></i>短信通知</a>
                    </li>
                    <li>
                        <a href="${prefix}/rest/teacher/share"><i class="fa fa-bookmark-o nav_icon"></i>我的分享</a>
                    </li>
                    <li>
                        <a href="${prefix}/rest/teacher/reply"><i class="fa fa-commenting-o nav_icon"></i>我的留言</a>
                    </li>
                    <li>
                        <a href="${prefix}/rest/user/updatePwd"><i class="fa fa-file-o nav_icon"></i>修改密码</a>
                    </li>
                </ul>
            </div>
            <div id="contentPanel" class="pull-left" style=" margin-left: 30px;width: 910px">
                <!--家长信息-->
                <h4 style="background-color: #f5f5f5; height: 35px; line-height: 35px;margin: 0px; padding-left: 10px; color:  #555555; font-size: 16px;margin-bottom: 20px;"><i class="fa fa-user-circle-o" style="padding: 0 10px;color: #ff8f2b"></i>我的资料</h4>
                <div class="main container">
                    <div class="row">
                        <p><span>姓名：</span>${teacher.name}</p>
                    </div>
                    <div class="row">
                        <p><span>性别：</span><c:if test="${ 'm' eq teacher.sex }">男</c:if><c:if test="${teacher.sex eq 'f' }">女</c:if></p>
                    </div>
                    <div class="row">
                        <p><span>职位：</span>${teacher.job}</p>
                    </div>
                    <div class="row">
                        <p style="float: left"><span>所在年级：</span>${teacher.grade}年级</p> <p style="float: left;padding-left: 45px"><span>所在班级：</span>${teacher.classname}班</p>
                    </div>
                    <div class="row">
                        <p><span>工作学校：</span>${teacher.school}</p>
                    </div>
                    <div class="row">
                        <p><span>联系方式：</span>${teacher.phone}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="${prefix}/js/bootstrap.min.js"></script>
</body>
</html>