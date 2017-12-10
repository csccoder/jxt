package cn.jxt.service;

import cn.jxt.bean.Notice;

import java.util.List;

public interface NoticeService {
    public List<Notice> queryNoticeByMaxSize(int maxSize);
    public List<Notice> queryAllNotice();

    void addNotice(Notice notice);

    void updateNotice(Notice notice);

    void deleteNotice(int noticeId);
}
