<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                    <a href="${prefix}/rest/teacher/info"><i class="fa fa-user-o nav_icon"></i>我的资料</a>
                </li>
                <li>
                    <a href="${prefix}/rest/teacher/class"><i class="fa fa-file-o nav_icon"></i>班级信息</a>
                </li>
                <li  class="nav_active">
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

            <h4 style="background-color: #f5f5f5; height: 35px; line-height: 35px;margin: 0px; padding-left: 10px; color:  #555555; font-size: 16px;margin-bottom: 20px;">
                <i class="fa fa-commenting-o" style="padding: 0 10px;color: #ff8f2b"></i>短信通知</h4>
            <div class="main">
               <c:choose>
                   <c:when test="${studentList ne null and fn:length(studentList) gt 0}">
                       <form style="width: 900px;overflow: hidden" method="post" action="${prefix}/rest/teacher/message" enctype="multipart/form-data">
                           <div id="leftReceiverOperationDiv" style="float: left">
                               <label for="all"><input id="all"  type="checkbox">全选</label>
                               <ul id="receiverSelectList">

                                   <c:forEach var="student" items="${studentList}" varStatus="status">
                                       <li>
                                           <label for="receiver${status.index+1}"><span style="display: inline-block;width: 42px;">${student.name}</span><input id="receiver${status.index+1}" name="studentIds" type="checkbox" value="${student.id}"></label>
                                       </li>
                                   </c:forEach>
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
                                       <input type="radio"  name="templateCode"  value="SMS_99025014" >成绩模板
                                   </label>
                                   <label class="radio-inline" data-toggle="tooltip" data-placement="top" title="Tooltip on top消息模板消息模板消息模板消息模板消息模板">
                                       <input type="radio"  name="templateCode"  value=""> 普通模板
                                   </label>
                               </div>
                               <textarea class="form-control" rows="9" name="content" placeholder="请填写消息,可以使用\${}符号来添加占位符；例如语文\${语文}分,数学\${数学}分,英语\${英语}分"></textarea>
                               <div class="pull-right" style="margin-top: 40px;">
                                       <%--<button type="button" class="btn btn-warning " style="margin-right:20px;display: inline-block">查看历史消息</button>--%>
                                   <button type="submit" class="btn btn-success " style="display: inline-block">发送消息</button>
                               </div>
                           </div>
                       </form>
                   </c:when>
                   <c:otherwise>
                       <div style="font-size: 36px; width: 100%;height: 100px; text-align: center;vertical-align: middle;font-weight: 200;color: #737373;letter-spacing: 1px">
                           所管理的班级没有家长注册，无法使用短信服务
                       </div>
                   </c:otherwise>
               </c:choose>

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
<c:if test="${msg ne null}">
    <script>
        alert('${msg}');
    </script>
</c:if>
</body>
</html>