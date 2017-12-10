$('#teacherTable').bootstrapTable({
    striped:true,//斑马线
    search:true,
    showColumns:true,
    showRefresh:true,
    showToggle:true,
    cardView:false,//手机设备上的卡片视图
    toolbar:'#toolbar',//工具栏
    method:'get',
    url:'registerList',
    idField:'id',
    uniqueId:'id',
    columns: [{
        title:'状态',
        singleSelect:true,
        checkbox:true,
    },{
        field: 'id',
        title: '班主任id',
    },{
        field: 'name',
        title: '班主任姓名',
    }, {
        field: 'sex',
        title: '性别'
    }, {
        field: "phone",
        title: "联系方式"
    },{
        field: "job",
        title: "职务",
    },{
        field: "school",
        title: "学校名称",
    },{
        field: "grade",
        title: "年级",
    },{
        field: "classname",
        title: "班级",
    }]/*,
    onClickRow:function (row,element,field) {
        //row：点击行的数据，
        //$element：tr 元素，
        //field：点击列的 field 名称。

        //获取所有选中的行
        var rows=$('#teacherTable').bootstrapTable('getSelections');

        for(var index=0;index<rows.length;index++){
            if(rows[index].id==row.id){
                $('#teacherTable').bootstrapTable('uncheck',row.id);
                return;
            }
        }
        $('#teacherTable').bootstrapTable('check',row.id-1);
    }*/
});


$("#delete").click(function () {
    var row=$('#teacherTable').bootstrapTable('getSelections');
    if(row.length==0){
        alert("未勾选需要删除的行");
    }else if(row.length>1){
        alert("删除操作只能够勾选一行");
    }else{
        var id=row[0].id;
        $.ajax({
            type:'post',
            url:'register?_method=delete',
            data:{teacherId:id},
            dataType:'json',
            success:function (data) {
                if(data.status==200){
                    $('#teacherTable').bootstrapTable('removeByUniqueId', id);
                }else{
                    alert("删除失败");
                }
            }
        });

    }
});
//修改操作 start
$("#edit").click(function () {
    var row=$('#teacherTable').bootstrapTable('getSelections');
    if(row.length==0){
        alert("未勾选需要编辑的行");
    }else if(row.length>1){
        alert("编辑操作只能够勾选一行");
    }else{
        var id=row[0].id;
        //init
        $('#teacherInfoModalLabel').html("修改班主任信息");
        $('#registerBtn').html("完成修改");

        $('#teacherInfoModal #inputTeacherName').val(row[0].name);
        row[0].sex=="m"?$('#teacherInfoModal #inlineRadio1').attr("checked","true"):$('#teacherInfoModal #inlineRadio2').attr("checked","true");
        $('#teacherInfoModal #inputPhoneNumber').val(row[0].phone);
        $('#teacherInfoModal #inputJob').val(row[0].job);
        $('#teacherInfoModal #inputSchoolName').val(row[0].school);
        $('#teacherInfoModal #inputGrade').val(row[0].grade);
        $('#teacherInfoModal #inputClassName').val(row[0].classname);
        $('#inputTeacherId').removeAttr('disabled');
        console.log(id);
        $('#inputTeacherId').val(id);
        //开始修改操作
        $('#teacherInfoModal').modal('show');
        //绑定点击事件
        $('#registerBtn').unbind('click').bind("click",updateTeacher);
    }
});



function updateTeacher() {
    //step1 省略
    $.ajax({
        type:'post',
        url:'register?_method=put',
        data:$('#teacherForm').serialize(),
        dataType:'json',
        success:function (data) {
            if(data.status==200){
                //刷新
                $('#teacherTable').bootstrapTable('refresh', {url: "registerList"});
                $('#teacherInfoModal').modal('hide');
            }else{
                alert("修改失败");
            }
        },
        async:false
    });
    //step2
    $('#teacherInfoModal').modal('hide');
}
//修改操作结束

//注册操作开始
$("#register").click(function () {
    //init模态框
    $('#teacherInfoModalLabel').html("注册班主任信息");
    $('#registerBtn').html("完成注册");
    //初始化表单数据
    $('#teacherForm :input').not(':button,:submit,:reset,:hidden').val('').removeAttr('checked').removeAttr('selected');
    $('#teacherForm :input').not(':button,:submit,:reset,:hidden').val('').removeAttr('checked').removeAttr('selected');
    $('#teacherInfoModal').modal('show');
    //绑定点击事件
    $('#registerBtn').unbind('click').bind("click",registerTeacher);
});


function registerTeacher(){
    $.ajax({
        type:'post',
        url:'register',
        data:$('#teacherForm').serialize(),
        dataType:'json',
        success:function (data) {
            if(data.status==200){
                //刷新
                $('#teacherTable').bootstrapTable('refresh', {url: "registerList"});
                console.log('刷新');
                $('#teacherInfoModal').modal('hide');
            }else{
                alert("注册失败");
            }
        },
        async:false
    });

}