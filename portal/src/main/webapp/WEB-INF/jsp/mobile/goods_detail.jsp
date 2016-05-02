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
		<title>商品详情页</title>
		
		<script src="static/mobile/js/flexible.js"></script>
		<link rel="stylesheet" href="static/mobile/css/global.css">
		<link rel="stylesheet" href="static/mobile/css/index.css">
	</head>
	<body>
	<%@ include file="common/header.jsp" %>

	<input type="hidden" id="goodsId" value="${goods.id}"/>

		<div class="main">
			
			<div class="goodsBanner">
				<div class="imgWrap">
					<c:forEach var="goodsImage" items="${goods.goodsImageList}">
						<a href="javascript:;">
							<img src="${goodsImage.image}" alt="">
						</a>
					</c:forEach>
				</div>
				<ul class="clearfix">
					<c:forEach var="goodsImage" items="${goods.goodsImageList}">
						<li class="cur">
							<img src="${goodsImage.image}" alt="">
							<div class="mask"></div>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="desBox">
				<h3>${goods.name}</h3>
				<ul class="labs clearfix">
					${tagHtml}
				</ul>
				<p>${goods.info}</p>
				<div class="info">
					<span class="star">${goods.praiseNum}</span>
					<span class="cmt">${commentNum}</span>
				</div>
			</div>
			<div class="commentsBox">
				<div class="caret"></div>
				<ul class="commentsList">
					<c:forEach var="comment" items="${commentList}">
						<li>
							<div class="name clearfix">${comment.user.nickname}<span class="time">${comment.createTime}</span></div>
							<p>${comment.content}</p>
						</li>
					</c:forEach>
				</ul>
				<div class="cmtBottom">
					<a href="javascript:;" class="link">更多评价</a>
					<a href="javascript:;" class="link orange">添加评价</a>
				</div>
			</div>
			<div class="goodsBox">
				<div class="topLine"></div>
				<h2>商品参数</h2>
				<div class="paramsBox">
					<dl class="clearfix">
						<dt>尺寸：</dt>
						<dd class="first">${goods.size}</dd>
						<dt>材料：</dt>
						<dd>${goods.texture}</dd>
					</dl>
				</div>
			</div>
			<div class="goodsBox">
				<div class="topLine"></div>
				<h2>商品所属场景</h2>
				<ul id="sceneList" class="goodsList2 clearfix">

				</ul>
			</div>
			<div class="goodsBox">
				<h2>同类推荐</h2>
				<ul id="sameList" class="goodsList clearfix">

				</ul>
			</div>
		</div>
		<script src="static/mobile/js/jquery.min.js"></script>
		<script src="static/mobile/js/global.js"></script>
		<script>
			$(function(){
				//banner交互
				var banner = $('.goodsBanner');
				var imgWrap = $('.goodsBanner .imgWrap');
				var list = $('.goodsBanner ul');
				//初始化
				imgWrap.find('>a').eq(0).css('display','block').siblings().css('display','none');
				list.find('li').eq(0).addClass('cur').siblings().removeClass('cur');
				//点击切换
				list.on('click','li',function(){
					var $this = $(this);
					var index = $this.index();
					console.log(index);
					$this.addClass('cur').siblings().removeClass('cur');
					imgWrap.find('>a').eq(index).css('display','block').siblings().css('display','none');
				});

				ajaxSceneByGoodsId($("#goodsId").val());
				ajaxSameTypeGoods($("#goodsId").val());
			});

			// 加载商品所属场景图
			function ajaxSceneByGoodsId(goodsId) {
				$.ajax({
					url:'mobile/goods/ajaxSceneByGoodsId',
					method:'get',
					dataType:'json',
					data: {goodsId: goodsId},
					async: true,
					success: function (result) {
						if (result.data.length > 0) {
							var html = '';
							for (var i = 0; i < result.data.length; i++) {
								var scene = result.data[i];
								html+='<li>\
										<a href="pc/scene/detail?sceneId=' + scene.id + '">\
										<img src="' + scene.image + '" alt="">\
										</a>\
										</li>';
							}
							$("#sceneList").html(html);
						}
					}
				});
			}

			// 加载同类型商品
			function ajaxSameTypeGoods(goodsId) {
				$.ajax({
					url:'mobile/goods/ajaxSameTypeGoods',
					method:'get',
					dataType:'json',
					data: {goodsId: goodsId},
					async: true,
					success: function (result) {
						if (result.data.length > 0) {
							var html = '';
							for (var i = 0; i < result.data.length; i++) {
								var goods = result.data[i];
								html+='<li>\
										<div class="imgBox">\
										<a href="mobile/goods/detail?goodsId=' + goods.id + '"><img src="'+goods.cover+'" alt=""></a>\
										</div>\
										<div class="name">\
										<a href="mobile/goods/detail?goodsId=' + goods.id + '">'+goods.name+'</a>\
										</div>\
										</li>';
							}
							$("#sameList").html(html);
						}
					}
				});
			}
		</script>
	</body>
</html>
