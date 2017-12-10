package cn.jxt.service.impl;

import cn.jxt.bean.Reply;
import cn.jxt.mapper.ReplyMapper;
import cn.jxt.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyServiceImpl implements ReplyService {
    @Autowired
    private ReplyMapper replyMapper;

    public List<Reply> queryMyReply(Integer curPage, Integer pageSize, String userId){

        return  replyMapper.queryMyReply((curPage-1)*pageSize,pageSize,userId);
    }

    @Override
    public void addReply(Reply reply) {
        replyMapper.insert(reply);
    }

    @Override
    public List<Reply> queryReplyListByShareId(int shareId) {

        List<Reply> replyList=replyMapper.queryReplyListByShareId(shareId);
        return replyList;
    }

    @Override
    public int queryMyReplyCount(String userId) {
        Reply reply=new Reply();
        reply.setUserId(userId);
        return replyMapper.selectCount(reply);
    }
}
