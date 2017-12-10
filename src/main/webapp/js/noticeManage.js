$('#noticeTable').bootstrapTable({
    striped:true,//斑马线
    search:true,
    showRefresh:true,
    onDblClickRow:function (row,element,field) {
        //row：点击行的数据，
        //$element：tr 元素，
        //field：点击列的 field 名称。

        //init模态框
        $('#noticeDetailModal .modal-body').text(row.noticeContent);
        $('#noticeDetailModal').modal('show');
    },
    cardView:false,//手机设备上的卡片视图
    toolbar:'#toolbar',//工具栏
    idField:'id',
    uniqueId:'id',
    method:'get',
    url:'noticeList',
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
        field: 'id',
        title: '公告id',
        visible:false,
    }, {
        field: 'title',
        title: '公告标题'
    }, {
        field: 'content',
        title: '公告内容',
        visible:false,
    }, {
        field: "createTime",
        title: "发布时间"
    },{
        field: "updateTime",
        title: "修改时间"
    }],
    onClickRow:function (row,element,field) {
        //row：点击行的数据，
        //$element：tr 元素，
        //field：点击列的 field 名称。

        //获取所有选中的行
        var rows=$('#noticeTable').bootstrapTable('getSelections');

        for(var index=0;index<rows.length;index++){
            if(rows[index].id==row.id){
                $('#noticeTable').bootstrapTable('uncheck',row.autoId);
                return;
            }
        }
        $('#noticeTable').bootstrapTable('check',row.autoId);
    }
});


$("#delete").click(function () {
    $('#inputNoticeId').attr("disabled","true");
    var row=$('#noticeTable').bootstrapTable('getSelections');
    if(row.length==0){
        alert("未勾选需要删除的行");
    }else if(row.length>1){
        alert("删除操作只能够勾选一行");
    }else{
        var id=row[0].id;
        $.ajax({
            type:'post',
            url:"notice?_method=delete",
            data:{noticeId:id},
            success:function (data) {
                if(data.status==200){
                    //刷新
                    //$('#noticeTable').bootstrapTable('refresh', {url: "noticeList"});
                    $('#noticeInfoModal').modal('hide');
                }else{
                    alert("添加公告失败！请稍后尝试");
                }
            },
            async:false
        });
        $('#noticeTable').bootstrapTable('removeByUniqueId', id);
    }
});
//修改操作 start
$("#edit").click(function () {
    var row=$('#noticeTable').bootstrapTable('getSelections');
    if(row.length==0){
        alert("未勾选需要编辑的行");
    }else if(row.length>1){
        alert("编辑操作只能够勾选一行");
    }else{
        var id=row[0].id;
        //init模态框
        $('#noticeInfoModalLabel').html("编辑公告");
        $('#completeAdd').html("编辑");
        console.log(row[0].noticeContent);
        $('#noticeInfoModal #inputNoticeTitle').val(row[0].title);
        $('#noticeInfoModal #inputNoticeContent').val(row[0].content);
        $('#inputNoticeId').val(row[0].id);
        $('#inputNoticeId').removeAttr("disabled");
        $('#noticeInfoModal').modal('show');
        //绑定点击事件
        $('#completeAdd').unbind('click').bind("click",updateNotice);

    }
});


function updateNotice() {
    //step1 省略
    $.ajax({
        type:'post',
        url:"notice?_method=put",
        data:$('#noticeForm').serialize(),
        success:function (data) {
            if(data.status==200){
                //刷新
                $('#noticeTable').bootstrapTable('refresh', {url: "noticeList"});
                $('#noticeInfoModal').modal('hide');
            }else{
                alert("添加公告失败！请稍后尝试");
            }
        },
        async:false
    });
    //step2

    //$('#noticeInfoModal').modal('hide');
}

//修改操作结束

//注册操作开始
$("#add").click(function () {
    //init模态框
    $('#noticeInfoModalLabel').html("新增公告");
    $('#completeAdd').html("新增");
    $('#noticeForm :input').not(':button,:submit,:reset,:hidden').val('').removeAttr('checked').removeAttr('selected');
    $('#inputNoticeId').attr("disabled","true");
    $('#noticeInfoModal').modal('show');
    //绑定点击事件
    $('#completeAdd').unbind('click').bind("click",addNotice);
});


function addNotice() {
    $.ajax({
        type:'post',
        url:"notice",
        data:$('#noticeForm').serialize(),
        success:function (data) {
            if(data.status==200){
                //刷新
                $('#noticeTable').bootstrapTable('refresh', {url: "noticeList"});
                $('#noticeInfoModal').modal('hide');
            }else{
                alert("添加公告失败！请稍后尝试");
            }
        },
        async:false
    });

}

