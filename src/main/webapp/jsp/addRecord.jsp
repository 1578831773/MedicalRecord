<%--
  Created by IntelliJ IDEA.
  User: 何西
  Date: 2023/6/16
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored ="false" %>
<html>
<head>
    <title>门诊病历</title>
    <link rel="stylesheet" type="text/css" href="/static/bootstrap/css/bootstrap.css"/>
    <script src="/static/js/jquery-1.11.1.js"></script>
    <script src="/static/bootstrap/js/bootstrap.js"></script>
    <script src="/static/bootstrap/js/bootstrap.min.js"></script>
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
        <div class="record col-sm-11">
            <div class="container">
                <h1>门诊病历</h1>
                <form method="post" action="/record/addRecord" style="margin-top: 20px" enctype="multipart/form-data">

                <div class="form-section">
                    <h3>患者基本情况</h3>
                    <table>
                        <tr>
                            <th>姓名</th>
                            <td><input type="text" name="name" value="${patient.name}" required></td>
                        </tr>
                        <tr>
                            <th>性别</th>
                            <td>
                                <select name="sex" required>
                                    <c:if test="${patient.sex == '男' or patient.sex == null}">
                                        <option value="男" selected>男</option>
                                        <option value="女">女</option>
                                    </c:if>
                                    <c:if test="${patient.sex == '女'}">
                                        <option value="男">男</option>
                                        <option value="女" selected>女</option>
                                    </c:if>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>年龄</th>
                            <td><input type="number" name="age" value="${patient.age}" required></td>
                        </tr>
                        <tr>
                            <th>电话</th>
                            <td><input type="text" name="phone" value="${patient.phone}" required></td>
                        </tr>

                    </table>
                </div>

                <div class="form-section">
                    <h3>门诊病历</h3>
                    <table>
                        <tr>
                            <th>主诉</th>
                            <td><textarea name="mainSuit" rows="3" ></textarea></td>
                        </tr>
                        <tr>
                            <th>现病史</th>
                            <td><textarea name="historyOfPresentIllness" rows="3" ></textarea></td>
                        </tr>
                        <tr>
                            <th>既往史</th>
                            <td><textarea name="previousHistory" rows="3" ></textarea></td>
                        </tr>
                        <tr>
                            <th>体格检查</th>
                            <td><textarea name="healthCheckUp" rows="3" ></textarea></td>
                        </tr>
                        <tr>
                            <th>诊断</th>
                            <td><textarea name="diagnose" rows="3"  required></textarea></td>
                        </tr>
                        <tr>
                            <th>处理</th>
                            <td><textarea name="cure" rows="3"  required></textarea></td>
                        </tr>
                        <tr>
                            <th>医生签名</th>
                            <td><input type="text" rows="3"  name="signature"></td>
                        </tr>
                    </table>
                </div>

                <div class="form-section">
                    <h3>项目费用</h3>
                    <table>
                        <tr>
                            <th>项目</th>
                            <td><textarea name="project"></textarea></td>
                        </tr>
                        <tr>
                            <th>总费用</th>
                            <td><input id="allInCost" step="0.01" type="number" name="allInCost" required>元</td>
                        </tr>
                        <tr>
                            <th>已收费用</th>
                            <td><input id="paid" step="0.01" type="number" name="paid" required>元</td>
                        </tr>
                        <tr>
                            <th>备注</th>
                            <td><textarea name = "detail" rows="3" ></textarea></td>
                        </tr>
                    </table>
                </div>

                <div class="submit-button">
                    <input type="submit" value="添加病历">
                    <input type="reset" value="重置">
                </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    const input1 = document.getElementById('allInCost');
    const input2 = document.getElementById('paid')
    // 监听输入事件
    input1.addEventListener('input', function() {
        const value = parseFloat(input1.value);

        if (isNaN(value) || value < 0) {
            input1.setCustomValidity(`请输入大于等于0的数字`);
        } else {
            input1.setCustomValidity(''); // 重置验证消息
        }
    })
    input2.addEventListener('input', function() {
        const value2 = parseFloat(input2.value);
        const value1 = parseFloat(input1.value);
        if (isNaN(value2) || value2 > value1 || value2 < 0) {
            input2.setCustomValidity(`请输入小于等于`+ value1 + `且大于0的数字`);
        } else {
            input2.setCustomValidity(''); // 重置验证消息
        }
    })
</script>
</body>
</html>
