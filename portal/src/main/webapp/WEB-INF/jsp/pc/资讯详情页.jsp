<%--
  Created by IntelliJ IDEA.
  User: xiaoj
  Date: 2015/9/30
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="common/meta.jsp" %>
    <%@ include file="common/css.jsp" %>
    <title><fmt:message key="info.zixunxiangqing"/></title>
    <link href="static/pc/css/common.css" rel="stylesheet" type="text/css">
    <link href="static/pc/css/all.css" rel="stylesheet" type="text/css">

</head>
<div class="wrapper">
    <%@ include file="common/header.jsp" %>
    <div class="search-condition" style="display: none;">
        <input type="hidden" id="cur-page" value="message"/>
        <input type="hidden" id="messageId" value="${message.id}"/>
        <input type="hidden" id="messageShowTags" value="${message.showTags} "/>
        <input type="hidden" class="name" value="${name}"/>
    </div>

    <div class="cantainer">
        <div class="content pt20 pb60 clearfix">
            <div class="breadcrumb borderbtm pd20">
                <a href="#"><fmt:message key="info.zixun"/></a><span>${message.title}</span>
            </div>
            <div class="mainCont clearfix">
                <div class="maiLeft">
                    <div class="details clearfix">
                        <div class="message">
                            <a class="cobtn" onclick="collectionMessage()"><span><fmt:message key="info.shoucang"/></span>(<span>${message.collectionNum}</span>)</a>
                            <h3>${message.title}</h3>
                            <p><span class="mr30"><fmt:message key="info.fenlei"/>：${message.messageTag.name}</span><span><fmt:message key="info.fabushijian"/><fmt:formatDate value="${message.createTime}"
                                                                                                                                                             pattern="yyyy-MM-dd HH:mm:ss"/> </span>
                            </p>
                        </div>
                        <div class="mesTxt">
                            <div class="mesImg"><img src="${message.image}" width="680" /></div>
                            <p>${message.subContent}</p>

                            <div class="mesImg"><img src="${message.intro_image}" width="680" /></div>
                            <p>${message.content}</p>
                        </div>
                        <div class="tab">
                            <span><fmt:message key="info.fengxiangdao"/></span>
                            <div class="jiathis_style_32x32" style="float: right">
                                <a class="jiathis_button_tsina"></a>
                                <a class="jiathis_button_cqq"></a>
                                <a class="jiathis_button_weixin"></a>
                            </div>
                            <span class="mr10"><fmt:message key="info.biaoqian"/></span>
                        </div>
                        <div class="mespage clearfix">

                        </div>
                        <input type="hidden" id="hiddenName" value="${message.title}" />
                        <input type="hidden" id="hiddenInfo" value="${message.subContent}" />
                    </div>
                    <div class="comment pad20">
                    </div>
                </div>
                <div class="maiRight">
                    <h3 class="Title"><fmt:message key="info.xiangguantuijian"/></h3>
                    <div class="article">
                        <ul class="list-article">
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- footer -->
<%@ include file="common/footer.jsp" %>
<!--右侧悬浮-->
<div class="push">
    <ul>
        <li class="getTop"><i class="iicon rel"></i></li>
        <li class="idea"><fmt:message key="info.yijianfankui"/></li>
    </ul>
</div>
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
    $(function () {
        formatShowTag();

        $(".horizonalList").each(function () {
            var config = {
                wrapObj: $(this),   //配置最外层包裹对象
                innerObj: $(".inner_wrap"),     //配置内层包裹对象
                listObj: $(".newpro_list"),     //配置列表包裹对象
                scrollElements: $(".newpro_list li"),
                leftArrow: $(".scroll_left"),  //配置左箭头
                rightArrow: $(".scroll_right"),  //配置右箭头
                animateTime: 600,
                scrollStep: 4
            };
            new HorizontalList(config);
        });
        var bigImg = '';
        $(".newpro_list li img").click(function () {
            $(this).parent('li').addClass('current').siblings().removeClass('current');
            bigImg = $(this).attr("src");//获取点击图片的地址
            $(".detImg img").attr("src", bigImg); //更换大图的图片地址
        })
        ajaxSameTypeMessage($("#messageId").val());
        ajaxPageJump($("#messageId").val());
        ajaxJudgeCollection($("#messageId").val(),$("#sessionUserId").val());
    });
    // 加载同类型资讯
    function ajaxSameTypeMessage(messageId) {
        $bluemobi.ajax("pc/message/ajaxSameTypeMessage", {messageId: messageId}, function (result) {
            if (result.status == "0") {
                var html = '';
                for (var i = 0; i < result.data.length; i++) {
                    var message = result.data[i];
                    var subTitle = message.title
                    if (subTitle.length > 19) {
                        subTitle = subTitle.substring(0, 19) + "..."
                    }
                    html += '<li><a href="pc/message/detail?messageId=' + message.id + '"><img src="' + message.image + '" width="195px" height="195px"/></a><div class="arttxt"><p title=' + message.title + '>' + subTitle + '</p></div></li>';
                }
                $(".list-article").html(html);
            }
        });
    }
    /*标签格式化*/
    function formatShowTag() {
        var html = '';
        var tag = $("#messageShowTags").val();
        var tags = tag.split(",");
        for (var i = 0; i < tags.length; i++) {
            tags[i] = tags[i].replace(/\@/g, "");
            html += '<span class="mark mr10">' + tags[i] + '</span>'
        }
        $(html).appendTo($(".tab:contains('<fmt:message key="info.biaoqian"/>')"));
    }
    /*上下页跳转*/
    function ajaxPageJump(messageId) {
        $bluemobi.ajax("pc/message/ajaxPageJump", {messageId: messageId}, function (result) {
            if (result.status == "0") {
                var fl= '<a class="fl" href="pc/message/detail?messageId=' +  result.data[0].id + '"><fmt:message key="info.shangyipian"/>'+ result.data[0].title+'</a>'
                var fr='<a class="fr" href="pc/message/detail?messageId='+result.data[1].id + '"><fmt:message key="info.xiayipian"/>'+ result.data[1].title+'</a>'
                $(".mespage").html(fl+fr);
            }
        });
    }
    //收藏量增加
    function ajaxMessageCollectionAdd(messageId,addOrDel) {
        $bluemobi.ajax("pc/message/ajaxCollectionNumAdd", {messageId: messageId ,addOrDel:addOrDel},
                function (result) {
                    if (result.status == "0") {
                        $bluemobi.notify(result.msg, "success");
                        $(".cobtn>span:eq(1)").text(result.data);

                    }
                });
    }
    //判断用户是否=收藏该资讯
    function ajaxJudgeCollection(messageId,userId) {
        if(userId==''){
            $(".cobtn>span:eq(0)").text("<fmt:message key="info.shoucang"/>");
        }else{
            $bluemobi.ajax("pc/message/ajaxJudgeCollection", {messageId: messageId,userId:userId}, function (result) {
                if (result.status == "0") {
                    if(result.data==true){
                        $(".cobtn>span:eq(0)").text("<fmt:message key="info.quxiaoshoucang"/>");
                    }else{
                        $(".cobtn>span:eq(0)").text("<fmt:message key="info.shoucangzixun"/>");
                    }
                }
            });
        }
    }
    /*收藏资讯*/
    function collectionMessage(){
        var userId = $("#sessionUserId").val();
        var messageId = $("#messageId").val();
        var messageCollectionNum=$("#messageCollectionNum").val();
        var addOrDel=false;
        // 用户未登录，则弹出未登录提示框
        if(userId==""){
            loginPopup.showDlg();
            return false;
        }
        //判断资讯收藏状态
        if(  $(".cobtn>span:eq(0)").text()=="<fmt:message key="info.shoucangzixun"/>") {
            $bluemobi.ajax("pc/message/saveCollectionMessage", {
                userId: userId,
                messageId: messageId
            }, function (result) {
                if (result.status == "0") {
                    $(".cobtn>span:eq(0)").text("<fmt:message key="info.quxiaoshoucang"/>");
                    $bluemobi.notify(result.msg, "success");
                }
                addOrDel=true;
                ajaxMessageCollectionAdd(messageId,addOrDel);
            });
        }
        else if( $(".cobtn>span:eq(0)").text()=="<fmt:message key="info.quxiaoshoucang"/>") {
            $bluemobi.ajax("pc/message/cancelledMessage", {
                userId: userId,
                messageId: messageId
            }, function (result) {
                if (result.status == "0") {
                    $(".cobtn>span:eq(0)").text("<fmt:message key="info.shoucangzixun"/>");
                    $bluemobi.notify(result.msg, "success");
                }
                ajaxMessageCollectionAdd(messageId,addOrDel);
            });
        }
    }


</script>
</body>
</html>