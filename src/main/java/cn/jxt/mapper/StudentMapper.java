package cn.jxt.mapper;

import cn.jxt.bean.Student;
import com.github.abel533.mapper.Mapper;

public interface StudentMapper extends Mapper<Student> {
    void deleteByStudentId(int studentId);
}
