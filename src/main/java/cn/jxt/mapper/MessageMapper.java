package cn.jxt.mapper;

import cn.jxt.bean.Message;
import com.github.abel533.mapper.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MessageMapper  extends Mapper<Message>{
    public List<Message> queryReceiveMessage(@Param("startLine") Integer startLine, @Param("pageSize")Integer pageSize,@Param("userId") String userId);


    int queryReceiveMessageCount(String userId);

    void saveSendMessageRecord(Message message);

    void saveReceiveMessageRecord(@Param("messageId") int messageId, @Param("guardianId") String guardianId);
}
