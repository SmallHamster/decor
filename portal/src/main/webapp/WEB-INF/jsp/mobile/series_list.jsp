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
		<title>作品搜索结果页</title>
		
		<script src="static/mobile/js/flexible.js"></script>
		<link rel="stylesheet" href="static/mobile/css/global.css">
		<link rel="stylesheet" href="static/mobile/css/index.css">
	</head>
	<body>

	<input type="hidden" id="cur-page" value="series"/>
	<div class="search-condition" style="display: none;">
		<input type="hidden" class="seriesTagId" value=""/>
		<input type="hidden" class="name" value="${name}"/>
	</div>

	<%@ include file="common/header.jsp" %>
		<div class="main">
			<div class="filterBox">
				在设计作品中，找到<span id="totalNum">0</span>个结果
				<a href="javascript:;" class="filterBtn">筛选</a>
				<div class="detailBox">
					<div class="topWhite"></div>
					<div class="content">
						<div class="caret"></div>
						<div class="title">作品分类</div>
						<ul class="tabsList clearfix seriesTagList">

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
			<ul class="worksList pt30">

			</ul>
			<div class="moreTitle"><a href="javascript:;">加载更多</a></div>
		</div>
	<script type="text/javascript">
		$(function () {
			$(".moreTitle").click(function(){
				ajaxPageSeries();
			});
			ajaxSeriesTagList();
			ajaxPageSeries();
			$(".goSearch").click(function(){
				$('.filterBox .conBottom .cancel').trigger("click");
				ajaxPageSeries(true);
			});
			$(".clearCondition").click(function(){
				$('.filterBox .tabsList').find("li").removeClass("on");
				$(".search-condition").find(".seriesTagId").val("");
			});
		});

		// 加载种类分类
		function ajaxSeriesTagList(){
			$.ajax({
				url:'pc/series/ajaxSeriesTagList',
				method:'get',
				dataType:'json',
				data: {},
				async: true,
				success: function (result) {
					if (result.status == "0") {
						var html = '';
						for(var i=0;i<result.data.length;i++){
							var seriesTag = result.data[i];
							html += '<li seriestagid="'+seriesTag.id+'">'+seriesTag.name+'</li>';
						}
						$(".seriesTagList").html(html);
						$(".seriesTagList").find("li").each(function(){
							$(this).click(function(){
								$(".search-condition").find(".seriesTagId").val($(this).attr("seriestagid"));
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
		function ajaxPageSeries(action){
			var name = $(".search-condition").find(".name").val();
			var seriesTagId = $(".search-condition").find(".seriesTagId").val();
			if(action){
				page.pageNum==1;
			}
			$.ajax({
				url:'mobile/series/page',
				method:'get',
				dataType:'json',
				data: {pageNum:page.pageNum,pageSize:page.pageSize,name:name,seriesTagId:seriesTagId},
				async: true,
				success: function (result) {
					if (result.status == "0") {
						page.next();
						$("#totalNum").html(result.data.page.totalNum);
						var html = '';
						for(var i=0;i<result.data.list.length;i++) {
							var obj = result.data.list[i];
							html += '<li>\
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
						if(action){
							$(".worksList").html(html);
						}else{
							$(".worksList").append(html);
						}
					}
				}
			});
		}

	</script>

	</body>
</html>
