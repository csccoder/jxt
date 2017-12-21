package cn.jxt.bean;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class PropertiseBean {
    @Value("${linuxBannerImgSaveLocation}")
    public  String linuxBannerImgSaveLocation;
    @Value("${windowsBannerImgSaveLocation}")
    public String windowsBannerImgSaveLocation;

}
