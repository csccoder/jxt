package cn.jxt.bean;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class PropertiseBean {
    @Value("${bannerImgSaveLocation}")
    public  String bannerImgSaveLocation;
    @Value("${windowsTomcatContextPathLocation}")
    public String windowsContextPathLocation;
    @Value("${linuxTomcatContextPathLocation}")
    public String linuxContextPathLocation;
}
