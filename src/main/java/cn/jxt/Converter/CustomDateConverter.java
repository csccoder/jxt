package cn.jxt.Converter;

import org.springframework.core.convert.converter.Converter;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CustomDateConverter implements Converter<String, Date> {

    @Override
    public Date convert(String s) {
        if(s==null||s.equals("")){
            return null;
        }
        DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try{
            return dateFormat.parse(s);
        }catch (Exception e){
            dateFormat=new SimpleDateFormat("yyyy-MM-dd");
            try {
                return dateFormat.parse(s);
            } catch (ParseException e1) {
                return null;
            }
        }
    }
}
