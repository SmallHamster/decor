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
		<div class="main">
			<div class="filterBox" style="display: block;">
				在商品中，找到<span id="totalNum">0</span>个结果
				<a href="javascript:;" class="filterBtn">筛选</a>
				<div class="detailBox">
					<div class="topWhite"></div>
					<div class="content">
						<div class="caret"></div>
						<div class="title">产品分类</div>
						<ul class="tabsList clearfix kindTagList">

						</ul>
						<div class="title">空间分类</div>
						<ul class="tabsList clearfix spaceTagList">

						</ul>
						<div class="title">风格分类</div>
						<ul class="tabsList clearfix styleTagList">

						</ul>
						<div class="conBottom clearfix">
							<a class="clearCondition" href="javascript:;">清空筛选条件</a>
							<div class="fr">
								<a href="javascript:;" class="cancel">取消</a>
								<a class="btn goSearch" href="javascript:;">确定</a>
							</div>

						</div>
					</div>
				</div>
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
			ajaxKindTagList(); // 加载种类分类
			ajaxStyleTagList(); // 加载风格分类
			ajaxSpaceTagList(); // 加载空间分类
			ajaxPageGoods(true);
			$(".goSearch").click(function(){
				$('.filterBox .conBottom .cancel').trigger("click");
				ajaxPageGoods(true);
			});
			$(".clearCondition").click(function(){
				$('.filterBox .tabsList').find("li").removeClass("on");
				$(".search-condition").find(".kindTagId").val("");
				$(".search-condition").find(".styleTagId").val("");
				$(".search-condition").find(".spaceTagId").val("");
			});
		});

		// 加载种类分类
		function ajaxKindTagList(){
			$.ajax({
				url:'pc/comm/ajaxKindTagList',
				method:'get',
				dataType:'json',
				data: {},
				async: true,
				success: function (result) {
					if (result.status == "0") {
						var html = '';
						for(var i=0;i<result.data.length;i++){
							var obj = result.data[i];
							html += '<li objid="'+obj.id+'">'+obj.name+'</li>';
						}
						$(".kindTagList").html(html);
						$(".kindTagList").find("li").each(function(){
							$(this).click(function(){
								$(".search-condition").find(".kindTagId").val($(this).attr("objid"));
							});
						});
					}
				}
			});
		}

		// 加载风格分类
		function ajaxStyleTagList(){
			$.ajax({
				url:'pc/comm/ajaxStyleTagList',
				method:'get',
				dataType:'json',
				data: {},
				async: true,
				success: function (result) {
					if (result.status == "0") {
						var html = '';
						for(var i=0;i<result.data.length;i++){
							var obj = result.data[i];
							html += '<li objid="'+obj.id+'">'+obj.name+'</li>';
						}
						$(".styleTagList").html(html);
						$(".styleTagList").find("li").each(function(){
							$(this).click(function(){
								$(".search-condition").find(".styleTagId").val($(this).attr("objid"));
							});
						});
					}
				}
			});
		}

		// 加载空间分类
		function ajaxSpaceTagList(){
			$.ajax({
				url:'pc/comm/ajaxSpaceTagList',
				method:'get',
				dataType:'json',
				data: {},
				async: true,
				success: function (result) {
					if (result.status == "0") {
						var html = '';
						for(var i=0;i<result.data.length;i++){
							var obj = result.data[i];
							html += '<li objid="'+obj.id+'">'+obj.name+'</li>';
						}
						$(".spaceTagList").html(html);
						$(".spaceTagList").find("li").each(function(){
							$(this).click(function(){
								$(".search-condition").find(".spaceTagId").val($(this).attr("objid"));
							});
						});
					}
				}
			});
		}

		var page = {
			pageNum : 1,
			pageSize : 10,
			next:function(){
				page.pageNum += 1;
			}
		};
		function ajaxPageGoods(action){
			var name = $(".search-condition").find(".name").val();
			var kindTagId = $(".search-condition").find(".kindTagId").val();
			var styleTagId = $(".search-condition").find(".styleTagId").val();
			var spaceTagId = $(".search-condition").find(".spaceTagId").val();
			if(action){
				page.pageNum==1;
			}
			$.ajax({
				url:'mobile/goods/page',
				method:'get',
				dataType:'json',
				data: {pageNum:page.pageNum,pageSize:page.pageSize,name:name,kindTagId:kindTagId,styleTagId:styleTagId,spaceTagId:spaceTagId},
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
						if(action){
							$("#goodsList").html(html);
						}else{
							$("#goodsList").append(html);
						}
					}
				}
			});
		}


	</script>
	</body>
</html>
