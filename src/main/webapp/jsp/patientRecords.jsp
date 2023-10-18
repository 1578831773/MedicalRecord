<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored ="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户诊断记录</title>
    <link rel="stylesheet" type="text/css" href="/static/bootstrap/css/bootstrap.css"/>
    <script src="/static/js/jquery-1.11.1.js"></script>
    <script src="/static/bootstrap/js/bootstrap.js"></script>
</head>
<body style="background-color: #c4e3f3">
<div class="top col-sm-offset-1 col-sm-10 row" style="height: 100px; padding-top: 10px;">
    <div class="webname col-sm-3"><h2>永皓齿科</h2></div>
</div>
<div class="main col-sm-offset-1 col-sm-10">
    <div class="navigation_bar">
        <ul class="breadcrumb">
            <li><a href="/patient/list">用户列表</a></li>
            <li class="active">用户诊断记录</li>
        </ul>
    </div>
    <div class="content row">
        <div class="nav col-sm-1">

            <ul class="nav nav-pills nav-stacked">
                <li><a href="/record/list">诊断记录</a></li>
                <li><a href="/jsp/addRecord.jsp">添加病例</a></li>
                <li class="active"><a href="/patient/list">病人列表</a></li>
                <li><a href="/log/list">系统日志</a> </li>
            </ul>
        </div>
        <div class="record_list col-sm-11" style="background-color: white; padding-top: 10px">
            <div class="row" style="padding-bottom: 10px">
                <div class="col-sm-6" style="margin-left: 15px">
                    <div class="thumbnail row">
                        <div class="col-sm-4">
                            <c:if test="${patient.sex == '男'}">
                                <img decoding="async" src="/static/img/img_2.png"
                                     alt="通用的占位符缩略图" width="200px" height="200px">
                            </c:if>
                            <c:if test="${patient.sex == '女'}">
                                <img decoding="async" src="/static/img/img_3.png"
                                     alt="通用的占位符缩略图" width="200px" height="200px">
                            </c:if>
                        </div>
                        <div class="caption col-sm-6 col-sm-offset-1">
                            <h3>姓名：${patient.name}</h3>
                            <p>电话：${patient.phone}</p>
                            <p>性别：${patient.sex}</p>
                            <p>年龄：${patient.age}</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2" style="margin-top: 180px">
                    <form method="post" action="/record/add">
                        <input type="number" name="patientId" value="${patient.patientId}" hidden>
                        <input type="text" name="name" value="${patient.name}" hidden>
                        <input type="text" name="sex" value="${patient.sex}" hidden>
                        <input type="number" name="age" value="${patient.age}" hidden>
                        <input type="text" name="phone" value="${patient.phone}" hidden>
                        <button type="submit" class="btn btn-primary">添加病例</button>
                    </form>
                </div>
            </div>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">诊断记录</h3>
                </div>
                <div class="panel-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>编号</th>
                            <th>初诊日期</th>
                            <th>诊断</th>
                            <th>治疗方案</th>
                            <th>总费用</th>
                            <th>已收</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="ind" value="1"/>
                        <c:forEach var="record" items="${recordList}">
                            <tr>
                                <td class="col-sm-1">${record.medicalId}</td>
                                <td class="col-sm-2">${record.firstVisitTime}</td>
                                <td class="col-sm-2">${record.medical.diagnose}</td>
                                <td class="col-sm-2">${record.medical.cure}</td>
                                <td class="col-sm-1">${record.projectCost.allInCost}</td>
                                <td class="col-sm-1">${record.projectCost.paid}</td>
                                <td>
                                    <form class="form-horizontal col-sm-8 row" role="form" action="/record/detail" method="get">
                                        <input name="medicalId" type="number" class="hidden" value="${record.medicalId}">
                                        <input name="page" type="number" value="${page}" hidden>
                                        <button type="submit" class="btn btn-primary">查看</button>
                                    </form>
                                </td>
                            </tr>
                            <c:set var="ind" value="${ind+1}"/>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-sm-offset-2">
                <ul class="pagination">
                    <c:if test="${page != 1}">
                        <li><a href="/patient/records?page=${page-1}&patientId=${patient.patientId}">&laquo;</a></li>
                    </c:if>
                    <c:forEach var="i" begin="${startPage}" end="${page+pageCount}">
                        <c:if test="${i == page}">
                            <li class="active"><a href="#">${i}</a></li>
                        </c:if>
                        <c:if test="${i != page}">
                            <li><a href="/patient/records?page=${i}&patientId=${patient.patientId}">${i}</a></li>
                        </c:if>
                    </c:forEach>
                    <li><a href="/patient/records?page=${page+1}&patientId=${patient.patientId}">&raquo;</a></li>
                </ul>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript">
    var tab= document.getElementsByClassName('table')[0];
    var trs =tab.getElementsByTagName('tr');//获取所有的tr标签
    for(var i=0;i<trs.length;i++){
        trs[i].onmouseover = function(){   //鼠标移动上事件
            if(this.className!='first-row'){
                this.style.backgroundColor='pink';
            }
        }
        trs[i].onmouseout= function(){		//鼠标移出事件
            if(this.className!='first-row'){
                this.style.backgroundColor='#fff';
            }
        }
    }
</script>

</body>
</html>
