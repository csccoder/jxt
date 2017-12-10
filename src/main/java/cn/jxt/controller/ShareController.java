package cn.jxt.controller;

import cn.jxt.bean.*;
import cn.jxt.service.ReplyService;
import cn.jxt.service.ShareService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("share")
public class ShareController {
    @Autowired
    private ShareService shareService;
    @Autowired
    private ReplyService replyService;
    @RequestMapping(method= RequestMethod.GET)
    public ModelAndView shareView(@RequestParam(required = false) Integer curPage, @RequestParam(required = false)Integer pageSize){
        if(curPage==null){
            curPage=1;
        }
        if(pageSize==null){
            pageSize=10;
        }

        int count=shareService.queryShareCount();
        List<Share> shareList=null;
        if(count!=0){
            shareList=shareService.queryShareListByPage(curPage,pageSize);
        }
        PageHelper<Share> pageHelper=new PageHelper<Share>(count,curPage,pageSize,shareList);
        Map map=new HashMap<String,Object>();
        map.put("pageHelper",pageHelper);
        map.put("categoryList",shareService.queryAllCategory());
        return new ModelAndView("section/share",map);
    }

    @RequestMapping(value = "category/{categoryId}",method=RequestMethod.GET)
    public ModelAndView queryShareByCategoryId(@PathVariable int categoryId,@RequestParam(required = false) Integer curPage, @RequestParam(required = false)Integer pageSize){
        if(curPage==null){
            curPage=1;
        }
        if(pageSize==null){
            pageSize=10;
        }

        int count=shareService.queryShareCountByCategoryId(categoryId);
        List<Share> shareList=null;
        if(count!=0){
            shareList=shareService.queryShareListByPageAndCategoryId(curPage,pageSize,categoryId);
        }
        PageHelper<Share> pageHelper=new PageHelper<Share>(count,curPage,pageSize,shareList);
        Map map=new HashMap<String,Object>();
        map.put("pageHelper",pageHelper);
        map.put("categoryList",shareService.queryAllCategory());
        map.put("categoryId",categoryId);
        return new ModelAndView("section/share",map);
    }

    @RequestMapping(value="{shareId}",method = RequestMethod.GET)
    public ModelAndView queryShareDetail(@PathVariable int shareId){
        Share share=shareService.queryShareDetail(shareId);
        if(share!=null){
            Map map=new HashMap<String,Object>();
            map.put("share",share);
            map.put("categoryList",shareService.queryAllCategory());
            map.put("replyList",replyService.queryReplyListByShareId(shareId));
            return new ModelAndView("section/share_detail",map);
        }else{
            return new ModelAndView("common/not_found");
        }
    }

    @RequestMapping(method=RequestMethod.POST)
    public String addShare(Share share, HttpSession session){
        User user= (User) session.getAttribute("user");
        share.setSharer(user);
        shareService.addShare(share);
        return "redirect:/rest/share/"+share.getId();
    }

    @RequestMapping(value="add",method=RequestMethod.GET)
    public ModelAndView goAddSharePage(){
        List<ShareCategory> categoryList=shareService.queryAllCategory();
        return new ModelAndView("section/addshare","categoryList",categoryList);
    }

    @RequestMapping(value="reply/{shareId}",method =RequestMethod.POST )
    public String addReply(@PathVariable int shareId,String content,HttpSession session){
        User user= (User) session.getAttribute("user");
        String userId=user.getId();
        Reply reply=new Reply();
        reply.setUserId(userId);
        reply.setShareId(shareId);
        reply.setReplyContent(content);
        replyService.addReply(reply);
        return "redirect:/rest/share/"+shareId;

    }
}
