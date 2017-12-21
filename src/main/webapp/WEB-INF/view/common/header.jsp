<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: chenny
  Date: 2017/9/29
  Time: 19:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String prefix=request.getContextPath();
    request.setAttribute("prefix",prefix);
    request.setAttribute("jxtImg","/jxtImg/");
%>
<link href="${prefix}/css/loginModal.css" rel="stylesheet">
<header id="header">
    <nav class="navbar navbar-default">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="${prefix}/index.jsp">家校通</a>
            </div>

            <!-- 主要功能菜单 -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li>
                        <c:choose>
                            <c:when test="${empty user}">
                                <a href="javascript:void(0)" onclick="alert('请先登录')">家校联系</a>
                            </c:when>
                            <c:when test="${user.role eq 3}">
                                <a href="javascript:void(0)" onclick="alert('管理员没有相应的功能操作')">家校联系</a>
                            </c:when>
                            <c:when test="${user.role eq 1}">
                                <a href="${prefix}/rest/guardian/message" >家校联系</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${prefix}/rest//teacher/message" >家校联系</a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <%--<li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                           aria-expanded="false">家校联系 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">短信消息</a></li>
                            <li><a href="#">信息查询</a></li>
                        </ul>

                    </li>--%>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                           aria-expanded="false">学科学习 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="${prefix}/rest/studyResource">全部</a></li>
                            <c:forEach var="studyResourceCategory" items="${studyResourceCategoryList}">
                                <li><a href="${prefix}/rest/studyResource/category/${studyResourceCategory.id}">${studyResourceCategory.categoryName}</a></li>
                            </c:forEach>
                        </ul>
                    </li>
                    <li><a href="${prefix}/rest/share">分享交流</a></li>
                    <c:choose>
                        <c:when test="${empty user}">
                            <li><a href="javascript:void(0)" onclick="alert('请先登录！')">后台管理</a></li>
                        </c:when>
                        <c:when test="${user.role ne 3}">
                            <li><a href="javascript:void(0)" onclick="alert('当前登录用户没有管理员操作权限！')">后台管理</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${prefix}/rest/manage">后台管理</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <!--登录/未登录状态 操作面板-->
                <ul class="nav navbar-nav navbar-right ">
                    <c:choose>
                        <c:when test="${user ne null}">
                            <li class="hidden"><a href="#" data-toggle="modal" data-target="#loginModal">登录</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                   aria-expanded="false">${user.name} <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <c:choose>
                                            <c:when test="${user.role eq 1}">
                                                <a href="${prefix}/rest/guardian/info">个人资料</a>
                                            </c:when>
                                            <c:when test="${user.role eq 2}">
                                                <a href="${prefix}/rest/teacher/info">个人资料</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${prefix}/rest/manage">个人资料</a>
                                            </c:otherwise>
                                        </c:choose>

                                    </li>
                                    <li><a href="${prefix}/rest/user/logout">注销</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="show"><a href="#" data-toggle="modal" data-target="#loginModal">登录</a></li>
                            <li class="dropdown hidden">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                   aria-expanded="false">我的信息 <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#">个人资料</a></li>
                                    <li><a href="#">注销</a></li>
                                </ul>
                            </li>
                        </c:otherwise>
                    </c:choose>

                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
</header>