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

			</ul>

			<div class="moreTitle"><a href="mobile/forward/to?type=designer">更多设计师</a></div>
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

			</ul>
			<div class="moreTitle"><a href="javascript:;">更多设计作品</a></div>
		</div>
		<script src="static/mobile/js/jquery.min.js"></script>
		<script src="static/mobile/js/global.js"></script>
	<script>
		$(function(){
			ajaxDesigner(); // 查询两个设计师显示在首页
			ajaxRecommendMessage(); // 加载推荐的咨询
		});

		function ajaxDesigner(){
			$.ajax({
				url:'mobile/homepage/ajaxDesigner',
				method:'get',
				dataType:'json',
				data: {},
				async: true,
				success: function (result) {
					if (result.status == "0") {
						var html = '';
						for(var i=0;i<result.data.length;i++){
							var designer = result.data[i];
							html+='<li>\
									<div class="imgBox">\
									<a href="mobile/designer/detail?designerId='+designer.id+'"><img src="'+designer.backgroundImage+'" alt=""></a>\
									<div class="headLogo">\
									<a href="javascript:;"><img src="'+designer.headImage+'" alt=""></a>\
									</div>\
									</div>\
									<div class="name"><a href="mobile/designer/detail?designerId='+designer.id+'">'+designer.nickname+'</a></div>\
									<div class="adress"><span>'+designer.city.province.name+'</span><span>'+designer.city.name+'</span></div>\
									<div class="collect"><a href="javascript:;"><span>'+designer.fans+'</span></a></div>\
									<div class="works">'+designer.opus+'</div>\
									</li>';
						}
						$(".designerList").html(html);
					}
				}
			});
		}

		// 查询推荐的咨询
		function ajaxRecommendMessage(){
			$.ajax({
				url:'mobile/homepage/ajaxRecommendMessage',
				method:'get',
				dataType:'json',
				data: {},
				async: true,
				success: function (result) {
					if (result.status == "0") {
						var html = '';
						for(var i=0;i<result.data.length;i++){
							var message = result.data[i];
							html+='<li class="clearfix">\
								<div class="imgBox">\
								<a href="mobile/message/detail?messageId='+message.id+'"><img src="'+message.image+'" alt=""></a>\
								</div>\
								<div class="content">\
								<div class="title"><a href="mobile/message/detail?messageId='+message.id+'">'+message.title+'</a></div>\
								<div class="time">'+message.createTime+'</div>\
								<div class="btn"><a href="javascript:;">设计交流</a></div>\
								</div>\
								</li>';
						}
						$(".infoList").html(html);
					}
				}
			});
		}
	</script>
	</body>
</html>
