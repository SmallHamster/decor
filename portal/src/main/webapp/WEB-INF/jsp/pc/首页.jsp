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
    <link href="static/pc-1.1/css/index.css" rel="stylesheet" type="text/css">
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
                <a href="pc/drawBoard/page" class="btn">开始设计</a>
            </div>
            <div class="module introduce"></div>
            <div class="module center source">
                <h3>你的设计，正在改变生活</h3>
                <p class="muted">一键入驻，海量资源</p>
                <a class="pull-left" id="hotSeries">

                </a>
                <div class="pull-right" id="hottestDesigner">

                </div>
                <a class="clear btn" id="goJoin">现在入驻</a>
                <p class="muted">更多设计师</p>
            </div>
            <div  class="module center image-list">
                <h3>这里，更好的设计</h3>
                <p class="muted">正在发生</p>
                <ul id="seriesList">

                </ul>
                <a class="clear btn">开始设计</a>
                <a href="pc/forward/to?type=series"><p class="muted" style="font-size: 16px;margin: 18px auto;">更多设计作品</p></a>
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
        if ((screen.height<=800) && (screen.width<=600)) {
            // 手机
            window.location.replace('mobile/forward/to?type=index');
        } else {
            // pc pad
            //window.location.replace('index');
        }

        // 现在入驻
        $("#goJoin").click(function(){
            $("#register").trigger("click");
        });
        ajaxAd(); // 加载广告
        ajaxSeries(); // 加载系列图
        ajaxRecommendMessage(); // 加载推荐的咨询
        hottestDesigner();
    });

    // 最热设计师
    function hottestDesigner(){
        $bluemobi.ajax("pc/homepage/hottestDesigner",{},function(result){
            if (result.status == "0") {
                if(result.data.list.length > 0){
                    var user = result.data.list[0];
                    var seriesList = user.seriesList;
                    var html='<div class="text-center face"><a href="pc/user/detail?userId=' + user.id + '"><img src="'+user.headImage+'" title="" alt="" width="78" height="78" /></a></div>\
                            <p class="text-center name"><a href="pc/user/detail?userId=' + user.id + '">'+user.nickname+'</a></p>\
                    <p class="text-center address"><i class="icon-addr"></i>'+user.province.name+'  '+user.city.name+'</p>\
                    <p class="text-center works">'+user.opus+'个作品</p>\
                    <div class="text-center note">'+user.info+'</div>\
                    <a class="btn btn-like">被'+user.fans+'人喜欢</a>\
                    <p class="text-center saw">平均每次发布换来'+user.seeNum+'次浏览</p>';
                    $("#hottestDesigner").html(html);
                    var hotSeriesHtml='';
                    var div='';
                    for(var i=0;i<seriesList.length;i++){
                        var series = seriesList[i];
                        if(i==0){
                            hotSeriesHtml+='<a href="pc/series/detail?seriesId=' + series.id + '"><img src="'+series.cover+'" title="" alt="" width="344" height="387" /></a>';
                            div='<div class="alpha-mask">\
                            <div class="alpha"></div>\
                            <div class="text">系列作品：'+series.seriesTag.name+'</div></div>';
                        }else {
                            hotSeriesHtml+='<a href="pc/series/detail?seriesId=' + series.id + '"><img src="'+series.cover+'" title="" alt="" width="306" height="190" style="margin-left: 6px;"/></a>';

                        }
                    }
                    hotSeriesHtml+=div;
                    $("#hotSeries").html(hotSeriesHtml);
                }
            }
        });
    }

    // 加载广告
    function ajaxAd(){
        $bluemobi.ajax("pc/homepage/ajaxAd",{},function(result){
            if (result.status == "0") {
                var html = '';
                for(var i=0;i<result.data.length;i++){
                    html += '<li><a target="_blank" href="'+result.data[i].link+'"><img src="'+result.data[i].image+'" alt="" width="1920" height="480"></a></li>';
                }
                $(".streamer").find("ul").html(html);
                roll($('div.streamer'));
            }
        });
    }

    //图片轮播
    function roll($layer){
        var $img = [],
                cur, intval, lock = false,
                $handlers = $layer.find('div.handlerList');

        $layer.find('ul li').each(function(i){
            $img.push($(this));
            $handlers.append('<span></span>');
        });

        cur = $img.length - 1;
        cur = cur < 0 ? 0 : cur;

        $layer.find('div.list').on({
            mouseenter : function(){ lock = true;},
            mouseleave : function(){ lock = false;}
        });

        $handlers.find('span').each(function(i){
            $(this).click(function(){
                clearTimeout(intval);
                show(i);
            });
        });

        $layer.find('.handler-prev').click(function(){
            show(cur - 1);
        });

        $layer.find('.handler-next').click(function(){
            show(cur + 1);
        });

        function show(n){
            if(cur == n || lock){ loop(); return}
            else if(n < 0) n = $img.length - 1;
            else if(n > $img.length - 1) n = 0;
            $img[cur].stop().fadeOut('slow');
            $handlers.find('span:eq(' + cur + ')').removeClass('cur');
            $img[n].stop().fadeIn('slow');
            $handlers.find('span:eq(' + n + ')').addClass('cur');
            cur = n;
            loop();
        }

        function loop(){
            clearInterval(intval);
            intval = setTimeout(function(){ show(cur + 1)}, 5000);
        }

        show(0);

    }

    // 加载推荐的场景
    function ajaxSeries(){
        $bluemobi.ajax("pc/homepage/ajaxSeries",{},function(result){
            if (result.status == "0") {
                var html = '';
                for(var i=0;i<result.data.length;i++){
                    var object = result.data[i];
                    var showName = "";
                    if(object.user.roleType == "admin"){
                        showName = 'Décor';
                    }else{
                        showName = '<a href="javascript:void(0)" onclick="toUserInfo('+object.user.id+')">'+object.user.nickname+'</a>';
                    }
                    $bluemobi.subStrAdminNick(eval(object),"Décor");
                    html+='<li>\
                            <a href="pc/series/detail?seriesId='+object.id+'">\
                            <div class="cell"><img src="'+object.cover+'" title="" alt="" width="357" width="251" /></div>\
                            <div class="face">\
                            <a href="pc/user/detailPage?userId='+object.user.id+'">' +
                            '<img src="'+object.user.headImage+'" title="" alt="" width="60" height="60" /></a>\
                            <p class="text-center">'+showName+'</p>\
                            </div>\
                            <div class="over-hidden">\
                            <p class="title slh"><a href="pc/series/detail?seriesId='+object.id+'">'+object.seriesTag.name+'</a></p>\
                            <p class="desc">'+object.info+'</p>\
                            <p class="count"><span class="pull-left">'+object.seeNum+'次查看</span><span class="pull-right">'+object.praiseNum+'人喜欢的设计</span></p>\
                            </div>\
                            </a>\
                            </li>';
                }
                $("#seriesList").html(html);
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
                        html+='<a href="pc/message/detail?messageId='+message.id+'"><h5 class="title slh">'+message.title+'</h5>\
                        <div class="text-content">'+message.subContent+'</div></a>\
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
