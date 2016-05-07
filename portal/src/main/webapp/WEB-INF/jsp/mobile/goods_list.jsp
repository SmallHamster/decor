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
		<title>搜索商品结果页</title>
		
		<script src="static/mobile/js/flexible.js"></script>
		<link rel="stylesheet" href="static/mobile/css/global.css">
		<link rel="stylesheet" href="static/mobile/css/index.css">
	</head>
	<body>

	<input type="hidden" id="cur-page" value="goods"/>
	<div class="search-condition" style="display: none;">
		<input type="hidden" class="kindTagId" value=""/>
		<input type="hidden" class="styleTagId" value=""/>
		<input type="hidden" class="spaceTagId" value=""/>
		<input type="hidden" class="name" value="${name}"/>
	</div>

	<%@ include file="common/header.jsp" %>
			<div class="filterBox" style="display:none;">
				在商品中，找到148个结果
				<a href="javascript:;" class="filterBtn">筛选</a>
				<div class="detailBox" style="display: none;">
					<div class="topWhite"></div>
					<div class="content">
						<div class="caret"></div>
						<div class="title">所属区域</div>
						<p>
							<span class="down">省份</span>
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
						<div class="title">所属区域</div>
						<ul class="tabsList clearfix">
							<li class="on">椅子</li>
							<li>桌子</li>
							<li>床</li>
							<li>地毯</li>
							<li>书架</li>
						</ul>
						<div class="conBottom clearfix">
							<a href="javascript:;">清空筛选条件</a>
							<div class="fr">
								<a href="javascript:;">取消</a>
								<a class="btn" href="javascript:;">确定</a>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="main">
			<div class="filterBox" style="display: block;">
				在商品中，找到<span id="totalNum">0</span>个结果
				<a href="javascript:;" class="filterBtn">筛选</a>
			</div>
			<div class="goodsBox bor0">
				<ul id="goodsList" class="goodsList4 clearfix">

				</ul>
			</div>
			<div class="moreTitle"><a href="javascript:;">加载更多</a></div>
		</div>
		<script src="static/mobile/js/jquery.min.js"></script>
		<script src="static/mobile/js/global.js"></script>

	<script type="text/javascript">
		$(function () {
			$(".moreTitle").click(function(){
				ajaxPageGoods();
			});
			ajaxPageGoods();
		});

		var page = {
			pageNum : 1,
			pageSize : 10,
			next:function(){
				page.pageNum += 1;
			}
		};
		function ajaxPageGoods(){
			var name = $(".search-condition").find(".name").val();
			$.ajax({
				url:'mobile/goods/page',
				method:'get',
				dataType:'json',
				data: {pageNum:page.pageNum,pageSize:page.pageSize,name:name},
				async: true,
				success: function (result) {
					if (result.status == "0") {
						page.next();
						$("#totalNum").html(result.data.page.totalNum);
						var html = '';
						for(var i=0;i<result.data.list.length;i++) {
							var goods = result.data.list[i];
							html += '<li>\
									<div class="imgWrap">\
									<a href="mobile/goods/detail?goodsId='+goods.id+'">\
									<img src="' + goods.cover + '" alt="" width="241" height="240">\
									</a>\
									</div>\
									<p><a href="mobile/goods/detail?goodsId='+goods.id+'">' + goods.name + '</a></p>\
									<div class="info clearfix">\
									<span class="view">' + goods.seeNum + '</span>\
									<span class="like">' + goods.praiseNum + '</span>\
									</div>\
									</li>';
						}
						$("#goodsList").append(html);
					}
				}
			});
		}


	</script>
	</body>
</html>
