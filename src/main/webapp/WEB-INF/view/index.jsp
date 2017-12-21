<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
  Created by IntelliJ IDEA.
  User: chenny
  Date: 2017/9/29
  Time: 16:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>首页</title>
    <link href="${prefix}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${prefix}/css/reset.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="${prefix}/js/html5shiv.min.js"></script>
    <script src="${prefix}/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<jsp:include page="/rest/header" ></jsp:include>
<!-- main content-->
<div id="content" class="">
    <!--图片滚动框-->
    <div id="main_banner" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
            <c:forEach var="banner" items="${bannerList}" varStatus="status">
                <div class="item <c:if test="${status.index eq 0}"> active</c:if> ">
                    <img src="/jxtImg/${banner.location}" alt="${banner.title}">
                    <div class="carousel-caption">

                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#main_banner" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#main_banner" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <!--文字显示区-->
    <div id="main_content" class="container">
        <div class="row">
            <!--公告-->
            <div id="announcement " class="col-md-4 column">
                <div class="row">
                    <h3 class="title col-md-4">最新公告</h3>
                    <a href="#" class="pull-right more"></a>
                </div>
                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                    <c:forEach var="notice" items="${noticeList}" varStatus="status">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="heading${status.index}">
                                <p class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse${status.index}"
                                            <c:if test="${status.index eq 0}">aria-expanded="true"</c:if><c:if test="${status.index ne 0}">aria-expanded="false"</c:if> aria-controls="collapse${status.index}">
                                        ${notice.title}
                                    </a>
                                </p>
                            </div>
                            <div id="collapse${status.index}" class="panel-collapse collapse <c:if test="${status.index eq 0}">in</c:if>" role="tabpanel"
                                 aria-labelledby="heading${status.index}">
                                <div class="panel-body">
                                    ${notice.content}
                                </div>
                            </div>
                        </div>
                    </c:forEach>


                </div>
            </div>
            <!--最热话题-->
            <div id="hotTopic" class="col-md-7 col-md-offset-1 column">
                <div class="row">
                    <h3 class="title col-md-4">热门话题</h3>
                    <a href="#" class=" pull-right more"></a>
                </div>
                <div class="">
                    <ol class=" ">

                        <c:forEach var="share" items="${shareList}" varStatus="status">
                            <li>
                                <a href="${prefix}/rest/share/${share.id}">${status.index+1}.${share.title}</a>
                            </li>
                        </c:forEach>
                    </ol>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="column">
                <div class="row">
                    <h3 class="title col-md-4">学科学习</h3>
                    <a href="#" class=" pull-right more"></a>
                </div>
                <div class="row xkxx_content">
                    <ul class="container-fluid">

                        <c:forEach var="studyResource" items="${studyResourceList}">
                            <li>
                                <a href="${prefix}/rest/studyResource/${studyResource.id}">
                                    <img src="${prefix}/img/xkxx.jpg" >
                                    <a href="${prefix}/rest/studyResource/${studyResource.id}">${studyResource.title}</a>
                                </a>
                            </li>
                        </c:forEach>

                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/rest/footer"></jsp:include>
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="${prefix}/js/bootstrap.min.js"></script>

</body>
</html>