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

        <!-- 页面主体内容开始 -->
        <div class="main" style="margin-top: 20px;">
            <div class="center scene">
                <div class="breadcrumb" style="height: 55px;"><a href="###">< 返回系列图</a></div>
                <div class="wall">
                    <div class="scene-show">
                        <div class="list">
                            <ul>
                                <li><img src="static/pc-1.1/images/scene/sample-1.jpg" title="" alt="" width="715" height="715" /></li>
                                <li><img src="static/pc-1.1/images/scene/sample-1.jpg" title="" alt="" width="715" height="715" /></li>
                                <li><img src="static/pc-1.1/images/scene/sample-1.jpg" title="" alt="" width="715" height="715" /></li>
                                <li><img src="static/pc-1.1/images/scene/sample-1.jpg" title="" alt="" width="715" height="715" /></li>
                            </ul>
                        </div>
                        <div class="handler-prev"></div>
                        <div class="handler-next"></div>
                    </div>
                    <div class="designer">
                        <div class="user" style="margin: 0px;margin-bottom: 19px;">
                            <img style="border-radius:0;" src="static/pc-1.1/images/scene/sample-2.jpg" title="" alt="" width="57" height="57" />
							<span class="inb" style="">
								<span class="name">ryel</span>
								<span class="address"><i class="icon-addr"></i>武汉  武汉</span><br/>
								<span class="text-orange">36套设计系列图作品</span>
							</span>
                            <a class="btn btn-like">被1.2万人喜欢</a>
                        </div>
                        <h4 class="title">溪水中的皮靠椅 </h4>
                        <p class="desc">来自系列图：<a class="text-orange">我在海边的木头房子里面患过伤风</a><br/>缓缓流淌的溪水中的座椅，让人产生了浓烈的盛夏氛围，很多人喜欢这样的设计</p>
                        <button class="btn btn-count">156人喜欢</button>
                        <p class="strong">场景中的商品</p>
                        <ul class="image-list">
                            <li>
                                <div class="cell"><img src="static/pc-1.1/images/scene/sample-3.jpg" title="" alt="" width="88" width="88" /></div>
                                arhaus-chairs- 0110
                            </li>
                            <li>
                                <div class="cell"><img src="static/pc-1.1/images/scene/sample-3.jpg" title="" alt="" width="88" width="88" /></div>
                                arhaus-chairs- 0110
                            </li>
                            <li>
                                <div class="cell"><img src="static/pc-1.1/images/scene/sample-3.jpg" title="" alt="" width="88" width="88" /></div>
                                arhaus-chairs- 0110
                            </li>
                            <li>
                                <div class="cell"><img src="static/pc-1.1/images/scene/sample-3.jpg" title="" alt="" width="88" width="88" /></div>
                                arhaus-chairs- 0110
                            </li>
                        </ul>
                        <p class="strong">讨论</p>
                        <form class="form" style="padding: 0px;">
                            <textarea></textarea>
                            <div class="text-right"><button type="submit">发布</button></div>
                        </form>
                        <div class="review">
                            <a class="pull-left face">
                                <img src="static/pc-1.1/images/scene/sample-4.png" title="" alt="" width="40" height="40" />
                            </a>
                            <div class="text">
                                <p><span class="pull-left">Lining NIHD</span><span class="pull-right">1小时前</span></p>
                                <p class="clear text-content">交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题</p>
                            </div>
                            <a class="pull-left face">
                                <img src="static/pc-1.1/images/scene/sample-4.png" title="" alt="" width="40" height="40" />
                            </a>
                            <div class="text">
                                <p><span class="pull-left">Lining NIHD</span><span class="pull-right">1小时前</span></p>
                                <p class="clear text-content">交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题</p>
                            </div>
                            <a class="pull-left face">
                                <img src="static/pc-1.1/images/scene/sample-4.png" title="" alt="" width="40" height="40" />
                            </a>
                            <div class="text">
                                <p><span class="pull-left">Lining NIHD</span><span class="pull-right">1小时前</span></p>
                                <p class="clear text-content">交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题</p>
                            </div>
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
        initPointPosition();//加载商品坐标
    });

    // 加载场景中的商品
    function ajaxGoodsListBySceneId(sceneId) {
        $bluemobi.ajax("pc/scene/ajaxGoodsListBySceneId", {sceneId: sceneId}, function (result) {
            if (result.status == "0") {
                if (result.data.length > 0) {
                    $(".goodslist").parent().css('display', '');
                    var html = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var goods = result.data[i];
                        html += '<li><a href="pc/goods/detail?goodsId=' + goods.id + '"><img src="' + goods.cover + '" width="116" height="116"/></a></li>';
                    }
                    $(".goodslist").html(html);
                } else {
                    $(".goodslist").parent().css('display', 'none');
                }
            }
        });
    }

    // 加载场景所属的系列图
    function ajaxSeriesBySceneId(sceneId) {
        $bluemobi.ajax("pc/scene/ajaxSeriesBySceneId", {sceneId: sceneId}, function (result) {
            if (result.status == "0") {
                if (result.data.length > 0) {
                    $(".serieslist").parent().css('display', '');
                    var html = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var series = result.data[i];
                        html += '<li><a href="pc/series/detail?seriesId=' + series.id + '"><img src="' + series.cover + '" width="116" height="116"/></a></li>';
                    }
                    $(".serieslist").html(html);
                } else {
                    $(".serieslist").parent().css('display', 'none');
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
    var jsonSceneGoods = eval(${jsonSceneGoods});
    function initPointPosition() {
        for (var ii = 0; ii < jsonSceneGoods.length; ii++) {
            var map = jsonSceneGoods[ii];
            var goodsId=map.goodsId
            var goodsPrice=map.goodsPrice;
            var goodsImg=map.goodsImage
            var goodsinfo=map.goodsInfo;
            var goodsName=map.goodsName;
            if(goodsPrice!="暂无报价"){
                goodsPrice="￥"+goodsPrice;
            }
            var x = map.x;
            var y = map.y;
            /*图片距离上左的距离*/
            var bfImg=$(".bfimg:eq(0)");
            var sysImgW = bfImg.offset().left - 200;
            var sceneImgW = sysImgW + bfImg.width() * x + "px";
            var syscImgH = bfImg.offset().top - 300;
            var sceneImgH = syscImgH + bfImg.height() * y + "px";
            //用绝对定位的方式显示图片
            content="<div class='shawer iicon imgtagli' onMouseOut='IonMouseOut()'  onMouseOver='IonMouseOver("+ii+")'  id-data='goodsImg" + ii + "'  style='left: " + sceneImgW + ";top: " + sceneImgH + ";position: absolute;'>" +
                    "<a class='tagcnt' href='pc/goods/detail?goodsId="+goodsId+"' target='_blank' onMouseOut='IonMouseOut()'><div class='title-style'><img src='"+goodsImg+"'><div class='tit'>"+goodsName+"<br/>价格："+goodsPrice+"</div></div></a></div>"
            //每次点击后讲描点拼接在一个div中
            $(".bigImg").append(content);        }
    }

    // 加载场景图评论
    function ajaxSceneComment(sceneId){
        $bluemobi.ajax("pc/scene/ajaxSceneComment",{sceneId:sceneId},function(result){
            if (result.status == "0") {
                var html = '';
                for(var i=0;i<result.data.length;i++){
                    var comment = result.data[i];
                    var praiseClass = "i-praise";
                    if(comment.isPraise && comment.isPraise=="yes"){
                        praiseClass="i-praised";
                    }

                    // 回复html
                    var replyhtml = '';
                    if($("#sessionUserId").val()!="" && $("#sessionUserId").val()==$("#creator").val() && comment.replyList.length<=0){ // 如果没有回复，且当前用户是上传者，则显示回复按钮
                        replyhtml = '<span class="i-share curp"><i class="iicon"></i><fmt:message key="info.huifu"/></span>';
                    }

                    html += '<li>\
                    <div class="rost">\
                    <img src="'+comment.user.headImage+'"/>\
                    <div class="prost">\
                    <div class="Rost2">\
                    <p class="first"><span class="fr">'+comment.createTime+'</span>'+comment.user.nickname+'</p>\
                    <p class="txt">'+comment.content+'</p>\
                    <p class="inter"><span class="'+praiseClass+' mr10 commentPraiseBtn" commentid='+comment.id+'><i class="iicon"></i><span class="praiseNum">'+comment.praiseNum+'</span></span>'+replyhtml+'</p>\
                    </div>';

                    html+='<div class="rost replydiv none"><textarea class="tared" maxlength="200"></textarea>\
                            <button class="replybtn" onclick="saveCommentReply('+comment.id+',this)"><fmt:message key="info.fabu"/></button></div>';

                    // 显示评论的回复
                    if(comment.replyList){
                        for(var j=0;j<comment.replyList.length;j++){
                            var reply = comment.replyList[j];
                            var replyPraiseClass = "i-praise";
                            if(reply.isPraise && reply.isPraise=="yes"){
                                replyPraiseClass="i-praised";
                            }
                            html+='<div class="rost">\
                                <img src="'+reply.headImage+'"/>\
                                <div class="Rost">\
                                <p class="first"><span class="fr">'+reply.createTime+'</span>'+reply.nickname+'</p><p class="txt">'+reply.content+'</p><p class="inter"><span class="'+replyPraiseClass+' mr10 commentPraiseBtn" commentid='+reply.id+'><i class="iicon"></i><span class="praiseNum">'+reply.praiseNum+'</span></span></p>\
                                </div>\
                                </div>';
                        }
                    }

                    html+='</div>\
                    </div>\
                    </li>';
                }
                $(".comment-list").html(html);

                $(".comment-list").find(".commentPraiseBtn").unbind("click").click(function(){
                    commentPraiseOrCancelPraise($("#sessionUserId").val(),$(this).attr("commentid"),$(this));
                });

                // 评论回复按钮点击事件
                $(".comment-list").find(".i-share").unbind("click").click(function(){
                    $(this).parents(".prost").find(".replydiv").show();
                });

            }
        });
    }

    // 新增商品评论
    function saveSceneComment(){
        var userId = $("#sessionUserId").val();
        // 用户未登录，则弹出未登录提示框
        if(userId==""){
            loginPopup.showDlg();
            return false;
        }
        var sceneId = $("#sceneId").val();
        var content = $(".commentContent").val();
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