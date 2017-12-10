package cn.jxt.mapper;

import cn.jxt.bean.Share;
import cn.jxt.bean.StudyResource;
import com.github.abel533.mapper.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyResourceMapper extends Mapper<StudyResource> {
    public List<StudyResource> queryMyCollect(@Param("startLine") Integer startLine, @Param("pageSize") Integer pageSize,@Param("userId") String userId);

    List<StudyResource> queryStudyResourceListByPage(@Param("startLine") Integer curPage,@Param("pageSize") Integer pageSize);

    List<StudyResource> queryStudyResourceListByPageAndCategoryId(@Param("startLine") Integer curPage,@Param("pageSize") Integer pageSize, @Param("categoryId") int categoryId);

    StudyResource queryStudyResourceDetail(int studyResourceId);

    void addStudyResource(StudyResource studyResource);

    int queryMyCollectCount(String userId);

    void addCollect(@Param("studyResourceId") int studyResourceId,@Param("userId") String userId);

    void cancelCollect(@Param("studyResourceId") int studyResourceId,@Param("userId") String userId);

    int queryIsCollectByUserIdAndResourceId(@Param("studyResourceId") int studyResourceId,@Param("userId") String userId);

    void editStudyResource(StudyResource studyResource);

    int queryStudyResourceCountByCategoryId(int categoryId);
}
