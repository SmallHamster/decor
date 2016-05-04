<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.filterBox{
		z-index: 0;
	}
</style>
<div class="header clearfix">
	<div class="btn nav"></div>
	<div class="btn logo"></div>
	<div class="btn user"><a href="javascript:;"></a></div>
	<div class="btn search"></div>
	<ul class="list">
		<li><a href="mobile/forward/to?type=index" style="color: white;">首页</a></li>
		<li><a href="mobile/forward/to?type=goods" style="color: white;">图库</a></li>
		<li><a href="mobile/forward/to?type=goods" style="color: white;">商品</a></li>
		<li><a href="mobile/forward/to?type=designer" style="color: white;">设计师</a></li>
		<li><a href="mobile/forward/to?type=index" style="color: white;">资讯</a></li>
		<li><a href="mobile/forward/to?type=index" style="color: white;">下载App</a></li>
		<li><a href="mobile/forward/to?type=index" style="color: white;">关于我们</a></li>
	</ul>
	<div class="searchBox" style="display:none;">
		<span id="searchType">商品</span>
		<input class="searchText" type="text" placeholder="VALERIE CRESWICK" value="${name}"/>
		<ul class="typeList">
			<li>设计师</li>
			<li>作品</li>
			<li>商品</li>
		</ul>
	</div>

</div>
<script>
</script>
