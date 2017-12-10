package cn.jxt.util;

import cn.jxt.bean.Guardian;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class AliCloudMessageSenderUtil {
    private static ObjectMapper objectMapper=new ObjectMapper();
    public static void sendMessage(String templateCode,List<MessageUtils.MessageWrap> messageWraps){
        if("SMS_99025014".equals(templateCode)){
            sendMessageByTemplate1( templateCode, messageWraps);
        }else if( "".equals(templateCode)){
            sendMessageByNomal(messageWraps);
        }
    }

    private static void sendMessageByNomal(List<MessageUtils.MessageWrap> messageWraps) {
        
    }

    private static void sendMessageByTemplate1(final String templateCode, List<MessageUtils.MessageWrap> messageWraps) {
        ThreadPoolExecutor threadPool=new ThreadPoolExecutor(5,Integer.MAX_VALUE,0, TimeUnit.SECONDS,new LinkedBlockingQueue<Runnable>());
        for(final MessageUtils.MessageWrap messageWrap:messageWraps){
            threadPool.execute(new Runnable() {
                @Override
                public void run() {
                    Map<String,String> templateParam=new HashMap<String,String>();
                    templateParam.put("name",messageWrap.getReceiver().getStudent().getName());
                    templateParam.put("content",messageWrap.getContent());
                    try {
                        sendMessageService(templateCode,messageWrap.getReceiver().getPhone(),objectMapper.writeValueAsString(templateParam) );
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            });
        }
    }


    private static void sendMessageService(String templateCode,String phoneNumber,String templateParam){
        //设置超时时间-可自行调整
        System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
        System.setProperty("sun.net.client.defaultReadTimeout", "10000");
//初始化ascClient需要的几个参数
        final String product = "Dysmsapi";//短信API产品名称（短信产品名固定，无需修改）
        final String domain = "dysmsapi.aliyuncs.com";//短信API产品域名（接口地址固定，无需修改）
//替换成你的AK
        final String accessKeyId = "LTAItW2Pg1WV9PeO";//你的accessKeyId,参考本文档步骤2
        final String accessKeySecret = "3spRfo8CAcMcvjap8ZT0dBufIZAE0G";//你的accessKeySecret，参考本文档步骤2
//初始化ascClient,暂时不支持多region
        IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId,
                accessKeySecret);
        try {
            DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product, domain);
        } catch (ClientException e) {
            e.printStackTrace();
        }
        IAcsClient acsClient = new DefaultAcsClient(profile);
        //组装请求对象
        SendSmsRequest request = new SendSmsRequest();
        //使用post提交
        request.setMethod(MethodType.POST);
        //必填:待发送手机号。支持以逗号分隔的形式进行批量调用，批量上限为1000个手机号码,批量调用相对于单条调用及时性稍有延迟,验证码类型的短信推荐使用单条调用的方式
        //request.setPhoneNumbers("17680467756");
        request.setPhoneNumbers(phoneNumber);
        //必填:短信签名-可在短信控制台中找到
        request.setSignName("家校通");
        //必填:短信模板-可在短信控制台中找到
        //request.setTemplateCode("SMS_99025014");
        request.setTemplateCode(templateCode);
        //可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
        //友情提示:如果JSON中需要带换行符,请参照标准的JSON协议对换行符的要求,比如短信内容中包含\r\n的情况在JSON中需要表示成\\r\\n,否则会导致JSON在服务端解析失败
        //request.setTemplateParam("{\"name\":\"陈思聪\", \"content\":\"语文：95、数学：87分\"}");
        request.setTemplateParam(templateParam);
        //可选-上行短信扩展码(无特殊需求用户请忽略此字段)
        //request.setSmsUpExtendCode("90997");
        //可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
        request.setOutId("2222");
//请求失败这里会抛ClientException异常
        SendSmsResponse sendSmsResponse = null;
        try {
            sendSmsResponse = acsClient.getAcsResponse(request);
        } catch (ClientException e) {
            e.printStackTrace();
        }
        if(sendSmsResponse.getCode() != null && sendSmsResponse.getCode().equals("OK")) {
//请求成功
            System.out.println("发送成功");
        }else{
            System.out.println("发送失败，错误代码："+sendSmsResponse.getCode()+",错误消息："+sendSmsResponse.getMessage());
        }
    }
}
