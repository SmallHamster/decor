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
    <link rel="stylesheet" href="static/pc-1.1/css/global.css" />
    <link rel="stylesheet" href="static/pc-1.1/css/scene-detail.css" />
    <style>
        .praiseZdy {
            width: 28px;
            height: 28px;
            border: 1px solid #17171d;
            border-radius: 4px;
            background-position: -83px -61px;
        }
        .tagcnt{
            width: 280px;
            height: 100px;

        }
        .tagcnt img{
            margin-left:10px;
            margin-top:10px;
            float: left;
            width: 80px;
            height: 80px;
            margin-right: 10px;
        }
        .tagcnt .tit {
            padding-top: 10px;
            margin-left: 80px;
            min-height: 82px;
            line-height: 30px;
            color: #fcfcfc;
            font-weight: bold;
            width: 220px;
            font-family: "微软雅黑",Microsoft YaHei;
        }
        .imgtagli {
            display: block;
            width: 24px;
            height: 30px;
            position: absolute;
            margin-left: -12px;
            margin-top: -6px;
            z-index: 1;
        }
        .imgtagli a{
            display: none;
            background-color: #0066cc;
        }
        .title-style{
            height: 100px;
            width: 320px;
            background-color: #080808;
            filter:alpha(opacity=50);
            opacity:0.8;
        }

        .user span{
            padding-left: 0px;line-height: inherit;
        }
        .clear {
            height: inherit;
        }
    </style>
</head>

<body>
<div class="wrapper">
    <div class="page">

        <!-- 头部开始 -->
        <%@ include file="common/header.jsp" %>
        <!-- 头部结束 -->

        <input type="hidden" id="sceneId" value="${scene.id}"/>
        <input type="hidden" id="creator" value="${scene.user.id}"/>

        <!-- 页面主体内容开始 -->
        <div class="main" style="margin-top: 20px;">
            <div class="center scene">
                <div class="breadcrumb" style="height: 55px;"><a href="pc/forward/to?type=series">< 返回系列图</a></div>
                <div class="wall">
                    <div class="scene-show">
                        <div class="list">
                            <ul id="goodsList1">
                                <li style="display: list-item;"><img src="${scene.image}" title="" alt="" width="715" height="715"></li>
                            </ul>
                        </div>
                        <%--<div class="handler-prev"></div>--%>
                        <%--<div class="handler-next"></div>--%>
                    </div>
                    <div class="designer">
                        <div class="user" style="margin: 0px;margin-bottom: 19px;">
                            <img style="border-radius:0;" src="${scene.user.headImage}" title="" alt="" width="57" height="57" />
							<span class="inb" style="">
								<span class="name">${scene.user.nickname}</span>
								<span class="address"><i class="icon-addr"></i>${scene.user.city.name}  ${scene.user.city.province.name}</span><br/>
								<span class="text-orange">${userSeriesNum}套设计系列图作品</span>
							</span>
                            <a class="btn btn-like">被${scene.user.fans}人喜欢</a>
                        </div>
                        <h4 class="title">${scene.name}</h4>
                        <p class="desc">来自系列图：<a id="seriesName" class="text-orange"></a><br/>${scene.info}</p>
                        <button class="btn btn-count">${scene.praiseNum}人喜欢</button>
                        <p class="strong">场景中的商品</p>
                        <ul id="goodsList" class="image-list">

                        </ul>
                        <p class="strong">讨论</p>
                        <div class="form" style="padding: 0px;">
                            <textarea id="commentContent"></textarea>
                            <div class="text-right"><button onclick="saveSceneComment()">发布</button></div>
                        </div>
                        <div id="commentList" class="review">

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 页面主体内容部分结束 -->

        <!-- 尾部开始 -->
        <%@ include file="common/footer.jsp"%>
        <!-- 尾部结束 -->
    </div>
</div>
<!--右侧悬浮-->
<%@ include file="common/other.jsp"%>

<script type="text/javascript" src="static/pc/js/table.js"></script>
<script type="text/javascript" src="static/pc/js/base.js"></script>
<script src="static/pc-1.1/js/global.js"></script>
<script src="static/pc-1.1/js/scene.js"></script>
<script type="text/javascript">
    $(function(){
        $(document).on("mouseover",".BigImg",function(){
            $(".BigImg i.close").css("display","block");
        });
        $(document).on("mouseout",".BigImg",function(){
            $(".BigImg i.close").css("display","none");
        });
        var x=$(".BigImg img").width();
        var y=$(window).height();
        $(".bigImg img").click(function(){
            bigImg=$(this).attr("src");//获取点击图片的地址
            $(".BigImg img").attr("src",bigImg); //更换大图的图片地址
        })
        var register = new dialogBox({
            // popupBoxW: x,
            // popupBoxH: y,
            contentHtml: $('#regPopupCont').html(),
            initEvent : function(){
                $(".popup-case .popup-cent").css({"max-height":y});
                $(".BigImg img").css({"max-height":y-20});
            }
        });
        $(".bigImg img.bfimg").click(function () {
            register.showDlg();
        });
        $(".horizonalList").each(function(){
            var config = {
                wrapObj : $(this),   //配置最外层包裹对象
                innerObj : $(".inner_wrap"),     //配置内层包裹对象
                listObj : $(".newpro_list"),     //配置列表包裹对象
                scrollElements : $(".newpro_list li"),
                leftArrow : $(".scroll_left") ,  //配置左箭头
                rightArrow : $(".scroll_right"),  //配置右箭头
                animateTime : 600,
                scrollStep : 4
            };
            new HorizontalList( config );
        });
        var bigImg='';
        $(".newpro_list li img").click(function(){
            $(this).parent('li').addClass('current').siblings().removeClass('current');
            bigImg=$(this).attr("src");//获取点击图片的地址
            $(".detImg img").attr("src",bigImg); //更换大图的图片地址
        });

        ajaxGoodsListBySceneId($("#sceneId").val()); // 查询场景中的商品
        ajaxSeriesBySceneId($("#sceneId").val()); // 查询场景所属系列图
        ajaxSameTypeScene($("#sceneId").val()); // 查询同类
        ajaxSceneComment($("#sceneId").val()); // 查询评论
        handlerAttention(); // 处理关注
        handlerPraise(); // 处理点赞
        handlerCollection(); // 处理收藏
    });

    // 加载场景中的商品
    function ajaxGoodsListBySceneId(sceneId) {
        $bluemobi.ajax("pc/scene/ajaxGoodsListBySceneId", {sceneId: sceneId}, function (result) {
            if (result.status == "0") {
                if (result.data.length > 0) {
                    var html = '';
                    var html1 = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var goods = result.data[i];
                        html+='<li>\
                                <div class="cell">\
                                <a href="pc/goods/detail?goodsId=' + goods.id + '">\
                                <img src="' + goods.cover + '" title="" alt="" width="88" width="88" />\
                                </a>\
                                </div>\
                                '+goods.name+'\
                                </li>';

                        html1+='<li><img src="' + goods.cover + '" title="" alt="" width="715" height="715" /></li>';
                    }
                    $("#goodsList").html(html);
                    $("#goodsList1").html(html1);
                    roll($('div.scene-show'));
                    $(".handler-next").trigger("click");
                }
            }
        });
    }

    // 加载场景所属的系列图
    function ajaxSeriesBySceneId(sceneId) {
        $bluemobi.ajax("pc/scene/ajaxSeriesBySceneId", {sceneId: sceneId}, function (result) {
            if (result.status == "0") {
                if (result.data.length > 0) {
                    for (var i = 0; i < result.data.length; i++) {
                        var series = result.data[i];
                    }
                    $("#seriesName").html(series.name);
                }
            }
        });
    }


    // 加载同类型场景
    function ajaxSameTypeScene(sceneId) {
        $bluemobi.ajax("pc/scene/ajaxSameTypeScene", {sceneId: sceneId}, function (result) {
            if (result.status == "0") {
                if (result.data.length > 0) {
                    $(".sameTypeScenelist").parent().css('display', '');
                    var html = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var scene = result.data[i];
                        html += '<li><a href="pc/scene/detail?sceneId=' + scene.id + '"><img class="sceneImage" src="' + scene.image + '" width="116" height="116"/></a></li>';
                    }
                    $(".sameTypeScenelist").html(html);
                } else {
                    $(".sameTypeScenelist").parent().css('display', 'none');
                }
            }
        });
    }

    var i = 1;

    // 加载场景图评论
    function ajaxSceneComment(sceneId){
        $bluemobi.ajax("pc/scene/ajaxSceneComment",{sceneId:sceneId},function(result){
            if (result.status == "0") {
                var html = '';
                for(var i=0;i<result.data.length;i++){
                    var comment = result.data[i];
                    html+='<a class="pull-left face">\
                            <img src="'+comment.user.headImage+'" title="" alt="" width="40" height="40" />\
                            </a>\
                            <div class="text">\
                            <p><span class="pull-left">'+comment.user.nickname+'</span><span class="pull-right">'+comment.createTime+'</span></p>\
                            <p class="clear text-content">'+comment.content+'</p>\
                            </div>';
                }
                $("#commentList").html(html);
            }
        });
    }

    // 新增商品评论
    function saveSceneComment(){
        debugger
        var userId = $("#sessionUserId").val();
        // 用户未登录，则弹出未登录提示框
        if(userId==""){
            loginPopup.showDlg();
            return false;
        }
        var sceneId = $("#sceneId").val();
        var content = $("#commentContent").val();
        if(content==""){
            $bluemobi.notify("<fmt:message key="info.qingshurupinglunleirong"/>","error");
            $(".commentContent").focus();
            return false;
        }

        $bluemobi.ajax("pc/comment/saveSceneComment",{userId:userId,sceneId:sceneId,content:content},function(result){
            if (result.status == "0") {
                $bluemobi.notify(result.msg,"success");
                $(".commentContent").val("");
                ajaxSceneComment($("#sceneId").val());
            }
        });
    }

    // 评论 点赞/取消点赞
    function commentPraiseOrCancelPraise(userId,commentId,$obj){
        if(userId==""){
            loginPopup.showDlg();
            return false;
        }
        if($obj.hasClass("i-praise")){ // 点赞
            $bluemobi.ajax("pc/praise/praise",{userId:userId,objectId:commentId,objectType:"comment"},function(result){
                if (result.status == "0") {
                    $bluemobi.notify(result.msg,"success");
                    $obj.removeClass("i-praise").addClass("i-praised");
                    var num = $obj.find(".praiseNum").text();
                    if(num==""){
                        num = 0;
                    }
                    num = num*1 + 1;
                    $obj.find(".praiseNum").text(num);
                }else{
                    $bluemobi.notify(result.msg,"error");
                }
            });
        }else if($obj.hasClass("i-praised")){ // 取消点赞
            $bluemobi.ajax("pc/praise/cancelPraise",{userId:userId,objectId:commentId,objectType:"comment"},function(result){
                if (result.status == "0") {
                    $bluemobi.notify(result.msg,"success");
                    $obj.removeClass("i-praised").addClass("i-praise");
                    var num = $obj.find(".praiseNum").text();
                    if(num==""){
                        num = 0;
                    }
                    num = num*1 -1;
                    if(num<0){
                        num=0;
                    }
                    $obj.find(".praiseNum").text(num);
                }else{
                    $bluemobi.notify(result.msg,"error");
                }
            });
        }
    }

    // 新增评论回复
    function saveCommentReply(commentId,_this){
        var userId = $("#sessionUserId").val();
        // 用户未登录，则弹出未登录提示框
        if(userId==""){
            loginPopup.showDlg();
            return false;
        }
        var content = $(_this).parents(".replydiv").find("textarea").val();
        if(content==""){
            $bluemobi.notify("<fmt:message key="info.qingshurupinglunleirong"/>","error");
            $(_this).parents(".replydiv").find("textarea").focus();
            return false;
        }

        $bluemobi.ajax("pc/comment/saveCommentReply",{userId:userId,commentId:commentId,content:content},function(result){
            if (result.status == "0") {
                $bluemobi.notify(result.msg,"success");
                $(_this).parents(".replydiv").find("textarea").val("");
                ajaxSceneComment($("#sceneId").val());
            }
        });
    }

    // 处理关注状态
    function handlerAttention(){
        var fansId = $("#sessionUserId").val();
        var userId = $("#creator").val();
        var flag = commFun.isAttention(userId,fansId);
        if(flag){
            $(".ddddd .atten").html("<fmt:message key="info.quxiaoguanzhu"/>");
        }else{
            $(".ddddd .atten").html("<fmt:message key="info.guanzhuTA"/>");
        }
        $(".ddddd .atten").unbind("click").click(function(){
            if($("#sessionUserId").val()==""){
                loginPopup.showDlg();
                return false;
            }
            if($(this).html()=="<fmt:message key="info.guanzhuTA"/>"){
                commFun.attention(userId,fansId,function(result){
                    if (result.status == "0") {
                        $bluemobi.notify(result.msg,"success");
                        $(".ddddd .atten").html("<fmt:message key="info.quxiaoguanzhu"/>");
                    }
                });
            }
            else if($(this).html()=="<fmt:message key="info.quxiaoguanzhu"/>"){
                commFun.cancelAttention(userId,fansId,function(result){
                    if (result.status == "0") {
                        $bluemobi.notify(result.msg,"success");
                        $(".ddddd .atten").html("<fmt:message key="info.guanzhuTA"/>");
                    }
                });
            }
        });
    }

    // 处理点赞
    function handlerPraise(){
        var userId = $("#sessionUserId").val();
        var objectId = $("#sceneId").val();
        var objectType = "scene";
        var flag = commFun.isPraise(userId,objectId,objectType);
        if(flag){
            $(".ddddd .dddPraise").removeClass("praise").addClass("praiseZdy");
        }else{
            $(".ddddd .dddPraise").removeClass("praiseZdy").addClass("praise");
        }
        $(".ddddd .dddPraise").unbind("click").click(function(){
            if($("#sessionUserId").val()==""){
                loginPopup.showDlg();
                return false;
            }
            // 点赞
            if($(".ddddd .dddPraise").hasClass("praise")){
                commFun.praise(userId,objectId,objectType,function(result){
                    if (result.status == "0") {
                        $(".ddddd .dddPraise").removeClass("praise").addClass("praiseZdy");
                        $bluemobi.notify(result.msg,"success");
                    }
                });
            }
            // 取消点赞
            else if($(".ddddd .dddPraise").hasClass("praiseZdy")){
                commFun.cancelPraise(userId,objectId,objectType,function(result){
                    if (result.status == "0") {
                        $bluemobi.notify(result.msg,"success");
                        $(".ddddd .dddPraise").removeClass("praiseZdy").addClass("praise");
                    }
                });
            }
        });
    }

    // 处理收藏
    function handlerCollection(){
        var userId = $("#sessionUserId").val();
        var objectId = $("#sceneId").val();
        var objectType = "scene";
        var flag = commFun.isCollect(userId,objectId,objectType);
        if(flag){
            $(".ddddd .collectBtn").html("<fmt:message key="info.quxiaoshoucang"/>");
        }else{
            $(".ddddd .collectBtn").html("<fmt:message key="info.shoucang"/>");
        }
        $(".ddddd .collectBtn").unbind("click").click(function(){
            if($(this).html()=="<fmt:message key="info.shoucang"/>"){
                collectDlg.show(objectId,"scene",function(){
                    $(".ddddd .collectBtn").html("<fmt:message key="info.quxiaoshoucang"/>");
                    var num = $(".ddddd .collectNum").html();
                    if(num==""){
                        num = 0;
                    }
                    num = num*1 + 1;
                    $(".ddddd .collectNum").html(num);
                });
            }else if($(this).html()=="<fmt:message key="info.quxiaoshoucang"/>"){
                collectDlg.cancelCollect(objectId,"scene",function(){
                    $(".ddddd .collectBtn").html("<fmt:message key="info.shoucang"/>");
                    var num = $(".ddddd .collectNum").html();
                    if(num==""){
                        num = 0;
                    }
                    num = num*1 - 1;
                    if(num<0){
                        num=0
                    }
                    $(".ddddd .collectNum").html(num);
                });
            }
        });
    }
    function IonMouseOver(i) {
        $(".imgtagli ").eq(i).find("a").show();
    }
    function IonMouseOut(){
        $(".imgtagli a").hide();
    }



</script>
</body>
</html>