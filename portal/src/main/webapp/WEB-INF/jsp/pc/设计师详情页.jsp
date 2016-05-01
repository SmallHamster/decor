<%--
  Created by IntelliJ IDEA.
  User: xiaoj
  Date: 2015/10/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="common/meta.jsp" %>
    <%@ include file="common/css.jsp" %>
    <title><fmt:message key="info.shejishixiangqingye"/></title>
    <link href="static/pc/css/common.css" rel="stylesheet" type="text/css">
    <link href="static/pc/css/all.css" rel="stylesheet" type="text/css">
    <link href="static/pc/css/homepage.css" rel="stylesheet" type="text/css">
    <style>
        .head img{border-radius:inherit;}
        .nav {
            background: none;
        }
    </style>
</head>

<body>
<div class="wrapper">
    <%@ include file="common/header.jsp" %>
    <div class="search-condition" style="display: none;">
        <input type="hidden" id="cur-page" value="user"/>
        <input type="hidden" id="userId" value="${user.id}"/>
        <input type="hidden" id="sex" value="${user.sex}"/>
        <input type="hidden" id="isAttention" value=""/>
    </div>
    <div class="container">
        <!-- 个人主页信息 -->
        <div class="personalInfo" style="background: url('${user.backgroundImage}');height: 100%; padding-bottom: 30px;">
            <div class="infoCont">
                <div class="info_top clearfix rel">
                    <div class="head fl " style="margin-left: 0px;">
                        <img src="${user.headImage}" style="width: 154px;height: 154px;" class="vm">
                    </div>
                    <div class="follow fl">
                        <a onclick="ajaxAttentionPage()"><span class="num">${user.attention}</span><span><fmt:message key="info.guangzhu"/></span></a>
                        <a onclick="ajaxFansPage()"><span class="num">${user.fans}</span><span><fmt:message key="info.fengshi"/></span></a>
                        <a><span class="num">${user.seeNum}</span><span><fmt:message key="info.fangwen"/></span></a>
                    </div>
                    <div class="attention abs">
                        <button class="btn blackBtn" onclick="attentionUser()"><i class="iicon"></i></button>
                    </div>
                </div>
                <div class="info_cont">
                    <div class="name clearfix">
                        <span class="nickname">${user.nickname}</span>
                        <span class="level">
                            <c:if test="${user.seeNum < 20}"><i class="iicon star2"></i><i class="iicon star2"></i><i class="iicon star2"></i><i class="iicon star2"></i><i class="iicon star2"></i></c:if>
                            <c:if test="${user.seeNum < 40 && user.seeNum >= 20}"><i class="iicon star"></i><i class="iicon star2"></i><i class="iicon star2"></i><i class="iicon star2"></i><i class="iicon star2"></i></c:if>
                            <c:if test="${user.seeNum < 60 && user.seeNum >= 40}"><i class="iicon star"></i><i class="iicon star"></i><i class="iicon star2"></i><i class="iicon star2"></i><i class="iicon star2"></i></c:if>
                            <c:if test="${user.seeNum < 80 && user.seeNum >= 60}"><i class="iicon star"></i><i class="iicon star"></i><i class="iicon star"></i><i class="iicon star2"></i><i class="iicon star2"></i></c:if>
                            <c:if test="${user.seeNum < 100 && user.seeNum >= 80}"><i class="iicon star"></i><i class="iicon star"></i><i class="iicon star"></i><i class="iicon star"></i><i class="iicon star2"></i></c:if>
                            <c:if test="${user.seeNum >= 100}"><i class="iicon star"></i><i class="iicon star"></i><i class="iicon star"></i><i class="iicon star"></i><i class="iicon star"></i></c:if>
                            <span class="colorc fs12 pl5">${user.seeNum}<fmt:message key="info.redu"/></span>
                        </span>
                        <!--<span class="num fr">${user.mobile}</span>-->
                    </div>
                    <div class="info pt15">
                        <a style="cursor: default;" title="${user.sexInfo}">
                            <c:if test="${user.sex == 0}"><span class="iicon sex sex1"></span></c:if>
                            <c:if test="${user.sex == 1}"><span class="iicon sex sex2"></span></c:if>
                            <c:if test="${user.sex != 0 && user.sex != 1}"><img src="static/images/suo.png" height="20px;" width="20px;" /></c:if>
                        </a>
                        <span class="location">
                            <i class="iicon"></i>
                            <span>${user.city.province.name}</span>
                            <span>${user.city.name}</span>
                        </span>
                        <c:if test="${(null != user.info && user.info != '') ||(null != user.website && user.website != '')}">
                            <div class="brief pt15 fs12">
                                <c:if test="${null != user.info && user.info != '' }">
                                    <div class="item rel clearfix">
                                        <label class="abs color3 fl"><fmt:message key="info.gerenjianjie"/>：</label>
                                        <p class="color6 fl">${user.info}</p>
                                    </div>
                                </c:if>
                                <c:if test="${null != user.website && user.website != '' }">
                                    <div class="item rel pt10 clearfix">
                                        <label class="abs color3 fl"><fmt:message key="info.gerenwangzhan"/>：</label>

                                        <p class="color6 fl">${user.website}</p>
                                    </div>
                                </c:if>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <div class="content ">
            <div class="nav">
                <ul>
                    <li onclick="ajaxGoodsPage()"><fmt:message key="info.shangpintu"/></li>
                    <li onclick="ajaxScenePage()"><fmt:message key="info.changjintu"/></li>
                    <li onclick="ajaxSeriesPage()"><fmt:message key="info.xilietu"/></li>
                    <li onclick="ajaxCommentPage()"><fmt:message key="info.pingjia"/></li>
                </ul>
            </div>
            <div class="empty tc" style="min-height: 600px">
                <p class="color9 pt20" style="font-size: 20px;"><fmt:message key="info.zanwujilu"/></p>
            </div>
        </div>
        <%@ include file="common/page.jsp" %>
    </div>
    <!-- footer -->
    <%@ include file="common/footer.jsp" %>
</div>
<!-- 分页 -->

<%@ include file="common/other.jsp" %>
<script type="text/javascript" src="static/pc/js/base.js"></script>
<script type="text/javascript">
    var register;
    var thisPage = rpage; // 分页对象 rpage存在于page.jsp

    $(function () {
        window.onload = function() {
            $(".nav ul li").eq(0).trigger("click");

        }
        ajaxIsAttention(); // 加载类别
        // 评论回复按钮点击事件

    });
    //加载关注状态
    function ajaxIsAttention() {
        var sessionUserId = $("#sessionUserId").val();
        var userId = $(".search-condition").find("#userId").val();
        var userSexTo = $(".search-condition").find("#sex").val();
        if (userSexTo=='0'){
            $(".info").find(".sex").addClass("sex1");
        }else if(userSexTo=='2'){
            $(".info").find(".sex").removeClass("sex");
        }
        if (sessionUserId == "") {
            sessionUserId = 0
        }
        var data = {
            userId: userId,
            sessionUserId: sessionUserId
        };
        $bluemobi.ajax("pc/user/ajaxIsAttention", data, function (result) {
            if (result.status == "0") {
                var collect;
                if (sessionUserId != 0 && result.data == true) {
                    collect = "<fmt:message key="info.quxiaoTA"/>"
                    $(".search-condition").find("#isAttention").val("<fmt:message key="info.guangzhu"/>");
                } else if (sessionUserId != 0 && result.data == false) {
                    collect = "<fmt:message key="info.guangzhuTA"/>"
                    $(".search-condition").find("#isAttention").val("<fmt:message key="info.meiguangzhu"/>");
                } else if (sessionUserId == 0) {
                    collect = "<fmt:message key="info.weiguangzhu"/>"
                    // loginPopup.showDlg();
                    // 未登录时，隐藏评论div

                }
            }
            $(".abs button ").html("<i class='iicon'></i>" + collect);

        });
    }


    //关注操作
    function attentionUser() {
        var sessionUserId = $("#sessionUserId").val();
        var userId = $(".search-condition").find("#userId").val();
        var addOrDel = false;
        var isAttention = $(".search-condition").find("#isAttention").val();
        // 用户未登录，则弹出未登录提示框
        if (sessionUserId == "") {
            loginPopup.showDlg();
            return false;
        }
        //判断资讯收藏状态
        if (isAttention == "<fmt:message key="info.guangzhu"/>") {
            $bluemobi.ajax("pc/user/updateIsAttention", {
                addOrDel: addOrDel,
                userId: userId,
                sessionUserId: sessionUserId
            }, function (result) {
                if (result.status == "0") {

                    $(".abs button").html("<i class='iicon'></i>" + "<fmt:message key="info.guangzhuTA"/>");
                    $(".search-condition").find("#isAttention").val("<fmt:message key="info.meiguangzhu"/>");
                    $bluemobi.notify(result.msg, "success");
                    $(".follow span").eq(2).text(parseInt($(".follow span").eq(2).text()) - 1);
                    ajaxUpdateFansNum(userId, false);
                }
            });
        }
        else if (isAttention == "<fmt:message key="info.meiguangzhu"/>") {
            $bluemobi.ajax("pc/user/updateIsAttention", {
                addOrDel: true,
                userId: userId,
                sessionUserId: sessionUserId
            }, function (result) {
                if (result.status == "0") {
                    $(".abs button").html("<i class='iicon'></i>" + "<fmt:message key="info.quxiaoTA"/>");
                    $(".search-condition").find("#isAttention").val("<fmt:message key="info.guangzhu"/>");
                    $bluemobi.notify(result.msg, "success");
                    $(".follow span").eq(2).text(parseInt($(".follow span").eq(2).text()) + 1);
                    ajaxUpdateFansNum(userId, true);
                }
            });
        }

    }
    function ajaxUpdateFansNum(userId, addOrDel) {
        var data = {
            userId: userId,
            addOrDel: addOrDel
        };
        $bluemobi.ajax("pc/user/ajaxUpdateFansNum", data, function (result) {
        });
    }

    // 查询当前用户所关注的user数量
    function ajaxAttentionPage() {
        var userId = $(".search-condition").find("#userId").val();
        var data = {
            userId: userId,
            pageNum: thisPage.pageNum,
            pageSize: 20,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/user/attentionPage", data, function (result) {
            if (result.status == "0") {
                var html = '<div class="fansList"><ul>';
                for (var i = 0; i < result.data.list.length; i++) {
                    var user = result.data.list[i].attentionUser;
                    html += '<li class="clearfix"><img src="' + user.headImage + '" class="fl" style="width: 62px;height: 62px;"><div class="ml10 fl">\
              <p class="fs16 colorBlack pb5">' + user.nickname + '</p><p class="pb5"><span class="location"><i class="iicon"></i><span>' + user.city.province.name + '</span><span>' + user.city.name + '</span></span></p>\
              <p class="pt5 color6 fs12"><fmt:message key="info.guangzhu"/><span class="pl5 colorOrange">' + user.attention + '</span><span class="pl5 pr5">|</span><fmt:message key="info.fengshi"/><span class="pl5 pr5 colorOrange">' + user.collect + '</span></span>\
              </div></li>';
                }
                html += '</ul></div>'
                if(result.data.list.length==0){
                    html += '<div class="empty tc" style="min-height: 600px"><p class="color9 pt20" style="font-size: 20px;"><fmt:message key="info.zanwugaungzhujilu"/></p></div>'
                }
                if ($(".content").find(".empty").html() != null) {
                    $(".content").find(".empty").html(html).removeClass("empty tc").addClass("list", "attentionList");
                } else if ($(".content").find(".list").html() != null) {
                    $(".content").find(".list").html(html);
                }
                thisPage.init(result.data.page, " ajaxAttentionPage");
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
            }
        });
    }
    // 查询当前用户FANS的数量并分页展示
    function ajaxFansPage() {
        var userId = $(".search-condition").find("#userId").val();
        var data = {
            userId: userId,
            pageNum: thisPage.pageNum,
            pageSize: 20,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/user/fansPage", data, function (result) {
            if (result.status == "0") {
                var html = '<div class="fansList"><ul>';
                for (var i = 0; i < result.data.list.length; i++) {
                    var user = result.data.list[i].fansUser;
                    html += '<li class="clearfix"><img src="' + user.headImage + '" class="fl" style="width: 62px;height: 62px;"><div class="ml10 fl">\
              <p class="fs16 colorBlack pb5">' + user.nickname + '</p><p class="pb5"><span class="location"><i class="iicon"></i><span>' + user.city.province.name + '</span><span>' + user.city.name + '</span></span></p>\
              <p class="pt5 color6 fs12"><fmt:message key="info.guangzhu"/><span class="pl5 colorOrange">' + user.attention + '</span><span class="pl5 pr5">|</span><fmt:message key="info.fengshi"/><span class="pl5 pr5 colorOrange">' + user.collect + '</span></span>\
              </div></li>';
                }
                html += '</ul></div>'
                if(result.data.list.length==0){
                    html += '<div class="empty tc" style="min-height: 600px"><p class="color9 pt20" style="font-size: 20px;"><fmt:message key="info.zanwuFANSjilu"/></p></div>'
                }
                if ($(".content").find(".empty").html() != null) {
                    $(".content").find(".empty").html(html).removeClass("empty tc").addClass("list", "fansList");
                } else if ($(".content").find(".list").html() != null) {
                    $(".content").find(".list").html(html);
                }
                thisPage.init(result.data.page, " ajaxAttentionPage");
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
            }
        });
    }
    //查询指定用户的所有商品分页
    function ajaxGoodsPage() {
        $(".nav li").removeClass("current")
        $(".nav li").eq(0).addClass("current")
        var userId = $(".search-condition").find("#userId").val();
        var data = {
            userId: userId,
            pageNum: thisPage.pageNum,
            pageSize: 18,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/user/goodsPage", data, function (result) {
            if (result.status == "0") {
                var html = '<div class="commodityList"><ul>';
                for (var i = 0; i < result.data.list.length; i++) {
                    var goods = result.data.list[i];
                    html += '<li><a href="pc/goods/detail?goodsId=' + goods.id + '"><img src="' + goods.cover + '"><p class="colorBlack pl10">' + goods.name + '</p></a></li>';
                }
                html += '</ul></div>'
                if(result.data.list.length==0){
                    html+='<div class="empty tc" style="min-height: 600px"><p class="color9 pt20" style="font-size: 20px;"><fmt:message key="info.zanwushangpingtujilu"/></p></div>'
                }
                if ($(".content").find(".empty").html() != null) {
                    $(".content").find(".empty").html(html).removeClass("empty tc").addClass("list", "attentionList");
                } else if ($(".content").find(".list").html() != null) {
                    $(".content").find(".list").html(html);
                }
                thisPage.init(result.data.page, " ajaxGoodsPage");
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
            }
        });
    }

    //查询指定用户的所有场景分页
    function ajaxScenePage() {
        $(".nav li").removeClass("current")
        $(".nav li").eq(1).addClass("current")
        var userId = $(".search-condition").find("#userId").val();
        var data = {
            userId: userId,
            pageNum: thisPage.pageNum,
            pageSize: 18,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/user/scenePage", data, function (result) {
            if (result.status == "0") {
                var html = '<div class="commodityList materialList"><ul>';
                for (var i = 0; i < result.data.list.length; i++) {
                    var scene = result.data.list[i];
                    html += ' <li><a href="pc/scene/detail?sceneId=' + scene.id + '"><img src="' + scene.image + '"></a></li>';
                }
                html += '</ul></div>'
                if(result.data.list.length==0){
                    html+='<div class="empty tc" style="min-height: 600px"><p class="color9 pt20" style="font-size: 20px;"><fmt:message key="info.zanwuchangjintujilu"/></p></div>'
                }
                if ($(".content").find(".empty").html() != null) {
                    $(".content").find(".empty").html(html).removeClass("empty tc").addClass("list", "attentionList");
                } else if ($(".content").find(".list").html() != null) {
                    $(".content").find(".list").html(html);
                }
                thisPage.init(result.data.page, " ajaxScenePage");
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
            }
        });
    }

    //查询指定用户的所有系列图分页
    function ajaxSeriesPage() {
        $(".nav li").removeClass("current")
        $(".nav li").eq(2).addClass("current")
        var userId = $(".search-condition").find("#userId").val();
        var data = {
            userId: userId,
            pageNum: thisPage.pageNum,
            pageSize: 9,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/user/seriesPage", data, function (result) {
            if (result.status == "0") {
                var html = '<div class="commodityList seriesList"><ul>';
                for (var i = 0; i < result.data.list.length; i++) {
                    var series = result.data.list[i];
                    if (series.info.length > 14) {
                        series.info = series.info.substring(0, 14) + "..."
                    }
                    html += '<li class="clearfix"><a href="pc/series/detail?seriesId=' + series.id + '"><img src="' + series.cover + '">\
                    <p class="colorBlack pl10 fs16" style="margin-top: 8px;">\
                    <span class="fl">"' + series.info + '"</span><span class="fr pr20 color6">' + series.sceneNum + '<fmt:message key="info.zhangchangjintu"/></span></p></a></li>';
                }
                html += '</ul></div>'
                if(result.data.list.length==0){
                    html += '<div class="empty tc" style="min-height: 600px"><p class="color9 pt20" style="font-size: 20px;"><fmt:message key="info.zanwuxilietujilu"/></p></div>'
                }
                if ($(".content").find(".empty").html() != null) {
                    $(".content").find(".empty").html(html).removeClass("empty tc").addClass("list", "seriesList");
                } else if ($(".content").find(".list").html() != null) {
                    $(".content").find(".list").html(html);
                }
                thisPage.init(result.data.page, " ajaxSeriesPage");
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
            }
        });
    }
    //查询指定用户的所有评论分页
    function ajaxCommentPage() {
        $(".nav li").removeClass("current")
        $(".nav li").eq(3).addClass("current")
        var userId = $(".search-condition").find("#userId").val();
        var data = {
            userId: userId,
            pageNum: thisPage.pageNum,
            pageSize: 4,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/user/commentPage", data, function (result) {
            if (result.status == "0") {
                var html = '<div class="comment-list mb20"><ul>';
                debugger
                for (var i = 0; i < result.data.list.length; i++) {
                    var commentUpdateStatus = result.data.list[i];
                    html += '<li class="rel">\
                    <div class="imgwarp abs">\
                    <img src="' + commentUpdateStatus.objectCover + '">\
                    </div><div style="margin-left: 245px;">';
                    for (var j = 0; j < commentUpdateStatus.commentList.length; j++) {
                        var comment = commentUpdateStatus.commentList[j];
                        if (j == 0) {
                            html += '<div class="rost border_bottom_dashed">'
                            }else{
                            html += '<div class="rost pt20 pb20">'
                        }
                            html+='<img src="' + comment.user.headImage + '"/>\
                                <div class="prost">'
                                    if(comment.replyList.length==0){
                                    html+='<div class="Rost2">'
                                    }else{
                                        html+='<div class="Rost2 pb20 border_bottom_dashed">'
                                    }
                                html+='<p class="first fs16">\
                                    <span class="colorc fr fs12">' + comment.createTime + '</span>' + comment.user.nickname + '\
                                    </p>\
                                    <p class="txt">\
                                    ' + comment.content + '\
                                    </p>\
                                    <p class="inter">\
                                        <span class="i-praise mr10">\
                                            <i class="iicon"></i>' + comment.praiseNum + '' +
                                        '</span>'
                                html+='</p></div>'
                        //回复
                        if(comment.replyList.length!=0){
                            html += '<div class="rost"><img src="' + comment.replyList[0].headImage + '"/>\
                            <div class="Rost"><p class="first fs16">\
                            <span class="fr fs12 colorc">' + comment.replyList[0].createTime + '</span>' + comment.replyList[0].nickname + '</p>\
                            <p class="txt">' + comment.replyList[0].content + '</p></div>';
                        }
                        html+='</div></div>'

                    }
                    html += '</div></li>'
                }
                html += '</ul></div>'
                if(result.data.list.length==0){
                    html += '<div class="empty tc" style="min-height: 600px"><p class="color9 pt20" style="font-size: 20px;"><fmt:message key="info.zanwupinglunjilu"/></p></div>'
                }
                if ($(".content").find(".empty").html() != null) {
                    $(".content").find(".empty").html(html).removeClass("empty tc").addClass("list", "seriesList");
                } else if ($(".content").find(".list").html() != null) {
                    $(".content").find(".list").html(html);
                }
                $(".comment-list").find(".i-share").unbind("click").click(function(){
                    $(this).parents(".prost").find(".replydiv").show();
                });
                thisPage.init(result.data.page, " ajaxCommentPage");
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
            }
        });
    }

</script>
</body>
</html>
