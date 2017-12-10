package cn.jxt.controller;

import cn.jxt.bean.*;
import cn.jxt.service.StudyResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("studyResource")
public class StudyResourceController {
    @Autowired
    private StudyResourceService studyResourceService;

    @RequestMapping(method= RequestMethod.GET)
    public ModelAndView studyResourceView(@RequestParam(required = false) Integer curPage, @RequestParam(required = false)Integer pageSize){
        if(curPage==null){
            curPage=1;
        }
        if(pageSize==null){
            pageSize=10;
        }

        int count=studyResourceService.queryStudyResourceCount();
        List<StudyResource> studyResourceList=null;
        if(count!=0){
            studyResourceList=studyResourceService.queryStudyResourceListByPage(curPage,pageSize);
        }
        PageHelper<StudyResource> pageHelper=new PageHelper<StudyResource>(count,curPage,pageSize,studyResourceList);
        Map map=new HashMap<String,Object>();
        map.put("pageHelper",pageHelper);
        map.put("categoryList",studyResourceService.queryAllCategory());
        return new ModelAndView("section/studyResource",map);
    }

    @RequestMapping(value = "category/{categoryId}",method=RequestMethod.GET)
    public ModelAndView querystudyResourceByCategoryId(@PathVariable int categoryId,@RequestParam(required = false) Integer curPage, @RequestParam(required = false)Integer pageSize){
        if(curPage==null){
            curPage=1;
        }
        if(pageSize==null){
            pageSize=10;
        }

        int count=studyResourceService.queryStudyResourceCountByCategoryId(categoryId);
        List<StudyResource> studyResourceList=null;
        if(count!=0){
            studyResourceList=studyResourceService.queryStudyResourceListByPageAndCategoryId(curPage,pageSize,categoryId);
        }
        PageHelper<StudyResource> pageHelper=new PageHelper<StudyResource>(count,curPage,pageSize,studyResourceList);
        Map map=new HashMap<String,Object>();
        map.put("pageHelper",pageHelper);
        map.put("categoryList",studyResourceService.queryAllCategory());
        map.put("categoryId",categoryId);
        return new ModelAndView("section/studyResource",map);
    }

    @RequestMapping(value="{studyResourceId}",method = RequestMethod.GET)
    public ModelAndView querystudyResourceDetail(@PathVariable int studyResourceId,HttpSession httpSession){
        StudyResource studyResource=studyResourceService.queryStudyResourceDetail(studyResourceId);
        if(studyResource!=null){
            Map map=new HashMap<String,Object>();
            map.put("studyResource",studyResource);
            map.put("categoryList",studyResourceService.queryAllCategory());

            User user= (User) httpSession.getAttribute("user");
            if(user!=null){
                boolean isCollect=studyResourceService.queryIsCollectByUserIdAndResourceId(studyResourceId,user.getId());
                map.put("isCollect",isCollect);
            }

            return new ModelAndView("section/studyResource_detail",map);
        }else{
            return new ModelAndView("common/not_found","msg","没有找到对应的文章");
        }
    }

    @RequestMapping(method=RequestMethod.POST)
    public String addStudyResource(StudyResource studyResource, HttpSession session){
        User user= (User) session.getAttribute("user");
        studyResource.setUser(user);
        studyResourceService.addStudyResource(studyResource);
        return "redirect:/rest/studyResource/"+studyResource.getId();
    }

    @RequestMapping(method=RequestMethod.PUT)
    @ResponseBody
    public Result editStudyResource(StudyResource studyResource, HttpSession session){
       try{
           User user= (User) session.getAttribute("user");
           StudyResource oldStudyResource=studyResourceService.queryStudyResourceDetail(studyResource.getId());
           StudyResource newStudyResource=studyResource;
           if(oldStudyResource.getUser().getId().equals(user.getId())){
               newStudyResource.setUser(user);
               newStudyResource.setUpdateTime(new Timestamp(System.currentTimeMillis()));
               studyResourceService.editStudyResource(newStudyResource);
               return new Result(newStudyResource.getId(),"修改成功");
           }
           return new Result(-1,"没有修改权限");
       }catch (Exception e){
           return new Result(-1,"修改失败");
       }
    }

    @RequestMapping(value="add",method=RequestMethod.GET)
    public ModelAndView goAddStudyResourcePage(){
        List<StudyResourceCategory> categoryList=studyResourceService.queryAllCategory();
        return new ModelAndView("section/addStudyResource","categoryList",categoryList);
    }

    @RequestMapping(value="edit/{studyResourceId}",method=RequestMethod.GET)
    public ModelAndView goEditStudyResourcePage(@PathVariable int studyResourceId,HttpSession session){
        User user= (User) session.getAttribute("user");
        StudyResource studyResource=studyResourceService.queryStudyResourceDetail(studyResourceId);
        if(studyResource!=null){
            if(!user.getId().equals(studyResource.getUser().getId())){
                return new ModelAndView("common/not_found","msg","没有这篇文章的编辑权限");
            }
            List<StudyResourceCategory> categoryList=studyResourceService.queryAllCategory();
            HashMap map=new HashMap<String,Object>();
            map.put("categoryList",categoryList);
            map.put("studyResource",studyResource);
            return new ModelAndView("section/editStudyResource",map);
        }else{
            return new ModelAndView("common/not_found","msg","没有找到对应的文章");
        }

    }


    @RequestMapping(value="collect/{studyResourceId}",method=RequestMethod.POST)
    @ResponseBody
    public Result addCollect(@PathVariable int studyResourceId,HttpSession session){
       try{
           User user= (User) session.getAttribute("user");
           String userId=user.getId();
           if(studyResourceService.addCollect(studyResourceId,userId)){
               return new Result(200,"添加收藏成功");
           }else{
               return new Result(200,"已经收藏过");
           }

       }catch (Exception e){
            return new Result(500,"添加收藏失败");
       }

    }

    @RequestMapping(value="collect/{studyResourceId}",method=RequestMethod.DELETE)
    @ResponseBody
    public Result cancelCollect(@PathVariable int studyResourceId,HttpSession session){
        try{
            User user= (User) session.getAttribute("user");
            String userId=user.getId();
           if( studyResourceService.cancelCollect(studyResourceId,userId)){
               return new Result(200,"取消收藏成功");
           }else{
               return new Result(200,"没有对应的收藏记录，无法执行取消收藏操作");
           }

        }catch (Exception e){
            return new Result(500,"取消收藏失败");
        }

    }



}
