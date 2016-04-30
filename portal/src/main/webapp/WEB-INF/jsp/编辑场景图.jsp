<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="inc/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="inc/meta.jsp" %>
    <meta name="description" content="">
    <meta name="author" content="">
    <title>编辑场景图</title>
    <%@ include file="inc/css.jsp" %>
    <link href="static/js/plugins/dropper/jquery.fs.dropper.css" rel="stylesheet">
    <script src="static/js/plugins/dropper/jquery.fs.dropper.js"></script>
    <style>
        .none {
            display: none;
        }

        DIV.green-black {
            PADDING-RIGHT: 3px;
            PADDING-LEFT: 3px;
            PADDING-BOTTOM: 3px;
            MARGIN: 3px;
            PADDING-TOP: 3px;
            TEXT-ALIGN: center
        }

        DIV.green-black A {
            BORDER-RIGHT: #2c2c2c 1px solid;
            PADDING-RIGHT: 5px;
            BORDER-TOP: #2c2c2c 1px solid;
            PADDING-LEFT: 5px;
            BACKGROUND: url(images/pageimage1.gif) #2c2c2c;
            PADDING-BOTTOM: 2px;
            BORDER-LEFT: #2c2c2c 1px solid;
            COLOR: #fff;
            MARGIN-RIGHT: 2px;
            PADDING-TOP: 2px;
            BORDER-BOTTOM: #2c2c2c 1px solid;
            TEXT-DECORATION: none
        }

        DIV.green-black A:hover {
            BORDER-RIGHT: #aad83e 1px solid;
            BORDER-TOP: #aad83e 1px solid;
            BACKGROUND: url(images/pageimage2.gif) #aad83e;
            BORDER-LEFT: #aad83e 1px solid;
            COLOR: #fff;
            BORDER-BOTTOM: #aad83e 1px solid
        }

        DIV.green-black A:active {
            BORDER-RIGHT: #aad83e 1px solid;
            BORDER-TOP: #aad83e 1px solid;
            BACKGROUND: url(images/pageimage2.gif) #aad83e;
            BORDER-LEFT: #aad83e 1px solid;
            COLOR: #fff;
            BORDER-BOTTOM: #aad83e 1px solid
        }

        DIV.green-black SPAN.current {
            BORDER-RIGHT: #aad83e 1px solid;
            PADDING-RIGHT: 5px;
            BORDER-TOP: #aad83e 1px solid;
            PADDING-LEFT: 5px;
            FONT-WEIGHT: bold;
            BACKGROUND: url(images/pageimage2.gif) #aad83e;
            PADDING-BOTTOM: 2px;
            BORDER-LEFT: #aad83e 1px solid;
            COLOR: #fff;
            MARGIN-RIGHT: 2px;
            PADDING-TOP: 2px;
            BORDER-BOTTOM: #aad83e 1px solid
        }

        DIV.green-black SPAN.disabled {
            BORDER-RIGHT: #f3f3f3 1px solid;
            PADDING-RIGHT: 5px;
            BORDER-TOP: #f3f3f3 1px solid;
            PADDING-LEFT: 5px;
            PADDING-BOTTOM: 2px;
            BORDER-LEFT: #f3f3f3 1px solid;
            COLOR: #ccc;
            MARGIN-RIGHT: 2px;
            PADDING-TOP: 2px;
            BORDER-BOTTOM: #f3f3f3 1px solid
        }

        .tag {
            border: 1px solid #70b0f0;
            -moz-border-radius: 2px;
            -webkit-border-radius: 2px;
            border-radius: 2px;
            display: block;
            float: left;
            padding: 2px 5px;
            text-decoration: none;
            background: #81befb;
            color: #fff;
            margin-right: 5px;
            font-family: helvetica;
            font-size: 13px;
            margin-top: 3px;
            cursor: pointer;
        }

        .goodsImageList {
            float: left;
            margin-top: 30px;
            margin-left: 20px;
        }

        .goodsImageList img {
            margin-bottom: 5px;
            margin-right: 5px;
            width: 256px;
            height: 142px;
            cursor: pointer;
        }

        .goodsYWC {
            width: 200px;
            height: 35px;
            margin-top: 5px;
            margin-left: 5px;
        }

        .goodsXZ {
            width: 200px;
            height: 35px;
            margin-top: 5px;
            margin-left: 5px;
        }

        .goodsYWC img {
            width: 64px;
            height: 35.5px;
        }

        .goodsXZ img {
            width: 64px;
            height: 35.5px;
        }

    </style>
    <script type="text/javascript">
        $(function () {
            //全局
            document.onkeydown = function (e) {
                var ev = document.all ? window.event : e;
                if (ev.keyCode == 13) {
                    // 如（ev.ctrlKey && ev.keyCode==13）为ctrl+Center 触发

                    //要处理的事件
                    this_.fn.save();
                }
            }
        });
    </script>
</head>

<body>

<div id="posts" class="wrapper">

    <%@ include file="inc/nav.jsp" %>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">编辑场景图</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4>编辑场景图</h4>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <form id="form" method="post" action="backend/scene/updata">
                            <input type="hidden" name="sceneId" value="${scene.id}"/>
                            <input type="hidden" id="goodsImgId" name="goodsImgId" value=""/>
                            <table border="0" style="width: 90%; line-height: 40px; margin-left: 8%;">
                                <tr>
                                    <th>场景名称：</th>
                                    <td><input type="text" name="sceneName" id="sceneName" style="width: 30%"
                                               class="form-control" value="${scene.name}"/></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div><p></p></div>
                                    </td>
                                </tr>
                                <tr id="trh" style="line-height:25px;">
                                    <th>风格标签：
                                        <div id="bh"></div>
                                    </th>

                                    <td>
                                        <input type="hidden" id="styleTagIds" name="styleTagIds"/>

                                        <div class="col-sm-5" style="padding-left: 0px;width: 32%;">
                                            <div class="panel panel-default">
                                                <div class="panel-body selectedbox" id="selectedbox">

                                                </div>

                                                <div class="initbox">

                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div><p></p></div>
                                    </td>
                                </tr>
                                <tr id="trh1" style="line-height:25px;">
                                    <th>空间标签：
                                        <div id="bh1"></div>
                                    </th>
                                    <td>
                                        <input type="hidden" id="spaceTagIds" name="spaceTagIds"/>

                                        <div class="col-sm-5" style="padding-left: 0px;width: 32%;">
                                            <div class="panel panel-default">
                                                <div class="panel-body selectedbox1" id="selectedbox1">

                                                </div>

                                                <div class="initbox1">

                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div><p></p></div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>场景描述：</th>
                                    <td><textarea
                                            style="width: 419px; height: 113px;resize:none;"
                                            name="info" class="form-control">${scene.info}</textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div><p></p></div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>是否显示：</th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${scene.isShow=='yes'}">
                                                <input type="radio" name="isShow" value="yes" checked/>显示
                                                &nbsp;&nbsp;
                                                <input type="radio" name="isShow" value="no"/>不显示
                                            </c:when>
                                            <c:otherwise>
                                                <input type="radio" name="isShow" value="yes"/>显示
                                                &nbsp;&nbsp;
                                                <input type="radio" name="isShow" value="no" checked/>不显示
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th>是否推荐：</th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${scene.isRecommend=='yes'}">
                                                <input type="radio" name="isRecommend" value="yes" checked/>推荐
                                                &nbsp;&nbsp;
                                                <input type="radio" name="isRecommend" value="no"/>不推荐
                                            </c:when>
                                            <c:otherwise>
                                                <input type="radio" name="isRecommend" value="yes"/>推荐
                                                &nbsp;&nbsp;
                                                <input type="radio" name="isRecommend" value="no" checked/>不推荐
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div><p></p></div>
                                    </td>
                                </tr>
                                <tr style="line-height: 30px;">
                                    <th>上传图片：</th>
                                    <td>
                                        <div id="headImage" style="width: 800px;">

                                            <div class="col-sm-5" style="padding-left: 0px;">
                                                <input type="hidden" id="image" name="image" value="">

                                                <div class="image_show" style="display: none">

                                                </div>
                                                <div class="image_handle" data-toggle="tooltip" data-placement="top"
                                                     title=""
                                                     data-original-title="建议上传宽480px高320px的图片">
                                                    <div class="dropped"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-5">
                                            <a href="javascript:void(0)" id="removeImg" class="btn btn-info"
                                               role="button">删除图片</a>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <input type="hidden" name="goodsIds" id="goodsIds"/>
                            <input type="hidden" name="old_Input" id="old_Input"/>
                            <input type="hidden" name="index_goodsImg" id="index_goodsImg"/>
                        </form>
                        <div id="scD" style="width:1024px;display: none;">
                            <hr/>
                            <h4>筛选商品图</h4>
                            <hr/>

                            <img id="pointimg" style="display: none;" src="static/images/ok.png"/>
                            <%--与ipad统一--%>
                            <img id="sceneImage" src=""
                                 style="width: 400px;float: left;margin-left: 50px;position: relative;"
                                 onclick="getPointPosition(event)"/>

                            <div id="baseimg"></div>

                            <div style="width: 207px;height: 284px;float: left;margin-left: 20px;border:1px solid #BABABA;OVERFLOW-Y: auto; OVERFLOW-X:hidden;"
                                 id="goodsTagList">
                            </div>

                            <div style="float: left;margin-top: 30px;margin-left: 50px;">
                                商品名称：<input type="text" name="goodsName" id="goodsName"/>
                                空间分类：<select id="spaceId" name="spaceId" style="width: 150px;"></select>
                                风格分类：<select id="styleId" name="styleId" style="width: 150px;"></select>
                                <input type="button" id="sub" value="搜索" class="btn btn-info btn-sm"/>
                            </div>
                            <div width="800" class="goodsImageList" id="goodsImageList">
                            </div>
                            <div style="float: left;width: 800px;">
                                <div class="green-black" id="pageInfos" align="center">
                                </div>
                                <input type="hidden" id="pageNum"/>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel-body -->

                    <div class="panel-footer">
                        <div class="row">
                            <div class="col-lg-12" style="text-align: center;">
                                <button type="button" id="save" class="btn btn-primary">保存</button>
                                <a href="backend/scene/index" class="btn btn-primary" style="color: white;"
                                   role="button">返回</a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.panel -->
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<%@ include file="inc/footer.jsp" %>
</body>

<script type="text/javascript">
    var n = 1;
    var timeCode;
    var this_ = {
        v: {
            id: "this_"
        },
        fn: {
            init: function () {
                //清空
                $("#goodsIds").val("");
                //页面加载时，自动加载类型列表
                this_.fn.getStyleAndSpaceTag();
                this_.fn.getTagList();
                //进入页面加载商品图
                this_.fn.search();
                //点击保存按钮，执行表单提交方法
                $("#save").click(function () {
                    this_.fn.save();
                });
                this_.fn.dropperInit();
                $("#removeImg").click(function () {
                    this_.fn.clearImageViewAndDelete();
                })
                $("#sub").click(function () {
                    this_.fn.search();
                });
            },
            search: function (pn) {
                var goodsName = $("#goodsName").val();
                var styleId = $("#styleId").val();
                var spaceId = $("#spaceId").val();
                var pageNum;
                if (pn != null || pn > 0) {
                    pageNum = pn;
                    $("#pageNum").val(pn);
                } else {
                    //获取当前页数
                    pageNum = $("#pageNum").val();
                }
                var data = {
                    goodsName: goodsName,
                    styleId: styleId,
                    spaceId: spaceId,
                    pageNum: pageNum
                };
                $.ajax({
                    url: "backend/goods/findGoods",
                    data: data,
                    type: "POST",
                    dataType: "json",
                    success: function (result) {
                        this_.fn.addHtml(result);
                    },
                    error: function () {
                        //错误就清空页面
                        $("#goodsImageTable").empty();
                        $("#pageInfos").empty();
                    }
                });
            },
            addHtml: function (result) {
                //初始化页面
                $("#goodsImageList").empty();
                $("#pageInfos").empty();
                var $div1 = $("#goodsImageList");
                var $h3;
                if (result.goodsImageList == null || result.goodsImageList.length < 1) {
                    $h3 = $("<div style='float: left;width: 720px;'><h3 style='display: block;color: red;' align='center'>抱歉，未找到此商品图</h3></div>");
                    $h3.appendTo($div1);
                    return false;
                } else {
                    $h3 = $("<div style='float: left;width: 720px;'><h3 style='display: none;color: red;' align='center'>抱歉，未找到此商品图</h3></div>");
                    $h3.appendTo($div1);
                }
                for (var index in result.goodsImageList) {
                    var map = result.goodsImageList[index];
                    var $img = $("<img src='" + map.goodsImage + "' id='goodsIm" + map.goodsId + "' onclick='this_.fn.addGoodsImage(" + map.goodsId + ")'/>");
                    $img.appendTo($div1);
                }

                var $div2 = $("#pageInfos");
                var pageNum = $("#pageNum").val();
                if (pageNum == null || pageNum == '') {
                    pageNum = 1;
                }
                var totalPage = result.totalPage;
                if (pageNum == 1) {
                    var $span = $("<span class='disabled'>&lt; Prev</span>");
                    $span.appendTo($div2);
                } else {
                    if (totalPage == 1 || totalPage == 0) {
                        var $span = $("<span class='disabled'>&lt; Prev</span>");
                        $span.appendTo($div2);
                    } else {
                        var prev = pageNum - 1;
                        var $a = $("<a href='javascript:void(0);' onclick='this_.fn.search(" + prev + ")'>&lt; Prev</a>");
                        $a.appendTo($div2);
                    }
                }
                for (var index in result.pageInfos) {
                    var map = result.pageInfos[index];
                    if (map.pageNum == 1) {
                        if (totalPage == 1 || totalPage == 0) {
                            var $span = $("<span class='current'>1</span>");
                            $span.appendTo($div2);
                        } else {
                            if (pageNum != map.pageNum) {
                                var $a = $("<a href='javascript:void(0);' onclick='this_.fn.search(1)'>1...</a>");
                                $a.appendTo($div2);
                            } else {
                                var $span = $("<span class='current'>1...</span>");
                                $span.appendTo($div2);
                            }
                        }
                    } else if (map.pageNum == totalPage) {
                        if (totalPage != 1 && totalPage != 0) {
                            if (pageNum != map.pageNum) {
                                var $a = $("<a href='javascript:void(0);' onclick='this_.fn.search(" + totalPage + ")'>..." + totalPage + "</a>");
                                $a.appendTo($div2);
                            } else {
                                var $span = $("<span class='current'>..." + totalPage + "</span>");
                                $span.appendTo($div2);
                            }
                        }
                    } else {
                        if (totalPage != 1 && totalPage != 0) {
                            if (pageNum != map.pageNum) {
                                var $a = $("<a href='javascript:void(0);' onclick='this_.fn.search(" + map.pageNum + ")'>" + map.pageNum + "</a>");
                                $a.appendTo($div2);
                            } else {
                                var $span = $("<span class='current'>" + map.pageNum + "</span>");
                                $span.appendTo($div2);
                            }
                        }
                    }

                }
                if (pageNum == totalPage) {
                    var $span = $("<span class='disabled'>Next&gt;</span>");
                    $span.appendTo($div2);
                } else {
                    if (totalPage == 1 || totalPage == 0) {
                        var $span = $("<span class='disabled'>Next&gt;</span>");
                        $span.appendTo($div2);
                    } else {
                        var next = pageNum - 1 + 2;
                        var $a = $("<a href='javascript:void(0);' onclick='this_.fn.search(" + next + ")'>Next&gt;</a>");
                        $a.appendTo($div2);
                    }
                }

            },
            addGoodsImage: function (id) {
                if ($(".fa-plus-square").length > 0) {
                    var $i = $(".fa-plus-square").get(0);
                    $i.className = "fa fa-tags";
                    var div = $(".goodsXZ").get(0);
                    var $div = $(".goodsXZ").get(0);
                    $div.className = "goodsYWC";
                    var $span = $(div).find("span").last();
                    $span.css('display', 'none');
                    var img = ("#goodsIm" + id + "");
                    var src = $(img).attr("src");
                    var $gm = $("<img src='" + src + "'/>");
                    $gm.appendTo($div);
                    var xy = $(div).find("input").val();
                    var $input1 = $("#goodsIds");
                    $input1.val($input1.val() + id + "!" + xy + ",");
                    var $span = $("<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>");
                    $span.appendTo($div);
                    var nI = i;
                    nI = nI - 1;
                    var $li = $("<i class='fa fa-times' style='cursor: pointer;' onclick='deletePointPosition(" + nI + ")'></i>");
                    $li.appendTo($div);
                }
                else {
                    alert("请先选择一个坐标");
                }
            }
            ,
            getStyleAndSpaceTag: function () {
                $bluemobi.ajax("backend/utils/styleTag/mapList", null, function (result) {
                    //找到父节点
                    var $div = $(".initbox");//根据ID找节点
                    $div.empty();
                    for (var i = 0; i < result.length; i++) {
                        var d = result[i];
                        var $span = $("<span class='tag' tagid='" + d.id + "' tagtype='" + d.type + "'></span>");
                        $span.appendTo($div);
                        var $span1 = $("<span>" + d.name + "</span>");
                        $span1.appendTo($span);
                        var $a = $("<a class='none' href='javascript:void(0)' onclick='this_.fn.remove(this)' title='删除'></a>");
                        $a.appendTo($span);
                        var $li = $("<i class='fa fa-times'></i>");
                        $li.appendTo($a);
                    }
                    $(".initbox").find(".tag").unbind("click").click(function () {
                        var tagid = $(this).attr("tagid");
                        var tagtype = $(this).attr("tagtype");
                        var len = $(".selectedbox [tagid='" + tagid + "'][tagtype='" + tagtype + "']").length;
                        if (len == 0) {
                            var t = $(this).clone();
                            t.find("a").removeClass("none");
                            $(".selectedbox").append(t);
                        }
                    })
                });

                $bluemobi.ajax("backend/utils/spaceTag/mapList", null, function (result) {
                    //找到父节点
                    var $div = $(".initbox1");//根据ID找节点
                    $div.empty();
                    for (var i = 0; i < result.length; i++) {
                        var d = result[i];
                        var $span = $("<span class='tag' tagid='" + d.id + "' tagtype='" + d.type + "'></span>");
                        $span.appendTo($div);
                        var $span1 = $("<span>" + d.name + "</span>");
                        $span1.appendTo($span);
                        var $a = $("<a class='none' href='javascript:void(0)' onclick='this_.fn.remove(this)' title='删除'></a>");
                        $a.appendTo($span);
                        var $li = $("<i class='fa fa-times'></i>");
                        $li.appendTo($a);
                    }
                    $(".initbox1").find(".tag").unbind("click").click(function () {
                        var tagid = $(this).attr("tagid");
                        var tagtype = $(this).attr("tagtype");
                        var len = $(".selectedbox1 [tagid='" + tagid + "'][tagtype='" + tagtype + "']").length;
                        if (len == 0) {
                            var t = $(this).clone();
                            t.find("a").removeClass("none");
                            $(".selectedbox1").append(t);
                        }
                    })
                });
                //字符串计算为json数组
                var jsonStyle = eval('${jsonStyle}');
                var jsonSpace = eval('${jsonSpace}');
                //初始化标签
                addTag(jsonStyle, "selectedbox");
                addTag(jsonSpace, "selectedbox1");

                var image = '${scene.image}';
                this_.fn.viewImage(image);
            }
            ,
            getTagList: function () {

                $bluemobi.ajax("backend/utils/spaceTag/mapList", null, function (result) {
                    if (null != result) {
                        // 获取返回的分类列表信息，并循环绑定到label中
                        var content = "<option value=''>全部</option>";
                        jQuery.each(result, function (i, item) {
                            content += "<option value='" + item.id + "'>" + item.name + "</option>";
                        });
                        $('#spaceId').append(content);
                    } else {
                        $bluemobi.notify("获取分类信息失败", "error");
                    }
                });

                $bluemobi.ajax("backend/utils/styleTag/mapList", null, function (result) {
                    if (null != result) {
                        // 获取返回的分类列表信息，并循环绑定到label中
                        var content = "<option value=''>全部</option>";
                        jQuery.each(result, function (i, item) {
                            content += "<option value='" + item.id + "'>" + item.name + "</option>";
                        });
                        $('#styleId').append(content);
                    } else {
                        $bluemobi.notify("获取分类信息失败", "error");
                    }
                });
            }
            ,
            save: function () {
                if (!$('#form1').isValid()) {
                    return false;
                }
                ;

                //获取空间标签IDs
                var spaceTagIds = "";
                //获取风格标签IDs
                var styleTagIds = "";
                $(".selectedbox").find(".tag").each(function () {
                    var tagid = $(this).attr("tagid");
                    var tagtype = $(this).attr("tagtype");
                    if (styleTagIds != "") {
                        styleTagIds += ",";
                    }
                    styleTagIds += tagid;

                });
                $(".selectedbox1").find(".tag").each(function () {
                    var tagid = $(this).attr("tagid");
                    var tagtype = $(this).attr("tagtype");
                    if (spaceTagIds != "") {
                        spaceTagIds += ",";
                    }
                    spaceTagIds += tagid;
                });
                //获取图片ID
                $("#spaceTagIds").val(spaceTagIds);
                $("#styleTagIds").val(styleTagIds);

                $("#form").ajaxSubmit({
                    dataType: "json",
                    success: function (result) {
                        this_.fn.responseComplete(result, true);
                    }
                });
            }
            ,
            remove: function (_this) {
                $(_this).parent().remove();
            }
            ,
            responseComplete: function (result, action) {
                if (result.status == "0") {
                    window.location.href = _basePath + "/backend/scene/index";
                } else {
                    $bluemobi.notify(result.msg, "error");
                }
            }
            ,
            bhFun: function () {
                //标签选项显示处理
                var trHeight = document.getElementById('trh').clientHeight;
                document.getElementById("bh").style.height = (trHeight - 20) + "px";
                document.getElementById("bh").style.width = "100%";

                var trHeight1 = document.getElementById('trh1').clientHeight;
                document.getElementById("bh1").style.height = (trHeight - 20) + "px";
                document.getElementById("bh1").style.width = "100%";
            }
            ,
            clearImageView: function () {
                $("#image").val("");
                $("#headImage").find(".image_show").html("");
                $("#headImage").find(".image_handle").show();
                $("#headImage").find(".dropper-input").val("");
                $("#sceneImage").attr("src", "");
                var dis = document.getElementById("scD");
                dis.style.display = 'none';
                $("#baseimg").html("");
                $("#goodsIds").val("");
            }
            ,
            clearImageViewAndDelete: function () {
                var path = $("#ssimgid").prop("src");
                $.ajax({
                            url: "backend/utils/deleteImage",
                            data: {
                                path: path
                            }
                        }
                );
                $("#image").val("");
                $("#headImage").find(".image_show").html("");
                $("#headImage").find(".image_handle").show();
                $("#headImage").find(".dropper-input").val("");
                $("#sceneImage").attr("src", "");
                var dis = document.getElementById("scD");
                dis.style.display = 'none';
                $("#baseimg").html("");
                $("#goodsIds").val("");
            }
            ,
            viewImage: function (image) {
                if (image) {
                    $("#headImage").find(".dropper-input").val("");
                    $("#headImage").find(".image_handle").hide();
                    $("#headImage").find(".image_show").show();
                    $("#image").val(image);
                    $("#headImage").find(".image_show").html("<img id='ssimgid' src='" + image + "' class='img-responsive' >");
                    $("#sceneImage").attr("src", image);
                    var seI = document.getElementById("sceneImage");
                    seI.onload = function () {
                        $("#sceneImage").attr("src") == image;
                        var dis = document.getElementById("scD");
                        dis.style.display = 'block';
                        //自动加载已选中商品列表
                        initPointPosition();
                    };
                }
            }
            ,
            dropperInit: function () {
                $("#headImage" + " .dropped").dropper({
                    postKey: "file",
                    action: "backend/utils/saveImage",
                    postData: {thumbSizes: '480x320'},
                    label: "把文件拖拽到此处"
                }).on("fileComplete.dropper", this_.fn.onFileComplete)
                        .on("fileError.dropper", this_.fn.onFileError);
            }
            ,
            onFileComplete: function (e, file, response) {
                if (response != '' && response != null) {
                    this_.fn.viewImage(response);
                } else {
                    $bluemobi.notify("抱歉上传失败", "error");
                }
            }
            ,
            onFileError: function (e, file, error) {
                $bluemobi.notify(error, "error");
            }
        }
    }

    //生成标签
    function addTag(result, className) {
        var $div = $("." + className + "");//根据ID找节点
        $div.empty();
        for (var i = 0; i < result.length; i++) {
            var d = result[i];
            var $span = $("<span class='tag' tagid='" + d.id + "' tagtype='" + d.type + "'></span>");
            $span.appendTo($div);
            var $span1 = $("<span>" + d.name + "</span>");
            $span1.appendTo($span);
            var $a = $("<a href='javascript:void(0)' onclick='this_.fn.remove(this)' title='删除'></a>");
            $a.appendTo($span);
            var $li = $("<i class='fa fa-times'></i>");
            $li.appendTo($a);
        }
    }

    var i = 1;
    function initPointPosition() {
        var jsonSceneGoods = eval('${jsonSceneGoods}');
        for (var ii = 0; ii < jsonSceneGoods.length; ii++) {
            var map = jsonSceneGoods[ii];
            var x = map.x;
            var y = map.y;
            var sceneImage = $("#sceneImage");
            var sysImgW = sceneImage.offset().left - 270;
            var sceneImgW = sysImgW + $("#sceneImage").width() * x + "px";
            var syscImgH = sceneImage.offset().top - 165;
            var sceneImgH = syscImgH + $("#sceneImage").height() * y + "px";
            //用绝对定位的方式显示图片
            content = "<i class='fa fa-plus-square' id='goodsImg" + i + "' ondblclick='deletePointPosition(" + i + ")' style='left: " + sceneImgW + ";top: " + sceneImgH + ";position: absolute;'></i>";
            //每次点击后讲描点拼接在一个div中
            $("#baseimg").append(content);
            var $div = $("#goodsTagList");
            var $div1 = $("<div class='goodsXZ' id='goodsImgD" + i + "'></div>");
            $div1.appendTo($div);
            var $span = $("<span style='line-height:35px;'>已标记坐标&nbsp;&nbsp;&nbsp;</span>");
            $span.appendTo($div1);
            var $input = $("<input type='hidden' value='" + x + "_" + y + "' />");
            $input.appendTo($div1);
            var $span1 = $("<span style='color: #ff0000;'>   请添加图片</span>");
            $span1.appendTo($div1);
            //显示描点
            $("#baseimg").html($("#baseimg").html());
            //显示图片
            if ($(".fa-plus-square").length > 0) {
                var $i = $(".fa-plus-square").get(0);
                $i.className = "fa fa-tags";
                var div = $(".goodsXZ").get(0);
                var $div = $(".goodsXZ").get(0);
                $div.className = "goodsYWC";
                var $span = $(div).find("span").last();
                $span.css('display', 'none');
                var $gm = $("<img src='" + map.goodsImage + "'/>");
                $gm.appendTo($div);
                var xy = $(div).find("input").val();
                var $input1 = $("#goodsIds");
                $input1.val($input1.val() + map.goodsId + "!" + xy + ",");
                var $span = $("<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>");
                $span.appendTo($div);
                var $li = $("<i class='fa fa-times' style='cursor: pointer;' onclick='deletePointPosition(" + i + ")'></i>");
                $li.appendTo($div);
            }
            else {
                alert("请先选择一个坐标");
            }
            i++;
        }
        $("#baseimg i").mousedown(function (_this) {
            $(this).css("cursor", "move")
            var offset = $(this).offset();//DIV在页面的位置
            var x = event.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离
            var y = event.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离
            var imgId=$(this).attr("id");
            var goodsIndex=imgId.substring(imgId.length-1,imgId.length);
            $("#old_Input").val($("#goodsImgD"+goodsIndex).find("input").eq(0).val())
            $("#index_goodsImg").val(goodsIndex);
            $(document).bind("mousemove",function (ev)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件
            {
                $("#"+imgId).stop();//加上这个之后
                var imgOffSet=$("#sceneImage").offset();
                var IofdSet=$("#"+imgId).offset()
                var _x = ev.pageX -272;//获得X轴方向移动的值
                var _y = ev.pageY -162;//获得Y轴方向移动的值
                $("#"+imgId).animate({left: _x + "px", top: _y + "px"}, 10);
                var x_px_scrTo = ev.offsetX ;
                var y_px_scrTo = ev.offsetY;
                var xxs = ((IofdSet.left-imgOffSet.left) / $("#sceneImage").width()).toFixed(4);
                var yxs = ((IofdSet.top-imgOffSet.top) / $("#sceneImage").height()).toFixed(4);
                /*替换Input*/
                $("#goodsImgD"+goodsIndex).find("input").eq(0).val(xxs + "_" + yxs);
                if(ev.pageX<imgOffSet.left||ev.pageX>imgOffSet.left+$("#sceneImage").width()||ev.pageY<imgOffSet.top||ev.pageY>imgOffSet.top+$("#sceneImage").height()){
                    var ZhongX=imgOffSet.left+($("#sceneImage").width()/2)-272;
                    var ZhongY=imgOffSet.top+($("#sceneImage").height()/2)-162;
                    $("#"+imgId).animate({left: ZhongX + "px", top: ZhongY + "px"}, 10);
                    $("#goodsImgD"+goodsIndex).find("input").eq(0).val("0.4850" + "_" + "0.4920");
                    $(this).unbind("mousemove");
                }
            });
        })

    }

    function getPointPosition(event) {
        if ($(".fa-plus-square").length >= 1 || $(".goodsXZ").length >= 1) {
            alert("请先完成上一个商品标签的信息！");
            return false;
        }
        //获取描点相对图片左边的距离(offsetX在IE,360,谷歌兼容，layerX在火狐兼容)
        var x_px_scr = event.offsetX || event.layerX;
        //获取描点相对图片上边的距离(offsetX在IE,360,谷歌兼容，layerX在火狐兼容)
        var y_px_scr = event.offsetY || event.layerY;
        //1.获取描点相对浏览器左边距离(显示描点图片用) 2.event.pageX是相对整个页面的左偏移量 3. $("#pointimg").width()是图片宽4，相减是为了在描点处居中显示描点图片
        var mleft = (event.pageX - $("#pointimg").width() / 2) - 270 + "px";
        var mtop = (event.pageY - $("#pointimg").height() / 2) - 160 + "px";
        //获取描点相对主图片左边距离百分比
//      var percentX = (x_px_scr / $("#sceneImage").width()) * 100 + "%";
//      var percentY = (y_px_scr / $("#sceneImage").height()) * 100 + "%";

        var xxs = (x_px_scr / $("#sceneImage").width()).toFixed(4);
        var yxs = (y_px_scr / $("#sceneImage").height()).toFixed(4);
        //用绝对定位的方式显示图片
        content = "<i class='fa fa-plus-square' id='goodsImg" + i + "'   ondblclick='deletePointPosition(" + i + ")' style='left: " + mleft + ";top: " + mtop + ";position: absolute;'></i>";
        //每次点击后讲描点拼接在一个div中
        $("#baseimg").append(content);
        //添加的最外层DIV
        var $div = $("#goodsTagList");
        var $div1 = $("<div class='goodsXZ' id='goodsImgD" + i + "'></div>");
        $div1.appendTo($div);
        var $span = $("<span style='line-height:35px;'>已标记坐标&nbsp;&nbsp;&nbsp;</span>");
        $span.appendTo($div1);
        var $input = $("<input type='hidden' value='" + xxs + "_" + yxs + "' />");
        $input.appendTo($div1);
        var $span1 = $("<span style='color: #ff0000;'>   请添加图片</span>");
        $span1.appendTo($div1);
        //显示描点
        $("#baseimg").html($("#baseimg").html());
        $("#baseimg i").mousedown(function (_this) {
            $(this).css("cursor", "move")
            var offset = $(this).offset();//DIV在页面的位置
            var x = event.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离
            var y = event.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离
            var imgId=$(this).attr("id");
            var goodsIndex=imgId.substring(imgId.length-1,imgId.length);
            $("#old_Input").val($("#goodsImgD"+goodsIndex).find("input").eq(0).val())
            $("#index_goodsImg").val(goodsIndex);
            $(document).bind("mousemove",function (ev)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件
            {
                $("#"+imgId).stop();//加上这个之后
                var imgOffSet=$("#sceneImage").offset();
                var IofdSet=$("#"+imgId).offset()
                var _x = ev.pageX -272;//获得X轴方向移动的值
                var _y = ev.pageY -162;//获得Y轴方向移动的值
                $("#"+imgId).animate({left: _x + "px", top: _y + "px"}, 10);
                var x_px_scrTo = ev.offsetX ;
                var y_px_scrTo = ev.offsetY;
                var xxs = ((IofdSet.left-imgOffSet.left) / $("#sceneImage").width()).toFixed(4);
                var yxs = ((IofdSet.top-imgOffSet.top) / $("#sceneImage").height()).toFixed(4);
                /*替换Input*/
                $("#goodsImgD"+goodsIndex).find("input").eq(0).val(xxs + "_" + yxs);
                if(ev.pageX<imgOffSet.left||ev.pageX>imgOffSet.left+$("#sceneImage").width()||ev.pageY<imgOffSet.top||ev.pageY>imgOffSet.top+$("#sceneImage").height()){
                    var ZhongX=imgOffSet.left+($("#sceneImage").width()/2)-272;
                    var ZhongY=imgOffSet.top+($("#sceneImage").height()/2)-162;
                    $("#"+imgId).animate({left: ZhongX + "px", top: ZhongY + "px"}, 10);
                    $("#goodsImgD"+goodsIndex).find("input").eq(0).val("0.4850" + "_" + "0.4920");
                    $(this).unbind("mousemove");
                }
            });
        })
        i++;

    }
    /*鼠标放开时*/
    $(document).mouseup(function () {
        /*替换goodsIds的值*/
        var old_Input=$("#old_Input").val();
        var index_goodsImg=$("#index_goodsImg").val();
        var goodsIds=$("#goodsIds").val();

        $("#"+$("#goodsImgId").val()).css("cursor","move");
        $(this).unbind("mousemove");
        var newInput=  $("#goodsImgD"+index_goodsImg).find("input").eq(0).val();
        var xh = goodsIds.split(",");
        for (var i in xh) {
            var goodId = xh[i];
            var pos=goodId.indexOf("!");
            if(old_Input!=''&&goodId.indexOf(old_Input) != -1){
                var pos=goodId.indexOf("!");
                var oldString =goodId.substring(pos+1,goodId.length);
                var newstr = goodsIds.replace(oldString ,newInput);
                $("#goodsIds").val(newstr);
                console.log($("#goodsIds").val());
                break;
            }
        }
    })
    function deletePointPosition(index) {
        var goodsIds = $("#goodsIds").val();
        var xh = goodsIds.split(",");
        for (var i in xh) {
            var goodsId = xh[i];
            if (goodsId.indexOf($("#goodsImgD" + index).find("input").val()) != -1) {
                var newstr = goodsIds.replace(goodsId + ",", "");
                $("#goodsIds").val(newstr)
            }
        }
        $("#goodsImg" + index).remove();
        $("#goodsImgD" + index).remove();
    }
    $(document).ready(function () {
        this_.fn.init();
    });

</script>

</html>