package cn.jxt.service;

import cn.jxt.bean.Banner;
import cn.jxt.bean.Notice;

import java.util.List;

public interface BannerService {
    public List<Banner> queryBannerByMaxSize(int maxSize);

    List<Banner> queryAllBanner();

    void addBanner(Banner banner);


    void updateBanner(Banner banner);

    void deleteBanner(int bannerId);
}
