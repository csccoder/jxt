$('#classTable').bootstrapTable({
    striped:true,//斑马线
    search:true,
    showColumns:true,
    showRefresh:true,
    showToggle:true,
    cardView:false,//手机设备上的卡片视图
    detailView:true,//详细视图
    toolbar:'#toolbar',//工具栏
    method:'get',
    url:'guardian',
    detailFormatter:function(index, row, element) {
        //index 当前行索引，从0开始
        //row 当前行的Json格式数据
        //Jquey选择器选择的当前行元素

            var data='<p><span>学生id：</span>'+row.student.id+'</p>';
            data+='<p><span>学生姓名：</span>'+row.student.name+'</p>';
            data+='<p><span>学生性别：</span>'+(row.student.sex=='f'?'女':'男')+'</p>';
            data+='<p><span>出生日期：</span>'+row.student.birth+'</p>';
            data+='<p><span>担任职位：</span>'+row.student.job+'</p>';
            data+='<hr/>';
            data+='<p><span>家长id：</span>'+row.id+'</p>';
            data+='<p><span>家长姓名：</span>'+row.name+'</p>';
            data+='<p><span>亲属关系：</span>'+row.relation+'</p>';
            data+='<p><span>联系方式：</span>'+row.phone+'</p>';
            data+='<p><span>工作单位：</span>'+row.company+'</p>';
            data+='<p><span>家庭住址：</span>'+row.address+'</p>';
        return data;
    },
    idField:'student.id',
    uniqueId:'student.id',
    columns: [{

        title:'状态',
        singleSelect:true,
        checkbox:true,

    },{
        field: 'autoId',
        title: '序号',
        formatter:function (value,row,index) {
            row.autoId=index;
            return index+1;
        }
    },{
        field: 'student.id',
        title: '学生id',

    }, {
        field: 'student.name',
        title: '学生姓名'
    }, {
        field: 'name',
        title: '监护人姓名'
    }, {
        field: "phone",
        title: "监护人电话"
    },{
        field: "address",
        title: "家庭地址"
    },{
        field: "company",
        title: "工作单位",
        visible:false
    },{
        field: "student.sex",
        title: "性别",
        visible:false
    },{
        field: "student.birth",
        title: "出生日期",
        visible:false
    },{
        field: "student.job",
        title: "班级职务",
        visible:false
    }],
    onClickRow:function (row,element,field) {
        //row：点击行的数据，
        //$element：tr 元素，
        //field：点击列的 field 名称。

        //获取所有选中的行
        var rows=$('#classTable').bootstrapTable('getSelections');

        for(var index=0;index<rows.length;index++){
            if(rows[index].id==row.id){
                $('#classTable').bootstrapTable('uncheck',row.autoId);
                return;
            }
        }
        $('#classTable').bootstrapTable('check',row.autoId);
    }
});


$("#delete").click(function () {
    var row=$('#classTable').bootstrapTable('getSelections');
    if(row.length==0){
        alert("未勾选需要删除的行");
    }else if(row.length>1){
        alert("删除操作只能够勾选一行");
    }else{
       console.log(row[0]);
        $.ajax({
            type:'post',
            url:'student?_method=delete',
            data:{studentId:row[0].student.id},
            success:function (data) {
                if(data.status==200){
                    //刷新表格
                    $('#classTable').bootstrapTable('refresh', {url: "guardian"});
                }else{
                    alert("删除失败");
                }
            }
        });

    }
});
//修改操作 start
$("#edit").click(function () {
    var row=$('#classTable').bootstrapTable('getSelections');
    if(row.length==0){
        alert("未勾选需要编辑的行");
    }else if(row.length>1){
        alert("编辑操作只能够勾选一行");
    }else{
        var id=row[0].id;
        //init
        $('#studentInfoModalLabel').html("修改学生信息");
        $('#guardianInfoModalLabel').html("修改监护人信息");
        $('#completeStudentInfoEdit').css('display','true');
        $('#rollback').css('dispaly','none');
        $('#completeStudentInfoEdit').html("完成修改");
        $('#completeStudentInfoEditAndOpenGuardianEditModal').html("下一步,修改监护人的信息");
        $('#completeGuardianInfoEdit').html("完成修改");
        //开始修改操作
        $('#studentInfoModal').modal('show');
        //绑定点击事件
        $('#completeStudentInfoEdit').unbind('click').bind("click",commitStudentInfoEdit);
        $('#completeStudentInfoEditAndOpenGuardianEditModal').unbind('click').bind("click",commitStudentInfoEditAndOpenGuardianEditModal);
        $('#completeGuardianInfoEdit').unbind('click').bind("click",commitGuardianInfoEdit);
        $('#rollback').unbind('click').bind("click",rollback);


        //初始化模态框数据
        $('#studentInfoModal #inputStudentName').val(row[0].student.name);
        $('#studentInfoModal #inputClassJob').val(row[0].student.job);
        $('#studentInfoModal #inputBirth').val(row[0].student.birth);
        $('#studentInfoModal #birth').val(row[0].student.birth);
        $('#studentInfoModal #inputStudentId').val(row[0].student.id);
        $('#datetimepicker').datetimepicker('update');
        row[0].student.sex=="m"?$('#studentInfoModal #inlineRadio1').attr("checked","true"):$('#studentInfoModal #inlineRadio2').attr("checked","true");

    }
});

/**
 * step1:进行ajax提交学生信息修改操作，并同步修改表格信息
 * step2:关闭学生信息编辑窗口
 */
function commitStudentInfoEdit() {
    //step1 省略
    $.ajax({
        type:'post',
        url:'student?_method=PUT',
        data:$('#studentForm').serialize(),
        dataType:'json',
        success:function(data){
            if(data.status!=200){
                alert("修改失败。请尝试操作");
            }else{
                //刷新表格
                $('#classTable').bootstrapTable('refresh', {url: "guardian"});
            }
        },
        async:false
    });
    //step2
    $('#studentInfoModal').modal('hide');
}
/**
 * step1:进行ajax提交学生信息修改操作，并同步修改表格信息
 * step2:关闭学生信息编辑窗口，并打开家长信息编辑窗口
 */
function commitStudentInfoEditAndOpenGuardianEditModal() {


    //step2
    //初始化模态框数据
    var row=$('#classTable').bootstrapTable('getSelections');
    $('#guardianInfoModal #inputGuardianName').val(row[0].name);
    $('#guardianInfoModal #inputPhoneNumber').val(row[0].phone);
    $('#guardianInfoModal #inputCompany').val(row[0].company);
    $('#guardianInfoModal #inputAddress').val(row[0].address);
    $('#guardianInfoModal #inputGuardianId').val(row[0].id);
    row[0].relation=="父亲"?$('#guardianInfoModal #relationRadio1').attr("checked","true"):$('#guardianInfoModal #relationRadio1').attr("checked","true");


    $('#studentInfoModal').modal('hide');
    $('#guardianInfoModal').modal('show');

}

function commitGuardianInfoEdit() {
    //step1
    //修改学生成功的前提下 修改家长信息
    $.ajax({
        type:'post',
        url:'student?_method=PUT',
        data:$('#studentForm').serialize(),
        dataType:'json',
        success:function(data){
            if(data.status!=200){
                alert("学生修改失败。请尝试操作");
            }else{
                $.ajax({
                    type:'post',
                    url:'guardian?_method=PUT',
                    data:$('#guardianForm').serialize(),
                    dataType:'json',
                    success:function(data){
                        if(data.status!=200){
                            alert("家长修改失败。请尝试操作");
                        }else{
                            //刷新表格
                            $('#classTable').bootstrapTable('refresh', {url: "guardian"});
                        }
                    },
                    async:false
                });
            }
        },
        async:false
    });
    //step2
    $('#guardianInfoModal').modal('hide');
}
//修改操作结束

//注册操作开始
$("#register").click(function () {
    //init模态框
    $('#studentInfoModalLabel').html("注册学生信息");
    $('#guardianInfoModalLabel').html("注册监护人信息");
    $('#completeStudentInfoEditAndOpenGuardianEditModal').html("下一步,填写监护人注册信息");
    $('#completeGuardianInfoEdit').html("完成注册");


    $('#studentInfoModal').modal('show');
    //初始化表单数据
    $('#studentForm :input').not(':button,:submit,:reset,:hidden').val('').removeAttr('checked').removeAttr('selected');
    $('#guardianForm :input').not(':button,:submit,:reset,:hidden').val('').removeAttr('checked').removeAttr('selected');
    //绑定点击事件
    $('#completeStudentInfoEdit').css('display','none');
    $('#completeStudentInfoEditAndOpenGuardianEditModal').unbind('click').bind("click",registerStudentInfo);
    $('#completeGuardianInfoEdit').unbind('click').unbind('click').bind("click",registerGuardianInfo);
    $('#rollback').css('dispaly','true');
    $('#rollback').unbind('click').bind('click',rollback);
});

function rollback() {
    $('#guardianInfoModal').modal('hide');
    $('#studentInfoModal').modal('show');
}

function registerStudentInfo() {
    $('#studentInfoModal').modal('hide');
    $('#guardianInfoModal').modal('show');
}

function registerGuardianInfo(){
    //注册学生成功的前提下 注册家长信息
    $.ajax({
        type:'post',
        url:'student',
        data:$('#studentForm').serialize(),
        dataType:'json',
        success:function(data){
            if(data.status==500){
                alert("学生注册失败。请尝试操作");
            }else{
                $('#inputGuardianChildId').removeAttr("disabled");
                $('#inputGuardianChildId').val(data.status);
                $.ajax({
                    type:'post',
                    url:'guardian',
                    data:$('#guardianForm').serialize(),
                    dataType:'json',
                    success:function(data){
                        if(data.status!=200){
                            alert("家长注册失败。请尝试操作");
                            $.ajax({
                                type:'post',
                                url:'student?_method=delete',
                                data:{studentId:$('#inputGuardianChildId').val()}
                            })

                        }else{
                            //刷新表格
                            $('#classTable').bootstrapTable('refresh', {url: "guardian"});
                            //重置表单
                            $('#inputGuardianChildId').attr("disabled",true);
                        }
                    },
                    async:false
                });
            }
        },
        async:false
    });
    $('#guardianInfoModal').modal('hide');
}