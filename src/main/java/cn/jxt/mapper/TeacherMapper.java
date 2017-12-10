package cn.jxt.mapper;

import cn.jxt.bean.Guardian;
import cn.jxt.bean.Teacher;
import com.github.abel533.mapper.Mapper;

import java.util.List;

public interface TeacherMapper extends Mapper<Teacher> {
    public Teacher queryById(String id);


    List<Teacher> queryAllTeacher();
}
