package cn.jxt.service.impl;

import cn.jxt.bean.Banner;
import cn.jxt.bean.Notice;
import cn.jxt.mapper.BannerMapper;
import cn.jxt.service.BannerService;
import cn.jxt.service.TeacherService;
import cn.jxt.service.UserService;
import com.github.abel533.entity.Example;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;
@Service
public class BannerServiceImpl implements BannerService {
    @Autowired
    private BannerMapper bannerMapper;



    @Override
    public List<Banner> queryBannerByMaxSize(int maxSize) {
        return bannerMapper.queryBannerByMaxSize(maxSize);
    }

    @Override
    public List<Banner> queryAllBanner() {
        Example example=new Example(Banner.class);
        example.setOrderByClause("update_time desc");
        return bannerMapper.selectByExample(example);

    }

    @Override
    public void addBanner(Banner banner) {
        banner.setCreateTime(new Timestamp(System.currentTimeMillis()));
        banner.setUpdateTime(banner.getCreateTime());
        bannerMapper.insert(banner);
    }

    @Override
    public void updateBanner(Banner banner) {
        banner.setUpdateTime(new Timestamp(System.currentTimeMillis()));
        bannerMapper.updateByPrimaryKeySelective(banner);
    }

    @Override
    public void deleteBanner(int bannerId) {
        bannerMapper.deleteByPrimaryKey(bannerId);
    }
}
