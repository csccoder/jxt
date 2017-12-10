package cn.jxt.Interceptor;

import cn.jxt.bean.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;


public class RoleVerifyInterceptor implements HandlerInterceptor {
    private static Map<String,Integer> map=new HashMap<String,Integer>();
    static {
        map.put("guardian",1);
        map.put("teacher",2);
        map.put("manage",3);
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session=request.getSession(false);
        if(session!=null){
            User user= (User) session.getAttribute("user");
            if(user!=null){
                int roleId=user.getRole();

                boolean flag=false;
                String uri=request.getRequestURI();
                for(Map.Entry<String,Integer> entry:map.entrySet()){
                    if(uri.contains(entry.getKey())){
                        flag=true;
                        if(entry.getValue()==roleId){
                            return true;
                        }else{
                            response.sendRedirect(request.getContextPath());
                            return false;
                        }
                    }
                }
                return true;
            }
        }
        response.sendRedirect("index.jsp");
        return false;


    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
