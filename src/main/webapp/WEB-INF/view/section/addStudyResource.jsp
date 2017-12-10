<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: chenny
  Date: 2017/10/1
  Time: 19:23
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
    <title>分享交流</title>
    <link href="${prefix}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${prefix}/css/nav.css" rel="stylesheet">
    <link href="${prefix}/css/fxjl_layout.css" rel="stylesheet">
    <link href="${prefix}/css/font-awesome.min.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<jsp:include page="/rest/header"></jsp:include>
<div style="width: 1030px; margin: 0 auto">
    <div class="row">
        <div class="col-md-11" id="banner">
            <img src="${prefix}/img/ffjl_bg.png">
            <div class="topic">
                <h3>学科学习</h3>
                <p>这是学科学习板块，一起学习吧！</p>
            </div>
        </div>
    </div>
    <div class="row" >
        <div class="col-md-12 main" style="margin-left: 15px;">
            <div class="mainContent">
                <form class="form-horizontal" id="shareForm" method="post" action="${prefix}/rest/studyResource">
                    <div class="form-group">
                        <label for="title" class="col-sm-2 control-label">标题</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="title" name="title" placeholder="请输入标题">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">分类</label>
                        <div class="col-sm-3">
                            <select name="category.id" class="form-control">
                                <c:forEach var="category" items="${categoryList}">
                                    <option value="${category.id}">${category.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">内容</label>
                        <div class="col-sm-8">
                            <!-- 加载编辑器的容器 -->
                            <script id="container" name="content" type="text/plain"> </script>

                        </div>
                    </div>


                    <div class="form-group">
                        <div class="col-sm-offset-8 col-sm-2" style="overflow: hidden">
                            <button type="submit"  class="btn btn-success" style="width: 100px;display: block;float: right">提交</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>

</body>
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="${prefix}/js/bootstrap.min.js"></script>
<!-- 配置文件 -->
<script type="text/javascript" src="${prefix}/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${prefix}/ueditor/ueditor.all.min.js"></script>
<!-- 实例化编辑器 -->
<script type="text/javascript">
    var ue = UE.getEditor('container');

</script>
</html>
