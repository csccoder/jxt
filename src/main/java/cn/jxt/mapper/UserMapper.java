package cn.jxt.mapper;

import cn.jxt.bean.User;
import com.github.abel533.mapper.Mapper;

public interface UserMapper extends Mapper<User> {
    String queryLastedUserIdByRole(int roleId);
}
