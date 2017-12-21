package cn.jxt.service.impl;

import cn.jxt.bean.Share;
import cn.jxt.bean.ShareCategory;
import cn.jxt.mapper.ShareCategoryMapper;
import cn.jxt.mapper.ShareMapper;
import cn.jxt.service.ShareService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.sql.Timestamp;
import java.util.List;
@Service
public class ShareServiceImpl implements ShareService {
    @Autowired
    private ShareMapper shareMapper;
    @Autowired
    private ShareCategoryMapper shareCategoryMapper;
    @Override
    public List<Share> queryMyShare(Integer curPage, Integer pageSize, String userId) {

        return shareMapper.queryMyShare((curPage-1)*pageSize,pageSize,userId);
    }

    @Override
    public List<Share> queryShareListByPage(int curPage, int pageSize) {
        return shareMapper.queryShareListByPage((curPage-1)*pageSize,pageSize);
    }

    @Override
    public int queryShareCount() {
        return shareMapper.selectCount(null);
    }

    @Override
    public List<ShareCategory> queryAllCategory() {
        return shareCategoryMapper.select(null);
    }

    @Override
    public List<Share> queryShareListByPageAndCategoryId(Integer curPage, Integer pageSize, int categoryId) {
        return shareMapper.queryShareListByPageAndCategoryId((curPage-1)*pageSize,pageSize,categoryId);
    }

    @Override
    public Share queryShareDetail(int shareId) {
        return shareMapper.queryShareDetail(shareId);
    }

    @Override
    public void addShare(Share share) {
        share.setCreateTime(new Timestamp(System.currentTimeMillis()));
        share.setUpdateTime(share.getCreateTime());
        shareMapper.addShare(share);
    }

    @Override
    public List<Share> queryHotShareByMaxSize(int maxSize) {
        return shareMapper.queryHotShareByMaxSize(maxSize);
    }

    @Override
    public int queryMyShareCount(String userId) {

       return shareMapper.queryMyShareCount(userId);
    }

    @Override
    public int queryShareCountByCategoryId(int categoryId) {
        return shareMapper.queryShareCountByCategoryId(categoryId);
    }


}
