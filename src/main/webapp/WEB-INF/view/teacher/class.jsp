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
    <title>班级信息-个人中心</title>
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
                <h3>个人中心</h3>
                <a href="#">返回首页</a>
            </div>
        </div>
        <div class="row">
            <div id="nav" class="col-md-2">
                <ul>
                    <li >
                        <a href="${prefix}/rest/teacher/info"><i class="fa fa-user-o nav_icon"></i>我的资料</a>
                    </li>
                    <li class="nav_active">
                        <a href="${prefix}/rest/teacher/class"><i class="fa fa-file-o nav_icon"></i>班级信息</a>
                    </li>
                    <li>
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
                    <%--<li>
                    <a href="xiaoxi.jsp"><i class="fa fa-envelope-o nav_icon"></i>我的消息</a>
                </li>--%>
                </ul>
            </div>
            <div id="contentPanel" class="pull-left" style=" margin-left: 30px;width: 910px">
                <h4 style="background-color: #f5f5f5; height: 35px; line-height: 35px;margin: 0px; padding-left: 10px; color:  #555555; font-size: 16px;margin-bottom: 20px;"><i class="fa fa-user-circle-o" style="padding: 0 10px;color: #ff8f2b"></i>班级信息</h4>
                <div class="main container">
                    <%--<div class="row">
                        <p style="float: left"><span>管理班级：</span>湖南理工学院附小六年级二班</p> <p style="float: left;padding-left: 45px"><span>人数：</span>59人</p>
                    </div>--%>
                    <div class="row">
                        <ul id="toolbar">
                            <li><button type="button" class="btn btn-success" id="register">注册</button></li>
                            <li><button type="button" class="btn btn-info" id="edit">编辑</button></li>
                            <li><button type="button" class="btn btn-danger" id="delete">删除</button></li>
                        </ul>
                        <table id="classTable" ></table>
                    </div>

                </div>
            </div>
        </div>

        <!--学生信息模态框-->
        <div class="modal fade" id="studentInfoModal" tabindex="-1" role="dialog" aria-labelledby="studentInfoModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="studentInfoModalLabel">编辑学生信息</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" id="studentForm">
                            <input type="hidden" id="inputStudentId" name="id">
                            <div class="form-group">
                                <label for="inputStudentName" class="col-sm-2 control-label">学生姓名</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="inputStudentName" placeholder="学生姓名" name="name">
                                </div>
                            </div>
                            <div class="form-group" style="height: 34px;">
                                <label for="birth" class="col-md-2 control-label">出生日期</label>
                                <div class="input-group date form_date col-sm-6" data-date="" data-date-format="yyyy-mm-dd" data-link-field="birth" data-link-format="yyyy-mm-dd" style="padding-left: 15px;background-color: #fff" id="datetimepicker">
                                    <input class="form-control" size="16" type="text"  style="background-color: #fff" placeholder="出生日期"  id="inputBirth" readonly>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                </div>
                                <input type="hidden"  name="birth" value="" id="birth" /><br/>
                            </div>
                            <div class="form-group" >
                                <label for="birth" class="col-md-2 control-label" style="margin-right: 15px;">性别</label>
                                <label class="radio-inline" >
                                    <input type="radio"  name="sex" id="inlineRadio1" value="m" > 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio"  name="sex" id="inlineRadio2" value="f"> 女
                                </label>
                            </div>
                            <div class="form-group">
                                <label for="inputClassJob" class="col-sm-2 control-label">担任职务</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="inputClassJob" placeholder="填写职务，例如班长，学习委员等" name="job">
                                </div>
                            </div>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"  id="completeStudentInfoEdit">完成编辑</button>
                        <button type="button" class="btn btn-primary" id="completeStudentInfoEditAndOpenGuardianEditModal">提交编辑，并修改监护人资料</button>
                    </div>
                </div>
            </div>
        </div>
        <!--家长信息模态框-->
        <div class="modal fade" id="guardianInfoModal" tabindex="-1" role="dialog" aria-labelledby="guardianInfoModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="guardianInfoModalLabel">编辑监护人信息</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" id="guardianForm">
                            <input type="hidden"  id="inputGuardianId"  name="id">
                            <input type="hidden"  id="inputGuardianChildId"  name="childId" disabled="disabled">
                            <div class="form-group">
                                <label for="inputGuardianName" class="col-sm-3 control-label">监护人姓名</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="inputGuardianName" placeholder="监护人姓名" name="name">
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="col-md-3 control-label" style="margin-right: 15px;">监护人关系</label>
                                <label class="radio-inline" >
                                    <input type="radio" name="relation" name="sex" id="relationRadio1" value="父亲" >父亲
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="relation" name="sex" id="relationRadio2" value="母亲"> 母亲
                                </label>
                            </div>
                            <div class="form-group">
                                <label for="inputPhoneNumber" class="col-sm-3 control-label">联系方式</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="inputPhoneNumber" placeholder="手机号码，微信号等" name="phone">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputCompany" class="col-sm-3 control-label">工作单位</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="inputCompany" placeholder="填写工作单位" name="company">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputAddress" class="col-sm-3 control-label">家庭住址</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="inputAddress" placeholder="填写家庭住址" name="address">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" id="rollback">返回上一步</button>
                        <button type="button" class="btn btn-primary" id="completeGuardianInfoEdit">完成编辑</button>
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
<script src="${prefix}/js/classTable.js"></script>
<script>
    $('.form_date').datetimepicker({
        language:  'zh-CN',
        weekStart: 1,
        todayBtn:  1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });
</script>
</body>
</html>