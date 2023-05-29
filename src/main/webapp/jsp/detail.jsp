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
    <script>
        function update(){
            var inputs = document.getElementsByTagName("input")
            for(var i = 0; i < inputs.length; i ++){
                inputs[i].removeAttribute("readonly")
            }
            document.getElementById("detail").removeAttribute("readonly")
            document.getElementById("back").setAttribute("style", "display:block")
            document.getElementById("updateBtn").setAttribute("style", "display:block")
            document.getElementById("startUp").setAttribute("style", "display:none")
            document.getElementById("backBtn").setAttribute("style", "display:none")
            document.getElementById("print").setAttribute("style", "display:none")
        }

        window.onload =  function forbid(){
            var inputs = document.getElementsByTagName("input")
            for(var i = 0; i < inputs.length; i ++){
                inputs[i].setAttribute("readonly", "readonly")
            }
            document.getElementById("back").setAttribute("style", "display:none")
            document.getElementById("detail").setAttribute("readonly", "readonly")
            document.getElementById("updateBtn").setAttribute("style", "display:none")

        }
    </script>
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
            <li><a href="/record/list">诊断记录</a></li>
            <li class="active">病例详情</li>
        </ul>
    </div>
    <div class="content row">
        <div class="nav col-sm-1">
            <ul class="nav nav-pills nav-stacked">
                <li class="active"><a href="/record/list">诊断记录</a></li>
                <li><a href="/jsp/addRecord.jsp">添加病例</a></li>
                <li><a href="/patient/list">病人列表</a></li>
                <li><a href="/log/list">系统日志</a> </li>
            </ul>
        </div>
        <div class="col-sm-11 col" style="background-color: white; padding-top: 10px">
            <div class="panel panel-info ">
                <div class="panel-heading">
                    <h3 class="panel-title">病例详情</h3>
                </div>
                <div class="panel-body row">
                    <div class="col-sm-2" style="padding-top: 100px; padding-right: 10px;padding-left: 20px">
                        <c:if test="${detail.sex == '男'}">
                            <img decoding="async" src="/static/img/img_2.png"
                                 alt="通用的占位符缩略图" width="200px" height="200px">
                        </c:if>
                        <c:if test="${detail.sex == '女'}">
                        <img decoding="async" src="/static/img/img_3.png"
                             alt="通用的占位符缩略图" width="200px" height="200px">
                        </c:if>
                        <a class="btn btn-primary" role="button" href="/patient/records?patientId=${detail.patientId}" style="margin-top: 10px; margin-left: 40px">病人病例列表</a>
                    </div>
                    <form class="form-horizontal col-sm-10" onsubmit="return validateForm()" method="post" action="/record/update" enctype="multipart/form-data">
                        <div class="modal-body" style="height: 100px;">
                            <input type="number" name="medicalId" value="${detail.medicalId}" hidden>
                            <input type="number" name="patientId" value="${detail.patientId}" hidden>
                            <div class="form-group row">
                                <label for="name" class="control-label col-sm-1">姓名</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" id="name" name="name" value="${detail.name}">
                                    <span class="error" id="nameErr"></span>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="man" class=" control-label col-sm-1">性别</label>
                                <div class="radio col-sm-4">
                                    <c:if test="${detail.sex == '男'}">
                                        <label class="col-sm-2">
                                            <input type="radio" name="sex" value="男" checked> 男
                                        </label>
                                        <label class="col-sm-2">
                                            <input type="radio" name="sex" value="女">女
                                        </label>
                                    </c:if>
                                    <c:if test="${detail.sex == '女'}">
                                        <label class="col-sm-2">
                                            <input type="radio" name="sex" id="man" value="男"> 男
                                        </label>
                                        <label class="col-sm-2">
                                            <input type="radio" name="sex" id="woman" value="女" checked>女
                                        </label>
                                    </c:if>

                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="name" class=" control-label col-sm-1">年龄</label>
                                <div class="col-sm-2">
                                    <input type="number" class="form-control" id="age" name="age" value="${detail.age}">
                                    <span class="error" id="ageErr"></span>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="name" class=" control-label col-sm-1">诊断</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="diagnose" name="diagnose" value="${detail.diagnose}">
                                    <span class="error" id="diagnoseErr"></span>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="name" class=" control-label col-sm-1">治疗</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="cure" name="cure" value="${detail.cure}">
                                    <span class="error" id="cureErr"></span>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="name" class=" control-label col-sm-1">总费用</label>
                                <div class="col-sm-2">
                                    <input type="number" class="form-control" id="allInCost" name="allInCost" value="${detail.allInCost}">
                                    <span class="error" id="alInCostErr"></span>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="name" class=" control-label col-sm-1">已收费</label>
                                <div class="col-sm-2">
                                    <input type="number" class="form-control" id="recCost" name="recCost" value="${detail.recCost}">
                                    <span class="error" id="recCostErr"></span>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="name" class="control-label col-sm-1">电话</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="phone" name="phone" value="${detail.phone}">
                                    <span class="error" id="phoneErr"></span>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="name" class="col-sm-1">备注</label>
                                <textarea id = "detail" name = "detail" class="form-control col-sm-8" rows="3" style="width: 500px">${detail.detail}</textarea>
                            </div>
                            <input type="number" name="page" value="${page}" hidden>
                            <div class="form-group row">
                                <button id = "back" class="btn btn-default col-sm-1 col-sm-offset-1" data-dismiss="modal"><a href="/record/detail?medicalId=${detail.medicalId}&page=${page}">取消</a></button>
                                <button id = "updateBtn" type="submit" class="btn btn-primary col-sm-2 col-sm-offset-1">提交更改</button>

                            </div>
                        </div>
                    </form>
                    <div class="col-sm-10 col-sm-offset-2 row" style="padding-top: 15px">
                        <form method="get" action="/record/list" class="col-sm-1 col-sm-offset-1">
                            <input name="page" type="number" value="${page}" hidden>
                            <button id = "backBtn" type="submit" class="btn btn-default col-sm-offset-1">返回</button>
                        </form>
                        <form method="post" action="/record/print">
                            <input name="page" type="number" value="${page}" hidden>
                            <input name="medicalId" type="number" value="${detail.medicalId}" hidden>
                            <input name="name" type="text" value="${detail.name}" hidden>
                            <input name="diagnoseTime" type="text" value="${detail.firstVisitTime}" hidden>
                            <input name="cure" type="text" value="${detail.cure}" hidden>
                            <input name="allInCost" type="number" value="${detail.allInCost}" hidden>
                            <input name="recCost" type="number" value="${detail.recCost}" hidden>
                            <button id = "startUp" onclick="update();return false;" class="btn btn-primary col-sm-offset-1">更改信息</button>
                            <button id = "print" class="btn btn-default col-sm-offset-1" type="submit">打印</button>
                        </form>
                    </div>
                </div>
            </div>


            <div class="panel panel-warning" >
                <div class="panel-heading">
                    <h3 class="panel-title">打印记录</h3>
                </div>
                <div class="panel-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>姓名</th>
                            <th>初诊日期</th>
                            <th>治疗方案</th>
                            <th>打印时间</th>
                            <th>总费用</th>
                            <th>已收</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="record" items="${printRecords}">
                            <tr>
                                <td style="padding-right: 20px">${record.name}</td>
                                <td>${record.diagnoseTime}</td>
                                <td>${record.cure}</td>
                                <td>${record.printTime}</td>
                                <td>${record.allInCost}</td>
                                <td>${record.recCost}</td>
                            </tr>
                        </c:forEach>
                        </tbody>

                    </table>
                </div>

            </div>


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
</body>
</html>