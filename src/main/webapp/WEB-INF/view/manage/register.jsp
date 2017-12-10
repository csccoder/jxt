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
    <title>注册管理-个人中心</title>
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
                    <li>
                        <a href="${prefix}/rest/manage/notice"><i class="fa fa-user-o nav_icon"></i>公告管理</a>
                    </li>
                    <li>
                        <a href="${prefix}/rest/manage/banner"><i class="fa fa-file-o nav_icon"></i>版图管理</a>
                    </li>
                    <li  class="nav_active">
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
                <h4 style="background-color: #f5f5f5; height: 35px; line-height: 35px;margin: 0px; padding-left: 10px; color:  #555555; font-size: 16px;margin-bottom: 20px;"><i class="fa fa-user-circle-o" style="padding: 0 10px;color: #ff8f2b"></i>班主任注册</h4>
                <div class="main container">
                    <div class="row">
                        <ul id="toolbar">
                            <li><button type="button" class="btn btn-success" id="register">注册</button></li>
                            <li><button type="button" class="btn btn-info" id="edit">编辑</button></li>
                            <li><button type="button" class="btn btn-danger" id="delete">删除</button></li>
                        </ul>
                        <table id="teacherTable" ></table>
                    </div>

                </div>
            </div>
        </div>

        <!--信息模态框-->
        <div class="modal fade" id="teacherInfoModal" tabindex="-1" role="dialog" aria-labelledby="teacherInfoModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="teacherInfoModalLabel">编辑班主任信息</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" id="teacherForm">
                            <input type="hidden" id="inputTeacherId" name="id" disabled="disabled">
                            <div class="form-group">
                                <label for="inputTeacherName" class="col-sm-3 control-label">班主任姓名</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="inputTeacherName" placeholder="班主任姓名" name="name">
                                </div>
                            </div>

                            <div class="form-group" >
                                <label class="col-md-3 control-label" style="margin-right: 15px;">性别</label>
                                <label class="radio-inline" >
                                    <input type="radio"  name="sex" id="inlineRadio1" value="m" > 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio"  name="sex" id="inlineRadio2" value="f"> 女
                                </label>
                            </div>
                            <div class="form-group">
                                <label for="inputPhoneNumber" class="col-sm-3 control-label">联系方式</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="inputPhoneNumber" placeholder="手机号" name="phone">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputJob" class="col-sm-3 control-label">职位</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="inputJob" placeholder="职位" name="job" value="班主任">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputSchoolName" class="col-sm-3 control-label">学校名称</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="inputSchoolName" placeholder="填写学校名称" name="school">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputGrade" class="col-sm-3 control-label">年级</label>
                                <div class="col-sm-6">
                                    <select class="form-control" id="inputGrade" name="grade">
                                        <option value="1">一年级</option>
                                        <option value="2">二年级</option>
                                        <option value="3">三年级</option>
                                        <option value="4">四年级</option>
                                        <option value="5">五年级</option>
                                        <option value="6">六年级</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputClassName" class="col-sm-3 control-label">班级</label>
                                <div class="col-sm-6">
                                    <select class="form-control" id="inputClassName" name="classname">
                                        <option value="一">一班</option>
                                        <option value="二">二班</option>
                                        <option value="三">三班</option>
                                        <option value="四">四班</option>
                                        <option value="五">五班</option>
                                        <option value="六">六班</option>
                                        <option value="七">七班</option>

                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" id="registerBtn">注册</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="${prefix}/js/bootstrap.min.js"></script>
<script src="${prefix}/js/bootstrap-table.min.js"></script>
<script src="${prefix}/js/bootstrap-table-locale-all.min.js"></script>
<script src="${prefix}/js/bootstrap-datetimepicker.min.js"></script>
<script src="${prefix}/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="${prefix}/js/teacherTable.js"></script>
</body>
</html>