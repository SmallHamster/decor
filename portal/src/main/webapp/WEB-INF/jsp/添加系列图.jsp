<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="inc/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="inc/meta.jsp" %>
    <meta name="description" content="">
    <meta name="author" content="">
    <title>添加系列图</title>
    <%@ include file="inc/css.jsp" %>
    <link href="static/js/plugins/dropper/jquery.fs.dropper.css" rel="stylesheet">
    <script src="static/js/plugins/dropper/jquery.fs.dropper.js"></script>
    <style>
        .scene {
            width: 200px;
            height: 200px;
            float: left;
            margin-left: 10px;
            margin-top: 10px;
            cursor: pointer;
            background-position: center center;
        }

        .scene img {
            width: 120px;
            height: 120px;
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
    </style>
    <script>
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

            sceneIds = "";
            $("#sceneIds").val("");
        });
        var sceneIds;
        function updata(sceneId) {
            var sIs = $("#sceneIds").val();
            if (sceneIds.indexOf(sceneId + ",") != -1) {
                sceneIds = sIs.replace(sceneId + ",", "");
                var img = document.getElementById('im' + sceneId);
                img.style.display = 'none';
            } else {
                sceneIds = sIs + sceneId + ",";
                var img = document.getElementById('im' + sceneId);
                img.style.display = 'block';
            }
            $("#sceneIds").val(sceneIds);
        }
    </script>
</head>

<body>

<div id="posts" class="wrapper">

    <%@ include file="inc/nav.jsp" %>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">添加系列图</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4>添加系列图</h4>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <form id="form" method="post" action="backend/series/save">
                            <table border="0" style="width: 90%; line-height: 40px; margin-left: 8%;">
                                <tr>
                                    <th width="100px;" style="text-align: right;">系列图分类：&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                    <td><select id="tagList" name="tagId" style="width: 30%"
                                                class="form-control">
                                    </select></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div><p></p></div>
                                    </td>
                                </tr>
                                <tr>
                                    <th style="text-align: right;">系列图描述：&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                    <td><textarea
                                            style="width: 419px; height: 113px;resize:none;"
                                            name="info" class="form-control"></textarea>
                                    </td>
                                </tr>
                            </table>
                            <hr/>
                            <input type="hidden" name="sceneIds" id="sceneIds"/>
                        </form>
                        <h4>选择场景图</h4>
                        <hr/>
                        <br/>

                        <div align="center">
                            <form class="form-inline">
                                <div class="form-group" style="width: 200px;">
                                    <label>场景名称：</label><input type="text" id="name" class="form-control input-sm"/>
                                </div>
                                <div class="form-group" style="width: 200px;">
                                    <label>发布者：</label><input type="text" id="author" class="form-control input-sm"/>
                                </div>
                                <div class="form-group" style="width: 10px;">
                                </div>
                                <div class="form-group" style="width: 200px;">
                                    <label style="width:35%;">风格分类：</label><select
                                        id="styleList" name="styleList"
                                        style="width: 65%;"
                                        class="form-control"></select>
                                </div>
                                <div class="form-group" style="width: 10px;">
                                </div>
                                <div class="form-group" style="width: 200px;">
                                    <label style="width:35%;">空间分类：</label><select
                                        id="spaceList" name="spaceList"
                                        style="width: 65%;"
                                        class="form-control"></select>
                                </div>
                                <div class="form-group" style="width: 10px;">
                                </div>
                                <div class="form-group">
                                    <button type="button" id="c_search" class="btn btn-info btn-sm">搜索</button>
                                </div>
                            </form>
                        </div>
                        <br/>

                        <div id="sceneImageList"
                             style="width: 840px;height:640px;margin-left: auto;margin-right: auto;">
                        </div>

                        <div class="green-black" id="pageInfos">
                        </div>
                        <input type="hidden" id="pageNum"/>
                    </div>
                    <!-- /.panel-body -->

                    <div class="panel-footer">
                        <div class="row">
                            <div class="col-lg-12" style="text-align: center;">
                                <button type="button" id="save" class="btn btn-primary">保存</button>
                                <a href="backend/series/index" class="btn btn-primary" style="color: white;"
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
    var this_ = {
        v: {
            id: "this_"
        },
        fn: {
            init: function () {
                // 页面加载时，自动加载分类信息
                this_.fn.getTagList();

                this_.fn.search();

                //点击保存按钮，执行表单提交方法
                $("#save").click(function () {
                    this_.fn.save();
                });

                //点击查询按钮
                $("#c_search").click(function () {
                    this_.fn.search();
                });

                //初始化上传照片
                this_.fn.dropperInit();
                $("#removeImg").click(function () {
                    this_.fn.clearImageViewAndDelete();
                })

            },
            getTagList: function () {
                $bluemobi.ajax("backend/utils/seriesTag/list", null, function (result) {
                    if (null != result) {
                        // 获取返回的分类列表信息，并循环绑定到label中
                        var content = "";
                        jQuery.each(result, function (i, item) {
                            content += "<option value='" + item.id + "'>" + item.name + "</option>";
                        });
                        $('#tagList').append(content);
                    } else {
                        $bluemobi.notify("获取分类信息失败", "error");
                    }
                });

                $bluemobi.ajax("backend/utils/spaceTag/mapList", null, function (result) {
                    if (null != result) {
                        // 获取返回的分类列表信息，并循环绑定到label中
                        var content = "<option value=''>全部</option>";
                        jQuery.each(result, function (i, item) {
                            content += "<option value='" + item.id + "'>" + item.name + "</option>";
                        });
                        $('#spaceList').append(content);
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
                        $('#styleList').append(content);
                    } else {
                        $bluemobi.notify("获取分类信息失败", "error");
                    }
                });
            },
            save: function () {
                if (!$('#form').isValid()) {
                    return false;
                }
                ;

                $("#form").ajaxSubmit({
                    dataType: "json",
                    success: function (result) {
                        this_.fn.responseComplete(result, true);
                    }
                });
            },
            responseComplete: function (result, action) {
                if (result.status == "0") {
                    window.location.href = _basePath + "/backend/series/index";
                } else {
                    $bluemobi.notify(result.msg, "error");
                }
            },
            onFileComplete: function (e, file, response) {
                if (response != '' && response != null) {
                    this_.fn.viewImage(response);
                } else {
                    $bluemobi.notify("抱歉上传失败", "error");
                }
            },
            onFileError: function (e, file, error) {
                $bluemobi.notify(error, "error");
            },
            search: function (pn) {
                var name=$("#name").val();
                var author = $("#author").val();
                var styleId = $("#styleList").val();
                var spaceId = $("#spaceList").val();
                var pageNum;
                if (pn != null || pn > 0) {
                    pageNum = pn;
                    $("#pageNum").val(pn);
                } else {
                    //获取当前页数
                    pageNum = $("#pageNum").val();
                }
                var data = {
                    name:name,
                    author: author,
                    styleId: styleId,
                    spaceId: spaceId,
                    pageNum: pageNum
                };
                $.ajax({
                    url: "backend/scene/findImageList",
                    data: data,
                    type: "POST",
                    dataType: "json",
                    success: function (result) {
                        this_.fn.addHtml(result);
                    },
                    error: function () {
                        //错误就清空页面
                        $("#sceneImageList").empty();
                        $("#pageInfos").empty();
                    }
                });
            },
            addHtml: function (result) {
                //初始化页面
                $("#sceneImageList").empty();
                $("#pageInfos").empty();
                var $div1 = $("#sceneImageList");
                var $h3;
                if (result.sceneImageList.length < 1) {
                    $h3 = $("<h3 style='display: block;color: red;' align='center'>抱歉，未找到此场景图</h3>");
                } else {
                    $h3 = $("<h3 style='display: none;color: red;' align='center'>抱歉，未找到此场景图</h3>");
                }
                $h3.appendTo($div1);
                for (var index in result.sceneImageList) {
                    var map = result.sceneImageList[index];
                    var $div11 = $("<div class='scene' style = 'background: url(" + map.sceneImage + ") no-repeat 0px 0px;background-size: 200px;' onclick = 'updata(" + map.sceneId + ")'</div>");
                    $div11.appendTo($div1);
                    var $img;
                    var n = 0;
                    var sceneIds = $("#sceneIds").val().split(',');
                    for (var index in sceneIds) {
                        var sceneId = sceneIds[index];
                        if (sceneId == map.sceneId) {
                            n = 1;
                        }
                    }
                    if (n == 0) {
                        $img = $("<img src='static/images/yes.png' id='im" + map.sceneId + "'/>");
                    } else {
                        $img = $("<img style='display: block;' src='static/images/yes.png' id='im" + map.sceneId + "'/>");
                    }
                    $img.appendTo($div11);
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

            }
        }
    }

    $(document).ready(function () {
        this_.fn.init();
    });
</script>

</html>