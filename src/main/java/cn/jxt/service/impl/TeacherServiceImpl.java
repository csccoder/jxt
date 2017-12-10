package cn.jxt.service.impl;

import cn.jxt.bean.Guardian;
import cn.jxt.bean.Student;
import cn.jxt.bean.Teacher;
import cn.jxt.bean.User;
import cn.jxt.mapper.GuardianMapper;
import cn.jxt.mapper.StudentMapper;
import cn.jxt.mapper.TeacherMapper;
import cn.jxt.mapper.UserMapper;
import cn.jxt.service.TeacherService;
import com.github.abel533.entity.Example;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeacherServiceImpl implements TeacherService {
    @Autowired
    private TeacherMapper teacherMapper;
    @Autowired
    private GuardianMapper guardianMapper;
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private UserMapper userMapper;

    @Override
    public Teacher queryById(String id) {
        return teacherMapper.queryById(id);
    }

    @Override
    public List<Guardian> queryGuardiansByTeacherId(String userId) {
        return guardianMapper.queryGuardiansByTeacherId(userId);
    }

    @Override
    public List<Student> queryTeachedStudentList(String teacherId) {
        Student student=new Student();

        student.setTeacherId(teacherId);
        List<Student> studentList=studentMapper.select(student);
        return studentList;
    }

    @Override
    public List<Teacher> queryAllTeacher() {
        return teacherMapper.queryAllTeacher();
    }

    @Override
    public void registerTeacher(Teacher teacher) {
        User user=new User();
        user.setRole(2);
        synchronized (this){
            String lastedId=userMapper.queryLastedUserIdByRole(2);
            System.out.println("lastedId:"+lastedId);
            System.out.println("newId:"+String.valueOf(Integer.parseInt(lastedId.substring(1))+1));
            user.setId("t"+String.valueOf(Integer.parseInt(lastedId.substring(1))+1));

        }
            user.setName(teacher.getName());
            user.setPassword(teacher.getPhone().substring(5));
            userMapper.insert(user);

        teacher.setId(user.getId());
        teacherMapper.insertSelective(teacher);
    }

    @Override
    public void updateTeacher(Teacher teacher) {
        userMapper.updateByPrimaryKeySelective(teacher);
        teacherMapper.updateByPrimaryKeySelective(teacher);
    }

    @Override
    public void deleteTeacher(String teacherId) {
        userMapper.deleteByPrimaryKey(teacherId);
    }
}
