<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="common/meta.jsp" %>
    <%@ include file="common/css.jsp" %>
    <title><fmt:message key="info.gerenzhuye"/></title>
    <link href="static/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="static/pc/css/common.css" rel="stylesheet" type="text/css">
    <link href="static/pc/css/homepage.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="static/drawBoard/css/drawing.css" />
    <style>
        .popup-wrap{
            z-index: 99999;
        }
        .content{
            width: initial;
        }
    </style>
</head>
<body>
<%@ include file="common/header.jsp" %>
<div class="crawingBox">
    <div class="content clearfix">
        <div class="crawingLeft">
            <div class="saveBox">
                <a href="javascript:;" class="news">新 建</a>
                <a href="javascript:;" class="save">保 存</a>
                <p><a href="javascript:;" class="leftx"></a><a href="javascript:;" class="rightx"></a></p>
                <p><a href="javascript:;" class="big"></a><a href="javascript:;" class="small"></a></p>
            </div>
            <div class="editor">
                <a href="javascript:;" class="fx" onClick="document.getElementsByClassName('selected')[0].style.filter='fliph';">水平翻转</a>
                <a href="javascript:;" class="fy">垂直翻转</a>
                <a href="javascript:;" class="sy">上移一层</a>
                <a href="javascript:;" class="xy">下移一层</a>
                <a href="javascript:;" class="fz">复制</a>
                <a href="javascript:;" class="del">删除</a>
            </div>
            <div id="container">
            </div>
        </div>
        <div class="crawingRight">
            <div class="crawTabs">
                <div class="hd">
                    <ul>
                        <li class="personal"><b>个人图库</b></li>
                        <li class="on"><b>素材图库</b></li>
                    </ul>
                </div>
                <div class="bd">
                    <!--个人图库开始-->
                    <div id="my" class="con" style="display:none;">
                        <div class="searchBox">
                            <form>
                                <input type="text" class="drawInp" /><input type="submit" class="drawBtn" value="搜索" />
                            </form>
                        </div>
                        <div class="tabscon">
                            <div class="slideBox">
                                <ul class="slideList s_xl">
                                    <input type="hidden" id="kindTagId" value=""/>
                                    <li><a href="javascript:;">分类</a>
                                        <dl id="kindTagList" class="clearfix">
                                            <dt><a dataid="" href="javascript:;">全部</a></dt>
                                            <dd>

                                            </dd>
                                        </dl>
                                    </li>
                                </ul>

                                <div class="imgList">
                                    <ul class="clearfix">

                                    </ul>
                                    <div class="pages">
                                        <input type="hidden" class="pageNum" value="1"/>
                                        <input type="hidden" class="pageSize" value="12"/>
                                        <a href="javascript:;" class="prev">&lt;</a>
                                        <span>page <span class="showPageNum">0</span> of <span class="totalPage">0</span></span>
                                        <a href="javascript:;" class="next">&gt;</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--个人图库结束-->
                    <!--素材图库开始-->
                    <div id="kindTag" class="con"  >
                        <div class="searchBox">
                            <input type="text" class="drawInp" /><input type="button" class="drawBtn" value="搜索" />
                        </div>
                        <div class="tabscon">
                            <div class="slideBox proClass">
                                <h3>
                                    产品分类
                                </h3>
                                <div class="classList kindTag">
                                    <ul class="clearfix">
                                    </ul>
                                    <div class="pages">
                                        <input type="hidden" class="pageNum" value="1"/>
                                        <input type="hidden" class="pageSize" value="20"/>
                                        <a href="javascript:;" class="prev">&lt;</a>
                                        <span>page <span class="showPageNum">0</span> of <span class="totalPage">0</span></span>
                                        <a href="javascript:;" class="next">&gt;</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--素材图库结束-->
                </div>
            </div>

            <div class="bgList">
                <h3>背景</h3>
                <ul class="clearfix">

                </ul>
                <div class="pages">
                    <input type="hidden" class="pageNum" value="1"/>
                    <input type="hidden" class="pageSize" value="12"/>
                    <a href="javascript:;" class="prev">&lt;</a>
                    <span>page <span class="showPageNum">0</span> of <span class="totalPage">0</span></span>
                    <a href="javascript:;" class="next">&gt;</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!--保存弹出-->
<div class="modalbg"></div>
<div class="modal" style="height: auto">
    <h2>保存搭配</h2>
    <i class="close">×</i>
    <form>
        <div class="modal_l">
            <dl class="clearfix">
                <dt>名称</dt>
                <dd><input type="text" class="sceneName" placeholder="请输入标题"></dd>
            </dl>
            <dl class="clearfix">
                <dt>签名</dt>
                <dd><textarea class="info" placeholder="请对搭配进行描述"></textarea></dd>
            </dl>
        </div>
        <div class="modal_r">
            <dl class="clearfix">
                <dt>风格标签</dt>
                <dd class="styleTagList"><input class="show" type="text" placeholder="请点击下面的标签" readonly>
                                         <input class="ids styleTagIds" type="hidden" value="">

                </dd>
            </dl>
            <dl class="clearfix">
                <dt>空间标签</dt>
                <dd class="spaceTagList"><input class="show" type="text" placeholder="请点击下面的标签" readonly>
                    <input class="ids spaceTagIds" type="hidden" value="">

                </dd>
            </dl>
            <div class="y">
                <div class="y_open">
                    <input type="checkbox" id="open" checked><label for="open">设为公开</label>
                </div>
                <div class="y_btn">
                    <input type="button" class="btn1" onclick="save()" value="确定">
                    <input type="button" class="btn2" value="取消">
                </div>
            </div>
        </div>
    </form>
</div>
<!--保存弹出-->

<%@ include file="common/footer.jsp" %>
<script type="text/javascript" src="static/pc/js/base.js"></script>

<%--<script src="static/drawBoard/js/jquery-1.8.2.min.js"></script>--%>
<script src="static/drawBoard/js/jquery-ui.min.js"></script>
<script src="static/drawBoard/js/jquery.searchableSelect.js"></script>
<script src="static/drawBoard/js/jQueryRotate.2.2.js"></script>
<script src="static/drawBoard/js/html2canvas.js"></script>
<script src="static/drawBoard/js/export-canvas.js"></script>
<script src="static/drawBoard/js/drawing.js"></script>
<script type="text/javascript">
    // 背景图div对象
    var $bg = $(".bgList");
    $(function () {
        $('.crawingLeft').width($(window).width() - 560 + 'px');
        $(window).resize(function(event) {
            $('.crawingLeft').width($(window).width() - 560 + 'px');
        });
        $('.save').on('click', function(event) {
            event.preventDefault();
            if($("#sessionUserId").val() == ""){
                layer.msg('请先登录');
                return false;
            }
            $('.modalbg').show();
            $('.modal').show();
//            $('html').css('overflow','hidden');
        });
        $('.modal i.close,.modal .btn2').click(function(){
            $('.modalbg').hide();
            $('.modal').hide();
            $('html').css('overflow','auto');
        })



        // 默认选中第2个
        $('.crawTabs .hd li').eq(1).trigger("click");

        // 个人图库查询
        $("#my").find(".prev").click(function(){
            var pageNum = Number($("#my").find(".pageNum").val());
            if(pageNum > 1){
                $("#my").find(".pageNum").val(pageNum - 1);
                pageMyCollection();
            }
        });
        $("#my").find(".next").click(function(){
            var pageNum = Number($("#my").find(".pageNum").val());
            var totalPage = Number($("#my").find(".totalPage").html());
            if(pageNum < totalPage){
                $("#my").find(".pageNum").val(pageNum + 1);
                pageMyCollection();
            }
        });

        // 商品种类查询
        $("#kindTag").find(".drawBtn").click(function(){
            $("#kindTag").find(".pageNum").val(1);
            pageKindTag();
        });
        pageKindTag();

        // 背景图查询
        $bg.find(".prev").click(function(){
            var pageNum = Number($bg.find(".pageNum").val());
            if(pageNum > 1){
                $bg.find(".pageNum").val(pageNum - 1);
                pageBackground();
            }
        });
        $bg.find(".next").click(function(){
            var pageNum = Number($bg.find(".pageNum").val());
            var totalPage = Number($bg.find(".totalPage").html());
            if(pageNum < totalPage){
                $bg.find(".pageNum").val(pageNum + 1);
                pageBackground();
            }
        });
        pageBackground();

        allKindTag();
        ajaxStyleTagList();
        ajaxSpaceTagList();
    });

    // 全部分类
    function allKindTag(){
        $bluemobi.ajax("pc/comm/ajaxKindTagList", {}, function (result) {
            if (result.status == "0") {
                var html = '';
                for (var i = 0; i < result.data.length; i++) {
                    var kindTag = result.data[i];
                    html += '<a dataid="'+kindTag.id+'" href="javascript:;">'+kindTag.name+'</a>';
                }
                $("#kindTagList").find("dd").html(html);
                $("#kindTagList").find("a").unbind("click").click(function(){
                    $("#kindTagId").val($(this).attr("dataid"));
                    pageMyCollection();
                });
            }
        });
    }

    // 个人图库
    function pageMyCollection(){
        var $pageNum = $("#my").find(".pageNum");
        var $pageSize = $("#my").find(".pageSize");
        var kindTagId = $("#kindTagId").val();
        $.ajax({
            type: 'get',
            url: 'pc/material/pageMyCollection',
            data: {userId:$("#sessionUserId").val(),pageNum:$pageNum.val(),pageSize:$pageSize.val(),kindTagId:kindTagId},
            async: false,
            dataType: 'json',
            success: function (result) {
                if (result.status!="0") {
                    $bluemobi.notify(result.msg, "error");
                } else {
                    var html='';
                    for(var i=0;i<result.data.list.length;i++){
                        var material = result.data.list[i].material;
                        html+='<li><a class="drop"><img src="'+material.image+'" alt="" title="" width="92" height="92"/></a></li>';
                    }
                    $("#my").find(".imgList").find("ul").html(html);
                    // 绑定拖拽事件
                    drop();
                    $("#my").find(".pageNum").val(result.data.page.currentPage);
                    if(result.data.page.totalPage==0){
                        $("#my").find(".showPageNum").html(0);
                    }else {
                        $("#my").find(".showPageNum").html(result.data.page.currentPage);
                    }
                    $("#my").find(".totalPage").html(result.data.page.totalPage);
                }
            },
            error: function (err) {
                $bluemobi.notify("系统异常，请刷新页面后重试！", "error");
            }
        });
    }

    // 背景图分页
    function pageBackground(){
        var $pageNum = $bg.find(".pageNum");
        var $pageSize = $bg.find(".pageSize");
        $.ajax({
            type: 'get',
            url: 'pc/background/page',
            data: {pageNum:$pageNum.val(),pageSize:$pageSize.val()},
            async: false,
            dataType: 'json',
            success: function (result) {
                if (result.status!="0") {
                    $bluemobi.notify(result.msg, "error");
                } else {
                    var html='';
                    for(var i=0;i<result.data.list.length;i++){
                        var background = result.data.list[i];
                        html+='<li><a class="drop bg"><img src="'+background.image+'"/></a></li>';
                    }
                    $bg.find("ul").html(html);
                    // 绑定拖拽事件
                    drop();
                    $bg.find(".pageNum").val(result.data.page.currentPage);
                    if(result.data.page.totalPage==0){
                        $bg.find(".showPageNum").html(0);
                    }else {
                        $bg.find(".showPageNum").html(result.data.page.currentPage);
                    }
                    $bg.find(".totalPage").html(result.data.page.totalPage);
                }
            },
            error: function (err) {
                $bluemobi.notify("系统异常，请刷新页面后重试！", "error");
            }
        });
    }

    // 商品种类
    function pageKindTag(){
        var $div = $("#kindTag");
        var $pageNum = $div.find(".pageNum");
        var $pageSize = $div.find(".pageSize");
        var name = $div.find(".drawInp").val();
        $.ajax({
            type: 'get',
            url: 'pc/kindTag/page',
            data: {pageNum:$pageNum.val(),pageSize:$pageSize.val(),name:name},
            async: false,
            dataType: 'json',
            success: function (result) {
                if (result.status!="0") {
                    $bluemobi.notify(result.msg, "error");
                } else {
                    var html='';
                    for(var i=0;i<result.data.list.length;i++){
                        var kindTag = result.data.list[i];
                        html+='<li><a kindtagid="'+kindTag.id+'"><img src="'+kindTag.image+'" alt="" title="'+kindTag.name+'" /><p class="slh" title="'+kindTag.name+'">'+kindTag.name+'</p></a></li>';
                    }
                    $div.find(".classList").find("ul").html(html);
                    $div.find(".pageNum").val(result.data.page.currentPage);
                    if(result.data.page.totalPage==0){
                        $div.find(".showPageNum").html(0);
                    }else {
                        $div.find(".showPageNum").html(result.data.page.currentPage);
                    }
                    $div.find(".totalPage").html(result.data.page.totalPage);
                }
                kindTagClick();
            },
            error: function (err) {
                $bluemobi.notify("系统异常，请刷新页面后重试！", "error");
            }
        });
    }

    // 加载风格分类
    function ajaxStyleTagList(){
        $bluemobi.ajax("pc/comm/ajaxStyleTagList",{},function(result){
            if (result.status == "0") {
                var html = '';
                for(var i=0;i<result.data.length;i++){
                    var styleTag = result.data[i];
                    var styleIndex = "style" + (i*1+1);
                    var _class = "";
                    if(styleTag.name && styleTag.name.length > 4){
                        _class = "two";
                    }
//                    html += '<a styletagid="'+styleTag.id+'">'+styleTag.name+'</a>';
                    html+='<input type="checkbox" name="" id="'+styleIndex+'"><label _id="'+styleTag.id+'" class="'+_class+'" for="'+styleIndex+'">'+styleTag.name+'</label>';
                }
                $(".styleTagList").append(html);
                tagStyle();
            }
        });
    }

    // 加载风格分类
    function ajaxSpaceTagList(){
        $bluemobi.ajax("pc/comm/ajaxSpaceTagList",{},function(result){
            if (result.status == "0") {
                var html = '';
                for(var i=0;i<result.data.length;i++){
                    var spaceIndex = "space" + (i*1+1);
                    var spacetag = result.data[i];
//                    html += '<a spacetagid="'+spacetag.id+'">'+spacetag.name+'</a>';
                    var _class = "";
                    if(spacetag.name && spacetag.name.length > 4){
                        _class = "two";
                    }
                    html+='<input type="checkbox" name="" id="'+spaceIndex+'"><label _id="'+spacetag.id+'" class="'+_class+'" for="'+spaceIndex+'">'+spacetag.name+'</label>';
                }
                $(".spaceTagList").append(html);
                tagStyle();
            }
        });
    }

    function tagStyle(){
        $('.modal_r input[type="checkbox"]').unbind("click").click(function(){
            var chk_value = [];
            var ids_value = [];
            var inp = $(this).parents('dd').find('.show');
            var ids = $(this).parents('dd').find('.ids');
            if(inp.val() != ''){
                chk_value = inp.val().split(',');
                ids_value = ids.val().split(',');
            }
            if($(this).is(':checked')){
                chk_value.push($(this).next('label').text());
                ids_value.push($(this).next('label').attr("_id"));
                inp.val(chk_value);
                ids.val(ids_value);
            }else{
                chk_value.splice($.inArray($(this).next('label').text(),chk_value),1);
                ids_value.splice($.inArray($(this).next('label').attr("_id"),ids_value),1);
                inp.val(chk_value);
                ids.val(ids_value);
            }
        })
    }
</script>
</body>

</html>