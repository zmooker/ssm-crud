package com.zmk.test;

import com.zmk.bean.Employee;
import com.zmk.bean.EmployeeExample;
import com.zmk.dao.DepartmentMapper;
import com.zmk.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 *测试dao层的工作
 * 推荐spring测试项目可以使用Spring的单元测试，可以自动注入我们需要的组件
 * 1.导入springtest模块儿
 * 2.@ContextConfiguration指定spring配置文件的位置
 * 3.直接@autowired要是用的组件即可
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    public void testCRUD(){

        EmployeeExample employee=new EmployeeExample();
        EmployeeExample.Criteria criteria = employee.createCriteria();
        criteria.andDIdEqualTo(1);
        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        System.out.println(employees);


    }
}
