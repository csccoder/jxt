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
    <div class="row" id="main">
        <div class="col-md-9" class="main">
            <div class="mainContent">
                <h3 class="title">${studyResource.title}</h3>
                <div style=" border-bottom: 1px solid #dbdbdb;overflow: hidden;padding-bottom: 10px;padding-left: 20px;">
                    <div class="pull-left">

                        <c:choose>
                            <c:when test="${empty user}">
                                <i class="fa fa-star-o" style="padding-right: 20px;">&nbsp;<a href="javascirpt:void(0)" onclick="alert('请先登录再收藏')">收藏</a></i>
                            </c:when>
                            <c:when test="${isCollect eq true}">
                                <i class="fa fa-star" style="padding-right: 20px;">&nbsp;<a href="javascirpt:void(0)" onclick="cancelCollect(${studyResource.id})">取消收藏</a></i>
                            </c:when>
                            <c:when test="${isCollect eq false}">
                                <i class="fa fa-star-o" style="padding-right: 20px;">&nbsp;<a href="javascirpt:void(0)" onclick="addCollect(${studyResource.id})">收藏</a></i>
                            </c:when>
                        </c:choose>
                        <c:if test="${user.id eq studyResource.user.id}">
                            <i class="fa fa-edit" style="padding-right: 20px;">&nbsp;<a href="${prefix}/rest/studyResource/edit/${studyResource.id}">编辑</a> </i>
                        </c:if>

                    </div>
                    <div class="pull-right">
                        <i class="fa fa-user-o" style="padding-right: 20px;">&nbsp;${studyResource.user.name}</i>
                        <i class="fa fa-bars" style="padding-right: 20px;">&nbsp;<a href="${prefix}/rest/studyResource/category/${studyResource.category.id}" style="color: #333">${studyResource.category.categoryName}</a></i>
                        <i class="fa fa-calendar-minus-o" style="padding-right: 5px;">
                            &nbsp;<fmt:formatDate value="${studyResource.updateTime}" pattern="yyyy年MM月dd日 HH:mm:ss"></fmt:formatDate>
                        </i>
                    </div>
                </div>
                <div class="content" style="overflow: hidden">
                    ${studyResource.content}
                </div>
            </div>
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
<script>
    function addCollect(studyResourceId){
        $.ajax({
            type:'post',
            url:'${prefix}/rest/studyResource/collect/'+studyResourceId,
            success:function (data) {
                if(data.status==200){
                    location.reload(true);
                }else{
                    alert(data.msg);
                }
            }
        });
    }
    function cancelCollect(studyResourceId){
        $.ajax({
            type:'post',
            url:'${prefix}/rest/studyResource/collect/'+studyResourceId+'?_method=delete',
            success:function (data) {
                if(data.status==200){
                    location.reload(true);
                }else{
                    alert(data.msg);
                }
            }
        });
    }

</script>
</html>
