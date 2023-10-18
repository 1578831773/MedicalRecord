<%--
  Created by IntelliJ IDEA.
  User: 何西
  Date: 2023/8/13
  Time: 20:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored ="false" %>
<html>
<head>
    <title>付款记录</title>
    <link rel="stylesheet" type="text/css" href="/static/bootstrap/css/bootstrap.css"/>
    <script src="/static/js/jquery-1.11.1.js"></script>
    <script src="/static/bootstrap/js/bootstrap.js"></script>
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
                    <h3 class="panel-title">收费记录</h3>
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
                            <a class="btn btn-primary" role="button" href="/record/detail?medicalId=${detail.medicalId}" style="margin-top: 10px; margin-left: 40px">病人病例</a>

                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addPaymentModal" style="margin-top: 10px; margin-left: 40px">
                                添加收费记录
                            </button>

                        </div>
                        <div class="modal fade" id="addPaymentModal" tabindex="-1" aria-labelledby="addPaymentModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="addPaymentModalLabel">添加收费记录</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <form method="post" action="/pay/add" enctype="multipart/form-data">
                                            <table class="table">
                                                <tbody>
                                                <tr>
                                                    <th>病人姓名：</th>
                                                    <td>${detail.patientCard.name}</td>
                                                </tr>
                                                <tr>
                                                    <th>项目：</th>
                                                    <td>${detail.projectCost.project}</td>
                                                </tr>
                                                <tr>
                                                    <th>总费用：</th>
                                                    <td>${detail.projectCost.allInCost}</td>
                                                </tr>
                                                <tr>
                                                    <th>已缴费：</th>
                                                    <td>${detail.projectCost.paid}</td>
                                                </tr>
                                                <tr>
                                                    <th>待交费：</th>
                                                    <td>${detail.projectCost.allInCost - detail.projectCost.paid}</td>
                                                </tr>
                                                <c:if test="${detail.projectCost.paid == detail.projectCost.allInCost}">
                                                    <h3>已完成交费</h3>
                                                </c:if>
                                                <c:if test="${detail.projectCost.paid != detail.projectCost.allInCost}">
                                                    <tr>
                                                        <th>交费：</th>
                                                        <td><input step="0.01" type="number" name="pay" id="pay"></td>
                                                    </tr>
                                                    <tr>
                                                        <th>备注：</th>
                                                        <td><input type="text" name="detail" id="pay_detail"></td>
                                                    </tr>
                                                </c:if>

                                                </tbody>
                                            </table>
                                            <c:if test="${detail.projectCost.paid != detail.projectCost.allInCost}">
                                                <div class="modal-footer">
                                                    <input type="number" name="medicalId" value="${detail.medicalId}" hidden>
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                                                    <button type="submit" class="btn btn-primary">添加</button>
                                                </div>
                                            </c:if>
                                        </form>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>


                    <div class="col-sm-8 col-sm-offset-1">
                        <h4>项目：${detail.projectCost.project}，总费用：${detail.projectCost.allInCost}，已收费：${detail.projectCost.paid}，待收费：${detail.projectCost.allInCost-detail.projectCost.paid}</h4>

                        <table class="table">
                            <thead>
                            <tr>
                                <th>编号</th>
                                <th>付款时间</th>
                                <th>金额</th>
                                <th>备注</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="pay" items="${payList}">
                                <tr>
                                    <td>${pay.payId}</td>
                                    <td>${pay.payTime}</td>
                                    <td>${pay.pay}</td>
                                    <td>${pay.detail}</td>
                                    <td class="row">
                                        <form method="post" action="/record/print">
                                            <input name="medicalId" type="number" value="${detail.medicalId}" hidden>
                                            <input name="name" type="text" value="${detail.patientCard.name}" hidden>
                                            <input name="diagnoseTime" type="text" value="${detail.firstVisitTime}" hidden>
                                            <input name="cure" type="text" value="${detail.medical.cure}" hidden>
                                            <input name="allInCost" type="number" value="${detail.projectCost.allInCost}" hidden>
                                            <input name="recCost" type="number" value="${detail.projectCost.paid}" hidden>
                                            <input name="pay" type="number" value="${pay.pay}" hidden>
                                            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#updatePaymentModal${pay.payId}">
                                                修改
                                            </button>
                                            <button class="btn btn-primary col-sm-offset-1" type="submit">打印</button>
                                        </form>
                                            <div class="modal fade" id="updatePaymentModal${pay.payId}" tabindex="-1" aria-labelledby="updatePaymentModal${pay.payId}" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">修改收费记录</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form method="post" action="/pay/update" enctype="multipart/form-data">

                                                                <table class="table">
                                                                    <tbody>
                                                                    <tr>
                                                                        <th>病人姓名：</th>
                                                                        <td>${detail.patientCard.name}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th>项目：</th>
                                                                        <td>${detail.projectCost.project}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th>总费用：</th>
                                                                        <td>${detail.projectCost.allInCost}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th>已缴费：</th>
                                                                        <td>${detail.projectCost.paid - pay.pay}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th>待交费：</th>
                                                                        <td>${detail.projectCost.allInCost - detail.projectCost.paid + pay.pay}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th>交费：</th>
                                                                        <td><input type="number" step="0.01" name="pay" id="pay_up" value="${pay.pay}"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th>备注：</th>
                                                                        <td><input type="text" name="detail" id="pay_detail_up" value="${pay.detail}"></td>
                                                                    </tr>

                                                                    </tbody>
                                                                </table>
                                                                <div class="modal-footer">
                                                                    <input type="number" name="medicalId" value="${detail.medicalId}" hidden>
                                                                    <input type="number" name="payId" value="${pay.payId}" hidden>
                                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                                                                    <button type="submit" class="btn btn-primary">修改</button>
                                                                </div>
                                                            </form>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>


                    </div>
                </div>

            </div>
            <div class="panel panel-warning" >
                <div class="panel-heading">
                    <h3 class="panel-title">收据打印记录</h3>
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
    const input2 = document.getElementById('pay');
    // 监听输入事件
    input2.addEventListener('input', function() {
        const value = parseFloat(input2.value);

        if (isNaN(value) || value > ${detail.projectCost.allInCost - detail.projectCost.paid}) {
            input2.setCustomValidity(`请输入小于等于${detail.projectCost.allInCost - detail.projectCost.paid}的数字`);
        } else {
            input2.setCustomValidity(''); // 重置验证消息
        }
    })
</script>
</body>
</html>