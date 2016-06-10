<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="inc/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="inc/meta.jsp" %>
    <meta name="description" content="">
    <meta name="author" content="">
    <title>添加资讯</title>
    <%@ include file="inc/css.jsp" %>
    <link href="static/js/plugins/dropper/jquery.fs.dropper.css" rel="stylesheet">
    <script src="static/js/plugins/dropper/jquery.fs.dropper.js"></script>
    <script src="static/layer-v2.3/layer/layer.js"></script>
</head>

<body>

<div id="posts" class="wrapper">

    <%@ include file="inc/nav.jsp" %>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">添加资讯</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4>资讯信息</h4>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <!-- 资讯信息 -->
                        <form id="messageForm" method="post" enctype="multipart/form-data">
                            <table border="0" style="width: 90%; line-height: 40px; margin-left: 8%;">
                                <tr>
                                    <th style="width: 12%;">标题：</th>
                                    <td><input type="text" class="form-control" name="title" maxlength="25"
                                               data-rule="required;" style="width: 60%;"/></td>
                                </tr>
                                <tr>
                                    <th>文章栏目：</th>
                                    <td><select id="tagId" name="tagId" style="width: 20%;"
                                                class="form-control"></select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>排序：</th>
                                    <td><input type="text" class="form-control" name="showTurn" maxlength="11"
                                               data-rule="required;integer;" style="width: 20%;"/></td>
                                </tr>
                                <!-- 场景图 -->
                                <tr>
                                    <th>封面图片：</th>
                                    <td>
                                        <div id="headImage" class="form-group img_tooltip">
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
                                            <div class="col-sm-5">
                                                <a href="javascript:void(0)" id="removeImg" class="btn btn-info"
                                                   role="button">删除图片</a>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                              <tr>
                                    <th>资讯简介：</th>
                                    <td>
                                        <textarea class="form-control" name="subContent" maxlength="100" data-rule="required;"
                                                  style="resize: none;margin-top: 10px;margin-bottom: 10px;" ></textarea></td>
                                </tr>
                                <tr>
                                    <th>简介图片：</th>
                                    <td>
                                        <div id="bodyImage" class="form-group img_tooltip">
                                            <div class="col-sm-5" style="padding-left: 0px;">
                                                <input type="hidden" id="intro_image" name="intro_image" value="">

                                                <div class="image_show" style="display: none">

                                                </div>
                                                <div class="image_handle_intro" data-toggle="tooltip" data-placement="top"
                                                     title=""
                                                     data-original-title="建议上传宽480px高320px的图片">
                                                    <div class="dropped"></div>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <a href="javascript:void(0)" id="removeIntro_img" class="btn btn-info"
                                                   role="button">删除图片</a>
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <th>添加标签：</th>
                                    <td>
                                        <div id="tagBase" class="form-inline" style="z-index: 1000">
                                            <div class="form-group">
                                                <span id="tags" name="tags" data-rule="required"></span>
                                                <input type="hidden" id="tagsxxx" value="" />
                                            </div>
                                            <div class="form-group">
                                                <input id="tempTagInfo" type="text" class="form-control">
                                            </div>
                                            <button type="button" class="btn btn-default"
                                                    onclick="message_.fn.addInfo()">添加
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>资讯内容：</th>
                                    <td>
                                        <!-- 加载编辑器的容器 -->
                                        <script id="container" name="content" type="text/plain"
                                                style="width:100%; height:150px; line-height: 0px;"></script>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!-- /.panel-body -->

                    <!-- 隐藏标签Span -->
                    <span id="tagSpan" style="display: none;"></span>

                    <div class="panel-footer">
                        <div class="row">
                            <div class="col-lg-12" style="text-align: center;">
                                <a href="javascript:void(0)" id="subMessageForm" class="btn btn-primary"
                                   style="color: white;"
                                   role="button">发布</a>
                                &nbsp;&nbsp;
                                <a href="backend/message/index" class="btn btn-primary" style="color: white;"
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
    var message_ = {
        v: {
            id: "message_"
        },
        fn: {
            init: function () {
                //图片即时预览
                $("#add_img1").uploadPreview({
                    Img: "picture",
                    Width: 150,
                    Height: 120
                });
                $("#add_img2").uploadPreview({
                    Img: "picture_intro",
                    Width: 130,
                    Height: 100
                });


                $('#add_img1').change(function () {
                    $('#pic').val('0');
                    $('#picMsgBox').html('');
                });
                $('#add_img2').change(function () {
                    $('#pic').val('0');
                    $('#picMsgBox').html('');
                });

                message_.fn.dropperInit();
                message_.fn.dropperInit_intro();
                $("#removeImg").click(function () {
                    message_.fn.clearImageView();
                });


                $('#headImage').children(':first').children(':first').next().next().children(':first').children(':first').next().css('display', 'none');
                $("#removeIntro_img").click(function () {
                    message_.fn.clearImageView_intro();
                })
                $('#bodyImage').children(':first').children(':first').next().next().children(':first').children(':first').next().css('display', 'none');

                // 页面加载时，自动加载栏目列表信息
                message_.fn.getTagList();

                // 提交表单
                $('#subMessageForm').click(function () {
                    message_.fn.save();
                });
            },
            AddImg: function () {
                // a标签绑定onclick事件
                $('#add_img1').click();
                $("#add_img2").click();
            },
            addInfo: function () {
                // 点击在输入框前面添加标签
                var tempTag = $('#tempTagInfo').val();
                var tags = $('#tagBase').children(":first").children(":first");
                if (tempTag.length == 0) {
                    $bluemobi.notify("标签信息不能为空", "error");
                    return;
                }
                if (($("#tagsxxx").val() + "").trim().length > 16) {
                    $bluemobi.notify("标签内容过长", "error");
                    $('#tempTagInfo').val('');
                    return;
                }

                tags.html(tags.html() + tempTag +' <a onclick="message_.fn.removeInfo(&quot;'+tempTag+'&quot;)">X</a>'+',');
                $("#tagsxxx").val($("#tagsxxx").val() + tempTag + ',');
            },
            removeInfo:function(tempTag){
                var tags = $('#tagBase').children(":first").children(":first");
                tags.html(tags.html().replace(tempTag +' <a onclick="message_.fn.removeInfo(&quot;'+tempTag+'&quot;)">X</a>'+',',""));
                var lastValue = $("#tagsxxx").val().replace(tempTag+",","");
                $("#tagsxxx").val(lastValue);
            },
            getTagList: function () {
                $bluemobi.ajax("backend/utils/messageTag/list", null, function (result) {
                    if (null != result) {
                        // 获取返回的分类列表信息，并循环绑定到label中
                        var content = "";
                        jQuery.each(result, function (i, item) {
                            content += "<option value='" + item.id + "'>" + item.name + "</option>";
                        });
                        $('#tagId').append(content);
                    } else {
                        $bluemobi.notify("获取分类信息失败", "error");
                    }
                });
            },
            clearImageView: function () {
                var path = $("#ssimgid").prop("src");
                $("#image").val("");
                $("#headImage").find(".image_show").html("");
                $("#headImage").find(".image_handle").show();
                $("#headImage").find(".dropper-input").val("");


            },
            clearImageView_intro: function () {
                var path_intro = $("#ssimgid_intro").prop("src");
                $("#intro_image").val("");
                $("#bodyImage").find(".image_show").html("");
                $("#bodyImage").find(".image_handle_intro").show();
                $("#bodyImage").find(".dropper-input").val("");

            },
            viewImage: function (image) {
                if (image) {
                    $("#headImage").find(".dropper-input").val("");
                    $("#headImage").find(".image_handle").hide();
                    $("#headImage").find(".image_show").show();
                    $("#image").val(image);
                    $("#headImage").find(".image_show").html("<img id='ssimgid' src='" + image + "' class='img-responsive' >");
                }
            },
            viewImageTointro: function (image) {
                if (image) {
                    $("#bodyImage").find(".dropper-input").val("");
                    $("#bodyImage").find(".image_handle_intro").hide();
                    $("#bodyImage").find(".image_show").show();
                    $("#intro_image").val(image);
                    $("#bodyImage").find(".image_show").html("<img id='ssimgid_intro' src='" + image + "' class='img-responsive' >");
                }
            },
            dropperInit: function () {
                $("#headImage" + " .dropped").dropper({
                    postKey: "file",
                    action: "backend/utils/saveImage",
                    postData: {thumbSizes: '480x320'},
                    label: "把文件拖拽到此处",
                    maxSize: 1048576
                }).on("fileComplete.dropper", message_.fn.onFileComplete)
                        .on("fileError.dropper", message_.fn.onFileError);
            },
            dropperInit_intro: function () {
                $("#bodyImage" + " .dropped").dropper({
                    postKey: "file",
                    action: "backend/utils/saveImage",
                    postData: {thumbSizes: '480x320'},
                    label: "把文件拖拽到此处",
                    maxSize: 1048576
                }).on("fileComplete.dropper", message_.fn.onFileCompleteTointro)
                        .on("fileError.dropper", message_.fn.onFileError);
            },
            onFileComplete: function (e, file, response) {
                if (response != '' && response != null) {
                    message_.fn.viewImage(response);
                } else {
                    $bluemobi.notify("抱歉上传失败", "error");
                }
            },
            onFileCompleteTointro: function (e, file, response) {
                if (response != '' && response != null) {
                    message_.fn.viewImageTointro(response);
                } else {
                    $bluemobi.notify("抱歉上传失败", "error");
                }
            },
            onFileError: function (e, file, error) {
                $bluemobi.notify(error, "error");
            },
            save: function () {
                var flag = true;

                if (!$('#messageForm').isValid()) {
                    flag = false;
                    return;
                }

                var tags = $('#tagBase').children(":first").children(":first");
                if ((tags.html() + "").trim().length == 0) {
                    $bluemobi.notify("标签不能为空", "error");
                    flag = false;
                    return;
                }

                //获取纯文本内容
                var txt = editor1.getContentTxt();
                if (txt.length > 100) {
                    txt = txt.substring(0, 100);
                }
                // 所有的验证通过后，执行修改操作
                if (flag) {
                    $("#messageForm").ajaxSubmit({
                        url: _basePath + "backend/message/addMessageInfo",
                        dataType: "json",
                        data: {
                            tags: $('#tagsxxx').val(),
                            content: txt
                        },
                        success: function (result) {
                            if (result.status == 0) {
                                window.location.href = _basePath + "backend/message/index";
                            } else {
                                $bluemobi.notify(result.msg, "error");
                            }
                        }
                    });
                }
            }
        }
    }

    $(document).ready(function () {
        message_.fn.init();
    });

</script>

<!-- 配置文件 -->
<script type="text/javascript" src="ueditor1_4_3/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="ueditor1_4_3/ueditor.all.js"></script>
<!-- 实例化编辑器 -->
<script type="text/javascript">
    var editor1 = new baidu.editor.ui.Editor();
    editor1.render('container');
    editor1.ready(function () {

    });
    editor1.addListener( 'contentChange', function( editor ) {
        //imageIsReady();
    });

    function imageIsReady(){
        console.log("imageIsReady")
        var content = editor1.getContent();
        if(content.indexOf("正在上传") >= 0){
            setTimeout("imageIsReady()", 1000);
        }else{
            if(content.indexOf("121.40.54.152") >= 0){
                $("#ueditor_0").contents().find("body").find("img").each(function(){
                    if($(this).attr("src").indexOf("121.40.54.152") >= 0){
                        uploadUeditorImageToQiniu($(this));
                    }
                });
            }
        }
    }

    function uploadUeditorImageToQiniu($img){
        console.log("uploadUeditorImageToQiniu")
        $.ajax({
            type: 'POST',
            url: 'pc/upload/uploadUeditorImageToQiniu',
            data: {path:$img.attr("src")},
            async: false,
            dataType: 'json',
            success: function (data) {
                if (data.status=="0") {
                    $img.attr("src",data.data);
                } else {
                    $bluemobi.notify(data.msg, "error");
                }
            },
            error: function (err) {
                $bluemobi.notify("系统异常，请刷新页面后重试！", "error");
            }
        });
    }
</script>

</html>