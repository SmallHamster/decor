<%@ page import="com.bluemobi.decor.entity.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="backend/login/home">DECOR后台管理系统</a>
</div>
<!-- /.navbar-header -->

<ul class="nav navbar-top-links navbar-right">
    <!-- /.dropdown -->
    <li class="dropdown">
        <p id="bell_total"
           style="position: absolute;right: 0px;top: 0px;background-color: #c9302c;width: 20px;height: 20px;border-radius: 15px;text-align: center;padding: 2px 0px;z-index: 2;font-size: 10px;color: white;display: none;">
        </p>
    </li>
    <%
        User user = (User) session.getAttribute("user");
    %>
    <li>
        欢迎光临：<%=user.getAccount()%>
    </li>
    <li class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
            <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
        </a>
        <ul class="dropdown-menu dropdown-user">
            <li><a href="backend/logout"><i class="fa fa-sign-out fa-fw"></i> 退出</a>
            </li>
        </ul>
    </li>
</ul>
<!-- /.navbar-top-links -->

