package cn.jxt.service.impl;

import cn.jxt.bean.Guardian;
import cn.jxt.bean.User;
import cn.jxt.mapper.GuardianMapper;
import cn.jxt.mapper.UserMapper;
import cn.jxt.service.GuardianService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GuardianServiceImpl implements GuardianService {
    @Autowired
    private GuardianMapper guardianMapper;
    @Autowired
    private UserMapper userMapper;
    @Override
    public Guardian queryById(String id) {
        return guardianMapper.queryById(id);
    }

    @Override
    public void registerGuardian(Guardian guardian) {
        User user;
        synchronized (this){
            user=new User();
            user.setRole(1);
            String lastedId=userMapper.queryLastedUserIdByRole(1);
            user.setId("g"+String.valueOf(Integer.parseInt(lastedId.substring(1))+1));
        }
        //初始密码为手机号码后6位
        user.setPassword(guardian.getPhone().substring(5));
        user.setName(guardian.getName());
        userMapper.insert(user);


        guardian.setId(user.getId());
        guardianMapper.addGuardian(guardian);
    }

    @Override
    public void updateGuardian(Guardian guardian) {
        guardianMapper.updateByPrimaryKeySelective(guardian);
        userMapper.updateByPrimaryKeySelective(guardian);
    }

    @Override
    public List<Guardian> getGuadianListByStudentIds(List<Integer> studentIds) {
        return guardianMapper.getGuadianListByStudentIds(studentIds);
    }
}
