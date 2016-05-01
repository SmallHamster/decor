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
    <meta property="qc:admins" content="25322572076211456375" />
</head>
<body>
<div class="wrapper">
    <div class="page">

        <!-- 头部开始 -->
        <%@ include file="common/header.jsp" %>
        <!-- 头部结束 -->

        <!-- 页面横幅开始 -->
        <div class="streamer">
            <div class="list">
                <ul>
                    <li><a href="###"><img src="static/pc-1.1/images/logo.png" title="" alt="" width="1920" height="480" /></a></li>
                    <li><a href="###"><img src="static/pc-1.1/images/logo.png" title="" alt="" width="1920" height="480" /></a></li>
                    <li><a href="###"><img src="static/pc-1.1/images/logo.png" title="" alt="" width="1920" height="480" /></a></li>
                </ul>
            </div>
            <div class="center">
                <div class="handlerList"></div>
                <div class="handler-prev"></div>
                <div class="handler-next"></div>
            </div>
        </div>
        <!-- 页面横幅结束 -->

        <!-- 页面主体内容开始 -->
        <div class="main">
            <div class="module design">
                <h3>就现在，改变设计方式</h3>
                <p class="muted">12万名设计师已经启程</p>
                <a class="btn">开始设计</a>
            </div>
            <div class="module introduce"></div>
            <div class="module center source">
                <h3>你的设计，正在改变生活</h3>
                <p class="muted">一键入驻，海量资源</p>
                <a class="pull-left">
                    <img src="static/pc-1.1/images/index/sample-1.jpg" title="" alt="" width="344" height="387" />
                    <img src="static/pc-1.1/images/index/sample-2.jpg" title="" alt="" width="309" height="190" />
                    <img src="static/pc-1.1/images/index/sample-3.jpg" title="" alt="" width="309" height="190" />
                    <img src="static/pc-1.1/images/index/sample-4.jpg" title="" alt="" width="309" height="190" />
                    <img src="static/pc-1.1/images/index/sample-5.jpg" title="" alt="" width="309" height="190" />
                    <div class="alpha-mask">
                        <div class="alpha"></div>
                        <div class="text">系列作品：我们仍未知道那个夏天午后闻到的花的名字</div>
                    </div>
                </a>
                <div class="pull-right">
                    <div class="text-center face"><img src="static/pc-1.1/images/index/sample-6.png" title="" alt="" width="78" height="78" /></div>
                    <p class="text-center name">VALERIE CRESWICK</p>
                    <p class="text-center address"><i class="icon-addr"></i>武汉  武汉</p>
                    <p class="text-center works">112个作品</p>
                    <div class="text-center note">我就是我，不一样的烟火</div>
                    <a class="btn btn-like">被1.2万人喜欢</a>
                    <p class="text-center saw">平均每次发布换来134次浏览</p>
                </div>
                <a class="clear btn">现在入驻</a>
                <p class="muted">更多设计师</p>
            </div>
            <div  class="module center image-list">
                <h3>这里，更好的设计</h3>
                <p class="muted">正在发生</p>
                <ul id="sceneList">

                </ul>
                <a class="clear btn">开始设计</a>
                <p class="muted">更多设计作品</p>
            </div>
            <div class="module center news">
                <h3>更多行业内幕资讯</h3>
                <p class="muted">只在DECOR</p>
                <ul id="msgList">

                </ul>
            </div>
        </div>
        <!-- 页面主体内容部分结束 -->

        <!-- 尾部开始 -->
        <%@ include file="common/footer.jsp"%>
        <!-- 尾部结束 -->
    </div>
</div>

<!--返回顶部开始-->
<%@ include file="common/other.jsp"%>

<!--返回顶部结束-->
<script type="text/javascript" src="static/pc/js/slide.min.js"></script>
<script type="text/javascript" src="static/pc/js/slide.js"></script>
<script type="text/javascript" src="static/pc/js/base.js"></script>
<script src="static/pc-1.1/js/global.js"></script>
<script src="static/pc-1.1/js/index.js"></script>
<script>
    $(function(){
        ajaxAd(); // 加载广告
        ajaxRecommendScene(); // 加载推荐的场景
        ajaxRecommendMessage(); // 加载推荐的咨询
    });

    // 加载广告
    function ajaxAd(){
        $bluemobi.ajax("pc/homepage/ajaxAd",{},function(result){
            if (result.status == "0") {
                var html = '';
                for(var i=0;i<result.data.length;i++){
                    html += '<li><a target="_blank" href="'+result.data[i].link+'"><img src="'+result.data[i].image+'" alt=""></a></li>';
                }
                $(".ck-slide-wrapper").html(html);
                $('.ck-slide').ckSlide({
                    autoPlay: true
                });
            }
        });
    }

    // 加载推荐的场景
    function ajaxRecommendScene(){
        $bluemobi.ajax("pc/homepage/ajaxRecommendScene",{},function(result){
            if (result.status == "0") {
                var html = '';
                for(var i=0;i<result.data.length;i++){
                    var scene = result.data[i];
                    var showName = "";
                    if(scene.user.roleType == "admin"){
                        showName = 'Décor';
                    }else{
                        showName = '<a href="javascript:void(0)" onclick="toUserInfo('+scene.user.id+')">'+scene.user.nickname+'</a>';
                    }
                    $bluemobi.subStrAdminNick(eval(scene),"Décor");
                    html+='<li>\
                            <a href="pc/scene/detail?sceneId='+scene.id+'">\
                            <div class="cell"><img src="'+scene.image+'" title="" alt="" width="357" width="251" /></div>\
                            <div class="face">\
                            <img src="'+scene.user.headImage+'" title="" alt="" width="60" height="60" />\
                            <p class="text-center">'+showName+'</p>\
                            </div>\
                            <div class="over-hidden">\
                            <p class="title slh">'+scene.name+'</p>\
                            <p class="desc">'+scene.info+'</p>\
                            <p class="count"><span class="pull-left">'+scene.seeNum+'次查看</span><span class="pull-right">'+scene.praiseNum+'人喜欢的设计</span></p>\
                            </div>\
                            </a>\
                            </li>';
                }
                $("#sceneList").html(html);
            }
        });
    }

    // 跳转到用户界面
    function toUserInfo(userId){
        location.href = "pc/user/detailPage?userId="+userId;
    }

    // 点赞/取消点赞
    function praiseOrCancelPraise(userId,objectId,$obj){
        if(userId==""){
            loginPopup.showDlg();
            return false;
        }
        if($obj.hasClass("i-praise")){ // 点赞
            $bluemobi.ajax("pc/praise/praise",{userId:userId,objectId:objectId,objectType:"scene"},function(result){
                if (result.status == "0") {
                    $obj.removeClass("i-praise").addClass("i-praise2");
                    var praiseNum = $obj.find(".praiseNum").text();
                    $obj.find(".praiseNum").text(praiseNum*1+1);
                    $bluemobi.notify(result.msg,"success");
                }
            });
        }else if($obj.hasClass("i-praise2")){ // 取消点赞
            $bluemobi.ajax("pc/praise/cancelPraise",{userId:userId,objectId:objectId,objectType:"scene"},function(result){
                if (result.status == "0") {
                    $obj.removeClass("i-praise2").addClass("i-praise");
                    var praiseNum = $obj.find(".praiseNum").text();
                    if(praiseNum<=0){
                        praiseNum =0;
                    }else{
                        praiseNum = praiseNum-1;
                    }
                    $obj.find(".praiseNum").text(praiseNum);
                    $bluemobi.notify(result.msg,"success");
                }
            });
        }

    }

    // 查询推荐的咨询
    function ajaxRecommendMessage(){
        var userId = $("#sessionUserId").val();
        $bluemobi.ajax("pc/homepage/ajaxRecommendMessage",{userId:userId},function(result){
            if (result.status == "0") {
                var html = '';
                for(var i=0;i<result.data.length;i++){
                    var message = result.data[i];
                    var collect;
                    if(userId!=''&&message.ifCollect=='1'){
                        collect="<fmt:message key="info.quxiaoshoucang"/>"
                    }else if(userId!=''&&message.ifCollect=='0'){
                        collect="<fmt:message key="info.shoucangzixun"/>"
                    }else if(userId==''){
                        collect="<fmt:message key="info.shoucang"/>"
                    }
                    if(message.collectionNum<0){
                        message.collectionNum=0
                    }
                    html+='<li>';
                        if(i%2==0){
                            html+='<div class="text pull-left">';
                        }else {
                            html+='<div class="text pull-right">';
                        }
                        html+='<h5 class="title slh">'+message.title+'</h5>\
                        <a href="pc/message/detail?messageId='+message.id+'"><div class="text-content">'+message.subContent+'</div></a>\
                        <a class="btn btn-store" messageId='+message.id+'><span >'+collect+'</span>（<span>'+message.collectionNum+'</span>）</a>\
                        </div>\
                        <div class="images">\
                            <a href="pc/message/detail?messageId='+message.id+'">\
                                <img src="'+message.image+'" title="" alt="" width="343" height="230" />\
                                <img src="'+message.intro_image+'" title="" alt="" width="343" height="230" />\
                            </a>\
                        </div>\
                        </li>';
                }
                $("#msgList").html(html);
                $("#msgList").find(".btn-store").unbind("click").click(function(){
                    var messageId=$(this).attr("messageId");
                    var userId = $("#sessionUserId").val();
                    var addOrDel=false;
                    var Num=$(this).find("span").eq(1).text()*1;
                    var spanOne=$(this).find("span").eq(0);
                    var spanTwo=$(this).find("span").eq(1);
                    var thisObj=$(this);
                    // 用户未登录，则弹出未登录提示框
                    if(userId==""){
                        loginPopup.showDlg();
                        return false;
                    }
                    //判断资讯收藏状态
                    if(spanOne.text()=="<fmt:message key="info.shoucangzixun"/>") {
                        $bluemobi.ajax("pc/message/saveCollectionMessage", {
                            userId: userId,
                            messageId: messageId
                        }, function (result) {
                            if (result.status == "0") {
                                spanOne.text("<fmt:message key="info.quxiaoshoucang"/>");
                                $bluemobi.notify(result.msg, "success");
                            }
                            addOrDel=true;
                            $bluemobi.ajax("pc/message/ajaxCollectionNumAdd", {messageId: messageId ,addOrDel:addOrDel},
                                    function (result) {
                                        if (result.status == "0") {
                                            $bluemobi.notify(result.msg, "success");
                                            spanTwo.text(result.data);
                                        }
                                    });
                        });
                    }else if(spanOne.text()=="<fmt:message key="info.quxiaoshoucang"/>") {
                        $bluemobi.ajax("pc/message/cancelledMessage", {
                            userId: userId,
                            messageId: messageId
                        }, function (result) {
                            if (result.status == "0") {
                                spanOne.text("<fmt:message key="info.shoucangzixun"/>");
                                $bluemobi.notify(result.msg, "success");
                            }
                            //收藏量增加
                            $bluemobi.ajax("pc/message/ajaxCollectionNumAdd", {messageId: messageId ,addOrDel:addOrDel},
                                    function (result) {
                                        if (result.status == "0") {
                                            $bluemobi.notify(result.msg, "success");
                                            spanTwo.text(result.data);
                                        }
                                    });
                        });
                    }
                })
            }
        });
    }
</script>
</body>
</html>
