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
		<title>场景详情页</title>
		
		<script src="static/mobile/js/flexible.js"></script>
		<link rel="stylesheet" href="static/mobile/css/swiper.min.css">
		<link rel="stylesheet" href="static/mobile/css/global.css">
		<link rel="stylesheet" href="static/mobile/css/index.css">
		<style>
			.bannerWrap {
				height: auto;
			}
			.bannerWrap .imgWrap {
				height: auto;
			}
			.bannerWrap .imgWrap a {
				position: relative;
				height: auto;}
			.bannerWrap .imgWrap img {
				width: auto;
				height: auto;
			}
		</style>
	</head>
	<body>
	<%@ include file="common/header.jsp" %>
		<div class="main">
			<div class="userInfoBox" style="height: auto">
				<div class="content" style="height: auto">
					<input type="hidden" id="creator" value="${scene.user.id}"/>
					<div class="headBox">
						<a href="mobile/designer/detail?designerId=${scene.user.id}"><img src="${scene.user.headImage}" alt=""></a>
					</div>
					<div id="attention" class="collect">
						<span>${scene.user.fans}</span>
					</div>
					<div class="name">
						${scene.user.nickname}<span class="adress">${scene.user.city.province.name}</span><span class="adress">${scene.user.city.name}</span>
					</div>
					<div class="sign">${scene.user.info}</div>
					<div class="others clearfix">
						<div class="works">作品 <span class="num">${userSeriesNum}</span></div>
						<div class="views">访问 <span class="num">${scene.user.seeNum}</span></div>
					</div>
					<div class="share"><a href="javascript;"></a></div>
				</div>
			</div>
			<div class="bannerWrap">
							<div class="imgWrap">
								<a href="javascript:;"><img src="${scene.image}" alt="" /></a>
							</div>
			</div>
			<div class="desBox">
				<h3><a href="javascript:;">${scene.name}</a></h3>
				<p>来自系列图：<a href="javascript:;">${comeFromSeries}</a></p>
				<p>${scene.info}</p>
				<div class="info">
					<span class="like">${scene.praiseNum}</span>
					<span class="star">${scene.collectionNum}</span>
					<span id="commentNum" class="cmt">${commentNum}</span>
				</div>
			</div>
			<div class="commentsBox">
				<div class="caret"></div>
				<ul class="commentsList">
					<c:forEach var="comment" items="${commentList}">
						<li>
							<div class="name clearfix">${comment.user.nickname} <span class="time">${comment.createTime}</span></div>
							<p>${comment.content}</p>
						</li>
					</c:forEach>
				</ul>
				<div class="cmtBottom">
					<a href="javascript:;" class="link">更多评价</a>
				</div>
			</div>
			<div class="goodsBox">
				<h2>场景中的商品（${goodsNum}）</h2>
				<ul class="goodsList clearfix">
					<c:forEach var="goods" items="${goodsList}">
						<li>
							<div class="imgBox">
								<a href="mobile/goods/detail?goodsId=${goods.id}"><img src="${goods.cover}?imageView2/1/w/113/h/113" alt=""></a>
							</div>
							<div class="name">
								<a href="javascript:;">${goods.name}</a>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<script src="static/mobile/js/swiper.jquery.min.js"></script>
		<script>
			$(function(){
				var bannerBox = $('.bannerWrap');
				
				//swiper 插件调用
				var mySwiper = new Swiper ('.swiper-container', {
				    direction: 'horizontal',
				    loop: false,
				    
				    
				    // 如果需要前进后退按钮
				    nextButton: '.swiper-button-next',
				    prevButton: '.swiper-button-prev',
				    onSlideChangeEnd: function(swiper){
				      	console.log(swiper.activeIndex);
				    }
				    
			  	});

				if($("#commentNum").html()=="0"){
					$(".commentsBox").hide();
				}

				handlerAttention();
			});

			// 处理关注状态
			function handlerAttention() {
				var fansId = $("#mobileUserId").val();
				var userId = $("#creator").val();
				var flag = commFun.isAttention(userId, fansId);
				$("#attention").unbind("click").click(function () {
					if($("#mobileUserId").val() == ""){
						window.location.href = _bPath + "mobile/login/loginPage";
						return false;
					}
					if (!flag) {
						commFun.attention(userId, fansId, function (result) {
							if (result.status == "0") {
								location.reload();
							}
						});
					}
					else{
						commFun.cancelAttention(userId, fansId, function (result) {
							if (result.status == "0") {
								location.reload();
							}
						});
					}
				});
			}
		</script>
	</body>
</html>
