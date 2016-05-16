<%--
  Created by IntelliJ IDEA.
  User: xiaoj
  Date: 2015/10/19
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="common/meta.jsp" %>
    <%@ include file="common/css.jsp" %>
    <title><fmt:message key="info.gerenzhuye"/></title>
    <link href="static/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="static/pc/css/common.css" rel="stylesheet" type="text/css">
    <link href="static/pc/css/homepage.css" rel="stylesheet" type="text/css">
    <style>
        .choosePicList li img {
            width: 90%;
            height: 90%;
        }

        .redBorder2 {
            border: 2px solid #ff0000;
        }
    </style>
</head>

<body>
<div class="wrapper">
    <%@ include file="common/header.jsp" %>
    <div class="search-condition" style="display: none;">
        <input type="hidden" id="cur-page" value="user"/>
        <input type="hidden" id="userId" value="${user.id}"/>
    </div>
    <div class="container">
        <!-- 个人主页信息 -->
        <div class="personalInfo" style="background: url('${user.backgroundImage}');height: 100%; padding-bottom: 30px;">
            <div class="infoCont">
                <div class="info_top clearfix">
                    <div class="head fl">
                        <img src="${user.headImage}" width="154" height="154" class="vm">
                    </div>
                    <div class="follow fl">
                        <a onclick="ajaxAttentionPage()"><span class="num">${user.attention}</span><span><fmt:message key="info.guanzhu"/></span></a>
                        <a onclick="ajaxFansPage()"><span class="num">${user.fans}</span><span><fmt:message key="info.fensi"/></span></a>
                        <a><span class="num">${user.seeNum}</span><span><fmt:message key="info.fangwen"/></span></a>
                    </div>
                    <div class="setup mt20 fr _setting">
                        <a style="cursor: hand" title="修改背景"><span class="iicon skin"></span></a>
                        <div class="dropped" style="display: none"></div>
                        <a href="pc/userSetting/goto"><span class="iicon install"></span></a>
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
                            <c:if test="${user.sex != 0 && user.sex != 1}"><img src="static/images/suo.png" height="20px;" width="20px;"/></c:if>
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

        <div class="content">
            <div class="nav">
                <ul>
                    <li id="myHomePage"><fmt:message key="info.zhuye"/></li>
                    <li id="myCollect"><fmt:message key="info.wodeshoucang"/></li>
                    <li id="myPublish"><fmt:message key="info.wodefabu"/>
                        <i class="iicon search-select abs"></i>
                        <ul class="list-img">
                            <li><a><fmt:message key="info.shangpintu"/></a></li>
                            <li><a><fmt:message key="info.changjingtu"/></a></li>
                            <li><a><fmt:message key="info.xilietu"/></a></li>
                            <li><a><fmt:message key="info.huabansucai"/></a></li>
                        </ul>
                    </li>
                    <li id="myMessage"><fmt:message key="info.zixun"/></li>
                    <li id="myComment"><fmt:message key="info.pingjia"/></li>
                </ul>
            </div>
            <div class="myHomePage tabitem">
                <div class="borderline"></div>
                <div class="imageslist clearfix">
                    <div class="imgwarp fl">
                        <div class="collection"><p class="fs16 color6 pl20 mb20 " style="cursor:pointer;"><fmt:message key="info.shoucangjia"/><span class="pl25">>></span></p>
                            <ul class="clearfix">
                                <li class="first">
                                    <div class="Thumbnails"><span class="iicon addnewimg"></span></div>
                                    <p class="fs16 colorBlack tc"><fmt:message key="info.xinjianshoucangjia"/></p>
                                </li>
                                <div id="homePageLi"></div>
                            </ul>
                        </div>
                        <div class="collection newestupload mt20"><p class="fs16 color6 pl20 mb20"><fmt:message key="info.zuixinshangchuan"/><span class="pl25">>></span></p>
                            <ul class="clearfix"></ul>
                        </div>
                    </div>
                    <div class="uploadimg fl">
                        <p>
                            <button class="btn blackBtn mb20" onclick="createGoodsHandler.showCreateGoodsTab()" style="width: 150px;"><fmt:message key="info.shangchuanshangpin"/></button>
                        </p>
                        <p>
                            <button class="btn blackBtn mb20" onclick="createSceneHandler.showCreateSceneTab()" style="width: 150px;"><fmt:message key="info.shangchuanchangjingtu"/></button>
                        </p>
                        <p>
                            <button class="btn blackBtn mb20" onclick="createSeriesHandler.showCreateSeriesTab()" style="width: 150px;"><fmt:message key="info.shangchuanxilietu"/></button>
                        </p>
                    </div>
                </div>
            </div>
            <div class="myCollect tabitem"></div>
            <div class="myPublish tabitem"></div>
            <div class="myMessage tabitem"></div>
            <div class="myComment tabitem"></div>

            <%-- 新增商品 --%>
            <div class="createGoodsTab tabitem none">
                <p class="fs16 color6 mt20 mb20"><fmt:message key="info.fabushangpin"/></p>
                <div class="product mb20">
                    <div class="p-item">
                        <label><fmt:message key="info.shangpinmingcheng"/>：</label>
                        <input type="text" name="name">
                    </div>
                    <div class="p-item">
                        <label><fmt:message key="info.fenlei"/>：</label>
                        <div class="select_input inline-b rel">
                            <i class="iicon dropdown abs"></i>
                            <span class="select-text fs16 kindTagName"></span>
                            <select class="kingTagSelect"></select>
                        </div>
                    </div>
                    <div class="p-item">
                        <label class="vt"><fmt:message key="info.fenggebiaoqian"/>：</label>
                        <div class="styleTagSelected tags" style="width: 462px;height: auto;border: 1px solid #e5e5e5;margin-left: 86px;min-height: 30px;"></div>
                    </div>
                    <div class="p-item">
                        <label></label>
                        <div class="tags inline-b styleTagList"></div>
                    </div>
                    <div class="p-item">
                        <label class="vt"><fmt:message key="info.kongjianbiaoqian"/>：</label>
                        <div class="spaceTagSelected tags" style="width: 462px;height: auto;border: 1px solid #e5e5e5;margin-left: 86px;min-height: 30px;"></div>
                    </div>
                    <div class="p-item">
                        <label></label>
                        <div class="tags inline-b spaceTagList"></div>
                    </div>
                    <div class="p-item">
                        <label><fmt:message key="info.jiage"/>：</label>
                        <input type="text" name="price" style="width: 111px"><span class="fs16 colorBlack pl10"><fmt:message key="info.yuan"/></span>
                    </div>
                    <div class="p-item">
                        <label><fmt:message key="info.chicun"/>：</label>
                        <input type="text" name="size">
                    </div>
                    <div class="p-item">
                        <label><fmt:message key="info.caizhi"/>：</label>
                        <input type="text" name="texture">
                    </div>
                    <div class="p-item">
                        <label><fmt:message key="info.goumailianjie"/>：</label>
                        <input type="text" name="link">
                    </div>
                    <div class="p-item">
                        <label class="vt"><fmt:message key="info.shangpinmiaoshu"/>：</label>
                        <textarea name="info"></textarea>
                    </div>
                    <div class="p-item">
                        <label><fmt:message key="info.shangchuantupian"/>：</label>
                        <button class="btn blackBtn w150 uploadBtn"><fmt:message key="info.shangchuanshangpin"/></button>
                        <div class="dropped" style="display: none"></div>
                    </div>
                    <div class="p-item">
                        <label></label>
                        <div class="inline-b stePic piclist"></div>
                    </div>
                    <div class="p-item tc">
                        <button class="btn blackBtn" onclick="createGoodsHandler.pcCreateGoods()" style="width: 250px;"><fmt:message key="info.querenshangchuan"/></button>
                    </div>
                </div>
            </div>

            <%-- 新增场景图 --%>
            <div class="createSceneTab tabitem none">
                <p class="fs16 color6 mb20"><fmt:message key="info.shangchuanchangjingtu"/></p>
                <div class="uploadCont mb20 clearfix">
                    <div class="contLeft fl">
                        <p class="mb20"><fmt:message key="info.tianjiatupianxinxi"/></p>
                        <button class="btn blackBtn w150 mb20 _upload"><fmt:message key="info.shangchuanchangjingtu"/></button>
                        <div class="dropped" style="display: none"></div>
                        <div class="mb20">
                            <label><fmt:message key="info.mingcheng"/></label><input type="text" name="name">
                        </div>
                        <div class="mb20 ">
                            <label class="vt"><fmt:message key="info.fenggebiaoqian"/></label>
                            <div class="styleTagSelected tags" style="width: 265px;height: auto;border: 1px solid #e5e5e5;min-height: 30px;"></div>
                        </div>
                        <div class="tags mb20 styleTagList">
                        </div>
                        <div class="mb20">
                            <label class="vt"><fmt:message key="info.kongjianbiaoqian"/></label>
                            <div class="spaceTagSelected tags" style="width: 265px;height: auto;border: 1px solid #e5e5e5;min-height: 30px;"></div>
                        </div>
                        <div class="tags mb20 spaceTagList">
                        </div>
                        <div class="mb20">
                            <label class="vt"><fmt:message key="info.jieshao"/></label><textarea name="info"></textarea>
                        </div>
                        <div class="mb20" style="margin-left: 42px;">
                            <i class="iicon i-check checked vt _isShow"></i><fmt:message key="info.sheweigongkai"/>
                        </div>
                        <button class="btn blackBtn w150 mb20" onclick="createSceneHandler.pcCreateScene()"><fmt:message key="info.baocun"/></button>
                    </div>
                    <div class="contRight fr">
                        <p class="mb20"><fmt:message key="info.weitupiantianjiabiaoqian"/></p>
                        <div class="picPreview">
                            <div id="baseimg" style="z-index: 1;width: 0px;height: 0px;"></div>
                            <img id="sceneImage" onclick="createSceneHandler.getPointPosition(event)" src="" style="width: 80%;height: 80%;float: left">
                            <div style="min-height:50px;width: 130px;height: auto;float: left;margin-left: 20px;border:1px solid #BABABA;OVERFLOW-Y: auto; OVERFLOW-X:hidden;" id="goodsTagList"></div>
                        </div>
                        <div class="contRight choosePicList fr goodsList">
                            <p class="mb20"><fmt:message key="info.xuanzeshangpintu"/></p>
                            <ul style="margin-left: 10px;">
                                <li sceneid="1632"><img src="http://7xksl1.com2.z0.glb.qiniucdn.com/FmwaJJyP-Clgj8dHE1XCqgzrB2yi"></li>
                                <li sceneid="1631"><img src="http://7xksl1.com2.z0.glb.qiniucdn.com/FkyhwQ1npT7Ef9i0RcIdis4Dreet"></li>
                                <li sceneid="1630"><img src="http://7xksl1.com2.z0.glb.qiniucdn.com/Fi7H8y9sedOfJeUH44mxJt8rxVKG"></li>
                                <li sceneid="1629"><img src="http://7xksl1.com2.z0.glb.qiniucdn.com/FmOTtFhriZKiCmMF0YIDM9eBrld1"></li>
                                <li sceneid="1628"><img src="http://7xksl1.com2.z0.glb.qiniucdn.com/FlQqKg4ZjWGX5O93WBVPtf3Lmwh2"></li>
                                <li sceneid="1627"><img src="http://7xksl1.com2.z0.glb.qiniucdn.com/FrAUjBMfD3TNf64Ktk8Awg_iHpkb"></li>
                                <li sceneid="1626"><img src="http://7xksl1.com2.z0.glb.qiniucdn.com/FrMg-F0G4gzoZxrI5NVCTEx1JzRf"></li>
                                <li sceneid="1625"><img src="http://7xksl1.com2.z0.glb.qiniucdn.com/Fu8czSda_ARDxiJTbquRNolFlTzI"></li>
                                <li sceneid="1624"><img src="http://7xksl1.com2.z0.glb.qiniucdn.com/FuBV_Kjn4YRyNaa_0FrRIGY56Pp-"></li>
                                <li sceneid="1623"><img src="http://7xksl1.com2.z0.glb.qiniucdn.com/FobxuJvr8PyfbO_E0xtS1NooVOdD"></li>
                                <li sceneid="1622"><img src="http://7xksl1.com2.z0.glb.qiniucdn.com/FncwjZjrgyCb2rd6zmD0uUD3Y9tu"></li>
                                <li sceneid="1621"><img src="http://7xksl1.com2.z0.glb.qiniucdn.com/FgPWDQ7FBWZ8kSuVOqufJmF1LzX1"></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <%-- 新增系列图 --%>
            <div class="createSeriesTab tabitem none">
                <div class="mb20 clearfix">
                    <p class="fs16 color6 fl" style="line-height: 34px;"><fmt:message key="info.shangchuanxilietu"/></p>
                    <div class="page_rgt tr pr20 fr">
                        <a class="iicon back" href="#"></a><span>page <span class="page_rgt_pageNum">0</span> of <span class="page_rgt_totalPage">0</span></span><a class="iicon next" href="#"></a>
                    </div>
                </div>

                <div class="uploadCont mb20 clearfix">
                    <div class="contLeft fl">
                        <p class="mb20"><fmt:message key="info.tianjiaxilietuxinxi"/></p>
                        <div class="p-item">
                            <label style="min-width: 0;"><fmt:message key="info.anlifenlei"/></label>
                            <div class="select_input inline-b rel" style="width: 200px;">
                                <i class="iicon dropdown abs"></i>
                                <span class="select-text fs16 slh" style="width: 150px;"></span>
                                <select>

                                </select>
                            </div>
                        </div>
                        <div class="mb20">
                            <label class="vt"><fmt:message key="info.jieshao"/></label><textarea maxlength="200"></textarea>
                        </div>
                        <div class="mb20" style="margin-left: 42px;">
                            <button class="blackBtn btn" onclick="createSeriesHandler.pcCreateSeries()"><fmt:message key="info.wancheng"/></button>
                        </div>
                    </div>
                    <div class="contRight choosePicList fr">
                        <p class="mb20"><fmt:message key="info.xuanzetupian"/></p>
                        <ul>

                        </ul>

                    </div>
                </div>
            </div>

            <!-- 分页 -->
            <%@ include file="common/page.jsp" %>
        </div>
    </div>

</div>
<!-- footer -->
<%@ include file="common/footer.jsp" %>


<%@ include file="common/other.jsp" %>
<script type="text/javascript" src="static/pc/js/base.js"></script>
<link href="static/js/plugins/dropper/jquery.fs.dropper.css" rel="stylesheet">
<script src="static/js/plugins/dropper/jquery.fs.dropper.js"></script>
<script type="text/template" id="newLightBox">
    <div style="padding: 20px">
        <p class="tc fs16 color3 mb20" style="font-size: 18px"><fmt:message key="info.xinjianshoucangjia"/></p>

        <div class="collipt"><input type="text" placeholder="<fmt:message key="info.shoucangjiamingcheng"/>"/></div>
        <p class="color9 fs16 mt20"><fmt:message key="info.shoucangjiamiaoshu"/></p>

        <div class="mt20 textarea">
            <textarea></textarea>
        </div>
        <div class="tc btns">
            <button class="btn blackBtn confirmBtn" style="margin-right: 30px;"><fmt:message key="info.quxiao"/></button>
            <button class="btn blackBtn cancelBtn"><fmt:message key="info.queding"/></button>
        </div>
    </div>
</script>
<script type="text/javascript">
    window.onload = function () {
        var upload = sessionStorage.getItem("upload");
        if (upload == 'goods') {
            createGoodsHandler.showCreateGoodsTab();
        } else if (upload == 'scene') {
            createSceneHandler.showCreateSceneTab();
        } else if (upload == 'series') {
            createSeriesHandler.showCreateSeriesTab();
        }
        sessionStorage.setItem("showSeries", ""); //销毁 from 防止在b页面刷新 依然触发$('#xxx').click()
    }
    //加载
    $(function () {

        if ($(".brief p").text() == 'null') {
            $(".brief p").text('');
        }
        ajaxMyHomePage();
        showObject();
        //显示上传的 商品图 系列图 场景图
        showListImg();
        skinHandler();
    });
    var register;
    var thisPage = rpage; // 分页对象 rpage存在于page.jsp
    //显示上传的 商品图 系列图 场景图
    function showListImg() {
        $(".list-img a").unbind("click").click(function () {
            paginationClass("show");
            if ($(this).text() == "<fmt:message key="info.shangpintu"/>") {
                ajaxPageGoods();
            } else if ($(this).text() == "<fmt:message key="info.changjingtu"/>") {
                ajaxPageScene();
            } else if ($(this).text() == "<fmt:message key="info.xilietu"/>") {
                ajaxPageSeries();
            } else if ($(this).text() == "<fmt:message key="info.huabansucai"/>") {
                ajaxPageMaterial();
            }
        })
    }
    ;
    //上传商品图分页
    function ajaxPageGoods() {
        var userId = $("#sessionUserId").val();
        var data = {
            userId: userId,
            pageNum: thisPage.pageNum,
            pageSize: 18,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/user/goodsPage", data, function (result) {
            if (result.status == "0") {
                var html = ' <div class="mb20"><div class="page_rgt tr pr20 ">\
                <a class="iicon back"></a><span>page<span class="page_rgt_pageNum"></span> of <span class="page_rgt_totalPage"></span>\
                </span><a class="iicon next"></a>\
                </div></div><div class="borderline"></div><div class="clearfix mb20" style="line-height: 37px;">\
                 <p class="fl fs16 color6"></p><button class="btn blackBtn w150 fr" onclick="createGoodsHandler.showCreateGoodsTab()"><fmt:message key="info.shangchuanshangpin"/></button></div><div class="commodityList"><ul>'
                for (var i = 0; i < result.data.list.length; i++) {
                    var goods = result.data.list[i];
                    html += ' <li><a href="pc/goods/detail?goodsId=' + goods.id + '"><img src="' + goods.cover + '"><p class="colorBlack pl10">' + goods.name + '</p></a></li>';

                }
                html += '</ul></div>'
                $(".myPublish").html(html);
                thisPage.init(result.data.page, " ajaxPageGoods");
                $(".myPublish").find(".page_rgt").find(".back").unbind("click").click(function () {
                    $(".pagination").find(".first").trigger("click");
                });
                $(".myPublish").find(".page_rgt").find(".next").unbind("click").click(function () {
                    $(".pagination").find(".last").trigger("click");
                })
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
                $(".fl").filter(".fs16").text("<fmt:message key="info.wofabudeshangpintu"/>（" + rpage.totalNum + "）")
            }
        });
    }
    //上传场景图分页
    function ajaxPageScene() {
        var userId = $("#sessionUserId").val();
        var data = {
            userId: userId,
            pageNum: thisPage.pageNum,
            pageSize: 18,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/user/scenePage", data, function (result) {
            if (result.status == "0") {
                var html = ' <div class="mb20"><div class="page_rgt tr pr20 ">\
                <a class="iicon back"></a><span>page<span class="page_rgt_pageNum"></span> of <span class="page_rgt_totalPage"></span>\
                </span><a class="iicon next"></a>\
                </div></div><div class="borderline"></div><div class="clearfix mb20" style="line-height: 37px;">\
                 <p class="fl fs16 color6"></p><button class="btn blackBtn w150 fr" onclick="createSceneHandler.showCreateSceneTab()"><fmt:message key="info.shangchuanchangjingtu"/></button></div><div class="commodityList"><ul>'
                for (var i = 0; i < result.data.list.length; i++) {
                    var scene = result.data.list[i];
                    html += ' <li><a href="pc/scene/detail?sceneId=' + scene.id + '"><img src="' + scene.image + '"><p class="colorBlack pl10">' + scene.name + '</p></a></li>';

                }
                html += '</ul></div>'
                $(".myPublish").html(html);
                thisPage.init(result.data.page, " ajaxPageScene");
                $(".myPublish").find(".page_rgt").find(".back").unbind("click").click(function () {
                    $(".pagination").find(".first").trigger("click");
                });
                $(".myPublish").find(".page_rgt").find(".next").unbind("click").click(function () {
                    $(".pagination").find(".last").trigger("click");
                })
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
                $(".fl").filter(".fs16").text("<fmt:message key="info.wofabudechangjingtu"/>（" + rpage.totalNum + "）")
            }
        });
    }
    //上传系列图分页
    function ajaxPageSeries() {
        var userId = $("#sessionUserId").val();
        var data = {
            userId: userId,
            pageNum: thisPage.pageNum,
            pageSize: 9,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/user/seriesPage", data, function (result) {
            if (result.status == "0") {
                var html = ' <div class="mb20"><div class="page_rgt tr pr20 ">\
                <a class="iicon back"></a><span>page<span class="page_rgt_pageNum"></span> of <span class="page_rgt_totalPage"></span>\
                </span><a class="iicon next"></a></div></div><div class="borderline"></div>\
               <div class="clearfix mb20" style="line-height: 37px;padding:0 20px;">\
                <p class="fl fs16 color6"></p>\
                <button class="btn blackBtn w150 fr" onclick="createSeriesHandler.showCreateSeriesTab()"><fmt:message key="info.shangchuanxilietu"/></button></div><div class="commodityList seriesList"><ul>'
                for (var i = 0; i < result.data.list.length; i++) {
                    var series = result.data.list[i];
                    if (series.info.length > 14) {
                        series.info = series.info.substring(0, 14) + "..."
                    }
                    html += ' <li><a href="pc/series/detail?seriesId=' + series.id + '"><img src="' + series.cover + '"><p class="colorBlack pl10 fs16" style="margin-top: 8px;"' +
                            '><span class="fl">' + series.info + '</span><span class="fr color6 pr10">' + series.sceneNum + '<fmt:message key="info.zhangchangjingtu"/></span></p></a></li>';

                }
                html += '</ul></div>'
                $(".myPublish").html(html);
                thisPage.init(result.data.page, " ajaxPageSeries");
                $(".myPublish").find(".page_rgt").find(".back").unbind("click").click(function () {
                    $(".pagination").find(".first").trigger("click");
                });
                $(".myPublish").find(".page_rgt").find(".next").unbind("click").click(function () {
                    $(".pagination").find(".last").trigger("click");
                })
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
                $(".fl").filter(".fs16").text("<fmt:message key="info.wofabudexilietu"/>（" + rpage.totalNum + "）")
            }
        });
    }
    //上传画板素材分页
    function ajaxPageMaterial() {
        var userId = $("#sessionUserId").val();
        var data = {
            userId: userId,
            pageNum: thisPage.pageNum,
            pageSize: 12,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/user/materialPage", data, function (result) {
            if (result.status == "0") {
                var html = '<div class="borderline"></div>\
                 <div class="clearfix mb20" style="line-height: 37px;padding: 0 20px;"><div class="page_rgt tr pr20 ">\
                <a class="iicon back"></a><span>page<span class="page_rgt_pageNum"></span> of <span class="page_rgt_totalPage"></span>\
                </span><a class="iicon next"></a></div><p class="fl fs16 color6"></p></div><div class="commodityList materialList"><ul>'
                for (var i = 0; i < result.data.list.length; i++) {
                    var material = result.data.list[i];
                    html += '<li><img src="' + material.image + '"></li>';
                }
                html += '</ul></div>'
                $(".myPublish").html(html);
                thisPage.init(result.data.page, " ajaxPageMaterial");
                $(".myPublish").find(".page_rgt").find(".back").unbind("click").click(function () {
                    $(".pagination").find(".first").trigger("click");
                });
                $(".myPublish").find(".page_rgt").find(".next").unbind("click").click(function () {
                    $(".pagination").find(".last").trigger("click");
                })
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
                $(".fl").filter(".fs16").text("<fmt:message key="info.huabansucai"/>（" + rpage.totalNum + "）")
            }
        });
    }
    //加载主页
    function ajaxMyHomePage() {
        paginationClass("hide");
        var userId = $("#sessionUserId").val();
        $bluemobi.ajax("pc/user/favoriteList", {userId: userId}, function (result) {
            if (result.status == "0") {
                var html = ' ';
                if (result.data.length <= 3) {
                    for (var i = 0; i < result.data.length; i++) {
                        var favorite = result.data[i];
                        html += '<li onclick="pageShowFavorite(this,' + favorite.id + ')" favoriteName=' + favorite.name + ' style="cursor:pointer"><div class="Thumbnails"><img src="' + favorite.cover + '" style="width: 175px;height:148px;">\
                  </div><p class="fs16 colorBlack tc">' + favorite.name + '</p></li>';
                    }
                } else {
                    for (var i = 0; i < 3; i++) {
                        var favorite = result.data[i];
                        html += '<li onclick="pageShowFavorite(this,' + favorite.id + ')" favoriteName=' + favorite.name + ' style="cursor:pointer"><div class="Thumbnails"><img src="' + favorite.cover + '" style="width: 175px;height:148px;">\
                  </div><p class="fs16 colorBlack tc">' + favorite.name + '</p></li>';
                    }

                }
                $("#homePageLi").html(html);
                $(".myHomePage p").eq(0).unbind("click").click(function () {
                    $("#myCollect").trigger("click");
                });
                $(".myHomePage li").eq(0).unbind("click").click(function () {
                    newFavorite();
                });
            }
        });
        $bluemobi.ajax("pc/user/imagesList", {userId: userId}, function (result) {
            if (result.status == "0") {
                var html = ' ';
                if (result.data.length >= 4) {
                    for (var i = 0; i < 4; i++) {
                        var picObj = result.data[i];
                        html += '<li><a href="pc/' + picObj.objectType + '/detail?' + picObj.objectType + 'Id=' + picObj.id + '"><div class="Thumbnails"><img src="' + picObj.image + '"></div></a></li>';
                    }
                } else {
                    for (var i = 0; i < result.data.length; i++) {
                        var picObj = result.data[i];
                        html += '<li><a href="pc/' + picObj.objectType + '/detail?' + picObj.objectType + 'Id=' + picObj.id + '"><div class="Thumbnails"><img src="' + picObj.image + '"></div></a></li>';
                    }
                }
                $(".newestupload ul").html(html);
            }
        });
    }

    function ajaxMyCollect() {
        //展示所有收藏夹封面和标题
        var userId = $("#sessionUserId").val();
        $bluemobi.ajax("pc/user/favoriteList", {userId: userId}, function (result) {
            if (result.status == "0") {
                var html = '<div class="borderline" style="margin-bottom: 0"></div><div class="imageslist"><div class="collection mycollection"><ul class="clearfix">\
        <li class="first"><div class="Thumbnails"><span class="iicon addnewimg"></div>\
        <p class="fs16 colorBlack tc"><fmt:message key="info.xinjianshoucangjia"/></p></li>';
                for (var i = 0; i < result.data.length; i++) {
                    var favorite = result.data[i];
                    html += '<li onclick="pageShowFavorite(this,' + favorite.id + ')" favoriteName=' + favorite.name + ' ><div class="Thumbnails"><img src="' + favorite.cover + '" style="width: 165px;height:148px;cursor:pointer;">\
          </div><p class="fs16 colorBlack tc">' + favorite.name + '</p></li>';
                }
                html += '</ul></div>'

                $(".myCollect").html(html);
                $(".myCollect li").eq(0).unbind("click").click(function () {
                    newFavorite();
                })
            }
        });
    }
    //展示用户收藏的资讯
    function ajaxMyMessage() {
        var userId = $("#sessionUserId").val();
        var data = {
            userId: userId,
            pageNum: thisPage.pageNum,
            pageSize: 9,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/user/pageMessage", data, function (result) {
            if (result.status == "0") {
                var html = ' <div class="clearfix mb20" style="line-height: 37px;padding:0 20px;">\
                <p class="fl fs16 color6"></p>\
                <div class="page_rgt tr pr20 fr pagabs">\
                <a class="iicon back"></a><span>page<span class="page_rgt_pageNum"></span> of <span class="page_rgt_totalPage"></span>\
                </span><a class="iicon next"></a>\
                </div></div><div class="commodityList seriesList"><ul>';
                for (var i = 0; i < result.data.list.length; i++) {
                    var message = result.data.list[i].message;
                    var title = message.title;
                    if (title.length > 12) {
                        title = title.substring(0, 12) + "..."
                    }
                    html += '<li class="clearfix">\
                          <img src="' + message.image + '" style="cursor:pointer">\
                          <p class="colorBlack pl10 fs16" style="margin-top: 8px;">\
                          <span class="fl">' + title + '</span><button class="cancelCollBtn color6 fs12 fr" onclick="delMessage(' + message.id + ')"><fmt:message key="info.quxiaoshoucang"/></button></p>\
                          </li>';
                }
                html += '</ul></div>'
                if (result.data.list.length == 0) {
                    html += '<div class="empty tc" style="min-height: 600px"><p class="color9 pt20" style="font-size: 20px;"><fmt:message key="info.zanwuzixunjilu"/></p></div>'
                }
                $(".myMessage").html(html);
                thisPage.init(result.data.page, "ajaxMyMessage");
                $(".myMessage").find(".page_rgt").find(".back").unbind("click").click(function () {
                    $(".pagination").find(".first").trigger("click");
                });
                $(".myMessage").find(".page_rgt").find(".next").unbind("click").click(function () {
                    $(".pagination").find(".last").trigger("click");
                })
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
                $(".fl").filter(".fs16").text("<fmt:message key="info.woshoucangdezixun"/>（" + rpage.totalNum + "）")
            }
        });
    }
    //删除收藏资讯
    function delMessage(messageId) {
        var messageId = messageId;
        var userId = $("#sessionUserId").val();
        $bluemobi.ajax("pc/user/delMessageById", {userId: userId, messageId: messageId}, function (result) {
            if (result.status == "0") {
                ajaxMyMessage();
            }
        })
    }
    //展示收藏夹信息
    function pageShowFavorite(_this, favoriteId) {
        var favoriteId = favoriteId;
        var favoriteNameTo = $(_this).attr("favoriteName");
        var data = {
            favoriteId: favoriteId,
            pageNum: thisPage.pageNum,
            pageSize: 18,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/user/pageShowFavorite", data, function (result) {
            if (result.status == "0") {
                thisPage.init(result.data.page, "pageShowFavorite");
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
                var html = '<div class="clearfix mb20" style="line-height: 37px;"><p class="fl fs16 color6">"' + favoriteNameTo + '"（' + rpage.totalNum + '）</p>\
                    </div><div class="commodityList"><ul>';
                for (var i = 0; i < result.data.list.length; i++) {
                    var collection = result.data.list[i]
                    var favoriteName = result.data.list[i].name;
                    var favoriteCover = result.data.list[i].cover;
                    html += '<li><a href="pc/' + collection.objectType + '/detail?' + collection.objectType + 'Id=' + collection.objectId + '"><img src="' + favoriteCover + '" style="cursor:pointer"><p class="colorBlack pl10">' + favoriteName + '</p></a></li>';
                }
                html += '</ul></div>'
                $(".myHomePage").hide();
                $(".myCollect").show();
                $(".myCollect").html(html)
                thisPage.init(result.data.page, " ajaxPageGoods");
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
            }
        })
    }

    //新建收藏弹出输入框
    function newFavorite() {
        var lightBox = new dialogBox({
            popupBoxW: 520,
            popupBoxH: 530,
            contentHtml: $('#newLightBox').html()
        });
        lightBox.showDlg();
        ajaxLightBoxBtns(lightBox);
    }
    //收藏夹按钮
    function ajaxLightBoxBtns(lightBox) {
        $(".btns").find(".confirmBtn").unbind("click").click(function () {
            lightBox.hideDlg();
        })
        $(".btns").find(".cancelBtn").unbind("click").click(function () {
            var name = $(".btns").parent().find("input").val();
            var info = $(".btns").parent().find("textarea").val();
            var userId = $("#sessionUserId").val();
            $bluemobi.ajax("pc/user/newFavorite", {name: name, info: info, userId: userId}, function (result) {
                if (result.status == "0") {
                    $bluemobi.notify(result.msg, "success");
                    lightBox.hideDlg();
                    setTimeout(1000, location.reload());
                }
            });
        })

    }
    // 查询当前用户FANS的数量并分页展示
    function ajaxFansPage() {
        $(".nav li").removeClass("current")
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
                    if (user.nickname == null) {
                        user.nickname = '';
                    }
                    html += '<li class="clearfix"><img src="' + user.headImage + '" class="fl" style="width: 62px;height: 62px;"><div class="ml10 fl">\
              <p class="fs16 colorBlack pb5">' + user.nickname + '</p><p class="pb5"><span class="location"><i class="iicon"></i><span>' + user.city.province.name + '</span><span>' + user.city.name + '</span></span></p>\
              <p class="pt5 color6 fs12"><fmt:message key="info.guanzhu"/><span class="pl5 colorOrange">' + user.attention + '</span><span class="pl5 pr5">|</span><fmt:message key="info.fensi"/><span class="pl5 pr5 colorOrange">' + user.collect + '</span></span>\
              </div></li>';
                }
                html += '</ul></div>'
                if (result.data.list.length == 0) {
                    html += '<div class="empty tc" style="min-height: 600px"><p class="color9 pt20" style="font-size: 20px;"><fmt:message key="info.zanwufensijilu"/></p></div>'
                }
                $(".myHomePage").hide();
                $(".createSceneTab").hide();
                $(".createGoodsTab").hide();
                $(".createSeriesTab").hide();
                $(".myCollect").hide();
                $(".myPublish").hide();
                $(".myComment").hide();
                $(".myMessage").show();
                $(".myMessage").html(html);
                thisPage.init(result.data.page, " ajaxAttentionPage");
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
            }
        });
    }
    // 查询当前用户所关注的user数量
    function ajaxAttentionPage() {
        $(".nav li").removeClass("current")
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
              <p class="pt5 color6 fs12"><fmt:message key="info.guanzhu"/><span class="pl5 colorOrange">' + user.attention + '</span><span class="pl5 pr5">|</span><fmt:message key="info.fensi"/><span class="pl5 pr5 colorOrange">' + user.collect + '</span></span>\
              </div></li>';
                }
                html += '</ul></div>'
                if (result.data.list.length == 0) {
                    html += '<div class="empty tc" style="min-height: 600px"><p class="color9 pt20" style="font-size: 20px;"><fmt:message key="info.zanwuguanzhujilu"/></p></div>'
                }
                $(".createSceneTab").hide();
                $(".createGoodsTab").hide();
                $(".createSeriesTab").hide();
                $(".myHomePage").hide();
                $(".myCollect").hide();
                $(".myPublish").hide();
                $(".myComment").hide();
                $(".myMessage").show();
                $(".myMessage").html(html)
                thisPage.init(result.data.page, " ajaxAttentionPage");
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
            }
        });
    }
    //查询指定用户的所有评论分页
    function ajaxMyComment() {
        var userId = $(".search-condition").find("#userId").val();
        var data = {
            userId: userId,
            pageNum: thisPage.pageNum,
            pageSize: 4,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/user/commentPage", data, function (result) {
            if (result.status == "0") {
                var html = '<div class="clearfix mb20" style="line-height: 37px;padding:0 20px;"><p class="fl fs16 color6"><fmt:message key="info.pinglunliebiao"/>（123）</p>\
                <div class="page_rgt tr pr20 fr pagabs"><a class="iicon back"></a><span>page <span class="page_rgt_pageNum"></span> of <span class="page_rgt_totalPage"></span></span>\
                <a class="iicon next"></a></div></div><div class="comment-list mb20"><ul>';
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
                        } else {
                            html += '<div class="rost pt20 pb20">'
                        }
                        html += '<img src="' + comment.user.headImage + '"/>\
                                <div class="prost">'
                        if (comment.replyList.length == 0) {
                            html += '<div class="Rost2">'
                        } else {
                            html += '<div class="Rost2 pb20 border_bottom_dashed">'
                        }
                        html += '<p class="first fs16">\
                                    <span class="colorc fr fs12">' + comment.createTime + '</span>' + comment.user.nickname + '\
                                    </p>\
                                    <p class="txt">\
                                    ' + comment.content + '\
                                    </p>\
                                    <p class="inter">\
                                        <span class="i-praise mr10">\
                                            <i class="iicon"></i>' + comment.praiseNum + '' +
                                '</span>'
                        if (comment.replyList.length == 0 && $("#sessionUserId").val() != "") {
                            html += '<span class="i-share pl20"></i><fmt:message key="info.huifu"/></span><div class="rost replydiv none" style="width: 500px" ><textarea class="tared" maxlength="200"  style="height: 75px;width: 500px; resize: none"></textarea>\
                                        <button class="replybtn" onclick="saveCommentReply(' + comment.id + ',this)"><fmt:message key="info.fabu"/></button></div>';
                        }
                        html += '</p></div>'
                        if (result.data.list.length == 0) {
                            html += '<div class="empty tc" style="min-height: 600px"><p class="color9 pt20" style="font-size: 20px;"><fmt:message key="info.zanwupinglunjilu"/></p></div>'
                        }
                        //回复
                        if (comment.replyList.length != 0) {
                            html += '<div class="rost"><img src="' + comment.replyList[0].headImage + '"/>\
                            <div class="Rost"><p class="first fs16">\
                            <span class="fr fs12 colorc">' + comment.replyList[0].createTime + '</span>' + comment.replyList[0].nickname + '</p>\
                            <p class="txt">' + comment.replyList[0].content + '</p></div>';
                        }
                        html += '</div></div>'

                    }
                    html += '</div></li>'
                }
                html += '</ul></div>'
                if (result.data.list.length == 0) {
                    html += '<div class="empty tc" style="min-height: 600px"><p class="color9 pt20" style="font-size: 20px;"><fmt:message key="info.zanwupinglunjilu"/></p></div>'
                }
                $(".myComment").html(html);
                $(".comment-list").find(".i-share").unbind("click").click(function () {
                    $(this).parents(".prost").find(".replydiv").show();
                });
                thisPage.init(result.data.page, " ajaxMyComment");
                $(".myComment").find(".page_rgt").find(".back").unbind("click").click(function () {
                    $(".pagination").find(".first").trigger("click");
                });
                $(".myComment").find(".page_rgt").find(".next").unbind("click").click(function () {
                    $(".pagination").find(".last").trigger("click");
                });
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
            }
        });
    }
    // 新增评论回复
    function saveCommentReply(commentId, _this) {
        var userId = $("#sessionUserId").val();
        // 用户未登录，则弹出未登录提示框
        if (userId == "") {
            loginPopup.showDlg();
            return false;
        }
        var content = $(_this).parents(".replydiv").find("textarea").val();
        if (content == "") {
            $bluemobi.notify("<fmt:message key="info.qingshurupinglunneirong"/>", "error");
            $(_this).parents(".replydiv").find("textarea").focus();
            return false;
        }
        $bluemobi.ajax("pc/comment/saveCommentReply", {
            userId: userId,
            commentId: commentId,
            content: content
        }, function (result) {
            if (result.status == "0") {
                $bluemobi.notify(result.msg, "success");
                $(_this).parents(".replydiv").next("textarea").val("");
                ajaxMyComment();
            }
        });
    }


    var createGoodsHandler = {
        showCreateGoodsTab: function () {
            $(".tabitem").hide();
            $(".createGoodsTab").show();
            // 图片上传
            $(".createGoodsTab .dropped").dropper({
                postKey: "file",
                action: "pc/upload/uploadImageToQiniu",
                postData: {},
                label: ""
            }).on("fileComplete.dropper", function (e, file, response) {
                var html = '<p class="fs16 color6 mt20">\
                        <img src="' + response.image + '" thumbnailsrc="' + response.thumbnailImage + '" width="24" height="24"/>\
                <span><i class="iicon choose1 checkbox _cover"></i><fmt:message key="info.sheweifengmian"/></span>\
                <span><i class="iicon choose2 i-check"></i><fmt:message key="info.zhuanweisucai"/></span>\
                </p>';
                $(".createGoodsTab .piclist").append(html);
                $(".createGoodsTab i").unbind("click").click(function () {
                    if ($(this).hasClass("_cover")) {
                        $(".createGoodsTab ._cover").not($(this)).removeClass("checked");
                        $(this).addClass("_isCover");
                    }
                    if ($(this).hasClass("checked")) {
                        $(this).removeClass("checked");
                    } else {
                        $(this).addClass("checked");
                    }
                });
            }).on("fileError.dropper", function () {
                console.log("upload error")
            });
            $(".createGoodsTab .uploadBtn").unbind("click").click(function () {
                $(".createGoodsTab .dropped .dropper-dropzone").trigger("click");
            });

            createGoodsHandler.ajaxKindTagList();
            createGoodsHandler.ajaxStyleTagList();
            createGoodsHandler.ajaxSpaceTagList();
        },
        ajaxKindTagList: function () {
            $bluemobi.ajax("pc/comm/ajaxKindTagList", {}, function (result) {
                if (result.status == "0") {
                    var html = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var kindTag = result.data[i];
                        html += '<option value="' + kindTag.id + '">' + kindTag.name + '</option>';
                    }
                    $(".kingTagSelect").html(html);
                    var kindName = $(".kingTagSelect option:selected").text();
                    $(".createGoodsTab .kindTagName").text(kindName);
                }
            });
        },
        ajaxStyleTagList: function () {
            $bluemobi.ajax("pc/comm/ajaxStyleTagList", {}, function (result) {
                if (result.status == "0") {
                    var html = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var styleTag = result.data[i];
                        html += '<span class="curp" styletagid="' + styleTag.id + '">' + styleTag.name + '</span>';
                    }
                    $(".createGoodsTab .styleTagList").html(html);
                    $(".createGoodsTab .styleTagList").find("span").each(function () {
                        var currSpan = $(this);
                        currSpan.unbind("click").click(function () {
                            if (currSpan.parent().hasClass("styleTagSelected")) {
                                $(".createGoodsTab .styleTagList").append(currSpan);
                            } else {
                                $(".createGoodsTab .styleTagSelected").append(currSpan);
                            }
                        });
                    });
                }
            });
        },
        ajaxSpaceTagList: function () {
            $bluemobi.ajax("pc/comm/ajaxSpaceTagList", {}, function (result) {
                if (result.status == "0") {
                    var html = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var spacetag = result.data[i];
                        html += '<span class="curp" spacetagid="' + spacetag.id + '">' + spacetag.name + '</span>';
                    }
                    $(".createGoodsTab .spaceTagList").html(html);
                    $(".createGoodsTab .spaceTagList").find("span").each(function () {
                        var currSpan = $(this);
                        currSpan.unbind("click").click(function () {
                            if (currSpan.parent().hasClass("spaceTagSelected")) {
                                $(".createGoodsTab .spaceTagList").append(currSpan);
                            } else {
                                $(".createGoodsTab .spaceTagSelected").append(currSpan);
                            }
                        });
                    });
                }
            });
        },
        pcCreateGoods: function () {
            var userId = $("#sessionUserId").val();
            // 用户未登录，则弹出未登录提示框
            if (userId == "") {
                loginPopup.showDlg();
                return false;
            }

            var name = $('.createGoodsTab input[name="name"]').val();
            var price = $('.createGoodsTab input[name="price"]').val();
            var texture = $('.createGoodsTab input[name="texture"]').val();
            var size = $('.createGoodsTab input[name="size"]').val();
            var link = $('.createGoodsTab input[name="link"]').val();
            var info = $('.createGoodsTab textarea[name="info"]').val();

            if (name == "") {
                $bluemobi.notify("<fmt:message key="info.qingshurushangpinmingcheng"/>!", "error");
                $('.createGoodsTab input[name="name"]').focus();
                return false;
            }

            var kindTagIds = $(".createGoodsTab .kingTagSelect option:selected").val();
            if (!kindTagIds) {
                $bluemobi.notify("<fmt:message key="info.qingxuanzefenlei"/>!", "error");
                return false;
            }

            var styleTagIds = "";
            $(".createGoodsTab .styleTagSelected").find("span").each(function (index) {
                if (index != 0) {
                    styleTagIds += ",";
                }
                styleTagIds += "@" + $(this).attr("styletagid") + "@";
            });
            if (styleTagIds == "") {
                $bluemobi.notify("<fmt:message key="info.qingxuanzefenggebiaoqian"/>!", "error");
                return false;
            }

            var spaceTagIds = "";
            $(".createGoodsTab .spaceTagSelected").find("span").each(function (index) {
                if (index != 0) {
                    spaceTagIds += ",";
                }
                spaceTagIds += "@" + $(this).attr("spacetagid") + "@";
            });
            if (spaceTagIds == "") {
                $bluemobi.notify("<fmt:message key="info.qingxuanzekongjianbiaoqian"/>!", "error");
                return false;
            }

            if (price == "") {
                $bluemobi.notify("<fmt:message key="info.qingshurujiage"/>!", "error");
                $('.createGoodsTab input[name="price"]').focus();
                return false;
            }
            if (size == "") {
                $bluemobi.notify("<fmt:message key="info.qingshuruchicun"/>!", "error");
                $('.createGoodsTab input[name="size"]').focus();
                return false;
            }
            if (texture == "") {
                $bluemobi.notify("<fmt:message key="info.qingshurucaizhi"/>!", "error");
                $('.createGoodsTab input[name="texture"]').focus();
                return false;
            }
            if (link == "") {
                $bluemobi.notify("<fmt:message key="info.qingshurugoumailianjie"/>!", "error");
                $('.createGoodsTab input[name="link"]').focus();
                return false;
            }
            if (info == "") {
                $bluemobi.notify("<fmt:message key="info.qingshurushangpinmiaoshu"/>!", "error");
                $('.createGoodsTab textarea[name="info"]').focus();
                return false;
            }

            var cover = "";
            var thumbnailCover = "";
            var images = "";
            var thumbnailImages = "";
            var isTurnMaterials = "";
            $('.createGoodsTab .piclist').find("p").each(function (index) {
                var span0 = $(this).find("span").eq(0);
                var span1 = $(this).find("span").eq(1);
                if (index != 0) {
                    images += ",";
                    thumbnailImages += ",";
                    isTurnMaterials += ",";
                }
                images += $(this).find("img").attr("src");
                thumbnailImages += $(this).find("img").attr("thumbnailsrc");
                if (span1.find("i").hasClass("checked")) {
                    isTurnMaterials += "yes";
                } else {
                    isTurnMaterials += "no";
                }
                if (span0.find("i").hasClass("_isCover")) {
                    cover = span0.parent().find("img").attr("src");
                    thumbnailCover = span0.parent().find("img").attr("thumbnailsrc");
                }
            });
            if (images == "") {
                $bluemobi.notify("<fmt:message key="info.qingshangchuanshangpintupian"/>!", "error");
                return false;
            }
            if (cover == "") {
                $bluemobi.notify("<fmt:message key="info.qingxuanzefengmiantu"/>!", "error");
                return false;
            }

            var data = {
                name: name, kindTagIds: kindTagIds, styleTagIds: styleTagIds, spaceTagIds: spaceTagIds, price: price, texture: texture, size: size, link: link, info: info
                , cover: cover, thumbnailCover: thumbnailCover, images: images, thumbnailImages: thumbnailImages, isTurnMaterials: isTurnMaterials
            };

            $bluemobi.ajax("pc/goods/pcCreateGoods", data, function (result) {
                if (result.status == "0") {
                    $bluemobi.notify(result.msg, "success");
                    location.reload(true);
//                    $('.createGoodsTab input[name="name"]').val("");
//                    $('.createGoodsTab input[name="price"]').val("");
//                    $('.createGoodsTab input[name="texture"]').val("");
//                    $('.createGoodsTab input[name="size"]').val("");
//                    $('.createGoodsTab input[name="link"]').val("");
//                    $('.createGoodsTab textarea[name="info"]').val("");
//                    $('.createGoodsTab .piclist').html("");
                } else {
                    $bluemobi.notify(result.msg, "error");
                }
            });
        }
    };

    var createSceneHandler = {
        i: 0,
        showCreateSceneTab: function () {
            $(".tabitem").hide();
            $(".createSceneTab").show();
            paginationClass("show");

            // 图片上传
            $(".createSceneTab .dropped").dropper({
                postKey: "file",
                action: "pc/upload/uploadImageToQiniu",
                postData: {},
                label: ""
            }).on("fileComplete.dropper", function (e, file, response) {
                $("#sceneImage").attr("src", response.image);
                $("#sceneImage").attr("thumbnailsrc", response.thumbnailImage);
            }).on("fileError.dropper", function () {
                console.log("upload error")
            });
            $(".createSceneTab ._upload").unbind("click").click(function () {
                $(".createSceneTab .dropped .dropper-dropzone").trigger("click");
            });

            createSceneHandler.ajaxGoods4CreateScene("pageAttributeInit");
            createSceneHandler.ajaxStyleTagList();
            createSceneHandler.ajaxSpaceTagList();
        },
        ajaxStyleTagList: function () {
            $bluemobi.ajax("pc/comm/ajaxStyleTagList", {}, function (result) {
                if (result.status == "0") {
                    var html = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var styleTag = result.data[i];
                        html += '<span class="curp" styletagid="' + styleTag.id + '">' + styleTag.name + '</span>';
                    }
                    $(".createSceneTab .styleTagList").html(html);
                    $(".createSceneTab .styleTagList").find("span").each(function () {
                        var currSpan = $(this);
                        currSpan.unbind("click").click(function () {
                            if (currSpan.parent().hasClass("styleTagSelected")) {
                                $(".createSceneTab .styleTagList").append(currSpan);
                            } else {
                                $(".createSceneTab .styleTagSelected").append(currSpan);
                            }
                        });
                    });
                }
            });
        },
        ajaxSpaceTagList: function () {
            $bluemobi.ajax("pc/comm/ajaxSpaceTagList", {}, function (result) {
                if (result.status == "0") {
                    var html = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var spacetag = result.data[i];
                        html += '<span class="curp" spacetagid="' + spacetag.id + '">' + spacetag.name + '</span>';
                    }
                    $(".createSceneTab .spaceTagList").html(html);
                    $(".createSceneTab .spaceTagList").find("span").each(function () {
                        var currSpan = $(this);
                        currSpan.unbind("click").click(function () {
                            if (currSpan.parent().hasClass("spaceTagSelected")) {
                                $(".createSceneTab .spaceTagList").append(currSpan);
                            } else {
                                $(".createSceneTab .spaceTagSelected").append(currSpan);
                            }
                        });
                    });
                }
            });
        },
        // 查询场景图列表
        ajaxGoods4CreateScene: function (action) {
            if (action && action == "pageAttributeInit") {
                thisPage.pageAttributeInit();
            }
            thisPage.pageSize = 12;
            var data = {pageNum: thisPage.pageNum, pageSize: thisPage.pageSize};
            $bluemobi.ajax("pc/goods/page", data, function (result) {
                if (result.status == "0") {
                    var html = '';
                    for (var i = 0; i < result.data.list.length; i++) {
                        var goods = result.data.list[i];
                        html += '<li ><img goodsid=' + goods.id + ' src="' + goods.cover + '"></li>';
                    }
                    $(".createSceneTab ul").html(html);
                    thisPage.init(result.data.page, "createSceneHandler.ajaxGoods4CreateScene");

                    $(".createSceneTab .choosePicList img").unbind("click").click(function () {
                        createSceneHandler.addGoodsImage($(this));
                    });
                }
            });
        },
        getPointPosition: function (event) {
            if ($("#sceneImage").attr("src") == "") {
                $bluemobi.notify("<fmt:message key="info.qingxianshangchuantupian"/>！", "error");
                return false;
            }
            if ($(".fa-plus-square").length >= 1 || $(".goodsXZ").length >= 1) {
                $bluemobi.notify("<fmt:message key="info.qingxianwanchengshangyigeshangpinbiaoqianxinxi"/>！", "error");
                return false;
            }
            //获取描点相对图片左边的距离(offsetX在IE,360,谷歌兼容，layerX在火狐兼容)
            var x_px_scr = event.offsetX || event.layerX;
            //获取描点相对图片上边的距离(offsetX在IE,360,谷歌兼容，layerX在火狐兼容)
            var y_px_scr = event.offsetY || event.layerY;
            //1.获取描点相对浏览器左边距离(显示描点图片用) 2.event.pageX是相对整个页面的左偏移量 3. $("#pointimg").width()是图片宽4，相减是为了在描点处居中显示描点图片
            var mleft = (event.pageX - 6) + "px";
            var mtop = (event.pageY - 6) + "px";
            //获取描点相对主图片左边距离百分比
//      var percentX = (x_px_scr / $("#sceneImage").width()) * 100 + "%";
//      var percentY = (y_px_scr / $("#sceneImage").height()) * 100 + "%";

            var xxs = (x_px_scr / $("#sceneImage").width()).toFixed(4);
            var yxs = (y_px_scr / $("#sceneImage").height()).toFixed(4);

            //用绝对定位的方式显示图片
            content = '<i class="fa fa-plus-square" id="goodsImg"' + createSceneHandler.i + ' style="left: ' + mleft + ';top: ' + mtop + ';position: absolute;"></i>';
            //每次点击后讲描点拼接在一个div中
            $("#baseimg").append(content);
            //添加的最外层DIV
            var html = '<div class="goodsYWC"><span><fmt:message key="info.qingxuantupian"/></span>\
                    <input type="hidden" value="' + xxs + '_' + yxs + '" />\
            <img src="" style="width: 20px;height: 20px;"></div>';
            $("#goodsTagList").append(html);
            //显示描点
            $("#baseimg").html($("#baseimg").html());
            createSceneHandler.i++;
        },
        addGoodsImage: function ($img) {
            if ($(".fa-plus-square").length > 0) {
                $("#goodsTagList").find("img").last().attr("src", $img.attr("src"));
                $("#goodsTagList").find("input").last().attr("goodsid", $img.attr("goodsid"));
                $(".fa-plus-square").removeClass("fa-plus-square").addClass("fa-tags");
            }
            else {
                $bluemobi.notify("<fmt:message key="info.qingxianxuanzeyigezuobiao"/>", "error");
            }
        },
        pcCreateScene: function () {
            var userId = $("#sessionUserId").val();
            // 用户未登录，则弹出未登录提示框
            if (userId == "") {
                loginPopup.showDlg();
                return false;
            }
            var name = $('.createSceneTab input[name="name"]').val();
            var info = $('.createSceneTab textarea[name="info"]').val();

            if (name == "") {
                $bluemobi.notify("<fmt:message key="info.qingshurumingcheng"/>!", "error");
                $('.createSceneTab input[name="name"]').focus();
                return false;
            }

            var styleTagIds = "";
            $(".createSceneTab .styleTagSelected").find("span").each(function (index) {
                if (index != 0) {
                    styleTagIds += ",";
                }
                styleTagIds += "@" + $(this).attr("styletagid") + "@";
            });
            if (styleTagIds == "") {
                $bluemobi.notify("<fmt:message key="info.qingxuanzefenggebiaoqian"/>!", "error");
                return false;
            }

            var spaceTagIds = "";
            $(".createSceneTab .spaceTagSelected").find("span").each(function (index) {
                if (index != 0) {
                    spaceTagIds += ",";
                }
                spaceTagIds += "@" + $(this).attr("spacetagid") + "@";
            });
            if (spaceTagIds == "") {
                $bluemobi.notify("<fmt:message key="info.qingxuanzekongjianbiaoqian"/>!", "error");
                return false;
            }

            if (info == "") {
                $bluemobi.notify("<fmt:message key="info.qingshurushangpinmiaoshu"/>!", "error");
                $('.createSceneTab textarea[name="info"]').focus();
                return false;
            }
            if ($("#sceneImage").attr("src") == "") {
                $bluemobi.notify("<fmt:message key="info.shangchuantupian"/>!", "error");
                return false;
            }
            if ($('#goodsTagList').html() == "") {
                $bluemobi.notify("<fmt:message key="info.qingweichangjingtutianjiashangpin"/>!", "error");
                return false;
            }
            if ($('#goodsTagList img').last() && $('#goodsTagList img').last().attr("src") == "") {
                $bluemobi.notify("<fmt:message key="info.qingweizuihouyigezuobiaoxunazetupian"/>!", "error");
                return false;
            }

            var image = $("#sceneImage").attr("src");
            var thumbnailImage = $("#sceneImage").attr("thumbnailsrc");
            var goodsIds = "";
            var positons = "";
            $('#goodsTagList .goodsYWC').each(function (index) {
                if (index != 0) {
                    goodsIds += "@";
                    positons += "@";
                }
                goodsIds += $(this).find("input").attr("goodsid");
                positons += $(this).find("input").val();
            });

            var isShow = "no";
            if ($(".createSceneTab ._isShow").hasClass("checked")) {
                isShow = "yes";
            }

            var data = {
                name: name, styleTagIds: styleTagIds, spaceTagIds: spaceTagIds, info: info
                , image: image, thumbnailImage: thumbnailImage, goodsIds: goodsIds, positons: positons, isShow: isShow
            };

            $bluemobi.ajax("pc/scene/pcCreateScene", data, function (result) {
                if (result.status == "0") {
                    $bluemobi.notify(result.msg, "success");
                    location.reload(true);
                } else {
                    $bluemobi.notify(result.msg, "error");
                }
            });
        }
    };

    var createSeriesHandler = {
        selectedSceneIdArr: [], // 已选择的场景id
        showCreateSeriesTab: function () {
            var userId = $("#sessionUserId").val();
            // 用户未登录，则弹出未登录提示框
            if (userId == "") {
                loginPopup.showDlg();
                return false;
            }
            $(".tabitem").hide();
            $(".createSeriesTab").show();
            paginationClass("show");
            createSeriesHandler.ajaxSeriesTagList();
            createSeriesHandler.ajaxScene4CreateSeries("pageAttributeInit");
        },
        // 查询场景图列表
        ajaxScene4CreateSeries: function (action) {
            if (action && action == "pageAttributeInit") {
                thisPage.pageAttributeInit();
            }
            thisPage.pageSize = 12;
            var data = {pageNum: thisPage.pageNum, pageSize: thisPage.pageSize};
            $bluemobi.ajax("pc/scene/page", data, function (result) {
                if (result.status == "0") {
                    var html = '';
                    for (var i = 0; i < result.data.list.length; i++) {
                        var scene = result.data.list[i];
                        var sceneid = scene.id + "";
                        html += '<li sceneid=' + scene.id + '><img ';
                        if (createSeriesHandler.selectedSceneIdArr.indexOf(sceneid) >= 0) {
                            html += 'class="redBorder2"';
                        }
                        html += ' src="' + scene.image + '"></li>';
                    }
                    $(".createSeriesTab .choosePicList ul").html(html);
                    thisPage.init(result.data.page, "createSeriesHandler.ajaxScene4CreateSeries");

                    $(".createSeriesTab .page_rgt_pageNum").html(thisPage.pageNum);
                    $(".createSeriesTab .page_rgt_totalPage").html(thisPage.totalPage);

                    $(".createSeriesTab .choosePicList li img").unbind("click").click(function () {
                        var sceneid = $(this).parent().attr("sceneid");
                        // 取消选中
                        if ($(this).hasClass("redBorder2")) {
                            $(this).removeClass("redBorder2");
                            createSeriesHandler.selectedSceneIdArr.remove(sceneid);
                        }
                        // 选中
                        else {
                            $(this).addClass("redBorder2");
                            if (createSeriesHandler.selectedSceneIdArr.indexOf(sceneid) < 0) {
                                createSeriesHandler.selectedSceneIdArr.push(sceneid);
                            }
                        }
                    });
                }
            });
        },
        ajaxSeriesTagList: function () {
            $bluemobi.ajax("pc/comm/ajaxSeriesTagList", {}, function (result) {
                if (result.status == "0") {
                    var html = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var seriesTag = result.data[i];
                        html += '<option value="' + seriesTag.id + '">' + seriesTag.name + '</option>';
                    }
                    $(".createSeriesTab select").html(html);
                    $(".createSeriesTab .select-text").html($(".createSeriesTab select option:selected").text());
                }
            });
        },
        pcCreateSeries: function () {
            var userId = $("#sessionUserId").val();
            // 用户未登录，则弹出未登录提示框
            if (userId == "") {
                loginPopup.showDlg();
                return false;
            }
            var seriesTagId = "";
            if ($(".createSeriesTab select option:selected").val()) {
                seriesTagId = $(".createSeriesTab select option:selected").val()
            }
            if (seriesTagId == "") {
                $bluemobi.notify("<fmt:message key="info.qingxuanzeanlifenlei"/>", "error");
                return false;
            }
            var info = $(".createSeriesTab textarea").val();
            if (info == "") {
                $bluemobi.notify("<fmt:message key="info.qingshurujieshaoxinxi"/>", "error");
                $(".createSeriesTab textarea").focus();
                return false;
            }
            if (createSeriesHandler.selectedSceneIdArr.length == 0) {
                $bluemobi.notify("<fmt:message key="info.qingxuanzechangjingtu"/>", "error");
                return false;
            }
            var sceneIds = "";
            $.each(createSeriesHandler.selectedSceneIdArr, function (index, item) {
                if (index != 0) {
                    sceneIds += ",";
                }
                sceneIds += item;
            });

            var data = {seriesTagId: seriesTagId, info: info, sceneIds: sceneIds};
            $bluemobi.ajax("pc/series/pcCreateSeries", data, function (result) {
                if (result.status == "0") {
                    $bluemobi.notify(result.msg, "success");
                    location.reload(true);
                } else {
                    $bluemobi.notify(result.msg, "error");
                }
            });
        }
    };


    //点击按钮
    function showObject() {
        $(".nav li").unbind("click").click(function () {
            thisPage.pageAttributeInit();
            var objectClass = $(this).attr('id');
            $(".nav li").removeClass("current");
            $(".myHomePage").hide();
            $(".myCollect").hide();
            $(".myPublish").hide();
            $(".myMessage").hide();
            $(".myComment").hide();
            $(".tabitem").hide();
            $("#" + objectClass).addClass("current");
            $("." + objectClass).show();
            if (objectClass == 'myCollect') {
                ajaxMyCollect();
                paginationClass("hide");
            } else if (objectClass == 'myMessage') {
                ajaxMyMessage();
                paginationClass("show");
            } else if (objectClass == 'myHomePage') {
                ajaxMyHomePage();
                paginationClass("hide");
            } else if (objectClass == 'myPublish') {
                /* ajaxMyPublish();*/
            } else if (objectClass == 'myComment') {
                ajaxMyComment();
                paginationClass("show");
            }

        })
    }

    // 改变分页导航的样式
    // 因为有的页面需要显示分页，有的页面不需要，主要是显示隐藏
    function paginationClass(flag) {
        if ("hide" == flag) {
            $(".pagination").hide();
        } else if ("show" == flag) {
            $(".pagination").show();
            $(".pagination").removeClass("createSeries");
        } else if ("createSeries" == flag) {
            $(".pagination").show();
            $(".pagination").addClass("createSeries");
        }
    }

    function skinHandler() {
        $("._setting .dropped").dropper({
            postKey: "file",
            action: "pc/upload/uploadImageToQiniu",
            postData: {},
            label: ""
        }).on("fileComplete.dropper", function (e, file, response) {
            $bluemobi.ajax("pc/userSetting/saveUserBackgroundImage", {backgroundImage: response.image}, function (result) {
                if (result.status == "0") {
                    $bluemobi.notify(result.msg, "success");
                    location.reload(true);
                } else {
                    $bluemobi.notify(result.msg, "error");
                }
            });
        }).on("fileError.dropper", function () {
            console.log("upload error")
        });
        $(".skin").unbind("click").click(function () {
            $("._setting .dropped .dropper-dropzone").trigger("click");
        });
    }
</script>
</body>
</html>
