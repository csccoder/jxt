$('#bannerTable').bootstrapTable({
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
    url:'bannerList',
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
        title: '版图id',
        visible:false,
    }, {
        field: 'title',
        title: '版图标题'
    }, {
        field: 'location',
        title: '版图预览',
        formatter:function (value,row,index) {
            //value: the field value.
            //row: the row record data.
            //index: the row index.
            return "<a href=\""+value+"\" target='_blank'><img src=\"/jxt"+value+"\" style='width:200px'></a>";
        },
        align:'center'

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
        var rows=$('#bannerTable').bootstrapTable('getSelections');

        for(var index=0;index<rows.length;index++){
            if(rows[index].id==row.id){
                $('#bannerTable').bootstrapTable('uncheck',row.autoId);
                return;
            }
        }
        $('#bannerTable').bootstrapTable('check',row.autoId);
    }
});


$("#delete").click(function () {
    var row=$('#bannerTable').bootstrapTable('getSelections');
    if(row.length==0){
        alert("未勾选需要删除的行");
    }else if(row.length>1){
        alert("删除操作只能够勾选一行");
    }else{
        var id=row[0].id;

        $.ajax({
            type:'post',
            url:'banner?_method=delete',
            data:{bannerId:id},
            dataType:'json',
            success:function (data) {
                if(data.status==200){
                    $('#bannerTable').bootstrapTable('removeByUniqueId', id);
                }else{
                    alert("删除失败");
                }
            }
        })
    }
});
//修改操作 start
$("#edit").click(function () {
    var row=$('#bannerTable').bootstrapTable('getSelections');
    if(row.length==0){
        alert("未勾选需要编辑的行");
    }else if(row.length>1){
        alert("编辑操作只能够勾选一行");
    }else{
        var id=row[0].id;
        //init模态框
        $('#bannerInfoModalLabel').html("编辑版图");
        $('#completeAdd').html("编辑");
        $('#bannerForm').attr('action','updateBanner');
        $('#bannerForm #id').removeAttr('disabled');
        console.log(id);
        $('#bannerForm #id').val(id);
        console.log(row[0].title);
        console.log(row[0]);
        $('#inputBannerTitle').val(row[0].title);


        $('#bannerInfoModal').modal('show');
        //绑定点击事件
        $('#completeAdd').unbind('click').bind("click",updateBanner);

    }
});


function updateBanner() {
    //step1 省略
    $('#bannerForm').submit();
    //step2
    $('#noticeInfoModal').modal('hide');
}

//修改操作结束

//注册操作开始
$("#add").click(function () {
    //init模态框
    console.log('sdsd');
    $('#bannerInfoModalLabel').html("新增版图");
    $('#completeAdd').html("新增");

    $('#bannerForm').attr('action','addBanner');
    $('#bannerForm #id').attr('disabled',true);
    $('#bannerInfoModal').modal('show');
    //绑定点击事件
    $('#completeAdd').unbind('click').bind("click",addBanner);
});


function addBanner() {

    $('#bannerForm').submit();



}

