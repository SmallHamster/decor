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
    </style>
</head>
<body>
<%@ include file="common/header.jsp" %>
<div class="crawingBox">
    <div class="content clearfix">
        <div class="crawingLeft">
            <div class="saveBox">
                <a href="javascript:;" class="news">新 建</a>
                <a href="javascript:;" class="save" onclick="save()">保 存</a>
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
                        <li class="on"><b>素材图库</b></li>
                        <li><b>个人图库</b></li>
                    </ul>
                </div>
                <div class="bd">
                    <!--素材图库开始-->
                    <div class="con">
                        <div class="searchBox">
                            <form><input type="text" class="drawInp" /><input type="submit" class="drawBtn" value="搜索" /></form>
                        </div>
                        <div class="tabscon">
                            <div class="slideBox proClass">
                                <h3>
                                    产品分类
                                </h3>
                                <div class="classList">
                                    <ul class="clearfix">
                                        <li><a href="javascript:;" name="yizi.html"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>椅</p></a></li>
                                        <li><a href="javascript:;" name="yizi2.html"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>桌</p></a></li>
                                        <li><a href="javascript:;" name="yizi3.html"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>地毯</p></a></li>
                                        <li><a href="javascript:;" name="yizi4.html"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>吧台</p></a></li>
                                        <li><a href="javascript:;" name="yizi5.html"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>沙发</p></a></li>
                                        <li><a href="javascript:;" name="yizi6.html"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>酒柜</p></a></li>
                                        <li><a href="javascript:;" name="yizi7.html"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>相框</p></a></li>
                                        <li><a href="javascript:;" name="yizi8.html"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>床</p></a></li>
                                        <li><a href="javascript:;"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>吧台酒柜</p></a></li>
                                        <li><a href="javascript:;"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>椅</p></a></li>
                                        <li><a href="javascript:;"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>椅</p></a></li>
                                        <li><a href="javascript:;"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>椅</p></a></li>
                                        <li><a href="javascript:;"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>椅</p></a></li>
                                        <li><a href="javascript:;"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>椅</p></a></li>
                                        <li><a href="javascript:;"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>椅</p></a></li>
                                        <li><a href="javascript:;"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>椅</p></a></li>
                                        <li><a href="javascript:;"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>椅</p></a></li>
                                        <li><a href="javascript:;"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>椅</p></a></li>
                                        <li><a href="javascript:;"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>椅</p></a></li>
                                        <li><a href="javascript:;"><img src="static/drawBoard/images/fl.jpg" alt="" title="" /><p>椅</p></a></li>
                                    </ul>
                                    <div class="pages">
                                        <a href="javascript:;" class="prev">&lt;</a>
                                        <span>page 1 of 10</span>
                                        <a href="javascript:;" class="next">&gt;</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--素材图库结束-->
                    <!--个人图库开始-->
                    <div class="con" style="display:none;">
                        <div class="searchBox">
                            <form>
                                <input type="text" class="drawInp" /><input type="submit" class="drawBtn" value="搜索" />
                            </form>
                        </div>
                        <div class="tabscon">
                            <div class="slideBox">
                                <ul class="slideList s_xl">
                                    <li><a href="javascript:;">分类</a>
                                        <dl class="clearfix">
                                            <dt><a href="javascript:;">全部</a></dt>
                                            <dd>
                                                <a href="javascript:;">办公</a>
                                                <a href="javascript:;">餐饮娱乐</a>
                                                <a href="javascript:;">客厅</a>
                                                <a href="javascript:;">餐厅</a>
                                                <a href="javascript:;">厨房</a>
                                                <a href="javascript:;">卧室</a>
                                                <a href="javascript:;">玄关</a>
                                                <a href="javascript:;">卫生间</a>
                                                <a href="javascript:;">酒店</a>
                                                <a href="javascript:;">玄关</a>
                                            </dd>
                                        </dl>
                                    </li>
                                </ul>

                                <div class="imgList">
                                    <ul class="clearfix">
                                        <li><a class="drop"><img src="static/drawBoard/images/pro1.jpg" alt="" title="" /></a></li>
                                        <li><a class="drop"><img src="static/drawBoard/images/pro1.jpg" alt="" title="" /></a></li>
                                        <li><a class="drop"><img src="static/drawBoard/images/pro1.jpg" alt="" title="" /></a></li>
                                        <li><a class="drop"><img src="static/drawBoard/images/pro1.jpg" alt="" title="" /></a></li>
                                        <li><a class="drop"><img src="static/drawBoard/images/pro1.jpg" alt="" title="" /></a></li>
                                        <li><a class="drop"><img src="static/drawBoard/images/pro1.jpg" alt="" title="" /></a></li>
                                        <li><a class="drop"><img src="static/drawBoard/images/pro1.jpg" alt="" title="" /></a></li>
                                        <li><a class="drop"><img src="static/drawBoard/images/pro1.jpg" alt="" title="" /></a></li>
                                        <li><a class="drop"><img src="static/drawBoard/images/pro1.jpg" alt="" title="" /></a></li>
                                        <li><a class="drop"><img src="static/drawBoard/images/pro1.jpg" alt="" title="" /></a></li>
                                        <li><a class="drop"><img src="static/drawBoard/images/pro1.jpg" alt="" title="" /></a></li>
                                        <li><a class="drop"><img src="static/drawBoard/images/pro1.jpg" alt="" title="" /></a></li>
                                    </ul>
                                    <div class="pages">
                                        <a href="javascript:;" class="prev">&lt;</a>
                                        <span>page 1 of 10</span>
                                        <a href="javascript:;" class="next">&gt;</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--个人图库结束-->
                    <!--页面加载-->
                    <div id="load"></div>
                    <!--页面加载-->
                </div>
            </div>

            <div class="bgList">
                <h3>背景</h3>
                <ul class="clearfix">
                    <li><a class="drop bg"><img src="static/drawBoard/images/bg2.jpg" /></a></li>
                    <li><a class="drop bg"><img src="static/drawBoard/images/bg1.jpg" /></a></li>
                    <li><a class="drop bg"><img src="static/drawBoard/images/bg1.jpg" /></a></li>
                    <li><a class="drop bg"><img src="static/drawBoard/images/bg1.jpg" /></a></li>
                    <li><a class="drop bg"><img src="static/drawBoard/images/bg1.jpg" /></a></li>
                    <li><a class="drop bg"><img src="static/drawBoard/images/bg1.jpg" /></a></li>
                    <li><a class="drop bg"><img src="static/drawBoard/images/bg1.jpg" /></a></li>
                    <li><a class="drop bg"><img src="static/drawBoard/images/bg1.jpg" /></a></li>
                    <li><a class="drop bg"><img src="static/drawBoard/images/bg1.jpg" /></a></li>
                </ul>
                <div class="pages">
                    <a href="javascript:;" class="prev">&lt;</a>
                    <span>page 1 of 10</span>
                    <a href="javascript:;" class="next">&gt;</a>
                </div>
            </div>
        </div>
    </div>
</div>
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
    $(function () {
        if ($("#sessionUserId").val() == "") {
            loginPopup.showDlg();
            return false;
        }
    });

    function pageMyCollection(){
        $.ajax({
            type: 'get',
            url: 'pc/material/pageMyCollection',
            data: {userId:$("#sessionUserId").val()},
            async: false,
            dataType: 'json',
            success: function (data) {
                if (data.status!="0") {
                    $bluemobi.notify(data.msg, "error");
                } else {
                    var html='';
                    for(var i=0;i<data.list.length;i++){
                        var material = data.material;
                        html+='<li><a class="drop"><img src="'+material.image+'" alt="" title="" /></a></li>';
                    }
                    $(".imgList").find("ul").html(html);
                }
            },
            error: function (err) {
                $bluemobi.notify("系统异常，请刷新页面后重试！", "error");
            }
        });
    }
</script>
</body>

</html>