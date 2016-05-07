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
</head>

<body>
<div class="wrapper">
   
    <%@ include file="common/header.jsp" %>
    <input type="hidden" id="cur-page" value="series"/>
    <div class="search-condition" style="display: none;">
        <input type="hidden" class="seriesTagId" value=""/>
        <input type="hidden" class="name" value="${name}"/>
    </div>

    <div class="cantainer">
        <div class="content pt20 pb60 clearfix">
            <!--左侧内容-->
            <div class="pagestyle">
                <ul class="page_list">
                    <li>
                        <h3><fmt:message key="info.liulanfangshi"/><i class="iicon i-next i-nexted"></i></h3>

                        <div class="sort" style="display: none;">
                            <a href="pc/forward/to?type=scene"><fmt:message key="info.tuku"/></a><br/><a class="active"><fmt:message key="info.xilietu"/></a>
                        </div>
                    </li>
                    <li>
                        <h3><fmt:message key="info.xilietuliebiao"/><i class="iicon i-next"></i></h3>

                        <div class="sort sorted clearfix seriesTagList">

                        </div>
                    </li>
                </ul>
                <div class="code">
                    <img src="static/pc/img/code_bg.jpg"/>
                    <p><fmt:message key="info.saoyisao，xiazaiPADban"/></p>
                </div>
            </div>
            <!--右边内容区-->
            <div class="R-content">
                <div class="breadcrumb borderbtm"><a><fmt:message key="info.anli"/></a><span class="seriesTagName"></span></div>
                <div class="pro_show mb20">
                    <ul class="image-list">

                    </ul>
                </div>
                <!-- 分页 -->
                <%@ include file="common/page.jsp"%>
            </div>
        </div>
    </div>


    <!-- footer -->
    <%@ include file="common/footer.jsp"%>

</div>
<!--右侧悬浮-->
<%@ include file="common/other.jsp"%>

<script type="text/javascript" src="static/pc/js/base.js"></script>
<script>
    var thisPage = rpage; // 分页对象 rpage存在于page.jsp

    $(function(){
        ajaxSeriesTagList();
        ajaxPageSeries("pageAttributeInit");
    });

    function ajaxPageSeries(action){
        if(action && action=="pageAttributeInit"){
            thisPage.pageAttributeInit();
        }

        var seriesTagId = $(".search-condition").find(".seriesTagId").val();
        var name = $(".search-condition").find(".name").val();
        var userId = $("#sessionUserId").val();
        var data = {seriesTagId:seriesTagId,name:name,userId:userId,pageNum:thisPage.pageNum,pageSize:thisPage.pageSize};
        $bluemobi.ajax("pc/series/page",data,function(result){
            if (result.status == "0") {
                var html = '';
                for(var i=0;i<result.data.list.length;i++){
                    var series = result.data.list[i];

                    var btnHtml = "<fmt:message key="info.shoucang"/>"; // 点赞按钮样式
                    if(series.isCollection && series.isCollection == "yes"){
                        btnHtml = "<fmt:message key="info.quxiao"/>";
                    }

                    html+='<li seriesid='+series.id+'>\
                    <div class="showTxt ';
                    if(i%2!=0){
                        html+='changTxt';
                    }
                    html+='">\
                    <h3 class="s-title"><img src="'+series.user.headImage+'" width="30" height="30"/><a href="pc/series/detail?seriesId='+series.id+'">'+series.seriesTag.name+'</a></h3>\
                    <p>'+series.info+'</p>\
                    <div class="But"><a class="butn _collect" ><i class="iicon collect "></i><span class="collectSpan" style="margin-left: 0px;color: #ffffff;">'+btnHtml+'</span>（<span class="collectionNum" style="margin-left: 0px;color: #ffffff;">'+series.collectionNum+'</span>）</a><span>'+series.sceneNum+'张场景图</span></div>\
                    </div>\
                    <div class="showImg ';
                    if(i%2!=0){
                        html+='changImg';
                    }
                    html+='">\
                    <a href="pc/series/detail?seriesId='+series.id+'"><img src="'+series.cover+'"/><img src="'+series.image+'"/></a>\
                    </div>\
                    </li>';
                }
                $(".image-list").html(html);
                thisPage.init(result.data.page,"ajaxPageSeries");

                // 绑定收藏、点赞的点击事件
                $(".image-list").find("li").each(function(){
                    var seriesId = $(this).attr("seriesid");
                    $(this).find("._collect").unbind("click").click(function(){
                        var currCollectBtn = $(this);
                        if(currCollectBtn.find(".collectSpan").html()=="<fmt:message key="info.shoucang"/>"){
                            collectDlg.show(seriesId,"series",function(){
                                currCollectBtn.find(".collectSpan").html("<fmt:message key="info.quxiao"/>");
                                var collectionNum = currCollectBtn.find(".collectionNum").html();
                                currCollectBtn.find(".collectionNum").html(collectionNum*1+1);
                            });
                        }else if(currCollectBtn.find(".collectSpan").html()=="<fmt:message key="info.quxiao"/>"){
                            collectDlg.cancelCollect(seriesId,"series",function(){
                                currCollectBtn.find(".collectSpan").html("<fmt:message key="info.shoucang"/>");
                                var collectionNum = currCollectBtn.find(".collectionNum").html();
                                collectionNum = collectionNum - 1;
                                if(collectionNum < 0){
                                    collectionNum = 0;
                                }
                                currCollectBtn.find(".collectionNum").html(collectionNum);
                            });
                        }
                    });
                });
            }
        });
    }

    // 加载种类分类
    function ajaxSeriesTagList(){
        $bluemobi.ajax("pc/series/ajaxSeriesTagList",{},function(result){
            if (result.status == "0") {
                var html = '';
                for(var i=0;i<result.data.length;i++){
                    var seriesTag = result.data[i];
                    html += '<a seriestagid="'+seriesTag.id+'">'+seriesTag.name+'</a>';
                }
                $(".seriesTagList").html(html);
                $(".seriesTagList").find("a").each(function(){
                    $(this).unbind("click").click(function(){
                        $(".seriesTagList").find("a").removeClass("active");
                        $(this).addClass("active");
                        $(".search-condition").find(".seriesTagId").val($(this).attr("seriestagid"));
                        $(".seriesTagName").html($(this).html());
                        ajaxPageSeries("pageAttributeInit");
                    });
                });
            }
        });
    }
</script>
</body>
</html>