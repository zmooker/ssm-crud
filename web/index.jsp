<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: MENGKUN
  Date: 2022/1/19
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<html>
<head>
    <title>员工列表</title>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" checked="checked" value="M"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->
                            <select name="dId" class="form-control" id="dept_update_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" checked="checked" value="M"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->
                            <select name="dId" class="form-control" id="dept_add_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!--搭建页面-->
<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all">删除</button>
        </div>
    </div>
    <!--表格信息-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                  <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#id</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--分页信息-->
    <div class="row">
        <!--分页信息-->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!--分页条信息-->
        <div class="col-md-6" id="page_nav_area">

        </div>

    </div>
</div>
<script type="text/javascript">
    var toatlRecord,currentPage;
    //1页面加载完成之后，直接发送一个ajax请求，取到分页数据
    $(function(){
        //一进来就去首页
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+ pn,
            type:"get",
            success:function(result){
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页数据
                build_page_info(result);
                //3.解析并显示分页条
                build_page_nav(result);
            }
        });
    }
    //解析员工数据
    function build_emps_table(result) {
        //清空table表格
        $("#emps_table tbody").empty();
        var emps=result.extend.pageInfo.list;
        $.each(emps,function(index,item){
            var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd=$("<td></td>").append(item.empName);
            var genderTd=$("<td></td>").append(item.gender=='M'?'男':'女');
            var emailTd=$("<td></td>").append(item.email);
            var deptNameTd=$("<td></td>").append(item.department.deptName);
            //为编辑按钮添加一个自定义的属性，来表示当前员工的id
            var editBtn=$("<button></button>").addClass("btn btn-info btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            editBtn.attr("edit-id",item.empId);
            var delBtn=$("<button></button>").addClass("btn btn-warning btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash " )).append("删除");
            delBtn.attr("del-id",item.empId);
            var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完之后还是会返回之前的元素
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd)
                .append(emailTd).append(deptNameTd)
                .append(btnTd).appendTo("#emps_table tbody");
        })
    }
    //解析分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页," +
            "总共有"+result.extend.pageInfo.pages+"页," +
            "总共有条"+result.extend.pageInfo.total+"记录");
        toatlRecord =result.extend.pageInfo.total;
        currentPage=result.extend.pageInfo.pageNum;
    }
    //解析分页条
    function build_page_nav(result){
        //清空分页条信息
        $("#page_nav_area").empty();

        //Bootstrap中的写法，导航条中的信息都要写在ul变量中
        var ul = $("<ul></ul>").addClass("pagination");

        //首页
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href",""));

        //前一页
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        //如果当前遍历的页码是首页(没有前一页)，让首页和上一页不可点击
        if(result.extend.pageInfo.hasPreviousPage == false){
            //disabled是Bootstrap中的写法
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else{
            //为首页和前一页添加点击翻页的事件
            firstPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum -1);
            });
        }

        //后一页
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));

        //末页
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

        //如果当前遍历的页码是末页(没有下一页)，让末页和下一页不可点击
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            //为下一页和末页添加点击翻页的事件
            nextPageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum +1);
            });
            lastPageLi.click(function(){
                to_page(result.extend.pageInfo.pages);
            });
        }

        //导航条中添加首页和前一页
        ul.append(firstPageLi).append(prePageLi);

        //遍历1，2，3之类的页码
        $.each(result.extend.pageInfo.navigatepageNums, function(index,item){

            //numLi / item表示遍历到的1，2，3之类的页码
            var numLi = $("<li></li>").append($("<a></a>").append(item));

            //如果当前遍历的页码就是当前的页码，让其高亮显示
            if(result.extend.pageInfo.pageNum == item){
                //active是Bootstrap中的写法
                numLi.addClass("active");
            }

            //单击事件，跳转到对应页面
            numLi.click(function(){
                to_page(item);
            });

            //向导航条中添加1，2，3之类的页码
            ul.append(numLi);
        });

        //导航条中添加下一页和末页
        ul.append(nextPageLi).append(lastPageLi);

        //把ul导航条添加到导航条在页面中的位置
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

        //重置表单所有内容
        function reset_form(ele){
        //清空表单内容
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        //清空辅助信息
        $(ele).find(".help-block").text("");
        }

        //点击新增弹出按钮模态框
        $("#emp_add_modal_btn").click(function(){
            //清除表单数据
            reset_form("#empAddModal form");
            // $("#empAddModal form")[0].reset();//先把jquery对象转为dom对象才有reset方法，重置
            //发送ajax请求，查出部门信息，显示在下拉列表中
              getDepts("#empAddModal select");
            //弹出模态框
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });

    //查出所有的部门信息，显示在下拉列表中
    function getDepts(ele) {
        //清空之前的下拉列表
        $(ele).empty();
        $.ajax({
           url:"${APP_PATH}/depts",
           type: "get",
           success:function(result){
              //显示部门信息在下拉列表中
               $.each(result.extend.depts,function(){
                   var optionEle =$("<option></option>").append(this.deptName).attr("value",this.deptId);
                   optionEle.appendTo(ele);

               })
           }
        });
    }
   //校验表单数据
    function validate_add_form(){
        //1.拿到要校验的数据,使用正则表达式进行校验
        var empName= $("#empName_add_input").val();
        var regName=/(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
          // alert("用户名可以是2-5位中文或者3-16位英文和数字的组合");
            //应该清空之前的class内容
            show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者3-16位英文和数字的组合");
            // $("#empName_add_input").parent().addClass("has-error");
            // $("#empName_add_input").next("span").text("用户名可以是2-5位中文或者3-16位英文和数字的组合");
          return false;
        }else{
            show_validate_msg("#empName_add_input","success","");
            // $("#empName_add_input").parent().addClass("has-success");
            // $("#empName_add_input").next("span").text("");
        }
        //2.校验邮箱的值
        var email=$("#email_add_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            // alert("邮箱格式不正确！");
            show_validate_msg("#email_add_input","error","邮箱格式不正确!")
            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("邮箱格式不正确！");
            return false;
        }else{
            show_validate_msg("#email_add_input","success","")
            // $("#email_add_input").parent().addClass("has-success");
            // $("#email_add_input").next("span").text("");
        }
        return true;
    }
    //抽取校验成功和失败的方法
    function show_validate_msg(ele,status,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);

        }else if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //校验用户名是否可用
    $("#empName_add_input").change(function(){
       //发送ajax请求校验用户名是否可用
        var empName=this.value;
        $.ajax({
           url:"${APP_PATH}/checkUser",
           data:"empName="+empName,
           type:"POST",
           success:function(result){
               if(result.code==100){
                   show_validate_msg("#empName_add_input","success","用户名可用!");
                   $("#emp_save_btn").attr("ajax-va","success");
               }else{
                   show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                   $("#emp_save_btn").attr("ajax-va","error");
               }
           }
        });
    });
    //点击保存，保存员工
    $("#emp_save_btn").click(function(){
        //1.模态框中填写的表单数据提交给服务器进行保存
        //1.先进行数据校验，再保存
        if (!validate_add_form()){
          return false;
        };
        //1.判断之前的ajax用户名校验是否成功了
        if($(this).attr("ajax-va")=="error"){
            return false;
        }
        //2.发送ajax请求保存员工
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                //alert(result.msg);
                if(result.code==100){
                    //关闭模态框
                    $("#empAddModal").modal("hide");
                    //去到最后一页
                    to_page(toatlRecord);
                }else{
                    //显示失败的信息
                    if(undefined!=result.extend.errorFieldsMap.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errorFieldsMap.email);
                    }
                    if(undefined!=result.extend.errorFieldsMap.empName){
                        //显示用户名错误信息
                        show_validate_msg("#empName_add_input","error",result.extend.errorFieldsMap.empName);
                    }
                }

            }
        })
    });


    //1.我们是在按钮创建之前就绑定了click事件，所以绑定不上
    //2.(1)可以在创建按钮时绑定click事件
    //  (2)绑定点击.live()
    //  jquery新版没有live，使用on进行代替on(要绑定的事件，选中的后代是你要绑定的对象，函数)
    $(document).on("click",".edit_btn",function(){
        //alert("edit");
        //0.查出员工信息，并显示员工信息
        getEmp($(this).attr("edit-id"));
        //1.查出部门信息，并显示部门信息
        getDepts("#empUpdateModal select");
        //3.把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empUpdateModal").modal({//弹出模态框
            backdrop:"static"
        });
    });
    //根据id查询员工信息
    function getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function(result){
                //console.log(result);
                var empData=result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    //点击更新，更新员工信息
    $("#emp_update_btn").click(function(){
       //1.校验邮箱信息
        var email=$("#email_update_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email_add_input","error","邮箱格式不正确!")
            return false;
        }else{
            show_validate_msg("#email_add_input","success","")
        }
        //2.发送ajax请求保存更新的员工数据

        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function(result){
                //alert(result.msg);
                //1.关闭对话框
                $("#empUpdateModal").modal("hide");
                //2.回到本页面
                to_page(currentPage);
            }
        });
    });
    //点击删除单条
    $(document).on("click",".delete_btn",function(){
        //1.弹出是否确认删除对话框
        //alert($(this).parents("tr").find("td:eq(1)").text());
        var empName=$(this).parents("tr").find("td:eq(2)").text();
        var empId=$(this).attr("del-id");
        if(confirm("确认删除【"+empName+"】吗？")){
            //确认删除发送ajax请求
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function(result){
                    // alert(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            });
        }
    });

    //完成全选、全不选功能
    $("#check_all").click(function(){
        //attr获取checked是undefined；
        //我们获取和修改dom原生的属性，使用prop，attr获取自定义属性的值；
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    $(document).on("click",".check_item",function(){
        //判断当前选中的元素是不是五个
        var flag=$(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });
    //点击全部删除，就批量删除
    $("#emp_delete_all").click(function(){
        var empNames="";
        var del_idstr="";
       $.each($(".check_item:checked"),function(){
           empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
           del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
       });
       //去除empNames多余的，
       empNames=empNames.substring(0,empNames.length-1);
       //去除del_idstr多余的-
       del_idstr=del_idstr.substring(0,del_idstr.length-1);
       if(empNames.length!=0){
           if(confirm("确认删除【"+empNames+"】吗？")){
               //发送ajax请求
               $.ajax({
                   url:"${APP_PATH}/emp/"+del_idstr,
                   type:"DELETE",
                   success:function(result){
                       alert(result.msg);
                       to_page(currentPage);
                   }
               });
           }
       }else {
           alert("请至少选择一个员工来进行删除！");
       }

    });

</script>

</body>
</html>
