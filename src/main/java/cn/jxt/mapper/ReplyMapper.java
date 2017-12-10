package cn.jxt.mapper;

import cn.jxt.bean.Reply;
import com.github.abel533.mapper.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReplyMapper extends Mapper<Reply> {
    public List<Reply> queryMyReply(@Param("startLine") int curPage, @Param("pageSize") Integer pageSize,@Param("userId") String userId);

    List<Reply> queryReplyListByShareId(int shareId);
}
