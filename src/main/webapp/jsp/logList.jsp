<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored ="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>日志列表</title>
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
            <li class="active">日志列表</li>
        </ul>
    </div>
    <div class="content row">
        <div class="nav col-sm-1">

            <ul class="nav nav-pills nav-stacked">
                <li><a href="/record/list">诊断记录</a></li>
                <li><a href="/jsp/addRecord.jsp">添加病例</a></li>
                <li><a href="/patient/list">病人列表</a></li>
                <li class="active"><a href="/log/list">系统日志</a> </li>
            </ul>
        </div>
        <div class="record_list col-sm-11" style="background-color: white; padding-top: 30px;">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">日志列表</h3>
                </div>
                <div class="panel-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>记录时间</th>
                            <th>内容</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="ind" value="1"/>
                        <c:forEach var="log" items="${logList}">
                            <tr>
                                <td class="col-sm-2">${log.logTime}</td>
                                <td class="col-sm-10">${log.content}</td>
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
                        <li><a href="/log/list?page=${page-1}">&laquo;</a></li>
                    </c:if>
<%--                    <c:if test="${startPage % 10 == 0}">--%>
<%--                        <li class="active"><a href="#">${page}</a></li>--%>
<%--                        <c:forEach var="i" begin="${page+1}" end="${page + pageCount}">--%>
<%--                            <li><a href="/log/list?page=${i}">${i}</a></li>--%>
<%--                        </c:forEach>--%>
<%--                    </c:if>--%>
<%--                    <c:if test="${startPage % 10 != 0}">--%>
<%--                        <c:forEach var="i" begin="${startPage}" end="${page-1}">--%>
<%--                            <li><a href="/log/list?page=${i}">${i}</a></li>--%>
<%--                        </c:forEach>--%>
<%--                        <li class="active"><a href="#">${page}</a></li>--%>
<%--                        <c:forEach var="i" begin="${page+1}" end="${page + pageCount}">--%>
<%--                            <li><a href="/log/list?page=${i}">${i}</a></li>--%>
<%--                        </c:forEach>--%>
<%--                    </c:if>--%>
                    <c:forEach var="i" begin="${startPage}" end="${page+pageCount}">
                        <c:if test="${i == page}">
                            <li class="active"><a href="#">${i}</a></li>
                        </c:if>
                        <c:if test="${i != page}">
                            <li><a href="/log/list?page=${i}">${i}</a></li>
                        </c:if>
                    </c:forEach>
                    <li><a href="/log/list?page=${page+1}">&raquo;</a></li>
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
