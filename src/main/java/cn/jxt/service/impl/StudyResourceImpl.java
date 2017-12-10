package cn.jxt.service.impl;

import cn.jxt.bean.Share;
import cn.jxt.bean.StudyResource;
import cn.jxt.bean.StudyResourceCategory;
import cn.jxt.mapper.StudyResourceCategoryMapper;
import cn.jxt.mapper.StudyResourceMapper;
import cn.jxt.service.StudyResourceService;
import com.github.abel533.entity.Example;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;
@Service
public class StudyResourceImpl implements StudyResourceService{
    @Autowired
    private StudyResourceMapper studyResourceMapper;

    @Autowired
    private StudyResourceCategoryMapper studyResourceCategoryMapper;

    public List<StudyResource> queryMyCollect(Integer curPage, Integer pageSize,String userId){
        return studyResourceMapper.queryMyCollect((curPage-1)*pageSize,pageSize,userId);
    }

    @Override
    public int queryStudyResourceCount() {
        return studyResourceMapper.selectCount(null);
    }

    @Override
    public List<StudyResource> queryStudyResourceListByPage(Integer curPage, Integer pageSize) {
        return studyResourceMapper.queryStudyResourceListByPage((curPage-1)*pageSize,pageSize);
    }

    @Override
    public List<StudyResource> queryRecentlyStudyResource(int maxSize) {
        return queryStudyResourceListByPage(1,maxSize);
    }

    @Override
    public List<StudyResourceCategory> queryAllCategory() {
        return studyResourceCategoryMapper.select(null);
    }

    @Override
    public List<StudyResource> queryStudyResourceListByPageAndCategoryId(Integer curPage, Integer pageSize, int categoryId) {
        return studyResourceMapper.queryStudyResourceListByPageAndCategoryId((curPage-1)*pageSize,pageSize,categoryId);
    }

    @Override
    public StudyResource queryStudyResourceDetail(int studyResourceId) {
        return studyResourceMapper.queryStudyResourceDetail(studyResourceId);
    }

    @Override
    public void addStudyResource(StudyResource studyResource) {
        studyResource.setCreateTime(new Timestamp(System.currentTimeMillis()));
        studyResource.setUpdateTime(studyResource.getCreateTime());
        studyResourceMapper.addStudyResource(studyResource);
    }

    @Override
    public int queryMyCollectCount(String userId) {
        return studyResourceMapper.queryMyCollectCount(userId);
    }

    @Override
    public boolean addCollect(int studyResourceId, String userId) {
        if(studyResourceMapper.queryIsCollectByUserIdAndResourceId(studyResourceId,userId)==1){
            return false;
        }
        studyResourceMapper.addCollect(studyResourceId,userId);
        return true;
    }

    @Override
    public boolean cancelCollect(int studyResourceId, String userId) {

        if(studyResourceMapper.queryIsCollectByUserIdAndResourceId(studyResourceId,userId)==0){
            return false;
        }
        studyResourceMapper.cancelCollect(studyResourceId,userId);
        return true;
    }

    @Override
    public boolean queryIsCollectByUserIdAndResourceId(int studyResourceId, String userId) {
        return studyResourceMapper.queryIsCollectByUserIdAndResourceId(studyResourceId,userId)==1?true:false;
    }

    @Override
    public void editStudyResource(StudyResource studyResource) {
        studyResourceMapper.editStudyResource(studyResource);
    }

    @Override
    public int queryStudyResourceCountByCategoryId(int categoryId) {
        return studyResourceMapper.queryStudyResourceCountByCategoryId(categoryId);
    }
}
