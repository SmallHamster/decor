<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="common/meta.jsp"%>
    <%@ include file="common/css.jsp"%>
    <title><fmt:message key="info.shouye"/></title>
    <link href="static/pc/css/common.css" rel="stylesheet" type="text/css">
    <link href="static/pc/css/all.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="static/pc-1.1/css/public.css" />
    <link rel="stylesheet" href="static/pc-1.1/css/style.css" />
</head>
<body>
<div class="wrapper">
    <div class="page">
        <!-- 头部开始 -->
        <%@ include file="common/header.jsp" %>
        <!-- 头部结束 -->
        <input type="hidden" id="seriesId" value="${series.id}"/>
        <input type="hidden" id="creator" value="${series.user.id}"/>
        </div>
    </div>
<!--banner-->
<div class="bannerWrap">
    <div class="w1200">
        <div class="personal_information">
            <div class="personLeft">
                <a href="#" class="avater"><img src="${series.user.headImage}" height="153" width="153"/></a>
                <a href="#" class="name">${series.user.nickname}</a>
                <div class="address"><i class="ico"></i>&emsp;${series.user.city.name}&emsp;${series.user.city.province.name}</div>
            </div>
            <div class="personMiddle">
                <div class="per-mtp cleafix">
                    <span><i>${series.user.attention}</i><em>关注</em></span>
                    <span><i>${series.user.fans}</i><em>粉丝</em></span>
                    <span><i>${series.user.seeNum}</i><em>访问</em></span>
                </div>
                <p class="slh" style="width: 500px;">${series.user.info}</p>
                <h3>刚刚更新了设计系列图：<strong>《我在海边的木头房子里面患过伤风》  木屋陈设，木头吊柜…</strong></h3>
            </div>
            <div class="personRight">
                <a href="#" class="send"><img src="static/pc-1.1/images/ico_btn_6.png" />发私信</a>
                <p>共计${userSeriesNum}个作品</p>
                <a id="attention" class="like" style="display: none"><img src="static/pc-1.1/images/ico_btn_7.png" />被${series.user.fans}人喜欢</a>
                <a id="cancelAttention" class="like" style="display: none"><img src="static/pc-1.1/images/ico_btn_7.png" />取消关注</a>
            </div>
        </div>
    </div>
</div>
<!--主体部分-->
<div class="containeWrap">
    <div class="w1200">
        <div class="contain cleafix">
            <div class="containLeft">
                <div class="picFocus">
                    <div class="bd">
                        <ul>
                            <li>
                                <a target="_blank" href="#">
                                    <img src="static/pc-1.1/images/detail_pic2.jpg" />
                                    <p>查看详情</p>
                                    <h2 class="cleafix">
                                        <span class="pic_fl">客厅一角<em>包含商品：4件</em></span>
                                        <span class="pic_fr"><em>获得12次喜欢</em><em>6条评论</em></span>
                                    </h2>
                                </a>
                            </li>
                            <li>
                                <a target="_blank" href="#">
                                    <img src="static/pc-1.1/images/detail_pic2.jpg" />
                                    <p>查看详情</p>
                                    <h2 class="cleafix">
                                        <span class="pic_fl">客厅一角<em>包含商品：4件</em></span>
                                        <span class="pic_fr"><em>获得12次喜欢</em><em>6条评论</em></span>
                                    </h2>
                                </a>
                            </li>
                            <li>
                                <a target="_blank" href="#">
                                    <img src="static/pc-1.1/images/detail_pic2.jpg" />
                                    <p>查看详情</p>
                                    <h2 class="cleafix">
                                        <span class="pic_fl">客厅一角<em>包含商品：4件</em></span>
                                        <span class="pic_fr"><em>获得12次喜欢</em><em>6条评论</em></span>
                                    </h2>
                                </a>
                            </li>
                            <li>
                                <a target="_blank" href="#">
                                    <img src="static/pc-1.1/images/detail_pic2.jpg" />
                                    <p>查看详情</p>
                                    <h2 class="cleafix">
                                        <span class="pic_fl">客厅一角<em>包含商品：4件</em></span>
                                        <span class="pic_fr"><em>获得12次喜欢</em><em>6条评论</em></span>
                                    </h2>
                                </a>
                            </li>
                            <li>
                                <a target="_blank" href="#">
                                    <img src="static/pc-1.1/images/detail_pic2.jpg" />
                                    <p>查看详情</p>
                                    <h2 class="cleafix">
                                        <span class="pic_fl">客厅一角<em>包含商品：4件</em></span>
                                        <span class="pic_fr"><em>获得12次喜欢</em><em>6条评论</em></span>
                                    </h2>
                                </a>
                            </li>
                        </ul>
                        <a class="prev" href="javascript:void(0)"></a>
                        <a class="next" href="javascript:void(0)"></a>
                    </div>
                    <div class="hd">
                        <ul>
                            <li><a href="javascript:void(0)"><img src="static/pc-1.1/images/detail_pic1.jpg" /><div class="bg"></div></a></li>
                            <li><a href="javascript:void(0)"><img src="static/pc-1.1/images/detail_pic1.jpg" /><div class="bg"></div></a></li>
                            <li><a href="javascript:void(0)"><img src="static/pc-1.1/images/detail_pic1.jpg" /><div class="bg"></div></a></li>
                            <li><a href="javascript:void(0)"><img src="static/pc-1.1/images/detail_pic1.jpg" /><div class="bg"></div></a></li>
                            <li><a href="javascript:void(0)"><img src="static/pc-1.1/images/detail_pic1.jpg" /><div class="bg"></div></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="containRight">
                <h2 class="slh">${series.info}</h2>
                <p>${series.info}</p>
                <p>创建时间：${series.createTime}<br/>包含场景：23个</p>
                <h3><a href="#" class="collect"><i></i>${series.collectionNum}次收藏</a></h3>
                <h3><a href="#" class="share"><i></i>分享给朋友</a></h3>
                <h2 class="all">全部系列图（36）</h2>
                <p>我在海边的木头房子里面患过伤风<br/>SOMA Condo<br/>South of Market loft<br/>Tiny Bathroom Remodels<br/>Small San Francisco Bathroom Remodel<br/>San Francisco Charmer<br/>Custom Furniture<br/>My Houzz: Stylish City Living, Toddler Included<br/>Forest Hill Transformation</p>
                <a href="#" class="back">返回设计师首页</a>
            </div>
        </div>
        <!--同类热门-->
        <div class="hot">
            <h2 class="title">同类热门</h2>
            <ul class="hot-list cleafix sametypeserieslist">

            </ul>
        </div>
    </div>
</div>
<!--bottom-->
<%@ include file="common/footer.jsp"%>
<!--返回顶部-->
<div class="floatBack"><a href="javascript:;" class="gotop"><i class="ico"></i></a></div>
<script type="text/javascript" src="static/pc-1.1/js/jquery-1.8.0.min.js" ></script>
<script type="text/javascript" src="static/pc-1.1/js/jquery.SuperSlide.2.1.1.js" ></script>
<script type="text/javascript" src="static/pc-1.1/js/index.js" ></script>
<script type="text/javascript" src="static/pc/js/base.js"></script>
<script type="text/javascript">
    $(function(){
        //主体部分
        jQuery(".picFocus").slide({
        	mainCell: ".bd ul",
        	effect: "left",
        	autoPlay: true,
        	trigger: "click"
        });
        //设计系列图
        jQuery(".design-top-right").slide({
        	titCell: ".hd ul",
        	mainCell: ".bd ul",
        	autoPage: true,
        	effect: "left",
        	autoPlay: true,
        	vis: 1,
        	trigger: "click"
        });

        commFun.handlerAttention(); // 处理关注
        ajaxSameTypeSeries($("#seriesId").val());
    });



    // 加载同类型场景图
    function ajaxSameTypeSeries(seriesId){
        $bluemobi.ajax("pc/series/ajaxSameTypeSeries",{seriesId:seriesId},function(result){
            if (result.status == "0") {
                if (result.data.length > 0) {
                    var html = '';
                    for(var i=0;i<result.data.length;i++){
                        var series = result.data[i];
                        html+='<li>\
                                <a href="pc/series/detail?seriesId='+series.id+'"><img src="'+series.cover+'" width="270" height="189"/><p class="slh">'+series.info+'</p></a>\
                                </li>\
                               ';
                    }
                    $(".sametypeserieslist").html(html);
                }

            }
        });
    }
</script>
</body>
</html>
