package cn.jxt.util;

import cn.jxt.bean.PropertiseBean;
import org.testng.annotations.Test;

import javax.servlet.ServletContext;
import java.io.File;

/**
 * 路径工具类
 */
public class PathUtils {

    public static String getTomcatContextWEBINFsPath(ServletContext servletContext){
        return servletContext.getRealPath("/");
    };

    public static String getRealContextPathWEBINFPath(PropertiseBean propertiseBean){
        String osName=System.getProperty("os.name").toLowerCase();
        if(osName.indexOf("windows")>=0){
            return propertiseBean.windowsContextPathLocation;
        }else{
            return propertiseBean.linuxContextPathLocation;
        }
    }


}
