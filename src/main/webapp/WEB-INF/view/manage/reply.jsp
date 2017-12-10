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
                <li >
                    <a href="${prefix}/rest/manage/notice"><i class="fa fa-user-o nav_icon"></i>公告管理</a>
                </li>
                <li>
                    <a href="${prefix}/rest/manage/banner"><i class="fa fa-file-o nav_icon"></i>版图管理</a>
                </li>
                <li>
                    <a href="${prefix}/rest/manage/register"><i class="fa fa-file-o nav_icon"></i>注册管理</a>
                </li>
                <li>
                    <a href="${prefix}/rest/manage/share"><i class="fa fa-bookmark-o  nav_icon"></i>我的分享</a>
                </li>
                <li class="nav_active">
                    <a href="${prefix}/rest/manage/reply"><i class="fa fa-commenting-o nav_icon"></i>我的留言</a>
                </li>
                <li>
                    <a href="${prefix}/rest/user/updatePwd"><i class="fa fa-file-o nav_icon"></i>修改密码</a>
                </li>
                <%--<li>
                    <a href="xiaoxi.jsp"><i class="fa fa-envelope-o nav_icon"></i>我的消息</a>
                </li>--%>
            </ul>
        </div>
        <div id="contentPanel" class="pull-left" style=" margin-left: 30px;width: 910px">
            <h4 style="background-color: #f5f5f5; height: 35px; line-height: 35px;margin: 0px; padding-left: 10px; color:  #555555; font-size: 16px;margin-bottom: 20px;">
                <i class="fa fa-commenting-o" style="padding: 0 10px;color: #ff8f2b"></i>我的留言</h4>
            <div class="main">
                <ul id="mainContent" class="commentsColumn">
                    <c:choose>
                        <c:when test="${pageHelper.data ne null}">
                            <c:forEach var="reply" items="${pageHelper.data}">
                                <li>
                                    <div style="overflow: hidden">
                                        <div class="pull-left">
                                            【标题】<a href="#">【${reply.title}】</a><i>&gt;&gt;</i>
                                        </div>
                                        <div class="pull-right">
                                            【回复时间】<fmt:formatDate value="${reply.replyTime}" pattern="yyyy年MM月dd日 hh:mm:ss"></fmt:formatDate>
                                        </div>
                                        <div class="reply" style="clear: both">
                                            <span>【回复】</span><a href="javascript:void(0)"  onclick="showModal(this)">
                                                ${reply.replyContent}
                                        </a>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="font-size: 36px; width: 100%;height: 100px; text-align: center;vertical-align: middle;font-weight: 200;color: #737373">
                                暂无留言
                            </div>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <c:if test="${ pageHelper.data ne null}">
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
                                    <li><a href="${prefix}/rest/manage/reply?curPage=${pageHelper.nextPage}&pageSize=${pageHelper.pageSize}">下一页</a></li>
                                    <li><a href="${prefix}/rest/manage/reply?curPage=${pageHelper.last}&pageSize=${pageHelper.pageSize}">末页</a></li>
                                </c:when>
                                <c:when test="${pageHelper.curPage eq pageHelper.last}">
                                    <li><a href="${prefix}/rest/manage/reply?curPage=${pageHelper.first}&pageSize=${pageHelper.pageSize}">首页</a></li>
                                    <li><a href="${prefix}/rest/manage/reply?curPage=${pageHelper.prePage}&pageSize=${pageHelper.pageSize}">上一页</a></li>
                                    <li><input type="text" value="${pageHelper.curPage}" min="1" max="${pageHelper.last}">/${pageHelper.last}</li>
                                    <li><a>下一页</a></li>
                                    <li><a >末页</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="${prefix}/rest/manage/reply?curPage=${pageHelper.first}&pageSize=${pageHelper.pageSize}">首页</a></li>
                                    <li><a href="${prefix}/rest/manage/reply?curPage=${pageHelper.prePage}&pageSize=${pageHelper.pageSize}">上一页</a></li>
                                    <li><input type="text" value="${pageHelper.curPage}" min="1" max="${pageHelper.last}">/${pageHelper.last}</li>
                                    <li><a href="${prefix}/rest/manage/reply?curPage=${pageHelper.nextPage}&pageSize=${pageHelper.pageSize}">下一页</a></li>
                                    <li><a href="${prefix}/rest/manage/reply?curPage=${pageHelper.last}&pageSize=${pageHelper.pageSize}">末页</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </c:if>
            </div>

        </div>
    </div>
</div>
<!--留言展开模态框-->
<div class="modal fade" id="commentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">我的留言</h4>
            </div>
            <div class="modal-body">
                随着国家对网络安全教育的逐渐重视，更多的人开始关注到青少年网络安全教育。近年来，因“沉迷网络”荒费学业，因上网玩游戏缺钱买装备引发偷盗、抢劫、杀人等违法犯罪等等，这样的事件不计其数，几乎每天都在发生随着国家对网络安全教育的逐渐重视，更多的人开始关注到青少年网络安全教育。近年来，因“沉迷网络”荒费学业，因上网玩游戏缺钱买装备引发偷盗、抢劫、杀人等违法犯罪等等，这样的事件不计其数，几乎每天都在发生随着国家对网络安全教育的逐渐重视，更多的人开始关注到青少年网络安全教育。近年来，因“沉迷网络”荒费学业，因上网玩游戏缺钱买装备引发偷盗、抢劫、杀人等违法犯罪等等，这样的事件不计其数，几乎每天都在发生随着国家对网络安全教育的逐渐重视，更多的人开始关注到青少年网络安全教育。近年来，因“沉迷网络”荒费学业，因上网玩游戏缺钱买装备引发偷盗、抢劫、杀人等违法犯罪等等，这样的事件不计其数，几乎每天都在发生
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary">关闭</button>
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
</script>
</body>
</html>