<%@ page import="com.example.medicalrecord.enums.StatusCode" %>
<%@ page import="com.example.medicalrecord.bean.PatientCard" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored ="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>诊断记录</title>
    <link rel="stylesheet" type="text/css" href="/static/bootstrap/css/bootstrap.css"/>
    <script src="/static/js/jquery-1.11.1.js"></script>
    <script src="/static/bootstrap/js/bootstrap.js"></script>
    <script src="/static/bootstrap/js/bootstrap.min.js"></script>

    <style>
        .error{
            color: red;
        }
        label{
            display: inline-block;
            width: 70px;
            text-align: right;
        }
    </style>


</head>
<body style="background-color: #c4e3f3">
<div class="top col-sm-offset-1 col-sm-10 row" style="height: 100px; padding-top: 10px;">
    <div class="webname col-sm-3"><h2>永皓齿科</h2></div>
</div>
<div class="main col-sm-offset-1 col-sm-10">
    <div class="navigation_bar">
        <ul class="breadcrumb">
            <li class="active">添加病例</li>
        </ul>
    </div>
    <div class="content row">
        <div class="nav col-sm-1">
            <ul class="nav nav-pills nav-stacked">
                <li><a href="/record/list">诊断记录</a></li>
                <li class="active"><a href="/jsp/addRecord.jsp">添加病例</a></li>
                <li><a href="/patient/list">病人列表</a></li>
                <li><a href="/log/list">系统日志</a> </li>
            </ul>
        </div>
        <div class="col-sm-11">
<%--            <div class="panel-heading">--%>
<%--                <h3 class="panel-title">新建病例</h3>--%>
<%--            </div>--%>
<%--            <div class="panel-body">--%>
                <div class="panel panel-primary" style="border-top: 10px; background-color: white">
                    <div class="panel-heading">
                        <h3 class="panel-title">添加病例</h3>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal col-sm-offset-1" onsubmit="return validateForm()" method="post" action="/record/addRecord" enctype="multipart/form-data">
                            <input name="patientId" type="number" hidden>
                            <div class="modal-body">
                                <div class="form-group row">
                                    <label for="name" class="control-label col-sm-1">姓名</label>
                                    <div class="col-sm-2">
                                        <input type="text" class="form-control" id="name" name="name" placeholder="请输入病人姓名">
                                        <span class="error" id="nameErr"></span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="man" class=" control-label col-sm-1">性别</label>
                                    <div class="radio col-sm-4">
                                        <label class="col-sm-2">
                                            <input type="radio" name="sex" id="man" value="男" checked> 男
                                        </label>
                                        <label class="col-sm-2">
                                            <input type="radio" name="sex" id="woman" value="女">女
                                        </label>

                                    </div>
                                    <%--                        <div class="radio col-sm-1">--%>
                                    <%--                            <label>--%>
                                    <%--                                --%>
                                    <%--                            </label>--%>
                                    <%--                        </div>--%>
                                </div>
                                <div class="form-group row">
                                    <label for="name" class=" control-label col-sm-1">年龄</label>
                                    <div class="col-sm-2">
                                        <input type="number" class="form-control" id="age" name="age" placeholder="请输入病人年龄">
                                        <span class="error" id="ageErr"></span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="name" class="control-label col-sm-1">诊断</label>
                                    <div class="col-sm-4">
                                        <input type="text" class="form-control" id="diagnose" name="diagnose" placeholder="请输入诊断">
                                        <span class="error" id="diagnoseErr"></span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="name" class="control-label col-sm-1">治疗方案</label>
                                    <div class="col-sm-4">
                                        <input type="text" class="form-control" id="cure" name="cure" placeholder="请输入治疗方案">
                                        <span class="error" id="cureErr"></span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="name" class=" control-label col-sm-1">总费用</label>
                                    <div class="col-sm-2">
                                        <input type="number" class="form-control" id="allInCost" name="allInCost" placeholder="请输入总费用">
                                        <span class="error" id="allInCostErr"></span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="name" class=" control-label col-sm-1">已收费</label>
                                    <div class="col-sm-2">
                                        <input type="number" class="form-control" id="recCost" name="recCost" placeholder="请输入已收费">
                                        <span class="error" id="recCostErr"></span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="name" class="control-label col-sm-1">电话</label>
                                    <div class="col-sm-4">
                                        <input type="text" class="form-control" id="phone" name="phone" placeholder="请输入电话号码">
                                        <span class="error" id="phoneErr"></span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="name" class="col-sm-1">备注</label>
                                    <textarea name = "detail" class="form-control col-sm-8" rows="3" style="width: 450px"></textarea>
                                </div>
                                <div class="form-group row" style="padding-top: 50px">
                                    <button type="reset" class="btn btn-default col-sm-offset-1" data-dismiss="modal">重置</button>
                                    <button type="submit" class="btn btn-primary col-sm-offset-1">添加病例</button>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>
<%--            </div>--%>
        </div>
    </div>

</div>

<script>
    // 清空 input 标签后的提示信息
    var tags = document.getElementsByTagName('input');
    for (var i = 0; i < tags.length; i++) {
        tags[i].onchange = function(){
            var idname = this.name + "Err";
            document.getElementById(idname).innerHTML = '';
        }
    }
    // 显示错误消息
    function printError(elemId, hintMsg) {
        document.getElementById(elemId).innerHTML = hintMsg;
    }
    // 验证表单数据
    function validateForm() {
        // 获取表单元素的值
        var name = document.querySelector("input[name='name']").value;
        var age = document.querySelector("input[name='age']").value;
        var diagnose = document.querySelector("input[name='diagnose']").value;
        var cure = document.querySelector("input[name='cure']").value;
        var allInCost = document.querySelector("input[name='allInCost']").value;
        var recCost = document.querySelector("input[name='recCost']").value;
        var phone = document.querySelector("input[name='phone']").value;

        if(name == "" || name == null){
            printError("nameErr", "用户名不能为空");
            return false;
        }
        if(age == "" || age == null){
            printError("ageErr", "年龄不能为空");
            return false;
        }
        if(diagnose == "" || diagnose == null){
            printError("diagnoseErr", "诊断结果不能为空");
            return false;
        }
        if(cure == "" || cure == null){
            printError("cureErr", "治疗方案不能为空");
            return false;
        }
        if(allInCost == "" || allInCost == null){
            printError("allInCostErr", "总费用不能为空");
            return false;
        }
        if(recCost == "" || recCost == null){
            printError("recCostErr", "已收不能为空");
            return false;
        }
        if(phone == "" || phone == null){
            printError("phoneErr", "电话不能为空");
            return false;
        }

    }

</script>


<script>
    window.onload = function(){
        <%
             String errorMsg = (String)request.getAttribute("errorMsg");
            if(errorMsg != null){
        %>
        alert("<%=errorMsg%>");
        <%
            request.removeAttribute("errorMsg");
            }
        %>

        <%
               PatientCard patient = (PatientCard)request.getAttribute("patient");
               if(patient != null){
                    if(patient.getSex().equals("男")){
        %>
        document.getElementById("man").setAttribute("checked", "checked")
        <%
                }else{
        %>
        document.getElementById("woman").setAttribute("checked", "checked")
        <%
                }
        %>
        document.getElementsByName("patientId")[0].value = ${patient.patientId}
            document.getElementsByName("name")[0].value = "${patient.name}"
                document.getElementsByName("age")[0].value = ${patient.age}
                    document.getElementsByName("phone")[0].value = "${patient.phone}"
        <%
            }
        %>

    };
</script>
</body>
</html>