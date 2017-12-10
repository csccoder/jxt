<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: chenny
  Date: 2017/10/1
  Time: 19:23
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
    <title>学科学习</title>
    <link href="${prefix}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${prefix}/css/nav.css" rel="stylesheet">
    <link href="${prefix}/css/fxjl_layout.css" rel="stylesheet">
    <link href="${prefix}/css/font-awesome.min.css" rel="stylesheet">
    <style>
        .section *{
            font-size: 14px!important;
            color: #000!important;
            background: #fff!important;
            font-family: "Helvetica Neue",Helvetica,Arial,sans-serif!important;
            font-weight: normal!important;
            text-align: left!important;
            display: inline!important;
            padding: 0!important;
            margin: 0!important;
            width: auto!important;
        }
    </style>
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
    <jsp:include page="/rest/header"></jsp:include>
    <div  style="width: 1030px; margin: 0 auto">
        <div class="row">
            <div class="col-md-11" id="banner">
                <img src="${prefix}/img/ffjl_bg.png">
                <div class="topic">
                    <h3>学科学习</h3>
                    <p>这是学科学习板块，一起学习吧！</p>
                </div>
            </div>
        </div>
        <div class="row" id="main">
            <div class="col-md-9" id="mainContent">
                <c:choose>
                    <c:when test="${pageHelper.data ne null }">
                        <ul class="articleList">
                            <c:forEach var="studyResource" items="${pageHelper.data}">
                                <li>
                                    <div class="article col-md-12">
                                        <div class="line">
                                            <a class="title" href="${prefix}/rest/studyResource/${studyResource.id}">【${studyResource.category.categoryName}】${studyResource.title}</a>
                                            <span class="author"><i class="fa fa-user-o" style="line-height: 30px;margin-right: 5px;"></i>${studyResource.user.name}</span>
                                        </div>
                                        <div class="section">
                                            <p>${studyResource.content}</p>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <div style="font-size: 36px; width: 100%;padding:40px 0px;margin-top:40px;text-align: center;font-weight: 200;color: #737373;background: transparent!important;letter-spacing: 8px;">
                            该分类暂无发帖
                        </div>
                    </c:otherwise>
                </c:choose>
                <c:if test="${pageHelper.data ne null}">
                    <div id="pageTool">
                        <ul>
                            <c:choose>
                                <c:when test="${pageHelper.last eq 1}">
                                    <li><a >首页</a></li>
                                    <li><a >上一页</a></li>
                                    <li><input type="text" value="${pageHelper.curPage}" min="1" max="${pageHelper.last}" disabled>/${pageHelper.last}</li>
                                    <li><a >下一页</a></li>
                                    <li><a >末页</a></li>
                                </c:when>
                                <c:when test="${pageHelper.curPage eq 1}">
                                    <li><a >首页</a></li>
                                    <li><a >上一页</a></li>
                                    <li><input type="text" value="${pageHelper.curPage}" min="1" max="${pageHelper.last}">/${pageHelper.last}</li>
                                    <li><a href="${prefix}/rest/studyResource<c:if test="${categoryId ge 1}">/category/${categoryId}</c:if>?curPage=${pageHelper.nextPage}&pageSize=${pageHelper.pageSize}">下一页</a></li>
                                    <li><a href="${prefix}/rest/studyResource<c:if test="${categoryId ge 1}">/category/${categoryId}</c:if>?curPage=${pageHelper.last}&pageSize=${pageHelper.pageSize}">末页</a></li>
                                </c:when>
                                <c:when test="${pageHelper.curPage eq pageHelper.last}">
                                    <li><a href="${prefix}/rest/studyResource<c:if test="${categoryId ge 1}">/category/${categoryId}</c:if>?curPage=${pageHelper.first}&pageSize=${pageHelper.pageSize}">首页</a></li>
                                    <li><a href="${prefix}/rest/studyResource<c:if test="${categoryId ge 1}">/category/${categoryId}</c:if>?curPage=${pageHelper.prePage}&pageSize=${pageHelper.pageSize}">上一页</a></li>
                                    <li><input type="text" value="${pageHelper.curPage}" min="1" max="${pageHelper.last}">/${pageHelper.last}</li>
                                    <li><a>下一页</a></li>
                                    <li><a >末页</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="${prefix}/rest/studyResource<c:if test="${categoryId ge 1}">/category/${categoryId}</c:if>?curPage=${pageHelper.first}&pageSize=${pageHelper.pageSize}">首页</a></li>
                                    <li><a href="${prefix}/rest/studyResource<c:if test="${categoryId ge 1}">/category/${categoryId}</c:if>?curPage=${pageHelper.prePage}&pageSize=${pageHelper.pageSize}">上一页</a></li>
                                    <li><input type="text" value="${pageHelper.curPage}" min="1" max="${pageHelper.last}">/${pageHelper.last}</li>
                                    <li><a href="${prefix}/rest/studyResource<c:if test="${categoryId ge 1}">/category/${categoryId}</c:if>?curPage=${pageHelper.nextPage}&pageSize=${pageHelper.pageSize}">下一页</a></li>
                                    <li><a href="${prefix}/rest/studyResource<c:if test="${categoryId ge 1}">/category/${categoryId}</c:if>?curPage=${pageHelper.last}&pageSize=${pageHelper.pageSize}">末页</a></li>
                                </c:otherwise>
                            </c:choose>


                        </ul>
                    </div>
                </c:if>
            </div>
            <div class="col-md-3">
                <div class="panel">
                    <h3>标签 tag</h3>
                    <ul>
                        <c:forEach var="category" items="${categoryList}">
                            <li><a href="${prefix}/rest/studyResource/category/${category.id}">${category.categoryName}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <c:choose>
                    <c:when test="${user ne null}">
                        <a href="${prefix}/rest/studyResource/add" class="btn btn-success " role="button" style="display: inline-block;margin-top: 20px;margin-left: 70px;">我要发帖</a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:void(0)" class="btn btn-success " role="button" style="display: inline-block;margin-top: 20px;margin-left: 70px;" onclick="alert('请先登录')">我要发帖</a>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </div>
    <jsp:include page="/rest/footer"></jsp:include>
</body>
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="${prefix}/js/bootstrap.min.js"></script>
</html>
