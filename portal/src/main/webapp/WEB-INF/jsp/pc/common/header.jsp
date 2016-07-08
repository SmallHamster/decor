<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="static/pc-1.1/css/global.css" />
<link rel="stylesheet" href="static/pc-1.1/css/index.css" />
<script src="static/js/jquery-1.11.0.js"></script>
<script src="static/layer-v2.3/layer/layer.js"></script>
<div class="header">
    <div class="top">
        <div class="center">
            <span class="pull-left">DECOR故事&emsp;&emsp;服务热线：400-800-5262</span>
					<span class="pull-right">
                        <input type="hidden" id="sessionMode" value="${session_mode}"/>
                        <input type="hidden" id="sessionUserId" value="${session_pc_user.id}"/>
                        <c:if test="${session_pc_user != null}">
                            <div class="user fl" style="cursor: pointer;">
                                <a href='pc/user/detailHomePage'>${session_pc_user.shortNickname}</a>
                                <a onclick="login.out()"><fmt:message key="info.tuichu"/></a>
                            </div>
                        </c:if>
                        <c:if test="${session_pc_user == null}">
                            <a onclick="loginPopup.showDlg()"><fmt:message key="info.denglu"/></a>
                            <a id="register" onclick="showRegisterDiv()"><fmt:message key="info.zhuce"/></a>
                        </c:if>

                        <%
                            HttpSession s = request.getSession();
                        %>
                        <input type="hidden" id="langua" value="<%=s.getAttribute("langua") %>"/>
						<select onchange="lu()" id="lua" style="background: white;">
                            <option value="zh_CN">中文</option>
                            <option value="en_US">English</option>
                        </select>
						<a href="###">下载APP</a>
					</span>
        </div>
    </div>
    <div class="center">
        <a href="index" class="pull-left logo"><img src="static/pc-1.1/images/logo.png" title="" alt="" width="138" height="46" /></a>
        <div class="pull-left nav">
            <a href="pc/forward/to?type=scene"><fmt:message key="info.tuku"/></a>
            <a href="pc/forward/to?type=goods"><fmt:message key="info.shangpin"/></a>
            <a href="pc/forward/to?type=user"><fmt:message key="info.shejishi"/></a>
            <a href="pc/forward/to?type=message"><fmt:message key="info.zixun"/></a>
        </div>
        <div id="searchArea" class="pull-right search">
            <div class="dropdown pull-left">
                <button id="typeValue" type="button"><fmt:message key="info.changjingtu"/></button>
                <ul id="typeSelect" class="dropdown-menu">
                    <li><a><fmt:message key="info.changjingtu"/></a></li>
                    <li><a ><fmt:message key="info.shangpintu"/></a></li>
                    <li><a ><fmt:message key="info.xilietu"/></a></li>
                    <li><a ><fmt:message key="info.shejishi"/></a></li>
                    <li><a ><fmt:message key="info.zixun"/></a></li>
                </ul>
            </div>
            <form id="searchForm" class="form pull-left" action="pc/forward/to">
                <input type="hidden" id="search_type" name="type" value="${type}"/>
                <input id="searchText" name="name" type="text" placeholder="请输入您要查找的内容" value="${name}"/>
                <input id="search" type="submit" value="" />
            </form>
            <a class="btn btn-design" href="pc/drawBoard/page"><fmt:message key="info.zaixiansheji"/></a>
        </div>
    </div>
</div>
<script>
    $(function init() {
        var langua = $("#langua").val();
        $("#lua").val(langua);
    });
    function lu() {
        var lua = $("#lua").val();
        var url = _basePath;
        if (lua == 'en_US') {
            url += "us"
        }
        if (lua == 'zh_CN') {
            url += "chinese"
        }
        var data = {
            "locale": lua
        };
        $.ajax({
            url: url,
            type: "get",
            data: data,
            async: false
        });
        window.location.href = "index?langua=" + lua;
    }
</script>
