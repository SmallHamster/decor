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
		<title>设计师搜索结果页</title>
		
		<script src="static/mobile/js/flexible.js"></script>
		<link rel="stylesheet" href="static/mobile/css/global.css">
		<link rel="stylesheet" href="static/mobile/css/index.css">
	</head>
	<body>

	<input type="hidden" id="cur-page" value="designer"/>
	<div class="search-condition" style="display: none;">
		<input type="hidden" class="provinceId" value=""/>
		<input type="hidden" class="cityId" value=""/>
		<input type="hidden" class="name" value="${name}"/>
	</div>

	<%@ include file="common/header.jsp" %>
		<div class="main">
			<div class="filterBox">
				在设计师中，找到<span id="totalNum">0</span>个结果
				<a href="javascript:;" class="filterBtn">筛选</a>
				<div class="detailBox">
					<div class="topWhite"></div>
					<div class="content">
						<div class="caret"></div>
						<div class="title">所属区域</div>
						<p>
							<span class="orange down provinceTab">省份</span>
							<span class="up cityTab">城市</span>
						</p>
						<ul class="tabsList clearfix provinceList">

						</ul>
						<ul class="tabsList clearfix cityList" style="display:none">

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

			<ul class="designerList pt30">

			</ul>

			<div class="moreTitle"><a href="javascript:;">加载更多</a></div>
		</div>
	<script type="text/javascript">
		$(function () {
			$(".provinceTab").click(function(){
				$(this).addClass("down").removeClass("up").addClass("orange");
				$(".cityTab").addClass("up").removeClass("down").removeClass("orange");
				$(".provinceList").show();
				$(".cityList").hide();
			});
			$(".cityTab").click(function(){
				$(this).addClass("down").removeClass("up").addClass("orange");
				$(".provinceTab").addClass("up").removeClass("down").removeClass("orange");
				$(".cityList").show();
				$(".provinceList").hide();
			});
			ajaxShowProvince();
			$(".moreTitle").click(function(){
				ajaxPageDesigner();
			});
			ajaxPageDesigner();
			$(".goSearch").click(function(){
				$('.filterBox .conBottom .cancel').trigger("click");
				ajaxPageDesigner(true);
			});
			$(".clearCondition").click(function(){
				$('.filterBox .tabsList').find("li").removeClass("on");
				$(".search-condition").find(".provinceId").val("");
				$(".search-condition").find(".cityList").val("");
				$('.filterBox .conBottom .cancel').trigger("click");
			});
		});

		/*显示所有省份*/
		function ajaxShowProvince() {
			$.ajax({
				url:'pc/user/showProvince',
				method:'get',
				dataType:'json',
				data: {},
				async: true,
				success: function (result) {
					if (result.status == "0") {
						var html='';
						for (var i = 0; i < result.data.length; i++) {
							var province = result.data[i];
							var provinceName = province.name;
							html += '<li provinceid="'+province.id+'">' + provinceName + '</li>';
						}
						$(".provinceList").html(html);
						$(".provinceList").find("li").each(function(){
							$(this).click(function(){
								$(".search-condition").find(".provinceid").val($(this).attr("provinceid"));
								ajaxShowCity($(this).attr("provinceid"));
							});
						});
					}
				}
			});
		}

		/*点击获得省份下的城市*/
		function ajaxShowCity(provinceId) {
			$.ajax({
				url:'pc/user/showCity',
				method:'get',
				dataType:'json',
				data: {provinceId: provinceId},
				async: true,
				success: function (result) {
					if (result.status == "0") {
						var html='';
						for (var i = 0; i < result.data.length; i++) {
							var city = result.data[i];
							html += '<li cityid="'+city.id+'">' + city.name + '</li>';
						}
						$(".cityList").html(html);
						$(".cityList").find("li").each(function(){
							$(this).click(function(){
								$(".search-condition").find(".cityId").val($(this).attr("cityid"));
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
		function ajaxPageDesigner(action){
			var name = $(".search-condition").find(".name").val();
			var provinceId = $(".search-condition").find(".provinceId").val();
			var cityId = $(".search-condition").find(".cityId").val();
			if(action){
				page.pageNum==1;
			}
			$.ajax({
				url:'mobile/designer/page',
				method:'get',
				dataType:'json',
				data: {pageNum:page.pageNum,pageSize:page.pageSize,name:name,provinceId:provinceId,cityId:cityId},
				async: true,
				success: function (result) {
					if (result.status == "0") {
						page.next();
						$("#totalNum").html(result.data.page.totalNum);
						var html = '';
						for(var i=0;i<result.data.list.length;i++){
							var designer = result.data.list[i];
							html+='<li>\
								<div class="imgBox">\
								<a href="mobile/designer/detail?designerId='+designer.id+'"><img src="'+designer.backgroundImage+'" alt=""></a>\
								<div class="headLogo">\
								<a href="mobile/designer/detail?designerId='+designer.id+'"><img src="'+designer.headImage+'?imageView2/1/w/104/h/104" alt=""></a>\
								</div>\
								</div>\
								<div class="name"><a href="mobile/designer/detail?designerId='+designer.id+'">'+designer.nickname+'</a></div>\
								<div class="adress"><span>'+designer.city.province.name+'</span><span>'+designer.city.name+'</span></div>\
								<div class="collect" userid="'+designer.id+'"><a href="javascript:;"><span class="fansNum">'+designer.fans+'</span></a></div>\
								<div class="works">'+designer.opus+'个作品</div>\
								</li>';
						}
						if(action){
							$(".designerList").html(html);
						}else{
							$(".designerList").append(html);
						}
						$(".designerList").find(".collect").each(function(){
							$(this).unbind("click").click(function(){
								var fansId = $("#mobileUserId").val();
								var userId = $(this).attr("userid");
								var $fansNum = $(this).find(".fansNum");
								if(fansId == ""){
									window.location.href = _bPath + "mobile/login/loginPage";
								}else {
									var flag = commFun.isAttention(userId,fansId);
									if(flag){
										commFun.cancelAttention(userId,fansId,function(result){
											if (result.status == "0") {
												$bluemobi.notify("取消关注成功！", "success");
												var fansNum = $fansNum.html();
												if(isNaN(fansNum)){
													$fansNum.html(0);
												}else{
													$fansNum.html(Number(fansNum) - 1);
												}
											}
										});
									}else {
										commFun.attention(userId,fansId,function(result){
											if (result.status == "0") {
												$bluemobi.notify("关注成功！", "success");
												var fansNum = $fansNum.html();
												if(isNaN(fansNum)){
													$fansNum.html(1);
												}else{
													$fansNum.html(Number(fansNum) + 1);
												}
											}
										});
									}
								}
							});
						});
					}
				}
			});
		}


	</script>
	</body>
</html>
