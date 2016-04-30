<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="inc/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="inc/meta.jsp" %>
    <meta name="description" content="">
    <meta name="author" content="">
    <title>编辑商品图</title>
    <%@ include file="inc/css.jsp" %>
    <link href="static/js/plugins/dropper/jquery.fs.dropper.css" rel="stylesheet">
    <script src="static/js/plugins/dropper/jquery.fs.dropper.js"></script>
    <style>
        .none {
            display: none;
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
                <h1 class="page-header">编辑商品图</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4>编辑商品图</h4>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <form id="form" method="post" action="backend/goods/updata">
                            <input type="hidden" name="goodsId" value="${goods.id}"/>
                            <table border="0" style="width: 90%; line-height: 40px; margin-left: 8%;">
                                <tr>
                                    <th style="width: 9%;">商品名称：</th>
                                    <td><input type="text" name="goodsName" id="goodsName" style="width: 30%"
                                               class="form-control" value="${goods.name}"/></td>
                                </tr>
                                <tr>
                                    <th>商品分类：</th>
                                    <td><select id="tagList" name="goodsKindTagId" style="width: 30%"
                                                class="form-control">
                                    </select><input type="hidden" id="kti" value="${goods.kindTagId}"/>
                                    </td>
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
                                    <th>&nbsp;&nbsp;&nbsp;价格($)：</th>
                                    <td><input type="text" name="price" id="price" style="width: 30%"
                                               class="form-control" value="${goods.price}"/></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div><p></p></div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;尺寸：</th>
                                    <td><textarea
                                            style="width: 419px; height: 113px;resize:none;"
                                            name="size" class="form-control">${goods.size}</textarea>
                                </tr>
                                <tr>
                                    <td>
                                        <div><p></p></div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>商品材质：</th>
                                    <td><textarea
                                            style="width: 419px; height: 113px;resize:none;"
                                            name="texture" class="form-control">${goods.texture}
                                    </textarea></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div><p></p></div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>商品描述：</th>
                                    <td><textarea
                                            style="width: 419px; height: 113px;resize:none;"
                                            name="info" class="form-control">${goods.info}</textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td><h4 style=""><span style="display: none;"></span></h4></td>
                                </tr>
                                <tr>
                                    <th>购买链接：</th>
                                    <td><input type="text" name="link" id="link" style="width: 30%"
                                               class="form-control" value="${goods.link}"/></td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td><h4 style=""><span style="display: none;"></span></h4></td>
                                </tr>
                                <tr style="line-height: 30px;">
                                    <th>上传图片：</th>
                                    <td>
                                        <div id="headImage">

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
                                    </td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td>
                                        <input type="hidden" name="images" id="images"/>
                                        <input type="hidden" name="isTurnMaterialIds" id="isTurnMaterialIds"/>

                                        <div id="chekImage">
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!-- /.panel-body -->

                    <%-- 隐藏的图片区域 --%>
                    <div id="tempDiv" style="display:none;float: left; height: 180px;width: 200px;margin-right:6px;">
                        <img id="picSrc" alt="" src="" style="height: 170px;width: 200px;">
                    </div>

                    <div class="panel-footer">
                        <div class="row">
                            <div class="col-lg-12" style="text-align: center;">
                                <button type="button" id="save" class="btn btn-primary">保存</button>
                                <a href="backend/goods/index" class="btn btn-primary" style="color: white;"
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
                // 页面加载时，自动加载分类信息
                this_.fn.getTagList();
                //页面加载时，自动加载类型列表
                this_.fn.getStyleAndSpaceTag();
                //点击保存按钮，执行表单提交方法
                $("#save").click(function () {
                    this_.fn.save();
                });
                this_.fn.dropperInit();
                $("#removeImg").click(function () {
                    this_.fn.clearImageView();
                });
            },
            insertImage: function (imgURL) {
                var tempDiv = $("#tempDiv").clone();
                tempDiv.css("display", "block");
                tempDiv.children(":first").prop("src", imgURL);
                tempDiv.insertBefore("#lastImageDiv");
            },
            getTagList: function () {
                $bluemobi.ajax("backend/utils/kindTag/list", null, function (result) {
                    if (null != result) {
                        // 获取返回的分类列表信息，并循环绑定到label中
                        var content = "";
                        jQuery.each(result, function (i, item) {
                            content += "<option value='" + item.id + "'>" + item.name + "</option>";
                        });
                        $('#tagList').append(content);
                        $("#tagList").val($("#kti").val());
                    } else {
                        $bluemobi.notify("获取分类信息失败", "error");
                    }
                });
            },
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

                var jsonImage = eval('${jsonImage}');
                for (var ig in jsonImage) {
                    var item = jsonImage[ig];
                    addImage1(item.image, item.isHead, item.isTurnMaterial);
                    n++;
                }
            },
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
                var kingTag = $("#tagList").val();
                $("#spaceTagIds").val(spaceTagIds);
                $("#styleTagIds").val(styleTagIds);

                var a = new Array();
                var brstr = "";

                var c = "";
                $('.imageC').each(function () {
                    var b = "";
                    brstr = $(this).attr("value");
                    b += brstr;
                    b += ",";
                    a.push(b);

                });
                c = a.join("");
                $("#images").val(c);

                //isTurnMaterial
                var obj = document.getElementsByName('isTurnMaterial');
                var s = '';
                for (var i = 0; i < obj.length; i++) {
                    if (obj[i].checked) s += obj[i].value + ',';
                }
                $("#isTurnMaterialIds").val(s);

                $("#form").ajaxSubmit({
                    dataType: "json",
                    success: function (result) {
                        this_.fn.responseComplete(result, true);
                    }
                });
            },
            remove: function (_this) {
                $(_this).parent().remove();
            },
            responseComplete: function (result, action) {
                if (result.status == "0") {
                    window.location.href = _basePath + "/backend/goods/index";
                } else {
                    $bluemobi.notify(result.msg, "error");
                }
            },
            bhFun: function () {
                //标签选项显示处理
                var trHeight = document.getElementById('trh').clientHeight;
                document.getElementById("bh").style.height = (trHeight - 20) + "px";
                document.getElementById("bh").style.width = "100%";

                var trHeight1 = document.getElementById('trh1').clientHeight;
                document.getElementById("bh1").style.height = (trHeight - 20) + "px";
                document.getElementById("bh1").style.width = "100%";
            },
            clearImageView: function () {
                $("#image").val("");
                $("#headImage").find(".image_show").html("");
                $("#headImage").find(".image_handle").show();
                $("#headImage").find(".dropper-input").val("");
                clearInterval(timeCode);
            },
            viewImage: function (image) {
                if (image) {
                    $("#headImage").find(".dropper-input").val("");
                    $("#headImage").find(".image_handle").hide();
                    $("#headImage").find(".image_show").show();
                    $("#image").val(image);
                    $("#headImage").find(".image_show").html("<img src='" + image + "' class='img-responsive' >");
                    timeCode = setInterval("this_.fn.clearImageView()", 300);
                    addImage();
                    n++;
                }
            },
            dropperInit: function () {
                $("#headImage" + " .dropped").dropper({
                    postKey: "file",
                    action: "backend/utils/saveImage",
                    postData: {thumbSizes: '480x320'},
                    label: "把文件拖拽到此处"
                }).on("fileComplete.dropper", this_.fn.onFileComplete)
                        .on("fileError.dropper", this_.fn.onFileError);
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
            }
        }
    }

    var ryimId = 999999;
    function addImage() {
        var imageUrl = $(".img-responsive").prop("src");
        var image = $("#image").val();
        var $div = $("#chekImage");
        var $span = $("<span id='" + ryimId + "'></span>");
        $span.appendTo($div);
        var $img = $("<img style='height: 30px;width: 30px;' src='" + imageUrl + "' />");
        $img.appendTo($span);
        var $input = $("<input type='hidden' class='imageC' value='" + image + "'/>");
        $input.appendTo($span);
        var $input1;
        if (n != 1) {
            $input1 = $("<input style='margin-left:90px;' type='radio' id='cover' name='cover' value='" + image + "'/>");
        } else {
            $input1 = $("<input style='margin-left:90px;' type='radio' id='cover' name='cover' value='" + image + "' checked/>");
        }
        $input1.appendTo($span);
        var $lable1 = $("<lable>设为封面</lable>");
        $lable1.appendTo($span);
        var $input2 = $("<input type='checkbox' style='margin-left:15px;' name='isTurnMaterial' checked value='" + image + "'/>");
        $input2.appendTo($span);
        var $lable2 = $("<lable>转为素材</lable>");
        $lable2.appendTo($span);
        var $li = $("<i style='margin-left:30px;cursor: pointer;' class='fa fa-times' onclick='removeHtml(" + ryimId + ")'></i>");
        $li.appendTo($span);
        var $br = $("<br />");
        $br.appendTo($span);
        redChecked();
        ryimId += 1;
    }

    function addImage1(image, isHead, isTurnMaterial) {
        var $div = $("#chekImage");
        var $span = $("<span id='" + ryimId + "'></span>");
        $span.appendTo($div);
        var $img = $("<img style='height: 30px;width: 30px;' src='" + image + "' />");
        $img.appendTo($span);
        var $input = $("<input type='hidden' class='imageC' value='" + image + "'/>");
        $input.appendTo($span);
        var $input1;
        if (isHead == 'no') {
            $input1 = $("<input style='margin-left:90px;' type='radio' id='cover' name='cover' value='" + image + "'/>");
        } else if (isHead == 'yes') {
            $input1 = $("<input style='margin-left:90px;' type='radio' id='cover' name='cover' value='" + image + "' checked/>");
        } else {
            $input1 = $("<input style='margin-left:90px;' type='radio' id='cover' name='cover' value='" + image + "'/>");
        }
        $input1.appendTo($span);
        var $lable1 = $("<lable>设为封面</lable>");
        $lable1.appendTo($span);
        var $input2;
        if (isTurnMaterial == 'yes') {
            $input2 = $("<input type='checkbox' style='margin-left:15px;' name='isTurnMaterial' checked value='" + image + "'/>");
        }
        if (isTurnMaterial == 'no') {
            $input2 = $("<input type='checkbox' style='margin-left:15px;' name='isTurnMaterial' value='" + image + "'/>");
        }
        $input2.appendTo($span);
        var $lable2 = $("<lable>转为素材</lable>");
        $lable2.appendTo($span);
        var $li = $("<i style='margin-left:30px;cursor: pointer;' class='fa fa-times' onclick='removeHtml(" + ryimId + ")'></i>");
        $li.appendTo($span);
        var $br = $("<br />");
        $br.appendTo($span);
        ryimId += 1;
    }

    function removeHtml(imgId) {
        var idObject = document.getElementById(imgId);
        var $idObject = $(idObject);
        var path = $idObject.find("img").prop("src");
        $.ajax({
                    url: "backend/utils/deleteImage",
                    data: {
                        path: path
                    }
                }
        );
        if (idObject != null)
            idObject.parentNode.removeChild(idObject);
        redChecked();
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

    //默认选中第一张图片为封面
    function redChecked() {
        var $sSpan = $("#chekImage").parent().find("span").eq(0);
        if ($sSpan.html() != null && $sSpan.html() != 'undefined') {
            var $input = $sSpan.parent().find("input").eq(1);
            $input.prop("checked", true);
        }
    }

    $(document).ready(function () {
        this_.fn.init();
    });

</script>

</html>