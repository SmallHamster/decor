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
	</head>
	<body>
	<%@ include file="common/header.jsp" %>
		<div class="main">
			<div class="userInfoBox">
				<div class="content">
					<div class="headBox">
						<a href="mobile/designer/detail?designerId=${scene.user.id}"><img src="${scene.user.headImage}" alt=""></a>
					</div>
					<div class="collect">
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
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<div class="imgWrap">
								<a href="javascript:;"><img src="static/mobile/images/img3.jpg" alt="" /></a>
							</div>
						</div>
						<div class="swiper-slide">
							<div class="imgWrap">
								<a href="javascript:;"><img src="static/mobile/images/img4.jpg" alt="" /></a>
							</div>
						</div>
						<div class="swiper-slide">
							<div class="imgWrap">
								<a href="javascript:;"><img src="static/mobile/images/img5.jpg" alt="" /></a>
							</div>
						</div>
					</div>
					<div class="swiper-button-prev"></div>
                	<div class="swiper-button-next"></div>
				</div>
			</div>
			<div class="desBox">
				<h3><a href="javascript:;">白蜡木贴面利萨伯茶几</a></h3>
				<p>来自系列图：<a href="javascript:;">我在海边的木头房子里面患过伤风</a></p>
				<p>灰色木板桌面和采用桦木贴面的桌腿，给房间带来温暖自然的感觉。 每条支腿仅有一个配件，组装方便。</p>
				<div class="info">
					<span class="like">285</span>
					<span class="star">285</span>
					<span class="cmt">285</span>
				</div>
			</div>
			<div class="commentsBox">
				<div class="caret"></div>
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
				<div class="cmtBottom">
					<a href="javascript:;" class="link">更多评价</a>
					<a href="javascript:;" class="link orange">添加评价</a>
				</div>
			</div>
			<div class="goodsBox">
				<h2>场景中的商品（4）</h2>
				<ul class="goodsList clearfix">
					<li>
						<div class="imgBox">
							<img src="static/mobile/images/img6.jpg" alt="">
						</div>
						<div class="name">
							<a href="javascript:;">arhaus-chairs-0110</a>
						</div>
					</li>
					<li>
						<div class="imgBox">
							<img src="static/mobile/images/img6.jpg" alt="">
						</div>
						<div class="name">
							<a href="javascript:;">arhaus-chairs-0110</a>
						</div>
					</li>
					<li>
						<div class="imgBox">
							<img src="static/mobile/images/img6.jpg" alt="">
						</div>
						<div class="name">
							<a href="javascript:;">arhaus-chairs-0110</a>
						</div>
					</li>
					<li>
						<div class="imgBox">
							<img src="static/mobile/images/img6.jpg" alt="">
						</div>
						<div class="name">
							<a href="javascript:;">arhaus-chairs-0110</a>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<script src="static/mobile/js/jquery.min.js"></script>
		<script src="static/mobile/js/swiper.jquery.min.js"></script>
		<script src="static/mobile/js/global.js"></script>
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
			});
		</script>
	</body>
</html>
