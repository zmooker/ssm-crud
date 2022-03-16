package com.zmk.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zmk.bean.Employee;
import com.zmk.bean.Msg;
import com.zmk.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*URI:
/emp/{id} GET查询员工
/emp   POST保存员工
/emp/{id}  PUT 修改员工
/emp/{id}  DELETE 删除员工
* */
@Controller

public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 单个批量二合一
     * 批量删除：1-2-3
     * 单个删除：1
     * @param
     * @return
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids")String ids){
        //批量删除
        if(ids.contains("-")){
            List<Integer> del_ids=new ArrayList<>();
            String[] str_ids=ids.split("-");
            //组装id的集合
            for (String string : str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }else{//单个删除
            int id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }

        return Msg.success();
    }

    /**如果直接发送ajax=put形式的请求封装数据
     *
     * 员工更新方法
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 查询员工
     * @param id
     * @return
     */
    @RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    //(@PathVariable("id")注解表示从路径中取出id的值
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee=employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    @ResponseBody//返回json数据
    @RequestMapping("/checkUser")
    public Msg checkUser(@RequestParam("empName")String empName){
        //先判断用户名是否是合法的表达式；
        String regx="(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        boolean matches = empName.matches(regx);
        if(!matches){
            return Msg.fail().add("va_msg","用户名必须是6-16位数字和字母的组合或者2-5个汉字");
        }
        //数据库重复校验
        boolean b=employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg", "用户名重复！");
        }
    }

    /**
     * 员工保存
     * 1.支持JSR303校验
     * 2.导入Hibernate-Validator这个依赖
     * @param employee
     * @return
     */
    @RequestMapping(value ="/emp",method= RequestMethod.POST)//员工保存
    @ResponseBody
    //校验加上@Valid注解 result表示校验结果
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示失败的错误信息
            Map<String,Object> map=new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误的信息:"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFieldsMap",map);
        }else{
            //校验成功
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }


    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue = "1")Integer pn, Model model){
        //引入PageHelper插件
        //在查询前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的查询就是一个分页查询
        List<Employee> emps=employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以
        PageInfo page=new PageInfo(emps,5);//5代表你要连续显示的页数
        return Msg.success().add("pageInfo", page);
    }

//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value="pn",defaultValue = "1")Integer pn, Model model){
        //引入PageHelper插件
        //在查询前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的查询就是一个分页查询
        List<Employee> emps=employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以
        PageInfo page=new PageInfo(emps,5);//5代表你要连续显示的页数
        model.addAttribute("pageInfo",page);
        return "list";
    }
}
