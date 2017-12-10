package cn.jxt.mapper;

import cn.jxt.bean.Notice;
import com.github.abel533.mapper.Mapper;

import java.util.List;

public interface NoticeMapper extends Mapper<Notice> {
    public List<Notice> queryNoticeByMaxSize(int maxsize);
}
