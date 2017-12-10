package cn.jxt.service;

import cn.jxt.bean.Guardian;
import cn.jxt.bean.Student;
import cn.jxt.bean.Teacher;

import java.util.List;

public interface TeacherService {
    public Teacher queryById(String id);

    List<Guardian> queryGuardiansByTeacherId(String userId);

    List<Student> queryTeachedStudentList(String userId);

    List<Teacher> queryAllTeacher();

    void registerTeacher(Teacher teacher);

    void updateTeacher(Teacher teacher);

    void deleteTeacher(String teacherId);
}
