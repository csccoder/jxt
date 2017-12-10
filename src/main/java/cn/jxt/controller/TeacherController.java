package cn.jxt.controller;

import cn.jxt.bean.*;
import cn.jxt.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/teacher")
public class TeacherController {
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private StudentService studentService;
    @Autowired
    private GuardianService guardianService;
    @Autowired
    private ShareService shareService;
    @Autowired
    private ReplyService replyService;
    @Autowired
    private MessageService messageService;


    @RequestMapping(value="info",method= RequestMethod.GET)
    public ModelAndView info(HttpSession session){
        User user=(User)session.getAttribute("user");
        String userId=user.getId();
        Teacher teacher=teacherService.queryById(userId);
        Map map=new HashMap<String,Object>();
        map.put("teacher",teacher);
        return new ModelAndView("teacher/info",map);
    }

    @RequestMapping(value = "class",method=RequestMethod.GET)
    public String classView(){
        return "teacher/class";
    }

    @RequestMapping(value ="guardian",method = RequestMethod.GET)
    @ResponseBody
    public List<Guardian> guardianList(HttpSession session){
        User user=(User)session.getAttribute("user");
        String userId=user.getId();

        List<Guardian> guardianList=teacherService.queryGuardiansByTeacherId(userId);
        return guardianList;
    }

    @RequestMapping(value="student",method = RequestMethod.PUT)
    @ResponseBody
    public Result updateStudentInfo(Student student){
        Result result=null;
        try{
            studentService.updateStudent(student);
            result=new Result(200,"修改成功");
        }catch (Exception e){
            result=new Result(500,"修改失败");
        }
        return result;
    }

    @RequestMapping(value="student",method = RequestMethod.POST)
    @ResponseBody
    public Result addStudentInfo(Student student,HttpSession session){
        Result result=null;
        try{
            User user= (User) session.getAttribute("user");
            String teacherId=user.getId();
            student.setTeacherId(teacherId);
            studentService.addStudent(student);
            result=new Result(student.getId(),"注册成功");
        }catch (Exception e){
            result=new Result(500,"注册失败");
        }
        return result;
    }

    @RequestMapping(value="student",method = RequestMethod.DELETE)
    @ResponseBody
    public Result deleteStudent(int studentId,HttpSession session){
        Result result=null;
        try{
            studentService.deleteStudent(studentId);
            result=new Result(200,"删除成功");
        }catch (Exception e){
            result=new Result(500,"删除失败");
        }
        return result;
    }

    @RequestMapping(value="guardian",method = RequestMethod.POST)
    @ResponseBody
    public Result addGuardianInfo(Guardian guardian){
        Result result=null;
        try{
            guardianService.registerGuardian(guardian);
            result=new Result(200,"注册成功");
        }catch (Exception e){
            result=new Result(500,"注册失败");
        }
        return result;
    }
    @RequestMapping(value="guardian",method = RequestMethod.PUT)
    @ResponseBody
    public Result updateGuardianInfo(Guardian guardian){
        Result result=null;
        try{
            guardianService.updateGuardian(guardian);
            result=new Result(200,"修改成功");
        }catch (Exception e){
            e.printStackTrace();
            result=new Result(500,"修改失败");
        }
        return result;
    }

    @RequestMapping(value="message",method = RequestMethod.GET)
    public ModelAndView messageView(HttpSession session){
        User user= (User) session.getAttribute("user");
        String teacherId=user.getId();
        List<Student> studentList=teacherService.queryTeachedStudentList(teacherId);
        //TODO 要排除掉可能父母不存在的可能，即查询的时候要关联查询监护人表
        Map map=new HashMap<String,Object>();
        map.put("studentList",studentList);
        return new ModelAndView("teacher/message",map);
    }

    @RequestMapping(value="message",method =RequestMethod.POST)
    public ModelAndView sendMessage(@RequestParam("studentIds") ArrayList<Integer> studentIds, @RequestPart(name="excelFile") MultipartFile excelFile, @RequestParam String templateCode, @RequestParam String content, HttpSession session){

            User user= (User) session.getAttribute("user");
            String teacherId=user.getId();
            List<Student> studentList=teacherService.queryTeachedStudentList(teacherId);
            //TODO 要排除掉可能父母不存在的可能，即查询的时候要关联查询监护人表
            Map map=new HashMap<String,Object>();
            map.put("studentList",studentList);
        try{
            if(user==null||user.getRole()!=2){
                map.put("msg","非法操作");
            }
            else if(studentIds==null||studentIds.size()==0){
                map.put("msg","提交的信息不完全，请补全信息再操作！");
            }else{
                InputStream inputstream=null;
                if(excelFile.getSize()>0){
                    inputstream=excelFile.getInputStream();
                }
                messageService.sendMessage(user.getId(),studentIds,inputstream,templateCode,content);
                map.put("msg","消息发送成功！");
            }
        }catch (Exception e){
            map.put("msg","消息发送失败！");
        }
        return new ModelAndView("teacher/message",map);
    }

    @RequestMapping(value = "share",method = RequestMethod.GET)
    public ModelAndView share(@RequestParam(required = false) Integer curPage, @RequestParam(required = false)Integer pageSize, HttpSession session){
        User user= (User) session.getAttribute("user");
        String userId=user.getId();
        if(curPage==null){
            curPage=1;
        }
        if(pageSize==null){
            pageSize=10;
        }
        int count=shareService.queryMyShareCount(userId);
        List<Share> shareList=null;
        if(count!=0){
            shareList=shareService.queryMyShare(curPage,pageSize,userId);
        }
        PageHelper<Share> pageHelper=new PageHelper<Share>(count,curPage,pageSize,shareList);
        return new ModelAndView("teacher/share","pageHelper",pageHelper);
    }

    @RequestMapping(value = "reply",method = RequestMethod.GET)
    public ModelAndView reply(@RequestParam(required = false) Integer curPage, @RequestParam(required = false)Integer pageSize,HttpSession session){
        User user= (User) session.getAttribute("user");
        String userId=user.getId();
        if(curPage==null){
            curPage=1;
        }
        if(pageSize==null){
            pageSize=10;
        }
        int count=replyService.queryMyReplyCount(userId);
        List<Reply> replyList=null;
        if(count!=0){
            replyList=replyService.queryMyReply(curPage,pageSize,userId);
        }
        PageHelper<Reply> pageHelper=new PageHelper<Reply>(count,curPage,pageSize,replyList);
        return new ModelAndView("teacher/reply","pageHelper",pageHelper);
    }
}
