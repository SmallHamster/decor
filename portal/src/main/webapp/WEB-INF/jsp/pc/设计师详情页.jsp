﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<style>
    .content {
        width: 627px;
    }
    .comment-list li {
        border-top: 0px;
        padding: 0 0;
        border-bottom: 1px solid #cccccc;
        min-height:inherit;
    }
    .design-list {
        margin-left: 10px;
    }
    .design-list li {
        margin: 0 29px 20px 0;}
     .personMiddle h3 strong a {
         color: #fb9f38;
     }
</style>
<body>
<!--top-->
<div class="wrapper">
    <div class="page">
        <!-- 头部开始 -->
        <%@ include file="common/header.jsp" %>
        <!-- 头部结束 -->
        <input type="hidden" id="cur-page" value="user"/>
        <input type="hidden" id="userId" value="${user.id}"/>
        <input type="hidden" id="sex" value="${user.sex}"/>
        <input type="hidden" id="isAttention" value=""/>
    </div>
</div>
<input type="hidden" id="creator" value="${user.id}"/>
<!--banner-->
<div class="bannerWrap" style="background: url('${user.backgroundImage}');">
    <div class="w1200">
        <div class="personal_information">
            <div class="personLeft">
                <a class="avater"><img src="${user.headImage}" style="width: 153px;height: 153px;"/></a>
                <a class="name">${user.nickname}</a>
                <div class="address"><i class="ico"></i>&emsp;${user.city.province.name}&emsp;${user.city.name}</div>
            </div>
            <div class="personMiddle" style="width:700px;">
                <div class="per-mtp cleafix">
                    <span><i>${user.attention}</i><em><fmt:message key="info.guangzhu"/></em></span>
                    <span><i>${user.fans}</i><em><fmt:message key="info.fengshi"/></em></span>
                    <span><i>${user.seeNum}</i><em><fmt:message key="info.fangwen"/></em></span>
                </div>
                <p class="slh" title="${user.info}">${user.info}</p>
                ${infoHtml}
            </div>
            <div class="personRight">
                <a class="send"><img src="static/pc-1.1/images/ico_btn_6.png" />发私信</a>
                <p>共计36个作品</p>
                <a id="attention" class="like" style="display: none"><img src="static/pc-1.1/images/ico_btn_7.png" />被${user.fans}人喜欢</a>
                <a id="cancelAttention" class="like" style="display: none"><img src="static/pc-1.1/images/ico_btn_7.png" />取消关注</a>
            </div>
        </div>
    </div>
</div>
<!--主体部分-->
<div class="containeWrap">
    <div class="w1200">
        <!--最新互动-->
        <div class="interact">
            <h2 class="title">最新互动</h2>
            <c:if test="${newestComment != null}">
                <div class="interact-con cleafix">
                <div class="interact-img"><img src="${newestComment.objectCover}" width="357" height="300"/></div>
                <div class="interact-right">
                    <h2><a>${newestComment.tags}&nbsp;</a></h2>
                    <h3>来自：<span class="slh" style="color: #fb9f38;">${newestComment.objectName}</span></h3>
                    <div class="chat-content cleafix">
                        <div class="sc-new you">
                            <img class="me-avatar" src="${newestComment.user.headImage}" width="50" height="50"/>
                            <div class="content">
                                <i class="jianjian"></i>
                                <div class="bubble bubble-default">
                                    <div class="plain">${newestComment.content}</div>
                                </div>
                                <div class="time">${newestComment.createTime}</div>
                            </div>
                        </div>
                        <c:if test="${!empty newestComment.newestReply.content}">
                            <div class="sc-new me">
                                <img class="me-avatar" src="${newestComment.newestReply.headImage}" width="50" height="50"/>
                                <div class="content">
                                    <div class="time">${newestComment.newestReply.createTime}</div>
                                    <div class="bubble bubble-primary">
                                        <div class="plain">${newestComment.newestReply.content}</div>
                                    </div>
                                    <i class="jianjian"></i>
                                </div>
                            </div>
                        </c:if>
                    </div>
                    <a class="hudong">更多设计师互动<font>&gt;</font></a>
                </div>
            </div>
            </c:if>
        </div>
        <!--设计系列图（36）-->
        <div class="designer">
            <h2 class="title">设计系列图（<span id="seriesNum">0</span>）</h2>
            <div class="design">
                <div class="design-top cleafix">
                    <div class="design-top-left">
                        <h2 class="slh" title="${topSeries.info}">${topSeries.info}</h2>
                        <p>${topSeries.createTime}创建</p>
                        <div class="shoucang cleafix">
                            <span><img src="static/pc-1.1/images/ico_btn_15.png" /></span>
                            <p>${topSeries.collectionNum}人收藏<br/>${topSeries.praiseNum}人觉得这设计很棒</p>
                        </div>
                    </div>
                    <div class="design-top-right">
                        <div class="hd">
                            <a class="next"></a>
                            <a class="prev"></a>
                            <span class="pageState"></span>
                        </div>
                        <div class="bd">
                            <ul class="picList">
                                <c:forEach var="scene" items="${topSeries.sceneList}">
                                    <li><a href="pc/scene/detail?sceneId=${scene.id}"><img src="${scene.image}?imageView2/1/w/842/h/410" width="842" height="410"/></a></li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <ul id="seriesList" class="design-list cleafix">

                </ul>
            </div>
            <div id="showMore">
                <a href="javascript:;" class="look-more">查看更多设计系列图</a>
                <div class="pages cleafix">
                </div>
            </div>
            <div id="pageDiv" style="margin-top: -100px;background: white">
                <%@ include file="common/page1.jsp" %>
            </div>

        </div>
        <!--评论留言-->
        <div class="comments">
            <h2 class="title">评论留言</h2>
            <div class="comment-list">
                <ul id="commentList">

                </ul>
                <div id="showMore1">
                    <a href="javascript:;" class="look-more">查看更多留言</a>
                    <div class="pages cleafix">
                    </div>
                </div>
                <div id="pageDiv4Comment" style="margin-top: -100px;background: white">
                    <%@ include file="common/page2.jsp" %>
                </div>
            </div>
        </div>
    </div>
</div>
<!--bottom-->
<%@ include file="common/footer.jsp" %>
<!--返回顶部-->
<div class="floatBack"><a href="javascript:;" class="gotop"><i class="ico"></i></a></div>
<script type="text/javascript" src="static/pc/js/base.js"></script>
<script type="text/javascript" src="static/pc-1.1/js/jquery-1.8.0.min.js" ></script>
<script type="text/javascript" src="static/pc-1.1/js/jquery.SuperSlide.2.1.1.js" ></script>
<script type="text/javascript" src="static/pc-1.1/js/index.js" ></script>
<script type="text/javascript">
    $(function(){
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
        ajaxSeriesPage();
        ajaxCommentPage();
    });

    var ajaxTimes = 0;
    //查询指定用户的所有系列图分页
    var seriesPage = epage;
    function ajaxSeriesPage() {
        ajaxTimes+=1;
        var userId = $("#userId").val();
        var data = {
            userId: userId,
            pageNum: seriesPage.pageNum,
            pageSize: 15,
            totalPage: seriesPage.totalPage
        };
        $bluemobi.ajax("pc/user/seriesPage", data, function (result) {
            if (result.status == "0") {
                var html = '';
                for (var i = 0; i < result.data.list.length; i++) {
                    var series = result.data.list[i];
                    html+='<li>\
                            <a href="pc/series/detail?seriesId=' + series.id + '"><img src="' + series.cover + '?imageView2/1/w/357/h/200" width="300" height="200"/></a>\
                            <div class="list-con cleafix">\
                            <a href="#" class="list-avater">\
                            <img src="static/pc-1.1/images/designer_pic1.png" />\
                            <p>ryel</p>\
                            </a>\
                            <div class="list-con-right">\
                            <a href="pc/series/detail?seriesId=' + series.id + '" class="tit slh">'+series.info+'</a>\
                            <p class="slh">'+series.info+'</p>\
                            <h3><a>'+series.seeNum+'次查看</a><a>'+series.praiseNum+'人喜欢的设计</a></h3>\
                            </div>\
                            </div>\
                            </li>';
                }
                $("#seriesList").html(html);
                seriesPage.init(result.data.page, "ajaxSeriesPage",$("#pageDiv"));
                $("#seriesNum").html(result.data.page.totalNum);
                if(ajaxTimes == 1){
                    var $category = $('.design-list li:gt(5)');
                    $category.hide();
                    $("#pageDiv").hide();
                    $("#showMore").click(function(){
                        $category.show();
                        $(this).find('.look-more').addClass('hide');
                        $(this).find('.pages').addClass('show');
                        $("#pageDiv").show();
                    });
                }
                if(result.data.page.totalNum==0){
                    $(".design").hide();
                    $("#showMore").hide();
                    $("#pageDiv").hide();
                }
            }
        });
    }

    var ajaxTimes4Comment = 0;
    //查询指定用户的所有评论分页
    var commentPage = lpage;
    function ajaxCommentPage() {
        ajaxTimes4Comment+=1;
        var userId = $("#userId").val();
        var data = {
            userId: userId,
            pageNum: commentPage.pageNum,
            pageSize: 8,
            totalPage: commentPage.totalPage
        };
        $bluemobi.ajax("pc/user/findCommentPage", data, function (result) {
            if (result.status == "0") {
                var html = '';
                for (var i = 0; i < result.data.list.length; i++) {
                    var comment = result.data.list[i];
                    var type = "";
                    if (comment.objectType) {
                        if (comment.objectType == "goods") {
                            type = "商品图";
                        }
                        if (comment.objectType == "scene") {
                            type = "场景图";
                        }
                        if (comment.objectType == "series") {
                            type = "系列图";
                        }
                    }
                    html += ' <li class="cleafix">\
                            <a href="#" class="comment-name"><img src="' + comment.user.headImage + '"/><p>' + comment.user.nickname + '</p></a>\
                            <div class="comment-con">\
                            <p class="slh">' + comment.content + '</p>\
                            <h4><span>' + comment.tags + '</span><b></b><span>来自' + type + '：' + comment.objectName + '</span><b></b><span>' + comment.createTime + '</span></h4>\
                            </div>\
                            </li>';
                }
                $("#commentList").html(html);
                commentPage.init(result.data.page, "ajaxCommentPage",$("#pageDiv4Comment"));
                if(ajaxTimes4Comment == 1){
                    var $category1 = $('.comment-list ul li:gt(3)');
                    $category1.hide();
                    $("#pageDiv4Comment").hide();
                    $("#showMore1").click(function(){
                        $category1.show();
                        $(this).find('.look-more').addClass('hide');
                        $(this).find('.pages').addClass('show');
                        $("#pageDiv4Comment").show();
                    });
                }
                if(result.data.page.totalNum==0){
                    $(".comment-list").hide();
                }
            }
        });
    }
</script>
</body>
</html>
