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
            var inputs = document.querySelectorAll('form[name="recordForm"] input')
            for(var i = 0; i < inputs.length; i ++){
                inputs[i].removeAttribute("readonly")
            }
            document.getElementById("paid").setAttribute("readonly", "readonly")
            var textareas = document.getElementsByTagName("textarea")
            for(var i = 0; i < textareas.length; i ++){
                textareas[i].removeAttribute("readonly")
            }
            document.getElementById("back").setAttribute("style", "display:block")
            document.getElementById("updateBtn").setAttribute("style", "display:block")
            document.getElementById("startUp").setAttribute("style", "display:none")
            document.getElementById("backBtn").setAttribute("style", "display:none")
            document.getElementById("print").setAttribute("style", "display:none")
        }

        window.onload =  function forbid(){
            var inputs = document.querySelectorAll('form[name="recordForm"] input')
            for(var i = 0; i < inputs.length; i ++){
                inputs[i].setAttribute("readonly", "readonly")
            }
            var textareas = document.getElementsByTagName("textarea")
            for(var i = 0; i < textareas.length; i ++){
                textareas[i].setAttribute("readonly", "readonly")
            }
            document.getElementById("back").setAttribute("style", "display:none")
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
    <style>
        .record {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            /*margin: 10px;*/
            /*padding: 20px;*/
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);

        }
        .main h1, h2, h3 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 8px;
            border: 1px solid #ccc;
        }
        input {
            margin: 3px;
        }
        textarea {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            resize: vertical;
        }
        .form-section {
            margin-bottom: 20px;
        }
        .form-section h3 {
            margin-top: 0;
        }
        .form-section label {
            font-weight: bold;
        }
        .form-section label, .form-section textarea {
            display: block;
            margin-bottom: 5px;
        }
        .submit-button {
            text-align: center;
        }
        .submit-button input[type="submit"]{
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .submit-button input[type='reset']{
            padding: 10px 20px;
            font-size: 16px;
            background-color: grey;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .error{
            color: red;
        }
        label{
            display: inline-block;
            width: 70px;
            text-align: right;
        }


    </style>
<script>

    function printContainer() {
        // 获取 .container 部分的内容
        var containerContent = document.querySelector('.container').innerHTML;

        // 创建一个新的打印窗口
        var printWindow = window.open('', '_blank');

        var styles = '<style>' +
            '.error { color: red; }' +
            'label { display: inline-block; width: 70px; text-align: right; }' +
            '.record { font-family: Arial, sans-serif; background-color: #f5f5f5; }' +
            '.container { max-width: 800px; background-color: #fff; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }' +
            '.main h1, h2, h3 { text-align: center; }' +
            'table { width: 100%; border-collapse: collapse; }' +
            'th, td { padding: 8px; border: 1px solid #ccc; }' +
            'input { margin: 1px; border: none;}' +
            'textarea { width: 100%; padding: 1px; border: none; resize: vertical; }' +
            '.form-section { margin-bottom: 20px; }' +
            '.form-section h3 { margin-top: 0; }' +
            '.form-section label { font-weight: bold; }' +
            '.form-section label, .form-section textarea { display: block; margin-bottom: 5px; }' +
            '.submit-button { text-align: center; }' +
            '.submit-button input[type="submit"] { padding: 10px 20px; font-size: 16px; background-color: #4CAF50; color: #fff; border: none; border-radius: 4px; cursor: pointer; }' +
            '.submit-button input[type="reset"] { padding: 10px 20px; font-size: 16px; background-color: grey; color: #fff; border: none; border-radius: 4px; cursor: pointer; }' +
            '.error { color: red; }' +
            'label { display: inline-block; width: 70px; text-align: right; }' +
            '</style>';

        var scripts = '<script src="/static/js/jquery-1.11.1.js"/>' +
    '<script src="/static/bootstrap/js/bootstrap.js"/>';


    printWindow.document.write('<html><head><title>打印</title>' + styles + '</head><body>' + containerContent + scripts + '</body></html>');

// 打印
        printWindow.print();

        // 关闭打印窗口
        printWindow.close();
    }

</script>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th.common-column, td.common-column {
            background-color: #f2f2f2;
        }
    </style>


</head>
<body style="background-color: #c4e3f3">

<c:choose>
<c:when test="${code eq '0'}">
<script>
    // 假设这些信息是从后端返回的
    // 使用Bootstrap的Modal来创建弹出框
    $(document).ready(function() {
        $("#popupModal").modal("show");
    });
</script>
</c:when>
<c:otherwise>
<!-- 处理其他情况 -->
</c:otherwise>
</c:choose>

<!-- Bootstrap的Modal -->
<div class="modal fade" id="popupModal" tabindex="-1" role="dialog" aria-labelledby="popupModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="popupModalLabel">打印信息</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>姓名：${detail.patientCard.name}</p>
                <p>治疗方案：${detail.medical.cure}</p>
                <p>总费用：${detail.projectCost.allInCost}</p>
                <p>已收款：${detail.projectCost.paid}</p>
            </div>
            <div class="modal-footer">
                <form method="post" action="/record/print">
                    <input name="page" type="number" value="${page}" hidden>
                    <input name="medicalId" type="number" value="${detail.medicalId}" hidden>
                    <input name="name" type="text" value="${detail.patientCard.name}" hidden>
                    <input name="diagnoseTime" type="text" value="${detail.firstVisitTime}" hidden>
                    <input name="cure" type="text" value="${detail.medical.cure}" hidden>
                    <input name="allInCost" type="number" value="${detail.projectCost.allInCost}" hidden>
                    <input name="pay" type="number" value="${detail.projectCost.paid}" hidden>
                    <input name="recCost" type="number" value="${detail.projectCost.paid}" hidden>
                    <button class="btn btn-primary" type="submit">打印</button>
                    <button type="button" class="btn btn-secondary col-sm-offset-1" data-dismiss="modal">返回</button>
                </form>
            </div>
        </div>
    </div>
</div>

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
                        <div>
                            <c:if test="${detail.patientCard.sex == '男'}">
                                <img decoding="async" src="/static/img/img_2.png"
                                     alt="通用的占位符缩略图" width="200px" height="200px">
                            </c:if>
                            <c:if test="${detail.patientCard.sex == '女'}">
                                <img decoding="async" src="/static/img/img_3.png"
                                     alt="通用的占位符缩略图" width="200px" height="200px">
                            </c:if>
                            <a class="btn btn-primary" role="button" href="/patient/records?patientId=${detail.patientCard.patientId}" style="margin-top: 10px; margin-left: 40px">病人病例列表</a>
                            <a class="btn btn-primary" role="button" href="/pay/list?medicalId=${detail.medicalId}" style="margin-top: 10px; margin-left: 40px">收费记录</a>


                        </div>

                    </div>


                    <div class="col-sm-10">
                        <div class="container">
                            <h1>永皓齿科</h1>
                            <h5>初诊时间：${detail.firstVisitTime}</h5>
                            <form name="recordForm" class="form-horizontal" method="post" action="/record/update" enctype="multipart/form-data">
                                <input type="number" name="medicalId" value="${detail.medicalId}" hidden>
                                <input type="number" name="patientId" value="${detail.patientCard.patientId}" hidden>
                                <input type="number" name="page" value="${page}" hidden>
                                <div class="form-section">
                                    <table>
                                        <tr>
                                            <th rowspan="4" style="width: 30px">患者基本信息</th>
                                            <th>姓名</th>
                                            <td><input type="text" name="name" value="${detail.patientCard.name}" required></td>
                                        </tr>
                                        <tr>
                                            <th style="width: 100px">性别</th>
                                            <td>
                                                <div style="display: flex">
                                                    <c:if test="${detail.patientCard.sex == '男'}">
                                                        <label style="width: 50px">
                                                            <input type="radio" name="sex" value="男" checked> 男
                                                        </label>
                                                        <label style="width: 50px">
                                                            <input type="radio" name="sex" value="女">女
                                                        </label>
                                                    </c:if>
                                                    <c:if test="${detail.patientCard.sex == '女'}">
                                                        <label  style="width: 50px">
                                                            <input type="radio" name="sex" id="man" value="男"> 男
                                                        </label>
                                                        <label  style="width: 50px">
                                                            <input type="radio" name="sex" id="woman" value="女" checked>女
                                                        </label>
                                                    </c:if>
                                                </div>

                                            </td>
                                        </tr>
                                        <tr>
                                            <th>年龄</th>
                                            <td><input type="number" name="age" value="${detail.patientCard.age}" required></td>
                                        </tr>
                                        <tr>
                                            <th>电话</th>
                                            <td><input type="text" name="phone" value="${detail.patientCard.phone}" required></td>
                                        </tr>
                                        <tr>
                                            <th class="col-sm-1" rowspan="7">门诊病历</th>
                                            <th>主诉</th>
                                            <td><textarea name="mainSuit" rows="3" >${detail.medical.mainSuit}</textarea></td>
                                        </tr>
                                        <tr>
                                            <th>现病史</th>
                                            <td><textarea name="historyOfPresentIllness" rows="3" >${detail.medical.historyOfPresentIllness}</textarea></td>
                                        </tr>
                                        <tr>
                                            <th>既往史</th>
                                            <td><textarea name="previousHistory" rows="3" >${detail.medical.previousHistory}</textarea></td>
                                        </tr>
                                        <tr>
                                            <th>体格检查</th>
                                            <td><textarea name="healthCheckUp" rows="3" >${detail.medical.healthCheckUp}</textarea></td>
                                        </tr>
                                        <tr>
                                            <th>诊断</th>
                                            <td><textarea name="diagnose" rows="3"  required>${detail.medical.diagnose}</textarea></td>
                                        </tr>
                                        <tr>
                                            <th>处理</th>
                                            <td><textarea name="cure" rows="3"  required>${detail.medical.cure}</textarea></td>
                                        </tr>
                                        <tr>
                                            <th>医生签名</th>
                                            <td><input type="text" rows="3"  name="signature" value="${detail.medical.signature}"></td>
                                        </tr>
                                        <tr>
                                            <th class="col-sm-1" rowspan="3">项目费用</th>
                                            <th>项目</th>
                                            <td><textarea name="project">${detail.projectCost.project}</textarea></td>
                                        </tr>
                                        <tr>
                                            <th>总费用</th>
                                            <td><input id="allInCost" type="number" name="allInCost" required value="${detail.projectCost.allInCost}">元</td>
                                        </tr>
                                        <tr>
                                            <th>已收费用</th>
                                            <td><input id="paid" type="number" name="paid" required value="${detail.projectCost.paid}">元</td>
                                        </tr>

                                    </table>
                                </div>

                                <div class="submit-button">
                                    <button id = "back" class="btn btn-default col-sm-1 col-sm-offset-1" data-dismiss="modal"><a href="/record/detail?medicalId=${detail.medicalId}&page=${page}">取消</a></button>
                                    <button id = "updateBtn" type="submit" class="btn btn-primary col-sm-2 col-sm-offset-1">提交更改</button>
                                </div>
                            </form>
                        </div>
                        <div class="row" style="padding-top: 15px">
                            <form method="get" action="/record/list">
                                <input name="page" type="number" value="${page}" hidden>
                                <button id = "startUp" onclick="update();return false;" class="btn btn-default col-sm-1 col-sm-offset-2">更改信息</button>
<%--                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#printRecord" style="margin-top: 10px; margin-left: 40px">--%>
<%--                                    打印病历--%>
<%--                                </button>--%>
<%--                                <a class="btn btn-primary" role="button" href="/record/printRecord?medicalId=${detail.medicalId}" style="margin-top: 10px; margin-left: 40px">打印病历</a>--%>
                                <button id="print" class="btn btn-primary col-sm-offset-1" onclick="printContainer()">打印病历</button>


                                <button id = "backBtn" type="submit" class="btn btn-default col-sm-offset-1">返回</button>
                            </form>



                        </div>
                    </div>

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

<script>
    const input = document.getElementById('pay');
    // 监听输入事件
    input.addEventListener('input', function() {
        const value = parseFloat(input.value);

        if (isNaN(value) || value > ${detail.projectCost.allInCost - detail.projectCost.paid}) {
            input.setCustomValidity(`请输入小于等于${detail.projectCost.allInCost - detail.projectCost.paid}的数字`);
        } else {
            input.setCustomValidity(''); // 重置验证消息
        }
    })
</script>

<script>
    const input = document.getElementById('allInCost');
    // 监听输入事件
    input.addEventListener('input', function() {
        const value = parseFloat(input.value);

        if (isNaN(value) || value < ${detail.projectCost.paid}) {
            input.setCustomValidity(`请输入大于等于${detail.projectCost.paid}的数字`);
        } else {
            input.setCustomValidity(''); // 重置验证消息
        }
    })
</script>




</html>