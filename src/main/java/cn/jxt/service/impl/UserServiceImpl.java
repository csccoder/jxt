package cn.jxt.service.impl;

import cn.jxt.bean.User;
import cn.jxt.mapper.UserMapper;
import cn.jxt.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    public User queryUserById(String id){
        return userMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updatePwd(User user) {
        user.setName(null);
        user.setRole(null);
        userMapper.updateByPrimaryKeySelective(user);
    }
}
