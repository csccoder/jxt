package cn.jxt.service;

import cn.jxt.bean.Reply;

import java.util.List;

public interface ReplyService {
    public List<Reply> queryMyReply(Integer curPage, Integer pageSize, String userId);


    void addReply(Reply reply);

    List<Reply> queryReplyListByShareId(int sharId);

    int queryMyReplyCount(String userId);
}
