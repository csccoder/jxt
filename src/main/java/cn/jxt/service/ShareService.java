package cn.jxt.service;

import cn.jxt.bean.Share;
import cn.jxt.bean.ShareCategory;

import java.util.List;

public interface ShareService {

    public List<Share> queryMyShare(Integer curPage, Integer pageSize, String userId);

    List<Share> queryShareListByPage(int curPage, int pageSize);

    int queryShareCount();

    List<ShareCategory> queryAllCategory();

    List<Share> queryShareListByPageAndCategoryId(Integer curPage, Integer pageSize, int categoryId);

    Share queryShareDetail(int shareId);

    void addShare(Share share);

    List<Share> queryHotShareByMaxSize(int maxSize);

    int queryMyShareCount(String userId);

    int queryShareCountByCategoryId(int categoryId);
}
