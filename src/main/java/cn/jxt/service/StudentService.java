package cn.jxt.service;

import cn.jxt.bean.Student;

public interface StudentService {
     void updateStudent(Student student);

    void addStudent(Student student);

    void deleteStudent(int studentId);
}
