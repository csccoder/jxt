package cn.jxt.Interceptor;

import cn.jxt.bean.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class LoginInterceptor implements HandlerInterceptor{
    private static List<String> list=new ArrayList<String>();
    static{
        list.add("manage");
        list.add("guardian");
        list.add("teacher");
        list.add("share/add");
        list.add("share/reply");
        list.add("studyResource/add");
        list.add("studyResource/collect");
        list.add("user/logout");
        list.add("user/updatePwd");


    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri=request.getRequestURI();
        boolean flag=false;
        for(String str:list){
            if(uri.contains(str)){
                flag=true;
            }
        }

        if(!flag){
            return true;
        }else{
            HttpSession session=request.getSession(false);
            if(session!=null){
                User user= (User) session.getAttribute("user");
                if(user!=null){
                    return true;
                }
            }
        }
        response.sendRedirect(request.getContextPath());
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
