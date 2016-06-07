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
    <style>
        .personMiddle h3 strong a {
            color: #fb9f38;
        }
    </style>
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
                <a href="pc/user/detail?userId=${series.user.id}" class="avater"><img src="${series.user.headImage}" height="153" width="153"/></a>
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
                ${infoHtml}
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
                    <span id="prev" class="btn prev"></span>
                    <span id="next" class="btn next"></span>
                    <span id="prevTop" class="btn prev"></span>
                    <span id="nextTop" class="btn next"></span>
                    <div id="picBox" class="picBox">
                        <ul class="cf">
                            <c:forEach items="${series.sceneList}" var="scene">
                                <li>
                                    <a href="pc/scene/detail?sceneId=${scene.id}">
                                        <img src="${scene.image}?imageView2/1/w/917/h/611" style="height: 611px;"/>
                                        <p>查看详情</p>
                                        <h2 class="cleafix">
                                            <span class="pic_fl">${scene.name}<em>包含商品：${scene.goodsNum}件</em></span>
                                            <span class="pic_fr"><em>获得${scene.praiseNum}次喜欢</em><em>${scene.commentNum}条评论</em></span>
                                        </h2>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div id="listBox" class="listBox">
                        <ul class="cf">
                            <c:forEach items="${series.sceneList}" var="scene">
                                <li><a href="javascript:void(0)"><img src="${scene.image}?imageView2/1/w/159/h/110" /><div class="bg"></div></a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="containRight">
                <h2 class="slh">${series.info}</h2>
                <p>${series.info}</p>
                <p>创建时间：${series.createTime}<br/>包含场景：23个</p>
                <h3>
                    <a id="collect" class="collect" style="display: none"><i></i>${series.collectionNum}次收藏</a>
                    <a id="cancelCollect" class="collect" style="display: none"><i></i>取消收藏</a>
                </h3>
                <h3><a class="share"><i></i>分享给朋友</a></h3>
                <h2 class="all">全部系列图（36）</h2>
                <p>我在海边的木头房子里面患过伤风<br/>SOMA Condo<br/>South of Market loft<br/>Tiny Bathroom Remodels<br/>Small San Francisco Bathroom Remodel<br/>San Francisco Charmer<br/>Custom Furniture<br/>My Houzz: Stylish City Living, Toddler Included<br/>Forest Hill Transformation</p>
                <a href="pc/user/detail?userId=${series.user.id}" class="back">返回设计师首页</a>
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
<%--<script type="text/javascript" src="static/pc-1.1/js/jquery-1.8.0.min.js" ></script>--%>
<script type="text/javascript" src="static/pc-1.1/js/jquery.SuperSlide.2.1.1.js" ></script>
<script type="text/javascript" src="static/pc-1.1/js/index.js" ></script>
<script type="text/javascript" src="static/pc/js/base.js"></script>
<script type="text/javascript">
    $(function(){
        //主体部分
//        jQuery(".picFocus").slide({
//        	mainCell: ".bd ul",
//        	effect: "left",
//        	autoPlay: true,
//        	trigger: "click"
//        });
        //设计系列图
//        jQuery(".design-top-right").slide({
//        	titCell: ".hd ul",
//        	mainCell: ".bd ul",
//        	autoPage: true,
//        	effect: "left",
//        	autoPlay: true,
//        	vis: 1,
//        	trigger: "click"
//        });

        commFun.handlerAttention(); // 处理关注
        handlerCollection();
        ajaxSameTypeSeries($("#seriesId").val());
    });

    function handlerCollection(){
        var userId = $("#sessionUserId").val();
        var objectId = $("#seriesId").val();
        var objectType = "series";
        var flag = commFun.isCollect(userId,objectId,objectType);
        if(flag){
            $("#cancelCollect").show();
        }else{
            $("#collect").show();
        }
        $("#collect").unbind("click").click(function(){
            if($("#sessionUserId").val()==""){
                loginPopup.showDlg();
                return false;
            }
            collectDlg.show(objectId,objectType,function(){
                location.reload();
            });
        });
        $("#cancelCollect").unbind("click").click(function(){
            if($("#sessionUserId").val()==""){
                loginPopup.showDlg();
                return false;
            }
            collectDlg.cancelCollect(objectId,objectType,function(){
                location.reload();
            });
        });
    }

    // 加载同类型场景图
    function ajaxSameTypeSeries(seriesId){
        $bluemobi.ajax("pc/series/ajaxSameTypeSeries",{seriesId:seriesId},function(result){
            if (result.status == "0") {
                if (result.data.length > 0) {
                    var html = '';
                    for(var i=0;i<result.data.length;i++){
                        var series = result.data[i];
                        html+='<li>\
                                <a href="pc/series/detail?seriesId='+series.id+'"><img src="'+series.cover+'?imageView2/1/w/270/h/189" width="270" height="189"/><p class="slh">'+series.info+'</p></a>\
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
