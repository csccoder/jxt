package cn.jxt.controller;

import cn.jxt.bean.*;
import cn.jxt.service.BannerService;
import cn.jxt.service.NoticeService;
import cn.jxt.service.ShareService;
import cn.jxt.service.StudyResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class PageController {
    @Autowired
    private NoticeService noticeService;
    @Autowired
    private BannerService bannerService;
    @Autowired
    private ShareService shareService;
    @Autowired
    private StudyResourceService studyResourceService;

    @RequestMapping(value = "index",method= RequestMethod.GET)
    public ModelAndView index(){
        //加载最新的公告
        List<Notice> noticeList= noticeService.queryNoticeByMaxSize(3);
        //加载最新的banner
        List<Banner> bannerList=bannerService.queryBannerByMaxSize(3);
        //加载最热的话题
        List<Share> shareList=shareService.queryHotShareByMaxSize(8);
        //加载最新学科资料
        List<StudyResource> studyResourceList=studyResourceService.queryRecentlyStudyResource(12);

        Map model = new HashMap<String,Object>();
        model.put("noticeList",noticeList);
        model.put("bannerList",bannerList);
        model.put("shareList",shareList);
        model.put("studyResourceList",studyResourceList);
        return new ModelAndView("index",model);
    }

    @RequestMapping(value = "header",method= RequestMethod.GET)
    public ModelAndView header(){
        List<StudyResourceCategory> studyResourceCategoryList=studyResourceService.queryAllCategory();
        return new ModelAndView("common/header","studyResourceCategoryList",studyResourceCategoryList);
    }

    @RequestMapping(value = "footer",method= RequestMethod.GET)
    public ModelAndView footer(){
        return new ModelAndView("common/footer");
    }
}
