<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String _path = request.getContextPath();
	String _basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+_path+"/";
%>
<script src="static/mobile/js/jquery.min.js"></script>
<script src="static/mobile/js/global.js"></script>
<script src="static/js/plugins/notify-bootstap.min.js"></script>
<script src="static/pc/global.js"></script>
<div class="header clearfix" style="z-index: 777">
	<div class="btn nav"></div>
	<div class="btn logo"></div>
	<div class="btn user"><a></a></div>
	<div class="btn search"></div>
	<ul class="list">
		<li><a href="mobile/forward/to?type=index" style="color: white;">首页</a></li>
		<li><a href="mobile/forward/to?type=series" style="color: white;">图库</a></li>
		<li><a href="mobile/forward/to?type=goods" style="color: white;">商品</a></li>
		<li><a href="mobile/forward/to?type=designer" style="color: white;">设计师</a></li>
		<%--<li><a href="mobile/forward/to?type=index" style="color: white;">资讯</a></li>--%>
		<%--<li><a href="mobile/forward/to?type=index" style="color: white;">下载App</a></li>--%>
		<%--<li><a href="mobile/forward/to?type=index" style="color: white;">关于我们</a></li>--%>
	</ul>
	<input type="hidden" id="mobileUserId" value="${session_mobile_user.id}"/>
	<div class="searchBox" style="display:none;">
		<span id="searchType">商品</span>
		<input class="searchText" type="text" placeholder="请输入关键词信息" value="${name}"/>
		<ul class="typeList">
			<li>设计师</li>
			<li>作品</li>
			<li>商品</li>
		</ul>
	</div>

</div>
<script>
	var _bPath = "<%=_basePath%>";
	$(function(){
		$(".user").click(function(){
			if($("#mobileUserId").val() == ""){
				window.location.href = _bPath + "mobile/login/loginPage";
			}else{
				window.location.href = _bPath + "mobile/designer/detail?designerId="+$("#mobileUserId").val();
			}
		});
	});
</script>
