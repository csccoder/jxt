<%--
  Created by IntelliJ IDEA.
  User: chenny
  Date: 2017/10/6
  Time: 20:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer style="margin-top: 20px">
    <p class="text-center">版权所有：HNIST JSJXY 计科2班 第六组 Copyright:©2017-2018 All rights reserved </p>
</footer>

<!--登录模态框-->
<!-- Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header top20">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" style="visibility: hidden;width: 20px;display: inline-block">&times;</span></button>

            </div>
            <div class="modal-body">
                <div class="input-group input-group-lg parentCls">
                    <span class="input-group-addon" id="usr"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></span>
                    <input type="text" class="form-control inputElem" placeholder="请输入登录账号" aria-describedby="user" id="user" name="user" style="width: 466px;">
                </div>
                <div class="input-group input-group-lg top20">
                    <span class="input-group-addon" id="pw"><span class="glyphicon glyphicon-lock" aria-hidden="true"></span></span>
                    <input type="password" class="form-control" placeholder="初始密码为手机号后6位" aria-describedby="pwd" id="pwd" name="pwd">
                    <span class="input-group-btn tccBut">
                <button class="btn btn-success" type="button" onclick="login()">登 录</button>
              </span>
                </div>
            </div>
            <!--<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>-->
        </div>
    </div>
</div>
<script>
    function login(){
        var id=$('#user').val();
        var pwd=$('#pwd').val();
        $.ajax({
            url:"${prefix}/rest/user/login",
            type:"post",
            data:{id:id,password:pwd},
            dataType:"json",
            success:function(data){
                if(data.status==200){
                   // window.location='${prefix}/rest/index';
                    location.reload(true);
                }else{
                    alert(data.msg);
                }

            }
        })
    }
</script>