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
		<title>系列图详情页</title>
		
		<script src="static/mobile/js/flexible.js"></script>
		<link rel="stylesheet" href="static/mobile/css/global.css">
		<link rel="stylesheet" href="static/mobile/css/index.css">
	</head>
	<body>

	<input type="hidden" id="seriesId" value="${series.id}">

	<%@ include file="common/header.jsp" %>
		<div class="main">
			<div class="userInfoBox">
				<div class="content">
					<div class="headBox">
						<img src="static/mobile/images/img4.jpg" alt="">
					</div>
					<div class="collect">
						<span>${series.praiseNum}</span>
					</div>
					<div class="name">
						ryel<span class="adress">${series.user.city.province.name}</span><span class="adress">${series.user.city.name}</span>
					</div>
					<div class="sign">${series.user.info}</div>
					<div class="others clearfix">
						<div class="works">作品 <span class="num">${userSeriesNum}</span></div>
						<div class="views">访问 <span class="num">${series.seeNum}</span></div>
					</div>
					<div class="share"></div>
				</div>
			</div>
			<div class="desBox">
				<h3 class="pt15">设计作品：${series.seriesTag.name}</h3>
				<p>创建时间：<fmt:formatDate pattern="yyyy年MM月" value="${series.createTime}"></fmt:formatDate></p>
				<p>${series.info}</p>
				<ul class="btnWrap">
					<a href="javascript:;" class="btn collect">${series.collectionNum}次收藏</a>
					<a href="javascript:;" class="btn share">分享给朋友</a>
				</ul>
				
			</div>
			<div class="goodsBox bor0">
				<h2>场景23个</h2>
			</div>
			<ul class="worksList">
				<li class="topScene">

				</li>
			</ul>

			<div class="goodsBox bor0">
				<h2>其他场景图</h2>
				<ul class="goodsList3 clearfix sceneList">

				</ul>
			</div>
			

			
		</div>
		<script src="static/mobile/js/jquery.min.js"></script>
		<script src="static/mobile/js/global.js"></script>
	<script>
		$(function(){
			findSceneListBySeriesId();
		});

		function findSceneListBySeriesId(){
			$.ajax({
				url:'mobile/series/findSceneListBySeriesId',
				method:'get',
				dataType:'json',
				data: {seriesId:$("#seriesId").val()},
				async: true,
				success: function (result) {
					if (result.status == "0") {
						$(".totalNum").html(result.data.length);
						var html = '';
						var topHtml = '';
						for(var i=0;i<result.data.length;i++){
							var obj = result.data[i];
							if(i == 0){
								topHtml+='<div class="imgBox">\
										<a href="mobile/scene/detail?sceneId='+obj.id+'"><img src="'+obj.image+'" alt=""></a>\
										</div>\
										<div class="info2">\
										<p><a href="mobile/scene/detail?sceneId='+obj.id+'">'+obj.name+'</a></p>\
										<span class="like">'+obj.praiseNum+'</span>\
										<span class="cmt">'+obj.commentNum+'</span>\
										</div>';
							}else {
								html+='<li>\
									<div class="imgWrap">\
									<a href="mobile/scene/detail?sceneId='+obj.id+'"><img src="'+obj.image+'" alt="" /></a>\
									</div>\
									<p><a href="mobile/scene/detail?sceneId='+obj.id+'">'+obj.name+'</a></p>\
									</li>';
							}
						}
						$(".topScene").html(topHtml);
						$(".sceneList").html(html);
					}
				}
			});
		}
	</script>
	</body>
</html>
