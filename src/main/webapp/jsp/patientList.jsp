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
</head>
<body style="background-color: #c4e3f3">
<div class="top col-sm-offset-1 col-sm-10 row" style="height: 100px; padding-top: 10px;">
    <div class="webname col-sm-3"><h2>永皓齿科</h2></div>
</div>
<div class="main col-sm-offset-1 col-sm-10">
    <div class="navigation_bar">
        <ul class="breadcrumb">
            <li class="active">病人列表</li>
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
        <div class="record_list col-sm-11" style="background-color: white; padding-top: 30px;">
            <div class="row" style="padding-bottom: 10px">
                <form class="form-horizontal col-sm-8 row" role="form" action="/patient/list" method="get">
                    <div class="col-sm-6">
                        <input type="text" class="form-control" placeholder="输入要搜索的病人姓名" name="content">
                    </div>
<%--                    <div class="form-group col-sm-2" >--%>
<%--                        <label>--%>
<%--                            <input type="radio" name="flag" value="1" checked> 姓名--%>
<%--                        </label>--%>
<%--                        <label>--%>
<%--                            <input type="radio" name="flag" value="2"> 编号--%>
<%--                        </label>--%>
<%--                    </div>--%>
                    <div class="col-sm-2">
                        <button type="submit" class="btn btn-default">
                            <span class="glyphicon glyphicon-search	"></span>
                        </button>
                    </div>
                </form>
            </div>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">病人列表</h3>
                </div>
                <div class="panel-body row">
                    <c:forEach var="patient" items="${patientList}">
                        <div class="col-sm-6 col-md-3">
                            <div class="thumbnail">
                                <c:if test="${patient.sex == '男'}">
                                    <img decoding="async" src="/static/img/img_2.png"
                                         alt="通用的占位符缩略图">
                                </c:if>
                                <c:if test="${patient.sex == '女'}">
                                    <img decoding="async" src="/static/img/img_3.png"
                                         alt="通用的占位符缩略图">
                                </c:if>
                                <div class="caption">
                                    <h5>${patient.name}</h5>
                                    <p>${patient.phone}</p>
                                    <p>
                                        <form method="post" action="/record/add">
                                            <input type="number" name="patientId" value="${patient.patientId}" hidden>
                                            <input type="text" name="name" value="${patient.name}" hidden>
                                            <input type="text" name="sex" value="${patient.sex}" hidden>
                                            <input type="number" name="age" value="${patient.age}" hidden>
                                            <input type="text" name="phone" value="${patient.phone}" hidden>
                                            <button type="submit" class="btn btn-primary">添加病例</button>
                                            <a href="/patient/records?patientId=${patient.patientId}" class="btn btn-default" role="button">
                                                病例列表
                                            </a>
                                        </form>
<%--                                        <a href="#" class="btn btn-primary" role="button">--%>
<%--                                            添加病例--%>
<%--                                        </a>--%>

                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="col-sm-offset-2">
                <ul class="pagination">
                    <c:if test="${page != 1}">
                        <li><a href="/patient/list?page=${page-1}&content=${content}">&laquo;</a></li>
                    </c:if>
                    <c:forEach var="i" begin="${startPage}" end="${page+pageCount}">
                        <c:if test="${i == page}">
                            <li class="active"><a href="#">${i}</a></li>
                        </c:if>
                        <c:if test="${i != page}">
                            <li><a href="/patient/list?page=${i}&content=${content}">${i}</a></li>
                        </c:if>
                    </c:forEach>
                    <li><a href="/patient/list?page=${page+1}&content=${content}">&raquo;</a></li>
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
