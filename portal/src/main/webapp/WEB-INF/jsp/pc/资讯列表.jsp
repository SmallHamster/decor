<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="common/meta.jsp" %>
    <%@ include file="common/css.jsp" %>
    <title><fmt:message key="info.zixunliebiao"/></title>
    <link href="static/pc/css/common.css" rel="stylesheet" type="text/css">
    <link href="static/pc/css/all.css" rel="stylesheet" type="text/css">
    <style>
        .listNav li {
            margin-left: 1px;
            margin-right: 5px;
        }
    </style>

</head>

<body>
<div class="wrapper">
    <%@ include file="common/header.jsp" %>
    <input type="hidden" id="cur-page" value="message"/>
    <div class="search-condition" style="display: none;">
        <input type="hidden" class="styleTagId" value=""/>
        <input type="hidden" class="name" value="${name}"/>
    </div>
    <div class="cantainer">
        <div class="content pt20  clearfix">
            <div class="topNav">
                <div class="topCent clearfix" >
                    <ul class="listNav" >
                    </ul>
                </div>
            </div>
            <div class="pad20 rel">
                <div class="breadcrumb borderbtm"><a><fmt:message key="info.zixun"/></a><span class="span-tagName"></span></div>
                <div class="page_rgt pagabs"><a class="iicon back"></a><span>page <span class="page_rgt_pageNum"></span> of <span class="page_rgt_totalPage"></span></span><a
                        class="iicon next"></a></div>
            </div>
            <div class="pro_show ">
                <ul class="list_show">
                </ul>
            </div>
            <!--右边内容区-->
            <!-- 分页 -->
            <%@ include file="common/page.jsp" %>
        </div>
    </div>


    <!-- footer -->
    <%@ include file="common/footer.jsp" %>

</div>
<!--右侧悬浮-->
<%@ include file="common/other.jsp" %>
<script type="text/javascript" src="static/pc/js/slide.min.js"></script>
<script type="text/javascript" src="static/pc/js/slide.js"></script>
<script type="text/javascript" src="static/pc/js/base.js"></script>

<script>
    var register;
    var thisPage = rpage; // 分页对象 rpage存在于page.jsp

    $(function () {
        ajaxTag(); // 加载类别
        ajaxPageMessage(); // 加载所有message列表
        $(".page_rgt").find(".back").unbind("click").click(function(){
            $(".pagination").find(".first").trigger("click");
        });
        $(".page_rgt").find(".next").unbind("click").click(function(){
            $(".pagination").find(".last").trigger("click");
        });
        $(".butn").unbind("click").click(function(){
            /*收藏*/
        });
    });
  // 加载类别
    function ajaxTag() {
        $bluemobi.ajax("pc/message/messageTagShow", {}, function (result) {
            if (result.status == "0") {
                var html = '';
                for (var i = 0; i < result.data.length; i++) {
                    var tag = result.data[i];
                    html += '<li><a class="action" tagid="' + tag.id + '">' + tag.name + '</a></li>';
                }
                $(".listNav").html(html);
                $(".listNav").find("a").each(function () {
                    $(this).unbind("click").click(function () {
                        $(".listNav").find("a").removeAttr("style");
                        $(".tagname").html($(this).html());
                        $(this).css('border-bottom','2px solid black');
                        $(".span-tagName").html($(this).html());
                        var styleTagId=$(this).attr("tagid");
                        sessionStorage.setItem("action","action");
                        ajaxPageMessage(styleTagId);
                        ajaxJudgeCollection(this.messageId);
                    });
                });
            }
        });
    }
    function ajaxPageMessage(styleTagId) {
        var action= sessionStorage.getItem("action");
        if(action=='action'){
            thisPage.pageAttributeInit();
            sessionStorage.setItem("action",'');
        }
        var styleTagId = styleTagId;
        var name = $(".search-condition").find(".name").val();
        var userId=$("#sessionUserId").val();
        var data = {
            userId:userId,
            styleTagId:styleTagId,
            name:name,
            pageNum: thisPage.pageNum,
            pageSize: thisPage.pageSize,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/message/pageMessage", data, function (result) {
            if (result.status == "0") {
                var html = '';
                for (var i = 0; i < result.data.list.length; i++) {
                    var message = result.data.list[i];
                    var collect;
                    if(userId!=''&&message.ifCollect=='1'){
                        collect="<fmt:message key="info.quxiaoshoucang"/>"
                    }else if(userId!=''&&message.ifCollect=='0'){
                        collect="<fmt:message key="info.shoucangzixun"/>"
                    }else{
                        collect="<fmt:message key="info.shoucang"/>"
                    }
                    if(message.collectionNum<0){
                        message.collectionNum=0
                    }

                    html += '<li><div class="showTxt" style="height:300px; auto">\
                    <a style="color: #000000" href="pc/message/detail?messageId='+message.id+'"><h3 class="t-title" >' + message.title + '</h3></a>\
                    <p>' + message.subContent +'</p><a class="butn" onclick="collectionMessage(this,'+message.id+')" ><i class="iicon collect" messageId='+message.id+' ></i><span >'+collect+'</span>(<span class="spanNum message.id">' + message.collectionNum + '</span>)</a>\
                   <a href="pc/message/detail?messageId='+message.id+'"></div><div class="showImg">\
                    <img src="' + message.image + '?imageView2/1/w/343/h/230"/><img src="' + message.intro_image + '?imageView2/1/w/343/h/230"/>\
                    </div></a>\
                    </li>';
                }
                $(".pro_show").find("ul").html(html);
                thisPage.init(result.data.page, " ajaxPageMessage");
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);
            }
        });
    }
    /*收藏资讯*/
    function collectionMessage(_this,messageId){
        var userId = $("#sessionUserId").val();
        var addOrDel=false;
        var Num=$(_this).find("span").eq(1);
        // 用户未登录，则弹出未登录提示框
        if(userId==""){
            loginPopup.showDlg();
            return false;
        }
        //判断资讯收藏状态
        if($(_this).find("span").eq(0).text()=="<fmt:message key="info.shoucangzixun"/>") {
            $bluemobi.ajax("pc/message/saveCollectionMessage", {
                userId: userId,
                messageId: messageId
            }, function (result) {
                if (result.status == "0") {
                    $(_this).find("span").eq(0).text("<fmt:message key="info.quxiaoshoucang"/>");
                    $bluemobi.notify(result.msg, "success");
                }

                addOrDel=true;
                ajaxMessageCollectionAdd(Num,messageId,addOrDel);
            });
        }
        else if($(_this).find("span").eq(0).text()=="<fmt:message key="info.quxiaoshoucang"/>") {
            $bluemobi.ajax("pc/message/cancelledMessage", {
                userId: userId,
                messageId: messageId
            }, function (result) {
                if (result.status == "0") {
                    $(_this).find("span").eq(0).text("<fmt:message key="info.shoucangzixun"/>");
                    $bluemobi.notify(result.msg, "success");
                }
                ajaxMessageCollectionAdd(Num,messageId,addOrDel);
            });
        }
    }
    //收藏量增加
    function ajaxMessageCollectionAdd(Num,messageId, addOrDel) {
        $bluemobi.ajax("pc/message/ajaxCollectionNumAdd", {messageId: messageId ,addOrDel:addOrDel},
                function (result) {
                    if (result.status == "0") {
                        $bluemobi.notify(result.msg, "success");
                        Num.text(result.data);
                    }
                });
    }
</script>
</body>
</html>