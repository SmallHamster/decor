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
		<title>设计师搜索结果页</title>
		
		<script src="static/mobile/js/flexible.js"></script>
		<link rel="stylesheet" href="static/mobile/css/global.css">
		<link rel="stylesheet" href="static/mobile/css/index.css">
	</head>
	<body>
	<%@ include file="common/header.jsp" %>
		<div class="main">
			<div class="filterBox">
				在设计作品中，找到148个结果
				<a href="javascript:;" class="filterBtn">筛选</a>
				<div class="detailBox">
					<div class="topWhite"></div>
					<div class="content">
						<div class="caret"></div>
						<div class="title">所属区域</div>
						<p>
							<span class="orange down">省份</span>
							<span class="up">城市</span>
						</p>
						<ul class="tabsList clearfix">
							<li class="on">北京</li>
							<li>天津</li>
							<li>河北</li>
							<li>山西</li>
							<li>内蒙古</li>
							<li>辽宁</li>
							<li>吉林</li>
							<li>黑龙江</li>
							<li>江苏</li>
							<li>浙江</li>
							<li>安徽</li>
							<li>福建</li>
							<li>江西</li>
							<li>山东</li>
							<li>河南</li>
						</ul>
						<div class="addMore"><a href="javascript:;">加载更多</a></div>
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

			<ul class="designerList pt30">
				<li>
					<div class="imgBox">
						<img src="static/mobile/images/img1.jpg" alt="">
						<div class="headLogo">
							<a href="javascript:;">
								<img src="static/mobile/images/head_logo.png" alt="">
							</a>
						</div>
					</div>
					<div class="name"><a href="javascript:;">VALERIE CRESWICK</a></div>
					<div class="adress"><span>武汉</span><span>武汉</span></div>
					<div class="collect"><a href="javascript:;"><span>12万</span></a></div>
					<div class="works">112万</div>
				</li>
				<li>
					<div class="imgBox">
						<img src="static/mobile/images/img1.jpg" alt="">
						<div class="headLogo">
							<a href="javascript:;">
								<img src="static/mobile/images/head_logo.png" alt="">
							</a>
						</div>
					</div>
					<div class="name"><a href="javascript:;">VALERIE CRESWICK</a></div>
					<div class="adress"><span>武汉</span><span>武汉</span></div>
					<div class="collect"><a href="javascript:;"><span>12万</span></a></div>
					<div class="works">112万</div>
				</li>
			</ul>

			
		</div>
		<script src="static/mobile/js/jquery.min.js"></script>
		<script src="static/mobile/js/global.js"></script>
	</body>
</html>
