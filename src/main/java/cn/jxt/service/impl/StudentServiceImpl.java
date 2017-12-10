package cn.jxt.service.impl;

import cn.jxt.bean.Guardian;
import cn.jxt.bean.Student;
import cn.jxt.bean.Teacher;
import cn.jxt.bean.User;
import cn.jxt.mapper.GuardianMapper;
import cn.jxt.mapper.StudentMapper;
import cn.jxt.mapper.TeacherMapper;
import cn.jxt.mapper.UserMapper;
import cn.jxt.service.StudentService;
import com.github.abel533.entity.Example;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentServiceImpl implements StudentService {
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private TeacherMapper teacherMapper;



    @Override
    public void updateStudent(Student student) {
        studentMapper.updateByPrimaryKeySelective(student);
    }

    @Override
    public void addStudent(Student student) {
        Teacher teacher=teacherMapper.queryById(student.getTeacherId());
        student.setSchool(teacher.getSchool());
        student.setGrade(teacher.getGrade());
        student.setClassname(teacher.getClassname());

        studentMapper.insert(student);
    }

    @Override
    public void deleteStudent(int studentId) {
        studentMapper.deleteByStudentId(studentId);
    }
}
