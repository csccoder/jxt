package cn.jxt.service;

import cn.jxt.bean.Message;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public interface MessageService {
    public List<Message> queryReceiveMessage(Integer curPage, Integer pageSize, String userId);

    int queryReceiveMessageCount(String userId);

    void sendMessage(String senderId, List<Integer> studentIds, InputStream inputStream, String templateCode, String content) throws IOException, InvalidFormatException;
}
