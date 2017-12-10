package cn.jxt.mapper;

import cn.jxt.bean.Share;
import com.github.abel533.mapper.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ShareMapper extends Mapper<Share> {
    public List<Share> queryMyShare(@Param("startLine") int curPage, @Param("pageSize") int pageSize, @Param("userId")String userId);

    List<Share> queryShareListByPage(@Param("startLine") int curPage, @Param("pageSize") int pageSize);

    List<Share> queryShareListByPageAndCategoryId(@Param("startLine") int curPage, @Param("pageSize") int pageSize, @Param("categoryId") int categoryId);

    Share queryShareDetail(int shareId);

    void addShare(Share share);

    List<Share> queryHotShareByMaxSize(int maxSize);

    int queryMyShareCount(String userId);

    int queryShareCountByCategoryId(int categoryId);
}
