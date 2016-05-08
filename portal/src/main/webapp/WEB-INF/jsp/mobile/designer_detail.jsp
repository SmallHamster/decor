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
		<title>设计师详情页</title>
		
		<script src="static/mobile/js/flexible.js"></script>
		<link rel="stylesheet" href="static/mobile/css/global.css">
		<link rel="stylesheet" href="static/mobile/css/index.css">
	</head>
	<body>

	<input type="hidden" id="userId" value="${user.id}">

	<%@ include file="common/header.jsp" %>
		<div class="main">
			<div class="userInfoBox">
				<div class="content">
					<div class="headBox">
						<img src="static/mobile/images/img4.jpg" alt="">
					</div>
					<div class="collect">
						<span>${user.fans}</span>
					</div>
					<div class="name">
						${user.nickname}<span class="adress">${user.city.province.name}</span><span class="adress">${user.city.name}</span>
					</div>
					<div class="sign">把目标设定为完美，结果才可能及格</div>
					<div class="others clearfix">
						<div class="works">作品 <span class="num totalNum">0</span></div>
						<div class="views">访问 <span class="num">${user.seeNum}</span></div>
					</div>
					<div class="share"></div>
				</div>
			</div>
			<div class="goodsBox bor0">
				<h2><span class="totalNum">0</span>个设计作品</h2>
			</div>
			<ul class="worksList seriesList">

			</ul>
			<div class="moreTitle"><a href="javascript:;">查看全部作品</a></div>
			<div class="goodsBox bor0">
				<h2>134条评价</h2>
			</div>
			<div class="commentsBox white">
				<ul class="commentsList">
					<li>
						<div class="name clearfix">陈进 <span class="time">1天前</span></div>
						<p>交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题，帮助我们完成设计。</p>
					</li>
					<li>
						<div class="name clearfix">陈进 <span class="time">1天前</span></div>
						<p>交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题，帮助我们完成设计。</p>
					</li>
					<li>
						<div class="name clearfix">陈进 <span class="time">1天前</span></div>
						<p>交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题，帮助我们完成设计。</p>
					</li>
				</ul>
				
			</div>
			<div class="moreTitle"><a href="javascript:;">查看全部作品</a></div>
			
		</div>
		<script src="static/mobile/js/jquery.min.js"></script>
		<script src="static/mobile/js/global.js"></script>
	<script>
		$(function(){
			userSeries();
			$(".moreTitle").click(function(){
				userSeries(true);
			});
		});

		function userSeries(action){
			var pageNum = 1;
			var pageSize = 2;
			if(action){
				pageSize = 10000;
			}
			$.ajax({
				url:'mobile/series/userSeries',
				method:'get',
				dataType:'json',
				data: {pageNum:pageNum,pageSize:pageSize,userId:$("#userId").val()},
				async: true,
				success: function (result) {
					if (result.status == "0") {
						$(".totalNum").html(result.data.page.totalNum);
						var html = '';
						for(var i=0;i<result.data.list.length;i++){
							var obj = result.data.list[i];
							html+='<li>\
									<div class="imgBox">\
									<a href="mobile/series/detail?seriesId='+obj.id+'"><img src="'+obj.cover+'" alt=""></a>\
									</div>\
									<div class="name"><a href="mobile/series/detail?seriesId='+obj.id+'">'+obj.seriesTag.name+'</a></div>\
									<div class="info">\
									<span class="view">'+obj.seeNum+'</span>\
									<span class="like">'+obj.praiseNum+'</span>\
									</div>\
									</li>';
						}
						$(".seriesList").html(html);
					}
				}
			});
		}
	</script>
	</body>
</html>
