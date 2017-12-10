package cn.jxt.service.impl;

import cn.jxt.bean.Guardian;
import cn.jxt.bean.Message;
import cn.jxt.bean.User;
import cn.jxt.mapper.MessageMapper;
import cn.jxt.service.GuardianService;
import cn.jxt.service.MessageService;
import cn.jxt.util.AliCloudMessageSenderUtil;
import cn.jxt.util.MessageUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.List;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    private MessageMapper messageMapper;
    @Autowired
    private GuardianService guardianService;
    @Override
    public List<Message> queryReceiveMessage(Integer curPage, Integer pageSize, String userId) {

        return messageMapper.queryReceiveMessage((curPage-1)*pageSize,pageSize,userId);
    }

    @Override
    public int queryReceiveMessageCount(String userId) {
        return messageMapper.queryReceiveMessageCount(userId);
    }

    @Override
    public void sendMessage(String senderId, List<Integer> studentIds, InputStream inputStream, String templateCode, String content) throws IOException, InvalidFormatException,RuntimeException {
        //1.先获取对应学生id的家长信息和学生信息，主要是家长名和手机号，学生名
        List<Guardian> guardianList=guardianService.getGuadianListByStudentIds(studentIds);
        //2.解析短信模板，生成具体消息
        List<MessageUtils.MessageWrap> messageWraps=null;
        if(inputStream!=null){
            messageWraps=MessageUtils.resolveMessageContent(content,inputStream);
        }else{
            messageWraps=MessageUtils.resolveMessageContent(studentIds,content);
        }

        for(MessageUtils.MessageWrap messageWrap:messageWraps){
            for(Guardian guardian:guardianList){
                if(messageWrap.getChildId()==guardian.getStudent().getId()){
                    messageWrap.setReceiver(guardian);
                    break;
                }
            }
        }
        //去除掉excel中多余的数据行
        for(int i=0;i<messageWraps.size();i++){
            if(messageWraps.get(i).getReceiver()==null){
                messageWraps.remove(i);
            }
        }

        if(templateCode!=null&&!templateCode.equals("")){
            //3.调用阿里大于第三方服务发送短信
            AliCloudMessageSenderUtil.sendMessage(templateCode,messageWraps);
        }
        //4.将消息保存到数据库
        saveSendMessageRecord(senderId,messageWraps);

    }
    public void saveSendMessageRecord(final String senderId, List<MessageUtils.MessageWrap> messageWraps){
        ThreadPoolExecutor threadPool=new ThreadPoolExecutor(5,Integer.MAX_VALUE,20, TimeUnit.SECONDS,new LinkedBlockingQueue<Runnable>());

        for(final MessageUtils.MessageWrap messageWrap :messageWraps){
           threadPool.execute(new Runnable() {
               @Override
               public void run() {
                   Message message=message=new Message();
                   message.setContent(messageWrap.getContent());
                   User sender =new User();
                   sender.setId(senderId);
                   message.setSender(sender);
                   message.setSendTime(new Timestamp(System.currentTimeMillis()));

                   messageMapper.saveSendMessageRecord(message);
                   messageMapper.saveReceiveMessageRecord(message.getId(),messageWrap.getReceiver().getId());
               }
           });

        }
    }
}
