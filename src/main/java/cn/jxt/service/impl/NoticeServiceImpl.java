package cn.jxt.service.impl;

import cn.jxt.bean.Notice;
import cn.jxt.mapper.NoticeMapper;
import cn.jxt.service.NoticeService;
import com.github.abel533.entity.Example;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
@Service
public class NoticeServiceImpl implements NoticeService {
    @Autowired
    private NoticeMapper noticeMapper;


    @Override
    public List<Notice> queryNoticeByMaxSize(int maxSize) {
        return noticeMapper.queryNoticeByMaxSize(maxSize);
    }

    @Override
    public List<Notice> queryAllNotice() {
        Example example=new Example(Notice.class);
        example.setOrderByClause("update_time desc");
        return noticeMapper.selectByExample(example);

    }

    @Override
    public void addNotice(Notice notice) {
        Timestamp createTime=new Timestamp(System.currentTimeMillis());
        notice.setCreateTime(createTime);
        notice.setUpdateTime(createTime);
        noticeMapper.insert(notice);
    }

    @Override
    public void updateNotice(Notice notice) {
        Timestamp updateTime=new Timestamp(System.currentTimeMillis());
        notice.setUpdateTime(updateTime);
        noticeMapper.updateByPrimaryKeySelective(notice);
    }

    @Override
    public void deleteNotice(int noticeId) {
        noticeMapper.deleteByPrimaryKey(noticeId);
    }
}
