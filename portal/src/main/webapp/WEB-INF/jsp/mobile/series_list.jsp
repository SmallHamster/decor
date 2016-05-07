<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/taglibs.jsp" %>
<%@ include file="common/meta.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="UTF-8">
		<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
		<meta content="no-cache" http-equiv="pragma">
		<meta content="0" http-equiv="expires">
		<meta content="telephone=no, address=no" name="format-detection">
		<meta name="apple-mobile-web-app-capable" content="yes"> 
		<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
		<title>作品搜索结果页</title>
		
		<script src="static/mobile/js/flexible.js"></script>
		<link rel="stylesheet" href="static/mobile/css/global.css">
		<link rel="stylesheet" href="static/mobile/css/index.css">
	</head>
	<body>

	<input type="hidden" id="cur-page" value="series"/>
	<div class="search-condition" style="display: none;">
		<input type="hidden" class="name" value="${name}"/>
	</div>

	<%@ include file="common/header.jsp" %>
		<div class="main">
			<div class="filterBox">
				在设计作品中，找到148个结果
				<a href="javascript:;" class="filterBtn">筛选</a>
				<div class="detailBox">
					<div class="topWhite"></div>
					<div class="content">
						<div class="caret"></div>
						<div class="title">产品分类</div>
						<ul class="tabsList clearfix">
							<li class="on">椅子</li>
							<li>桌子</li>
							<li>床</li>
							<li>地毯</li>
							<li>书架</li>
						</ul>
						<div class="title">空间分类</div>
						<ul class="tabsList clearfix">
							<li class="on">卧室</li>
							<li>厨房</li>
							<li>客厅</li>
							<li>书房</li>
							<li>卫生间</li>
						</ul>
						<div class="title">风格分类</div>
						<ul class="tabsList clearfix">
							<li class="on">卧室</li>
							<li>厨房</li>
							<li>客厅</li>
							<li>书房</li>
							<li>卫生间</li>
						</ul>
						<div class="conBottom clearfix">
							<a href="javascript:;">清空筛选条件</a>
							<div class="fr">
								<a href="javascript:;" class="cancel">取消</a>
								<a class="btn" href="javascript:;">确定</a>
							</div>
							
						</div>
					</div>
				</div>
			</div>
			<ul class="worksList pt30">
				<li>
					<div class="imgBox">
						<img src="static/mobile/images/img2.jpg" alt="">
					</div>
					<div class="name"><a href="javascript:;">美式卧榻最美好夏日回忆</a></div>
					<div class="info">
						<span class="view">1159</span>
						<span class="like">1159</span>
					</div>
				</li>
				<li>
					<div class="imgBox">
						<img src="static/mobile/images/img2.jpg" alt="">
					</div>
					<div class="name"><a href="javascript:;">美式卧榻最美好夏日回忆</a></div>
					<div class="info">
						<span class="view">1159</span>
						<span class="like">1159</span>
					</div>
				</li>
			</ul>
			
		</div>
		<script src="static/mobile/js/jquery.min.js"></script>
		<script src="static/mobile/js/global.js"></script>
	</body>
</html>
