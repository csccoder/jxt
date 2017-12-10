<%--
  Created by IntelliJ IDEA.
  User: chenny
  Date: 2017/9/29
  Time: 16:57
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
    <title>公告管理-后台管理</title>
    <link href="${prefix}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${prefix}/css/nav.css" rel="stylesheet">
    <link href="${prefix}/css/layout.css" rel="stylesheet">
    <link href="${prefix}/css/font-awesome.min.css" rel="stylesheet">
    <link href="${prefix}/css/bootstrap-table.min.css" rel="stylesheet">
    <link href="${prefix}/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
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
            <h3>后台管理</h3>
            <a href="#">返回首页</a>
        </div>
    </div>
    <div class="row">
        <div id="nav" class="col-md-2">
            <ul>
                <li >
                    <a href="${prefix}/rest/manage/notice"><i class="fa fa-user-o nav_icon"></i>公告管理</a>
                </li>
                <li class="nav_active">
                    <a href="${prefix}/rest/manage/banner"><i class="fa fa-file-o nav_icon"></i>版图管理</a>
                </li>
                <li>
                    <a href="${prefix}/rest/manage/register"><i class="fa fa-file-o nav_icon"></i>注册管理</a>
                </li>
                <li>
                    <a href="${prefix}/rest/manage/share"><i class="fa fa-bookmark-o  nav_icon"></i>我的分享</a>
                </li>
                <li>
                    <a href="${prefix}/rest/manage/reply"><i class="fa fa-commenting-o nav_icon"></i>我的留言</a>
                </li>
                <li>
                    <a href="${prefix}/rest/user/updatePwd"><i class="fa fa-file-o nav_icon"></i>修改密码</a>
                </li>

            </ul>
        </div>
        <div id="contentPanel" class="pull-left" style=" margin-left: 30px;width: 910px">
            <h4 style="background-color: #f5f5f5; height: 35px; line-height: 35px;margin: 0px; padding-left: 10px; color:  #555555; font-size: 16px;margin-bottom: 20px;">
                <i class="fa fa-user-circle-o" style="padding: 0 10px;color: #ff8f2b"></i>版图管理</h4>
            <div class="main container">

                <div class="row">
                    <ul id="toolbar">
                        <li>
                            <button type="button" class="btn btn-success" id="add">新增</button>
                        </li>
                        <li>
                            <button type="button" class="btn btn-info" id="edit">编辑</button>
                        </li>
                        <li>
                            <button type="button" class="btn btn-danger" id="delete">删除</button>
                        </li>
                    </ul>
                    <table id="bannerTable"></table>
                </div>
            </div>
        </div>
    </div>
    <!--版图模态框-->
    <div class="modal fade" id="bannerInfoModal" tabindex="-1" role="dialog" aria-labelledby="bannerInfoModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="bannerInfoModalLabel">编辑版图信息</h4>
                </div>
                <div class="modal-body">

                    <form class="form-horizontal" id="bannerForm" method="post" enctype="multipart/form-data" action="banner">
                        <input type="hidden" name="id" id="id" disabled="disabled">
                        <div class="form-group">
                            <label for="inputBannerTitle" class="col-sm-2 control-label">版图标题</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" id="inputBannerTitle" placeholder="版图标题"
                                       name="title">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">版图上传</label>
                            <div class="col-sm-10">
                                <input type="file"  name="img" id="bannerFile">
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="completeAdd">新增</button>
                </div>
            </div>
        </div>
    </div>
    <!--版图详细模态框-->
    <!-- Small modal -->
    <div class="modal fade" id="bannerDetailModal" tabindex="-1" role="dialog" aria-labelledby="noticeDetailModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="noticeDetailModalLabel">公告详细</h4>
                </div>
                <div class="modal-body">

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="${prefix}/js/bootstrap.min.js"></script>
<script src="${prefix}/js/bootstrap-table.min.js"></script>
<script src="${prefix}/js/bootstrap-table-locale-all.min.js"></script>
<script src="${prefix}/js/bannerManage.js"></script>
</body>
</html>