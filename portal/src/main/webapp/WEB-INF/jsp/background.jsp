<%--
Created by IntelliJ IDEA.
User: gaoll
Date: 2015/3/3
Time: 11:58
To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="inc/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="inc/meta.jsp" %>
    <meta name="description" content="">
    <meta name="author" content="">
    <title>背景图管理</title>
    <%@ include file="inc/css.jsp" %>
    <link href="static/js/plugins/dropper/jquery.fs.dropper.css" rel="stylesheet">
    <script src="static/js/plugins/dropper/jquery.fs.dropper.js"></script>

</head>

<body>

<div id="posts" class="wrapper">

    <%@ include file="inc/nav.jsp" %>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">背景图管理</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="btn-group pull-left">
                            <a href="javascript:void(0)" id="new" class="btn btn-outline btn-primary btn-lg"
                               role="button">新增</a>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="dataTables">
                                <colgroup>
                                    <col class="gradeA odd"/>
                                    <col class="gradeA even"/>
                                </colgroup>
                                <thead>
                                <tr>
                                    <th>图片</th>
                                    <th>是否推荐</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <!-- /.panel-body -->

                </div>
                <!-- /.panel -->
            </div>
        </div>


    </div>
    <!-- /#page-wrapper -->

    <!-- Modal -->
    <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="modalLabel">操作</h4>
                </div>
                <div class="modal-body ">
                    <form id="form" method="post" action="backend/background/save" class="form-horizontal"
                          role="form">
                        <input type="hidden" id="id" name="id" value="">

                        <div id="adImage" class="form-group img_tooltip">
                            <label for="image" class="col-sm-2 control-label">背景图片</label>

                            <div class="col-sm-5">
                                <input type="hidden" id="image" name="image" value="">

                                <div class="image_show" style="display: none">

                                </div>
                                <div class="image_handle" data-toggle="tooltip" data-placement="top" title=""
                                     data-original-title="建议上传宽480px高320px的图片">
                                    <div class="dropped"></div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <a href="javascript:void(0)" id="removeImg" class="btn btn-info" role="button">删除图片</a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">是否推荐</label>
                            <div class="col-sm-5">
                                <input type="radio" name="status" value="1" checked/>推荐
                                <input type="radio" name="status" value="0" />不推荐
                            </div>
                        </div>

                    </form>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" id="save" class="btn btn-primary">保存</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- Modal end -->

</div>
<!-- /#wrapper -->

<%@ include file="inc/footer.jsp" %>
</body>

<script type="text/javascript">

    var background_ = {
        v: {
            id: "background_",
            list: [],
            dTable: null
        },
        fn: {
            init: function () {

                $("#new").click(function () {
                    background_.fn.showModal("新增");
                });

                //点击保存按钮，执行表单提交方法
                $("#save").click(function () {
                    background_.fn.save();
                });

                background_.fn.dataTableInit();


                background_.fn.dropperInit();
                $("#removeImg").click(function () {
                    background_.fn.clearImageViewAndDelete();
                })

            },
            clearImageViewAndDelete: function () {
                var path = $("#ssimgid").prop("src");
                $("#image").val("");
                $("#adImage").find(".image_show").html("");
                $("#adImage").find(".image_handle").show();
                $("#adImage").find(".dropper-input").val("");
            },
            clearImageView: function () {
                $("#image").val("");
                $("#adImage").find(".image_show").html("");
                $("#adImage").find(".image_handle").show();
                $("#adImage").find(".dropper-input").val("");
            },
            viewImage: function (image) {
                if (image) {
                    $("#adImage").find(".dropper-input").val("");
                    $("#adImage").find(".image_handle").hide();
                    $("#adImage").find(".image_show").show();
                    $("#image").val(image);
                    $("#adImage").find(".image_show").html("<img id='ssimgid' src='" + image + "' class='img-responsive' >");
                }
            },
            dropperInit: function () {
                $("#adImage" + " .dropped").dropper({
                    postKey: "file",
                    action: "backend/utils/saveImage",
                    postData: {thumbSizes: '480x320'},
                    label: "把文件拖拽到此处"
                }).on("fileComplete.dropper", background_.fn.onFileComplete)
                        .on("fileError.dropper", background_.fn.onFileError);
            },
            onFileComplete: function (e, file, response) {
                background_.fn.viewImage(response);
            },
            onFileError: function (e, file, error) {
                $bluemobi.notify(error, "error");
            },
            dataTableInit: function () {
                background_.v.dTable = $bluemobi.dataTable($('#dataTables'), {
                    "processing": true,
                    "serverSide": true,
                    "searching": false,
                    "ordering": false,
                    "ajax": {
                        "url": "backend/background/list",
                        "type": "POST"
                    },
                    "columns": [
                        {"data": "image"},
                        {"data": "status"},
                        {"data": ""}
                    ],
                    "columnDefs": [
                        {
                            "data": null,
                            "defaultContent": "",
                            "targets": -1
                        }
                    ],
                    "createdRow": function (row, data, index) {
                        background_.v.list.push(data);

                        var img = '<img src="' + data.image + '" width="30" height="30">';
                        $('td', row).eq(0).html(img);

                        var option = "<button type='button'  title='修改 ' class='btn btn-primary btn-circle edit'>" +
                                "<i class='fa fa-edit'></i>" +
                                "</button>"
                                + "&nbsp;" +
                                "<button type='button'  title='删除' class='btn btn-danger btn-circle delete'>" +
                                "<i class='fa fa-bitbucket'></i>" +
                                "</button>";
                        $('td', row).last().html(option);
                    },
                    rowCallback: function (row, data) {
                        var items = background_.v.list;
                        $('td', row).last().find(".edit").click(function () {
                            background_.fn.edit(data.id);
                        });
                        $('td', row).last().find(".delete").click(function () {
                            background_.fn.deleteRow(data.id);
                        });
                    },
                    "fnServerParams": function (aoData) {
                    },
                    "fnDrawCallback": function (row) {
                        $bluemobi.uiform();
                    }
                });
            },
            deleteRow: function (id) {
                $bluemobi.optNotify(function () {
                    $bluemobi.ajax("backend/ad/delete", {id: id}, function (result) {
                        if (result.status == "0") {
                            $bluemobi.notify(result.msg, "success");
                            background_.v.dTable.ajax.reload();
                        } else {
                            $bluemobi.notify(result.msg, "error");
                        }
                    })
                });
            },
            edit: function (id) {
                background_.fn.showModal("修改");
                var items = background_.v.list;
                $.each(items, function (index, item) {
                    if (item.id == id) {
                        for (var key in item) {
                            var element = $("#form :input[name=" + key + "]")
                            if (element.length > 0) {
                                element.val(item[key]);
                            }
                            if (key == "image") {
                                background_.fn.viewImage(item[key]);
                            }
                        }
                    }
                })
            },
            save: function () {
                if (!$('#form').isValid()) {
                    return false;
                }
                $("#form").ajaxSubmit({
                    dataType: "json",
                    success: function (result) {
                        background_.fn.responseComplete(result, true);
                    }
                })

            },
            responseComplete: function (result, action) {
                if (result.status == "0") {
                    if (action) {
                        background_.v.dTable.ajax.reload(null, false);
                    } else {
                        background_.v.dTable.ajax.reload();
                    }

                    $bluemobi.notify(result.msg, "success");
                    $("#modal").modal("hide");
                } else {
                    $bluemobi.notify(result.msg, "error");
                }
            },
            showModal: function (title) {
                $("#modal").modal("show");
                $bluemobi.clearForm($("#modal"));
                background_.fn.clearImageView();
                $("#id").val("");
                if (title) {
                    $("#modal .modal-title").text(title);
                }
            }
        }
    }

    $(document).ready(function () {
        background_.fn.init();
    });

</script>


</html>