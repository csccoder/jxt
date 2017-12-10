package cn.jxt.mapper;

import cn.jxt.bean.Banner;
import com.github.abel533.mapper.Mapper;

import java.util.List;

public interface BannerMapper extends Mapper<Banner> {
   public List<Banner> queryBannerByMaxSize(int maxsize);
}
