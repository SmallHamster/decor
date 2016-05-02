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

<!--banner-->
<div class="bannerWrap" style="background: url('${user.backgroundImage}');">
    <div class="w1200">
        <div class="personal_information">
            <div class="personLeft">
                <a href="#" class="avater"><img src="${user.headImage}" style="width: 153px;height: 153px;"/></a>
                <a href="#" class="name">${user.nickname}</a>
                <div class="address"><i class="ico"></i>&emsp;${user.city.province.name}&emsp;${user.city.name}</div>
            </div>
            <div class="personMiddle" style="width:700px;">
                <div class="per-mtp cleafix">
                    <span><i>${user.attention}</i><em><fmt:message key="info.guangzhu"/></em></span>
                    <span><i>${user.fans}</i><em><fmt:message key="info.fengshi"/></em></span>
                    <span><i>${user.seeNum}</i><em><fmt:message key="info.fangwen"/></em></span>
                </div>
                <p class="slh" title="${user.info}">${user.info}</p>
                <h3 class="slh">刚刚更新了设计系列图：<strong>《我在海边的木头房子里面患过伤风》  木屋陈设，木头吊柜…</strong></h3>
            </div>
            <div class="personRight">
                <a href="#" class="send"><img src="static/pc-1.1/images/ico_btn_6.png" />发私信</a>
                <p>共计36个作品</p>
                <a href="#" class="like"><img src="static/pc-1.1/images/ico_btn_7.png" />被1.2万人喜欢</a>
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
            <div class="interact-con cleafix">
                <div class="interact-img"><img src="static/pc-1.1/images/designer_pic1.jpg"/></div>
                <div class="interact-right">
                    <h2><a href="#">木屋陈设，木头吊柜</a></h2>
                    <h3>来自设计系列图：《<a href="#">我在海边的木头房子里面患过伤风</a>》 </h3>
                    <div class="chat-content cleafix">
                        <div class="sc-new you">
                            <img class="me-avatar" src="static/pc-1.1/images/designer_pic2.jpg" />
                            <div class="content">
                                <i class="jianjian"></i>
                                <div class="bubble bubble-default">
                                    <div class="plain">交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题</div>
                                </div>
                                <div class="time">1天前</div>
                            </div>
                        </div>
                        <div class="sc-new me">
                            <img class="me-avatar" src="static/pc-1.1/images/designer_pic2.jpg" />
                            <div class="content">
                                <div class="time">1天前</div>
                                <div class="bubble bubble-primary">
                                    <div class="plain">感谢您的夸奖，您的户型比较独特，所以我使用了相对更少用的方式来进行设计</div>
                                </div>
                                <i class="jianjian"></i>
                            </div>
                        </div>
                    </div>
                    <a href="#" class="hudong">更多设计师互动<font>&gt;</font></a>
                </div>
            </div>
        </div>
        <!--设计系列图（36）-->
        <div class="designer">
            <h2 class="title">设计系列图（<span class="totalNum">0</span>）</h2>
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
                                    <li><a href="pc/scene/detail?sceneId=${scene.id}"><img src="${scene.image}" width="842" height="410"/></a></li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <ul id="seriesList" class="design-list cleafix">
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                    <li>
                        <img src="static/pc-1.1/images/designer_pic4.jpg" />
                        <div class="list-con cleafix">
                            <a href="#" class="list-avater">
                                <img src="static/pc-1.1/images/designer_pic1.png" />
                                <p>ryel</p>
                            </a>
                            <div class="list-con-right">
                                <a href="#" class="tit">美式卧榻——最美好夏日回忆</a>
                                <p>源自系列图：夏日回忆是某个角落吹过的威风</p>
                                <h3><a href="#">1562次查看</a><a href="#">285人喜欢的设计</a></h3>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <div id="showMore">
                <a href="javascript:;" class="look-more">查看更多设计系列图</a>
                <div class="pages cleafix">
                </div>
            </div>
            <div id="pageDiv" style="margin-top: -100px;background: white">
                <%@ include file="common/page.jsp" %>
            </div>

        </div>
        <!--评论留言-->
        <div class="comments">
            <h2 class="title">评论留言</h2>
            <div class="comment-list">
                <ul>
                    <li class="cleafix">
                        <a href="#" class="comment-name"><img src="static/pc-1.1/images/designer_pic1.png"/><p>前进</p></a>
                        <div class="comment-con">
                            <p>交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题</p>
                            <h4><span>木屋陈设，木头吊柜</span><b></b><span>来自设计系列图：《我在海边的木头房子里面患过伤风》</span><b></b><span>1天前</span></h4>
                        </div>
                    </li>
                    <li class="cleafix">
                        <a href="#" class="comment-name"><img src="static/pc-1.1/images/designer_pic1.png"/><p>前进</p></a>
                        <div class="comment-con">
                            <p>交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题</p>
                            <h4><span>木屋陈设，木头吊柜</span><b></b><span>来自设计系列图：《我在海边的木头房子里面患过伤风》</span><b></b><span>1天前</span></h4>
                        </div>
                    </li>
                    <li class="cleafix">
                        <a href="#" class="comment-name"><img src="static/pc-1.1/images/designer_pic1.png"/><p>前进</p></a>
                        <div class="comment-con">
                            <p>交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题</p>
                            <h4><span>木屋陈设，木头吊柜</span><b></b><span>来自设计系列图：《我在海边的木头房子里面患过伤风》</span><b></b><span>1天前</span></h4>
                        </div>
                    </li>
                    <li class="cleafix">
                        <a href="#" class="comment-name"><img src="static/pc-1.1/images/designer_pic1.png"/><p>前进</p></a>
                        <div class="comment-con">
                            <p>交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题</p>
                            <h4><span>木屋陈设，木头吊柜</span><b></b><span>来自设计系列图：《我在海边的木头房子里面患过伤风》</span><b></b><span>1天前</span></h4>
                        </div>
                    </li>
                    <li class="cleafix">
                        <a href="#" class="comment-name"><img src="static/pc-1.1/images/designer_pic1.png"/><p>前进</p></a>
                        <div class="comment-con">
                            <p>交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题</p>
                            <h4><span>木屋陈设，木头吊柜</span><b></b><span>来自设计系列图：《我在海边的木头房子里面患过伤风》</span><b></b><span>1天前</span></h4>
                        </div>
                    </li>
                    <li class="cleafix">
                        <a href="#" class="comment-name"><img src="static/pc-1.1/images/designer_pic1.png"/><p>前进</p></a>
                        <div class="comment-con">
                            <p>交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题</p>
                            <h4><span>木屋陈设，木头吊柜</span><b></b><span>来自设计系列图：《我在海边的木头房子里面患过伤风》</span><b></b><span>1天前</span></h4>
                        </div>
                    </li>
                    <li class="cleafix">
                        <a href="#" class="comment-name"><img src="static/pc-1.1/images/designer_pic1.png"/><p>前进</p></a>
                        <div class="comment-con">
                            <p>交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题</p>
                            <h4><span>木屋陈设，木头吊柜</span><b></b><span>来自设计系列图：《我在海边的木头房子里面患过伤风》</span><b></b><span>1天前</span></h4>
                        </div>
                    </li>
                    <li class="cleafix">
                        <a href="#" class="comment-name"><img src="static/pc-1.1/images/designer_pic1.png"/><p>前进</p></a>
                        <div class="comment-con">
                            <p>交流比较多，可以更好地理解客户的意图，虽然细节上有时候有点疏漏，但是通过沟通可以很轻松的解决这些问题</p>
                            <h4><span>木屋陈设，木头吊柜</span><b></b><span>来自设计系列图：《我在海边的木头房子里面患过伤风》</span><b></b><span>1天前</span></h4>
                        </div>
                    </li>
                </ul>
                <div id="showMore1">
                    <a href="javascript:;" class="look-more">查看更多留言</a>
                    <div class="pages cleafix">
                        <span>总计<em>50</em>条记录</span>
                        <div class="page"><a href="#">上一页</a><a href="#" class="cur">1</a><a href="#">2</a><a href="#">下一页</a><strong>共9页，到第</strong><input /><strong>页</strong></div>
                    </div>
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
    var thisPage = rpage; // 分页对象 rpage存在于page.jsp
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

        ajaxSeriesPage();

    });

    var ajaxTimes = 0;
    //查询指定用户的所有系列图分页
    function ajaxSeriesPage() {
        ajaxTimes+=1;
        var userId = $("#userId").val();
        var data = {
            userId: userId,
            pageNum: thisPage.pageNum,
            pageSize: 15,
            totalPage: thisPage.totalPage
        };
        $bluemobi.ajax("pc/user/seriesPage", data, function (result) {
            if (result.status == "0") {
                var html = '';
                for (var i = 0; i < result.data.list.length; i++) {
                    var series = result.data.list[i];
                    html+='<li>\
                            <a href="pc/series/detail?seriesId=' + series.id + '"><img src="' + series.cover + '" width="300" height="200"/></a>\
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
                thisPage.init(result.data.page, "ajaxSeriesPage");
                $(".page_rgt_pageNum").html(thisPage.pageNum);
                $(".page_rgt_totalPage").html(thisPage.totalPage);

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
            }
        });
    }
</script>
</body>
</html>
