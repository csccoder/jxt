package cn.jxt.service;

import cn.jxt.bean.Share;
import cn.jxt.bean.StudyResource;
import cn.jxt.bean.StudyResourceCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyResourceService {

    public List<StudyResource> queryMyCollect(Integer curPage, Integer pageSize,String userId);

    int queryStudyResourceCount();

    List<StudyResource> queryStudyResourceListByPage(Integer curPage, Integer pageSize);

    List<StudyResource> queryRecentlyStudyResource(int maxSize);

    List<StudyResourceCategory> queryAllCategory();

    List<StudyResource> queryStudyResourceListByPageAndCategoryId(Integer curPage, Integer pageSize, int categoryId);

    StudyResource queryStudyResourceDetail(int studyResourceId);

    void addStudyResource(StudyResource studyResource);

    int queryMyCollectCount(String userId);

    boolean addCollect(int studyResourceId, String userId);

    boolean cancelCollect(int studyResourceId, String userId);

    boolean queryIsCollectByUserIdAndResourceId(int studyResourceId,String userId);

    void editStudyResource(StudyResource newStudyResource);

    int queryStudyResourceCountByCategoryId(int categoryId);
}
