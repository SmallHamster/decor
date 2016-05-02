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
		<title>首页</title>
		
		<script src="static/mobile/js/flexible.js"></script>
		<link rel="stylesheet" href="static/mobile/css/global.css">
		<link rel="stylesheet" href="static/mobile/css/index.css">
	</head>
	<style>
		.topBox img {
			width: 71px;
			height: 71px;
		}
	</style>
	<body>
	<%@ include file="common/header.jsp" %>
		<div class="main">
			<div class="topBox">
				<div class="mask"></div>
				<div class="content">
					<div class="logo">
						<img src="static/mobile/images/main_logo.png" alt="">
					</div>
					<h3>就现在，改变设计方式</h3>
					<p>${designerNum}名室内设计师</p>
					<p>选择Decor平台，表达设计新主张</p>
					<div class="icons">
						<div class="icon icon1">
							<img src="static/mobile/images/top_icon1.png" alt="">
							<div class="text">海量·资源</div>
						</div>
						<div class="icon icon2">
							<img src="static/mobile/images/top_icon2.png" alt="">
							<div class="text">享受·体验</div>
						</div>
						<div class="icon icon3">
							<img src="static/mobile/images/top_icon3.png" alt="">
							<div class="text">发现·设计</div>
						</div>
						<div class="icon icon4">
							<img src="static/mobile/images/top_icon4.png" alt="">
							<div class="text">崇尚·创意</div>
						</div>
					</div>
				</div>
			</div>
			<a href="javascript:;" class="blackBtn">现在加入</a>
			<div class="titleBox">
				<h3>你的设计，正在改变生活</h3>
				<p>一键入驻，海量资源</p>
			</div>
			<ul class="designerList">
				<li>
					<div class="imgBox">
						<img src="static/mobile/images/img1.jpg" alt="">
						<div class="headLogo">
							<a href="javascript:;"><img src="static/mobile/images/head_logo.png" alt=""></a>
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
							<a href="javascript:;"><img src="static/mobile/images/head_logo.png" alt=""></a>
						</div>
					</div>
					<div class="name"><a href="javascript:;">VALERIE CRESWICK</a></div>
					<div class="adress"><span>武汉</span><span>武汉</span></div>
					<div class="collect"><a href="javascript:;"><span>12万</span></a></div>
					<div class="works">112万</div>
				</li>
			</ul>

			<div class="moreTitle"><a href="javascript:;">更多设计师</a></div>
			<div class="titleBox">
				<h3>这里，更好的设计</h3>
				<p>正在发生</p>
			</div>
			<ul class="worksList">
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

			<div class="moreTitle"><a href="javascript:;">更多设计作品</a></div>
			<div class="titleBox">
				<h3>更多行业内幕资讯</h3>
				<p>只在DECOR</p>
			</div>
			<ul class="infoList">
				<li class="clearfix">
					<div class="imgBox">
						<img src="static/mobile/images/img3.jpg" alt="">
					</div>
					<div class="content">
						<div class="title"><a href="javascript:;">哈尔滨大剧院获评世界最佳建筑</a></div>
						<div class="time">2016-04-05</div>
						<div class="btn"><a href="javascript:;">设计交流</a></div>
					</div>
				</li>
				<li class="clearfix">
					<div class="imgBox">
						<img src="static/mobile/images/img3.jpg" alt="">
					</div>
					<div class="content">
						<div class="title"><a href="javascript:;">哈尔滨大剧院获评世界最佳建筑</a></div>
						<div class="time">2016-04-05</div>
						<div class="btn"><a href="javascript:;">设计交流</a></div>
					</div>
				</li>
				<li class="clearfix">
					<div class="imgBox">
						<img src="static/mobile/images/img3.jpg" alt="">
					</div>
					<div class="content">
						<div class="title"><a href="javascript:;">哈尔滨大剧院获评世界最佳建筑</a></div>
						<div class="time">2016-04-05</div>
						<div class="btn"><a href="javascript:;">设计交流</a></div>
					</div>
				</li>
				<li class="clearfix">
					<div class="imgBox">
						<img src="static/mobile/images/img3.jpg" alt="">
					</div>
					<div class="content">
						<div class="title"><a href="javascript:;">哈尔滨大剧院获评世界最佳建筑</a></div>
						<div class="time">2016-04-05</div>
						<div class="btn"><a href="javascript:;">设计交流</a></div>
					</div>
				</li>
			</ul>
			<div class="moreTitle"><a href="javascript:;">更多设计作品</a></div>
		</div>
		<script src="static/mobile/js/jquery.min.js"></script>
		<script src="static/mobile/js/global.js"></script>
	</body>
</html>
