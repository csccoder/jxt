package cn.jxt.mapper;

import cn.jxt.bean.Guardian;
import com.github.abel533.mapper.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GuardianMapper extends Mapper<Guardian>{
    public Guardian queryById(String id);

    List<Guardian> queryGuardiansByTeacherId(String teacherId);

    void addGuardian(Guardian guardian);

    List<Guardian> getGuadianListByStudentIds(@Param(value="studentIds") List<Integer> studentIds);
}
