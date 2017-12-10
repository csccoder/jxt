import cn.jxt.bean.User;
import cn.jxt.mapper.UserMapper;
import cn.jxt.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/application*.xml"})
public class MybatisTest {

    @Resource
    UserService userService;
    @Autowired
    UserMapper userMapper;
    @Test
    public void test(){
       /* ClassPathXmlApplicationContext applicationContext=new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml","classpath:spring/applicationContext-mybatis.xml","classpath:spring/applicationContext-transaction.xml");
        UserService userService= (UserService) applicationContext.getBean("userService");*/
        User user=userService.queryUserById("1000");
        System.out.println(user);
        System.out.println(userMapper.selectByPrimaryKey("1000"));
    }


}
