
$('#leftReceiverOperationDiv>label').on('ifChecked', function(event){
    $('#receiverSelectList li input').iCheck('check');
});
$('#leftReceiverOperationDiv>label').on('ifUnchecked', function(event){
    $('#receiverSelectList li input').iCheck('uncheck');
})
/**
 * 如果多选框全部选中，则选中“全选框”
 * 如果多选框中一个未选中，则取消选中“单选框”
 */

/*
$('#receiverSelectList>li>label').bind('click',function () {
    alert(this.checked)
    //获取单选框总数
    var checkeboxSum=$('#receiverSelectList>li input').length;
    var checkedNum=$('#receiverSelectList>li input:checked').length;
    console.log(checkeboxSum);
    console.log(checkedNum);
    if(checkeboxSum==checkedNum){
        $('#leftReceiverOperationDiv>label>div').addClass('checked');
    }else{
        $('#leftReceiverOperationDiv>label>div').removeClass('checked');
    }
})*/
