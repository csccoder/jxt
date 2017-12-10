package cn.jxt.controller;

import cn.jxt.bean.Result;
import cn.jxt.bean.User;
import cn.jxt.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping(value = "login", method= RequestMethod.POST)
    @ResponseBody
    public Result login(User user, HttpSession session){
        Result result=null;
        if(user == null||(user.getId()==null||user.getPassword()==null)){
            result =new Result(400,"账号或密码不能为空");
            return result;
        }

        User realUser=userService.queryUserById(user.getId());
        if(realUser!=null&&(realUser.getPassword().equals(user.getPassword()))){
            result = new Result(200,"登录成功");
            realUser.setPassword(null);
            session.setAttribute("user",realUser);
            return result;
        }

        result = new Result(404,"账号或密码错误");
        return result;

    }

    @RequestMapping(value = "logout",method = RequestMethod.GET)
    public String logout(HttpSession session){
        User user= (User) session.getAttribute("user");
        System.out.println("注销："+user);
        if(user!=null){
            session.removeAttribute("user");
        }

        return "redirect:/rest/index";
    }

    @RequestMapping(value="updatePwd",method = RequestMethod.POST)
    public ModelAndView updatePwd(@RequestParam String oldPwd, @RequestParam String newPwd, HttpSession session){
        User user= (User) session.getAttribute("user");
        String viewName=getUpdatePwdViewName(user);
        if(user!=null){
            user=userService.queryUserById(user.getId());
            if(user.getPassword().equals(oldPwd)){
                user.setPassword(newPwd);
                userService.updatePwd(user);
                return new ModelAndView(viewName,"msg","密码修改成功，下次登录请使用新密码");
            }
        }
        return new ModelAndView(viewName,"msg","密码修改失败");

    }

    @RequestMapping(value="updatePwd",method = RequestMethod.GET)
    public ModelAndView goUpdatePwdView(HttpSession session){
        User user= (User) session.getAttribute("user");
        String viewName=getUpdatePwdViewName(user);
        if(user!=null){
            return new ModelAndView(viewName);
        }
        return new ModelAndView("common/not_found","msg","非法操作");

    }

    public String getUpdatePwdViewName(User user){
        String viewName=null;
        if(user.getRole()==1){
            viewName="guardian/updatePwd";
        }else if(user.getRole()==2){
            viewName="teacher/updatePwd";
        }else if(user.getRole()==3){
            viewName="manage/updatePwd";
        }
        return viewName;
    }
}
