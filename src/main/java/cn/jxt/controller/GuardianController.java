package cn.jxt.controller;

import cn.jxt.bean.*;
import cn.jxt.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("guardian")
public class GuardianController {
    @Autowired
    private GuardianService guardianService;
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private StudyResourceService studyResourceService;
    @Autowired
    private ShareService shareService;
    @Autowired
    private ReplyService replyService;
    @Autowired
    private MessageService messageService;


    @RequestMapping(value = "info",method = RequestMethod.GET)
    public ModelAndView info(HttpSession session){
        User user= (User) session.getAttribute("user");
        String id=user.getId();
        Guardian guardian=guardianService.queryById(id);
        Teacher teacher=teacherService.queryById(guardian.getStudent().getTeacherId());
        Map map=new HashMap<String,Object>();
        map.put("guardian",guardian);
        map.put("teacher",teacher);
        return new ModelAndView("guardian/info",map);
    }

    @RequestMapping(value = "collect",method = RequestMethod.GET)
    public ModelAndView collection(@RequestParam(required = false) Integer curPage, @RequestParam(required = false)Integer pageSize,HttpSession session){
        User user= (User) session.getAttribute("user");
        String userId=user.getId();
        if(curPage==null){
            curPage=1;
        }
        if(pageSize==null){
            pageSize=10;
        }

        int count=studyResourceService.queryMyCollectCount(userId);
        List<StudyResource> studyResourceList=null;
        if(count!=0){
            studyResourceList=studyResourceService.queryMyCollect(curPage,pageSize,userId);
        }
        PageHelper<StudyResource> pageHelper=new PageHelper<StudyResource>(count,curPage,pageSize,studyResourceList);
        return new ModelAndView("guardian/collect","pageHelper",pageHelper);
    }

    @RequestMapping(value = "share",method = RequestMethod.GET)
    public ModelAndView share(@RequestParam(required = false) Integer curPage, @RequestParam(required = false)Integer pageSize,HttpSession session){
        User user= (User) session.getAttribute("user");
        String userId=user.getId();
        if(curPage==null){
            curPage=1;
        }
        if(pageSize==null){
            pageSize=10;
        }
        int count=shareService.queryMyShareCount(userId);
        List<Share> shareList=null;
        if(count!=0){
            shareList=shareService.queryMyShare(curPage,pageSize,userId);
        }
        PageHelper<Share> pageHelper=new PageHelper<Share>(count,curPage,pageSize,shareList);

        return new ModelAndView("guardian/share","pageHelper",pageHelper);
    }

    @RequestMapping(value = "reply",method = RequestMethod.GET)
    public ModelAndView reply(@RequestParam(required = false) Integer curPage, @RequestParam(required = false)Integer pageSize,HttpSession session){
        User user= (User) session.getAttribute("user");
        String userId=user.getId();
        if(curPage==null){
            curPage=1;
        }
        if(pageSize==null){
            pageSize=10;
        }
        int count=replyService.queryMyReplyCount(userId);
        List<Reply> replyList=null;
        if(count!=0){
            replyList=replyService.queryMyReply(curPage,pageSize,userId);
        }
        PageHelper<Reply> pageHelper=new PageHelper<Reply>(count,curPage,pageSize,replyList);

        return new ModelAndView("guardian/reply","pageHelper",pageHelper);
    }

    @RequestMapping(value = "message",method = RequestMethod.GET)
    public ModelAndView message(@RequestParam(required = false) Integer curPage, @RequestParam(required = false)Integer pageSize,HttpSession session){
        User user= (User) session.getAttribute("user");
        String userId=user.getId();
        if(curPage==null){
            curPage=1;
        }
        if(pageSize==null){
            pageSize=10;
        }
        int count=messageService.queryReceiveMessageCount(userId);
        List<Message> messageList=null;
        if(count!=0){
            messageList=messageService.queryReceiveMessage(curPage,pageSize,userId);
        }
        PageHelper<Message> pageHelper=new PageHelper<Message>(count,curPage,pageSize,messageList);
        return new ModelAndView("guardian/message","pageHelper",pageHelper);
    }


}
