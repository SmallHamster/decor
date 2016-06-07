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
    <style>
        .praiseZdy {
            width: 28px;
            height: 28px;
            border: 1px solid #17171d;
            border-radius: 4px;
            background-position: -83px -61px;
        }
    </style>

</head>

<body>
<div class="wrapper">
   
    <%@ include file="common/header.jsp" %>

    <input type="hidden" id="cur-page" value="goods"/>

    <input type="hidden" id="goodsId" value="${goods.id}"/>
    <input type="hidden" id="creator" value="${goods.user.id}"/>
    <input type="hidden" id="goodsLink" value="${goods.link}" />
    <a id="hiddenA" style="display: none;" href="${goods.link}" target="_blank"></a>

    <div class="cantainer">
        <div class="content pt20 pb60 clearfix">
            <div class="breadcrumb borderbtm pd20">
                <a><fmt:message key="info.shangpin"/></a><span>${goods.name}</span>
            </div>
            <div class="mainCont clearfix">
                <div class="maiLeft">
                    <div class="details clearfix">
                        <div class="detImg"><img src="${goods.cover}"/></div>
                        <div class="horizonalList rel">
                            <span class="iicon scroll_left abs"></span>
                            <span class="iicon scroll_right abs disabled"></span>
                            <div class="inner_wrap rel">
                                <ul class="newpro_list clearfix">
                                    <c:forEach var="goodsImage" items="${goods.goodsImageList}">
                                        <li <c:if test="${goodsImage.isTurnMaterial == 'yes'}">class="active"</c:if>>
                                            <span class="sign"><fmt:message key="info.sucai"/></span>
                                            <a href="javascript:void(0)" style="cursor: hand"><img src="${goodsImage.image}"/></a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <div class="pad20">
                            <div class="system clearfix">
                                <c:if test="${goods.user.roleType == 'admin'}">
                                    <img src="${goods.user.headImage}"/>
                                </c:if>
                                <c:if test="${goods.user.roleType != 'admin'}">
                                    <a href='pc/user/detail?userId=${goods.user.id}'><img src="${goods.user.headImage}"/></a>
                                </c:if>

                                <div class="Rgtem ddddd">
                                    <span class="vt">
                                        <c:if test="${goods.user.roleType == 'admin'}">
                                            ${goods.user.nickname}
                                        </c:if>
                                        <c:if test="${goods.user.roleType != 'admin'}">
                                            <a href='pc/user/detail?userId=${goods.user.id}'>${goods.user.nickname}</a>
                                        </c:if>
                                    </span><a class="atten mr30" ></a><a class="praise iicon mr10 dddPraise" ></a><a class="colle" ><span class="collectBtn" style="padding: 0 0;line-height:0px;"></span>(<span class="collectNum" style="padding: 0 0;line-height:0px;">${goods.collectionNum}</span>)</a>
                                    <span><fmt:message key="info.fengxiangdao"/></span>
                                    <div class="jiathis_style_32x32" style="float: right">
                                        <a class="jiathis_button_tsina"></a>
                                        <a class="jiathis_button_cqq"></a>
                                        <a class="jiathis_button_weixin"></a>
                                    </div>
                                    <!--<a class="iicon sina mr10" href="#"></a><a class="iicon qq mr10" href="http://connect.qq.com/widget/shareqq/index.html"></a><a class="iicon weixin" href="#"></a>-->
                                </div>
                            </div>
                            <p class="p_title">${goods.name}</p>
                            <p class="p_txt">${goods.info}</p>
                            <div class="refer">
                                <p><i class="iicon buy"></i><a onclick="noMoney('${goods.link}')" style="cursor: hand;color: #339900;"><fmt:message key="info.goumai"/></a>【${goods.price}】</p>
                                <p><i class="iicon size"></i><fmt:message key="info.cicun"/>【${goods.size}】</p>
                                <p id="tags"><i class="iicon tag"></i><fmt:message key="info.biaoqian"/>${tagHtml}</p>
                                <p><i class="iicon mode"></i><fmt:message key="info.caizhi"/>  ${goods.texture}</p>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" id="hiddenName" value="${goods.name}" />
                    <input type="hidden" id="hiddenInfo" value="${goods.info}" />
                    <div class="comment pad20">
                        <div class="post">
                            <img src="${session_pc_user.headImage}"/>
                            <div class="Rost">
                                <p class="first">${session_pc_user.nickname}</p>
                                <textarea class="tared commentContent" maxlength="200"></textarea>
                                <button onclick="saveGoodsComment()"><fmt:message key="info.fabu"/></button>
                            </div>
                        </div>
                        <ul class="comment-list">

                        </ul>
                    </div>
                </div>
                <div class="maiRight">
                    <div class="Rcenter">
                        <div class="recom">
                            <h3><fmt:message key="info.gaishangpingsuoshuchangjintu"/></h3>
                            <ul class="list-recom clearfix scenelist">

                            </ul>
                        </div>
                        <div class="recom">
                            <h3><fmt:message key="info.tongleixingtuijian"/></h3>
                            <ul class="list-recom clearfix sametypegoodslist">

                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- footer -->
    <%@ include file="common/footer.jsp"%>

</div>
<!--右侧悬浮-->
<%@ include file="common/other.jsp"%>

<!-- JiaThis Button BEGIN -->
<script type="text/javascript" >
    var jiathis_config={
        summary:$('#hiddenInfo').val(),
        shortUrl:false,
        hideMore:true,
        title:$('#hiddenName').val()
    }
</script>
<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jia.js" charset="utf-8"></script>
<!-- JiaThis Button END -->

<script type="text/javascript" src="static/pc/js/table.js"></script>
<script type="text/javascript" src="static/pc/js/base.js"></script>
<script type="text/javascript">
    $(function(){
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

        // 点击标签
        $("#tags").find("span").click(function(){
            var id = $(this).attr("tagid");
            var type = $(this).attr("tagtype");
            location.href = "pc/forward/to?type=goods&"+type+"="+id;
        });

        ajaxSceneByGoodsId($("#goodsId").val());
        ajaxSameTypeGoods($("#goodsId").val());
        ajaxGoodsComment($("#goodsId").val());
        handlerAttention(); // 处理关注
        handlerPraise(); // 处理点赞
        handlerCollection(); // 处理收藏
    });

    // 暂无报价
    function noMoney(str){
        if(null == str || str == ''){
            $bluemobi.notify('暂无购买链接','error');
        }else{
            // $('#hiddenA').click();
            window.open(str);
        }
    }

    // 加载商品所属场景图
    function ajaxSceneByGoodsId(goodsId) {
        $bluemobi.ajax("pc/goods/ajaxSceneByGoodsId", {goodsId: goodsId}, function (result) {
            if (result.status == "0") {
                if (result.data.length > 0) {
                    $(".scenelist").parent().css('display', '');
                    var html = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var scene = result.data[i];
                        html += '<li><a href="pc/scene/detail?sceneId=' + scene.id + '"><img src="' + scene.image + '" width="116" height="116"/></a></li>';
                    }
                    $(".scenelist").html(html);
                } else {
                    $(".scenelist").parent().css('display', 'none');
                }
            }
        });
    }

    // 加载同类型商品
    function ajaxSameTypeGoods(goodsId) {
        $bluemobi.ajax("pc/goods/ajaxSameTypeGoods", {goodsId: goodsId}, function (result) {
            if (result.status == "0") {
                if (result.data.length > 0) {
                    $(".sametypegoodslist").parent().css('display', '');
                    var html = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var goods = result.data[i];
                        html += '<li><a href="pc/goods/detail?goodsId=' + goods.id + '"><img src="' + goods.cover + '?imageView2/1/w/116/h/116" width="116" height="116"/></a></li>';
                    }
                    $(".sametypegoodslist").html(html);
                } else {
                    $(".sametypegoodslist").parent().css('display', 'none');
                }
            }
        });
    }

    // 加载场景图评论
    function ajaxGoodsComment(goodsId){
        $bluemobi.ajax("pc/goods/ajaxGoodsComment",{goodsId:goodsId},function(result){
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

    // 新增商品评论
    function saveGoodsComment(){
        var userId = $("#sessionUserId").val();
        // 用户未登录，则弹出未登录提示框
        if(userId==""){
            loginPopup.showDlg();
            return false;
        }
        var goodsId = $("#goodsId").val();
        var content = $(".commentContent").val();
        if(content==""){
            $bluemobi.notify("<fmt:message key="info.qingshurupingluanneirong"/>","error");
            $(".commentContent").focus();
            return false;
        }

        $bluemobi.ajax("pc/comment/saveGoodsComment",{userId:userId,goodsId:goodsId,content:content},function(result){
            if (result.status == "0") {
                $bluemobi.notify(result.msg,"success");
                $(".commentContent").val("");
                ajaxGoodsComment($("#goodsId").val());
            }
        });
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
            $bluemobi.notify("<fmt:message key="info.qingshurupingluanneirong"/>","error");
            $(_this).parents(".replydiv").find("textarea").focus();
            return false;
        }

        $bluemobi.ajax("pc/comment/saveCommentReply",{userId:userId,commentId:commentId,content:content},function(result){
            if (result.status == "0") {
                $bluemobi.notify(result.msg,"success");
                $(_this).parents(".replydiv").find("textarea").val("");
                ajaxGoodsComment($("#goodsId").val());
            }
        });
    }

    // 处理关注状态
    function handlerAttention(){
        var fansId = $("#sessionUserId").val();
        var userId = $("#creator").val();
        var flag = commFun.isAttention(userId,fansId);
        if(flag){
            $(".ddddd .atten").html("<fmt:message key="info.quxiaoguangzhu"/>");
        }else{
            $(".ddddd .atten").html("<fmt:message key="info.guangzhuTA"/>");
        }
        $(".ddddd .atten").unbind("click").click(function(){
            if($("#sessionUserId").val()==""){
                loginPopup.showDlg();
                return false;
            }
            if($(this).html()=="<fmt:message key="info.guangzhuTA"/>"){
                commFun.attention(userId,fansId,function(result){
                    if (result.status == "0") {
                        $bluemobi.notify(result.msg,"success");
                        $(".ddddd .atten").html("<fmt:message key="info.quxiaoguangzhu"/>");
                    }
                });
            }
            else if($(this).html()=="<fmt:message key="info.quxiaoguangzhu"/>"){
                commFun.cancelAttention(userId,fansId,function(result){
                    if (result.status == "0") {
                        $bluemobi.notify(result.msg,"success");
                        $(".ddddd .atten").html("<fmt:message key="info.guangzhuTA"/>");
                    }
                });
            }
        });
    }

    // 处理点赞
    function handlerPraise(){
        var userId = $("#sessionUserId").val();
        var objectId = $("#goodsId").val();
        var objectType = "goods";
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
        var objectId = $("#goodsId").val();
        var objectType = "goods";
        var flag = commFun.isCollect(userId,objectId,objectType);
        if(flag){
            $(".ddddd .collectBtn").html("<fmt:message key="info.quxiaoshoucang"/>");
        }else{
            $(".ddddd .collectBtn").html("<fmt:message key="info.shoucang"/>");
        }
        $(".ddddd .collectBtn").unbind("click").click(function(){
            if($(this).html()=="<fmt:message key="info.shoucang"/>"){
                collectDlg.show(objectId,objectType,function(){
                    $(".ddddd .collectBtn").html("<fmt:message key="info.quxiaoshoucang"/>");
                    var num = $(".ddddd .collectNum").html();
                    if(num==""){
                        num = 0;
                    }
                    num = num*1 + 1;
                    $(".ddddd .collectNum").html(num);
                });
            }else if($(this).html()=="<fmt:message key="info.quxiaoshoucang"/>"){
                collectDlg.cancelCollect(objectId,objectType,function(){
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
</script>
</body>
</html>