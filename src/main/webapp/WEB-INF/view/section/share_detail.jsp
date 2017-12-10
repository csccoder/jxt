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
                <h3>分享交流</h3>
                <p>这是分享交流板块，一起交流吧！</p>
            </div>
        </div>
    </div>
    <div class="row" id="main">
        <div class="col-md-9" class="main">
            <div class="mainContent">
                <h3 class="title">${share.title}</h3>
                <div style=" border-bottom: 1px solid #dbdbdb;text-align: right">
                    <i class="fa fa-user-o" style="padding-right: 20px;">&nbsp;${share.sharer.name}</i>
                    <i class="fa fa-bars" style="padding-right: 20px;">&nbsp;<a href="${prefix}/rest/share/category/${share.category.id}" style="color: #333">${share.category.categoryName}</a></i>
                    <i class="fa fa-calendar-minus-o" style="padding-right: 5px;">
                        &nbsp;<fmt:formatDate value="${share.updateTime}" pattern="yyyy年MM月dd日 HH:mm:ss"></fmt:formatDate>
                    </i>
                </div>
                <div class="content">
                    ${share.content}
                </div>
                <div class="post-reply">
                    <h3 class="title"><i class="icon common"></i>主题回复</h3>

                       <c:choose>
                           <c:when test="${empty replyList}">
                                <div style="font-size: 24px;text-align: center;margin-top: 20px;">
                                    暂无回复
                                </div>
                           </c:when>
                           <c:otherwise>
                               <ul class="replyList">
                                   <c:forEach var="reply" items="${replyList}">
                                       <li>
                                           <div class="wrap">
                                               <div class="pull-left">
                                                   <img />
                                                   <p>${reply.userName}</p>
                                               </div>
                                               <div class="pull-right reply_content">${reply.replyContent}</div>
                                               <div class="reply_time"><fmt:formatDate value="${reply.replyTime}" pattern="yyyy年MM月dd日 HH:mm:ss"></fmt:formatDate> </div>
                                           </div>
                                       </li>
                                   </c:forEach>
                              </ul>
                           </c:otherwise>
                       </c:choose>



                </div>
                <div class="post-reply" id="replyDiv">
                    <h3 class="title"><i class="icon common"></i>我要回复</h3>
                    <form method="post" action="${prefix}/rest/share/reply/${share.id}" style="padding: 20px 30px;overflow: hidden" >
                        <textarea class="form-control" rows="5" name="content"></textarea>
                        <c:if test="${user eq null}">

                        </c:if>
                        <c:choose>
                            <c:when test="${user ne null}">
                                <button type="submit" class="btn btn-success pull-right" style="margin-top: 20px;width: 100px;">提交</button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn btn-success pull-right" style="margin-top: 20px;width: 100px;" onclick="alert('未登录，不能回复')">提交</button>
                            </c:otherwise>
                        </c:choose>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="panel">
                <h3>标签 tag</h3>
                <ul>
                    <c:forEach var="category" items="${categoryList}">
                        <li><a href="${prefix}/rest/share/category/${category.id}">${category.categoryName}</a></li>
                    </c:forEach>
                </ul>
            </div>
            <c:choose>
                <c:when test="${user ne null}">
                    <a href="${prefix}/rest/share/add" class="btn btn-success " role="button" style="display: block;margin-top: 20px;margin-left: 40px;width: 120px;">我要发帖</a>
                </c:when>
                <c:otherwise>
                    <a href="javascript:void(0)" class="btn btn-success " role="button" style="display: inline-block;margin-top: 20px;margin-left: 70px;" onclick="alert('请先登录')">我要发帖</a>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${user ne null}">
                    <a href="#replyDiv" class="btn btn-success " role="button" style="display: block;margin-top: 20px;margin-left: 40px;width: 120px;">我要回复</a>
                </c:when>
                <c:otherwise>
                    <a href="javascript:void(0)" class="btn btn-success " role="button" style="display: inline-block;margin-top: 20px;margin-left: 70px;" onclick="alert('请先登录')">我要回复</a>
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
