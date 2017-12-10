package cn.jxt.controller;

import cn.jxt.bean.*;
import cn.jxt.service.*;
import cn.jxt.util.PathUtils;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("manage")
public class AdminController {
    @Autowired
    private BannerService bannerService;
    @Autowired
    private NoticeService noticeService;
    @Autowired
    private UserService userService;
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private PropertiseBean propertiseBean;
    @Autowired
    private ShareService shareService;
    @Autowired
    private ReplyService replyService;

    @RequestMapping(method = RequestMethod.GET)
    public String manageView() {
        return "redirect:/rest/manage/notice";
    }

    @RequestMapping(value = "banner", method = RequestMethod.GET)
    public ModelAndView bannerView() {
        return new ModelAndView("manage/banner");
    }

    @RequestMapping(value = "bannerList", method = RequestMethod.GET)
    @ResponseBody
    public List<Banner> bannerList() {
        return bannerService.queryAllBanner();
    }

    @RequestMapping("path")
    public void path(HttpServletRequest request) {
        ServletContext servletContext = request.getSession().getServletContext();

        try {
            System.out.println("");
            System.out.println(servletContext.getResource("."));
            System.out.println(servletContext.getResource(".").getPath());
            System.out.println(servletContext.getResource("/").getPath());
            System.out.println(new File(".").getAbsolutePath());
            System.out.println(new File("/").getAbsolutePath());
            return;
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "addBanner", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView addBanner(Banner banner, @RequestPart(name = "img") MultipartFile multipartFile, HttpServletRequest request) {
        Result result = null;
        try {
            //生成新的文件名，防止文件名冲突
            String imgFileName = "banner_" + UUID.randomUUID().toString();
            //获取文件后缀
            String suffix = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf('.'));
            //获取输出流
            //部署的tomcat容器中上传图片文件夹的绝对地址

            String realPathAtTomcat= PathUtils.getTomcatContextWEBINFsPath(request.getSession().getServletContext());
            String realPathAtJvm= PathUtils.getRealContextPathWEBINFPath(propertiseBean);
            String location = propertiseBean.bannerImgSaveLocation + imgFileName + suffix;
            String imgFileAtTomcat=realPathAtTomcat+location;
            String imgFileAtJvm=realPathAtJvm+location;
            Logger.getLogger(this.getClass()).warn("==================================");
            Logger.getLogger(this.getClass()).warn("pathAtTomcat:"+imgFileAtTomcat);
            Logger.getLogger(this.getClass()).warn("pathAtJvm:"+imgFileAtJvm);
            if(!imgFileAtTomcat.equals(imgFileAtJvm)){
                String path[]={imgFileAtTomcat,imgFileAtJvm};
                saveFileToSpecialPath(multipartFile.getInputStream(),path);
            }else{
                String path[]={imgFileAtTomcat};
                saveFileToSpecialPath(multipartFile.getInputStream(),path);
            }

            banner.setLocation(location);
            bannerService.addBanner(banner);
            return new ModelAndView("redirect:banner");
        } catch (Exception e) {
            return new ModelAndView("common/not_found","msg","banner添加失败");
        }
    }

    @RequestMapping(value = "updateBanner", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView updateBanner(Banner banner, @RequestPart(name = "img") MultipartFile multipartFile,HttpServletRequest request) {
        Result result = null;
        try {
            //生成新的文件名，防止文件名冲突
            String imgFileName = "banner_" + UUID.randomUUID().toString();
            //获取文件后缀
            String suffix = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf('.'));
            //获取输出流
            //部署的tomcat容器中上传图片文件夹的绝对地址

            String realPathAtTomcat= PathUtils.getTomcatContextWEBINFsPath(request.getSession().getServletContext());
            String realPathAtJvm= PathUtils.getRealContextPathWEBINFPath(propertiseBean);
            String location = propertiseBean.bannerImgSaveLocation + imgFileName + suffix;
            String imgFileAtTomcat=realPathAtTomcat+location;
            String imgFileAtJvm=realPathAtJvm+location;
            Logger.getLogger(this.getClass()).warn("==================================");
            Logger.getLogger(this.getClass()).warn("pathAtTomcat:"+imgFileAtTomcat);
            Logger.getLogger(this.getClass()).warn("pathAtJvm:"+imgFileAtJvm);
            if(!imgFileAtTomcat.equals(imgFileAtJvm)){
                String path[]={imgFileAtTomcat,imgFileAtJvm};
                saveFileToSpecialPath(multipartFile.getInputStream(),path);
            }else{
                String path[]={imgFileAtTomcat};
                saveFileToSpecialPath(multipartFile.getInputStream(),path);
            }
            banner.setLocation(location);
            bannerService.updateBanner(banner);
            return new ModelAndView("redirect:banner");
        } catch (Exception e) {
            return new ModelAndView("common/not_found","msg","banner修改失败");
        }
    }

    public void saveFileToSpecialPath(InputStream stream, String[] path ) throws IOException {

        for(int i=0;i<path.length;i++){
            FileOutputStream fileOutputStream=new FileOutputStream(path[i]);
            IOUtils.copy(stream,fileOutputStream);
            fileOutputStream.close();
        }
        stream.close();
    }


    @RequestMapping(value = "banner", method = RequestMethod.DELETE)
    @ResponseBody
    public Result deleteBanner(int bannerId) {
        Result result = null;
        try {
            bannerService.deleteBanner(bannerId);
            return new Result(200, "删除成功");
        } catch (Exception e) {
            return new Result(500, "删除失败");
        }
    }

    @RequestMapping(value = "notice", method = RequestMethod.GET)
    public ModelAndView noticeView() {
        return new ModelAndView("manage/notice");
    }

    @RequestMapping(value = "noticeList", method = RequestMethod.GET)
    @ResponseBody
    public List<Notice> noticeList() {
        return noticeService.queryAllNotice();
    }

    @RequestMapping(value = "notice", method = RequestMethod.POST)
    @ResponseBody
    public Result addNotice(Notice notice) {
        Result result = null;
        try {
            noticeService.addNotice(notice);
            return new Result(200, "新增成功");
        } catch (Exception e) {
            return new Result(500, "新增失败");
        }
    }

    @RequestMapping(value = "notice", method = RequestMethod.PUT)
    @ResponseBody
    public Result updateNotice(Notice notice) {
        Result result = null;
        try {
            noticeService.updateNotice(notice);
            return new Result(200, "修改成功");
        } catch (Exception e) {
            return new Result(500, "修改失败");
        }
    }

    @RequestMapping(value = "notice", method = RequestMethod.DELETE)
    @ResponseBody
    public Result deleteNotice(int noticeId) {
        Result result = null;
        try {
            noticeService.deleteNotice(noticeId);
            return new Result(200, "删除成功");
        } catch (Exception e) {
            return new Result(500, "删除失败");
        }
    }


    @RequestMapping(value = "register", method = RequestMethod.GET)
    public ModelAndView registerView() {
        return new ModelAndView("manage/register");
    }

    @RequestMapping(value = "registerList", method = RequestMethod.GET)
    @ResponseBody
    public List<Teacher> teacherList() {
        return teacherService.queryAllTeacher();
    }

    @RequestMapping(value = "register", method = RequestMethod.POST)
    @ResponseBody
    public Result registerTeacher(Teacher teacher) {
        try {
            teacherService.registerTeacher(teacher);
            return new Result(200, "注册成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(500, "注册失败");
        }
    }

    @RequestMapping(value = "register", method = RequestMethod.PUT)
    @ResponseBody
    public Result updateTeacher(Teacher teacher) {
        try {
            teacherService.updateTeacher(teacher);
            return new Result(200, "修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(500, "修改失败");
        }
    }

    @RequestMapping(value = "register", method = RequestMethod.DELETE)
    @ResponseBody
    public Result deleteTeacher(String teacherId) {
        try {
            teacherService.deleteTeacher(teacherId);
            return new Result(200, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(500, "删除失败");
        }
    }

    @RequestMapping(value = "share", method = RequestMethod.GET)
    public ModelAndView share(@RequestParam(required = false) Integer curPage, @RequestParam(required = false) Integer pageSize, HttpSession session) {
        User user = (User) session.getAttribute("user");
        String userId = user.getId();
        if (curPage == null) {
            curPage = 1;
        }
        if (pageSize == null) {
            pageSize = 10;
        }
        int count = shareService.queryMyShareCount(userId);
        List<Share> shareList = null;
        if (count != 0) {
            shareList = shareService.queryMyShare(curPage, pageSize, userId);
        }
        PageHelper<Share> pageHelper = new PageHelper<Share>(count, curPage, pageSize, shareList);

        return new ModelAndView("manage/share", "pageHelper", pageHelper);
    }

    @RequestMapping(value = "reply", method = RequestMethod.GET)
    public ModelAndView reply(@RequestParam(required = false) Integer curPage, @RequestParam(required = false) Integer pageSize, HttpSession session) {
        User user = (User) session.getAttribute("user");
        String userId = user.getId();
        if (curPage == null) {
            curPage = 1;
        }
        if (pageSize == null) {
            pageSize = 10;
        }
        int count = replyService.queryMyReplyCount(userId);
        List<Reply> replyList = null;
        if (count != 0) {
            replyList = replyService.queryMyReply(curPage, pageSize, userId);
        }
        PageHelper<Reply> pageHelper = new PageHelper<Reply>(count, curPage, pageSize, replyList);

        return new ModelAndView("manage/reply", "pageHelper", pageHelper);
    }

}
