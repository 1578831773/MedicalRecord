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
    <div class="webname col-sm-3"><h2>医疗诊断记录系统</h2></div>
</div>
<div class="main col-sm-offset-1 col-sm-10">
    <div class="navigation_bar">
        <ul class="breadcrumb">
            <li class="active">诊断记录</li>
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
        <div class="record_list col-sm-11" style="background-color: white; padding-top: 30px">
            <div class="row">
                <form class="form-horizontal col-sm-8 row" role="form" action="/record/search" method="get">
                    <div class="col-sm-6">
                        <input type="text" class="form-control" placeholder="输入要搜索的记录" name="content">
                    </div>
                    <div class="form-group col-sm-2" >
                        <label>
                            <input type="radio" name="searchFlg" value="1" checked> 内容
                        </label>
                        <label>
                            <input type="radio" name="searchFlg" value="2"> 编号
                        </label>
                    </div>
                    <div class="col-sm-2">
                        <button type="submit" class="btn btn-default">
                            <span class="glyphicon glyphicon-search	"></span>
                        </button>
                    </div>
                </form>
                <div class="col-sm-2 col-sm-offset-2">
                    <a class="btn btn-primary" role="button" href="/record/excel">导出为excel</a>
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
                            <th>姓名</th>
                            <th>性别</th>
                            <th>初诊日期</th>
                            <th>诊断</th>
                            <th>治疗方案</th>
                            <th>总费用</th>
                            <th>已收</th>
                            <th>电话</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="ind" value="1"/>
                        <c:forEach var="record" items="${recordList}">
                            <tr>
                                <td class="col-sm-1">${record.medicalId}</td>
                                <td class="col-sm-1">${record.name}</td>
                                <td class="col-sm-1">${record.sex}</td>
                                <td class="col-sm-2">${record.firstVisitTime}</td>
                                <td class="col-sm-2">${record.diagnose}</td>
                                <td class="col-sm-2">${record.cure}</td>
                                <td class="col-sm-1">${record.allInCost}</td>
                                <td class="col-sm-1">${record.recCost}</td>
                                <td class="col-sm-2">${record.phone}</td>
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
                        <li><a href="/record/list?page=${page-1}">&laquo;</a></li>
                    </c:if>
                    <c:forEach var="i" begin="${startPage}" end="${page+pageCount}">
                        <c:if test="${i == page}">
                            <li class="active"><a href="#">${i}</a></li>
                        </c:if>
                        <c:if test="${i != page}">
                            <li><a href="/record/list?page=${i}">${i}</a></li>
                        </c:if>
                    </c:forEach>
                    <li><a href="/record/list?page=${page+1}">&raquo;</a></li>
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
