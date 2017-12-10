package cn.jxt.service;

import cn.jxt.bean.User;


public interface UserService {
    public User queryUserById(String id);

    void updatePwd(User user);
}
