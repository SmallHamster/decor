<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="inc/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="inc/meta.jsp" %>
    <meta name="description" content="">
    <meta name="author" content="">
    <title>素材图片表</title>
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
</head>

<body>

<div id="posts" class="wrapper">

    <%@ include file="inc/nav.jsp" %>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">素材图片表</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div>
                            <form class="form-inline">
                                <div class="form-group">
                                    <label>ID：</label><input type="text" id="ID" class="form-control input-sm"/>
                                </div>
                                <div class="form-group" style="width: 200px;">
                                    <label style="width:50%;">&nbsp;&nbsp;&nbsp;&nbsp;风格分类：</label><select
                                        id="styleList" name="styleList"
                                        style="width: 50%;"
                                        class="form-control"></select>
                                </div>
                                <div class="form-group" style="width: 200px;">
                                    <label style="width:50%;">&nbsp;&nbsp;&nbsp;&nbsp;空间分类：</label><select
                                        id="spaceList" name="spaceList"
                                        style="width: 50%;"
                                        class="form-control"></select>
                                </div>
                                <div class="form-group" style="width: 180px;">
                                    <label style="width:33%;">&nbsp;&nbsp;&nbsp;&nbsp;分类：</label><select id="flList"
                                                                                                         name="flList"
                                                                                                         style="width: 67%;"
                                                                                                         class="form-control"></select>
                                </div>
                                <div class="form-group">
                                    <button type="button" id="c_search" class="btn btn-info btn-sm">搜索</button>
                                </div>
                            </form>
                            <p></p>
                            <%--<a href="javascript:void(0)" id="new" class="btn btn-outline btn-primary btn-lg"
                               role="button">上传素材
                            </a>--%>
                            <a href="javascript:void(0)" id="batchDel" class="btn btn-outline btn-danger btn-lg"
                               role="button">批量删除</a>
                        </div>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="dataTables">
                                <colgroup>
                                    <col class="gradeA odd"/>
                                    <col class="gradeA even"/>
                                    <col class="gradeA odd"/>
                                    <col class="gradeA even"/>
                                    <col class="gradeA odd" style="width: 16%;"/>
                                    <col class="gradeA even" style="width: 11%;"/>
                                    <col class="gradeA odd" style="width: 11%;"/>
                                    <col class="gradeA even"/>
                                    <col class="gradeA odd" style="width: 17%;"/>
                                </colgroup>
                                <thead>
                                <tr>
                                    <th><input type="checkbox" onclick="$bluemobi.checkAll(this)" class="checkall"/>
                                    </th>
                                    <th>ID</th>
                                    <th>发布账号</th>
                                    <th>发布者</th>
                                    <th>发布时间</th>
                                    <th>风格种类</th>
                                    <th>空间种类</th>
                                    <th>图片种类</th>
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
                            <form id="form1" method="post" action="backend/material/save" class="form-horizontal"
                                  role="form">
                                <input type="hidden" name="goodsImageId" id="goodsImageId"/>

                                <div class="form-group" id="xs" style="display: none;">
                                    <label class="col-sm-2 control-label">图片种类:</label>

                                    <div class="col-sm-5">
                                        <label id="kindTag1" class="control-label"></label>
                                    </div>
                                </div>

                                <div class="form-group" id="xs1" style="display:none;">
                                    <label class="col-sm-2 control-label">图片风格:</label>

                                    <div class="col-sm-5">
                                        <label id="styleTag1" class="control-label"></label>
                                    </div>
                                </div>

                                <div class="form-group" id="xs2" style="display:none;">
                                    <label class="col-sm-2 control-label">空间分类:</label>

                                    <div class="col-sm-5">
                                        <label id="spaceTag1" class="control-label"></label>
                                    </div>
                                </div>

                                <div class="form-group" id="bxs1">
                                    <label class="col-sm-2 control-label">图片种类:</label>
                                    <select id="tagList" name="kingTag" style="width: 30%"
                                            class="form-control">
                                    </select>
                                </div>
                                <div class="form-group" id="bxs2">
                                    <label class="col-sm-2 control-label">风格标签:</label>
                                    <input type="hidden" id="styleTagIds" name="styleTagIds"/>

                                    <div class="col-sm-5" style="padding-left: 0px;">
                                        <div class="panel panel-default">
                                            <div class="panel-body selectedbox" id="selectedbox">

                                            </div>

                                            <div class="initbox">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" id="bxs3">
                                    <label class="col-sm-2 control-label">空间标签:</label>
                                    <input type="hidden" id="spaceTagIds" name="spaceTagIds"/>

                                    <div class="col-sm-5" style="padding-left: 0px;">
                                        <div class="panel panel-default">
                                            <div class="panel-body selectedbox1" id="selectedbox1">

                                            </div>

                                            <div class="initbox1">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="headImage" class="form-group img_tooltip">
                                    <label for="image" class="col-sm-2 control-label">素材图片:</label>

                                    <div class="col-sm-5" style="padding-left: 0px;">
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
                            </form>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <button type="button" id="save" class="btn btn-primary">保存</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal end -->

            <!-- updateMaterialModal -->
            <div class="modal fade" id="updateMaterialModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title"></h4>
                        </div>
                        <div class="modal-body ">
                            <form id="form2" method="post" action="backend/material/updata" class="form-horizontal"
                                  role="form">
                                <input type="hidden" name="updateMaterialId" id="updateMaterialId"/>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">图片种类:</label>
                                    <select id="tagList1" name="kingTag" style="width: 30%"
                                            class="form-control">
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">风格标签:</label>
                                    <input type="hidden" id="styleTagIds1" name="styleTagIds"/>

                                    <div class="col-sm-5" style="padding-left: 0px;">
                                        <div class="panel panel-default">
                                            <div class="panel-body selectedbox2" id="selectedbox2">

                                            </div>

                                            <div class="upInitbox">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">空间标签:</label>
                                    <input type="hidden" id="spaceTagIds1" name="spaceTagIds"/>

                                    <div class="col-sm-5" style="padding-left: 0px;">
                                        <div class="panel panel-default">
                                            <div class="panel-body selectedbox3" id="selectedbox3">

                                            </div>

                                            <div class="upInitbox1">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="headImage1" class="form-group img_tooltip">
                                    <label for="image1" class="col-sm-2 control-label">素材图片:</label>

                                    <div class="col-sm-5" style="padding-left: 0px;">
                                        <input type="hidden" id="image1" name="image"/>

                                        <div class="image_show" style="display: none">

                                        </div>
                                        <div class="image_handle" data-toggle="tooltip" data-placement="top" title=""
                                             data-original-title="建议上传宽480px高320px的图片">
                                            <div class="dropped"></div>
                                        </div>
                                    </div>
                                    <div class="col-sm-5">
                                        <a href="javascript:void(0)" id="removeImg1" class="btn btn-info" role="button">删除图片</a>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <button type="button" id="update" class="btn btn-primary">保存</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- updateMaterialModal end -->

            <!-- goodsImgModal -->
            <div class="modal fade" id="goodsImgModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title"></h4>
                        </div>
                        <div class="modal-body ">
                            <form method="post" action="#" class="form-horizontal"
                                  role="form">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label"></label>

                                    <div>
                                        <img id="goodsImg" alt="" src="" style="height: 340px;width: 400px;">
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- goodsImgModal end -->

            <!-- materialModal -->
            <div class="modal fade" id="materialModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title"></h4>
                        </div>
                        <div class="modal-body ">

                            <form method="post" action="#" class="form-horizontal"
                                  role="form">

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">图片种类:</label>

                                    <div class="col-sm-5">
                                        <label id="kindTag" class="control-label"></label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">图片风格:</label>

                                    <div class="col-sm-5">
                                        <label id="styleTag" class="control-label"></label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">空间分类:</label>

                                    <div class="col-sm-5">
                                        <label id="spaceTag" class="control-label"></label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">图片:</label>

                                    <div class="col-sm-5">
                                        <img id="materialImg" alt="" src=""
                                             style="height: 204px;width: 240px;padding-left: 0px;">
                                    </div>
                                </div>
                            </form>

                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- materialModal end -->

        </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<%@ include file="inc/footer.jsp" %>
</body>

<script type="text/javascript">

    //有商品图时的按钮,没有时不显示
    var showGoodsImg = "<button type='button' title='查看商品图' class='btn btn-warning btn-circle showGoodsImg'>" + "<i class='fa fa-eye'></i>" + "</button>" + "&nbsp;&nbsp;";
    //有素材时的按钮,查看素材
    var showMaterialImg = "<button type='button' title='查看素材图' class='btn btn-primary btn-circle showMaterialImg'>" + "<i class='fa fa-eye'></i>" + "</button>" + "&nbsp;&nbsp;";
    //有素材时的按钮,编辑素材
    var updateMaterialImg = "<button type='button' title='编辑素材图' class='btn btn-primary btn-circle updataMaterialImg'>" + "<i class='fa fa-edit'></i>" + "</button>" + "&nbsp;&nbsp;";
    //没素材时的按钮,上传素材
    var upLoadMaterialImg = "<button type='button' title='上传素材图' class='btn btn-success btn-circle upLoadMaterialImg'>" + "<i class='fa fa-upload'></i>" + "</button>" + "&nbsp;&nbsp;";
    //默认显示删除按钮
    var dfl = "<button type='button' title='删除' class='btn btn-danger btn-circle delete'>" + "<i class='fa fa-trash-o'></i>" + "</button>";

    var this_ = {
        v: {
            id: "this_",
            list: [],
            dTable: null
        },
        fn: {
            init: function () {

                // 页面加载时，自动加载分类信息
                this_.fn.getTagList();

                //页面加载时，自动加载类型列表
                this_.fn.getStyleAndSpaceTag();

                $("#new").click(function () {
                    xs(1);
                    this_.fn.showModal("上传素材");
                });

                this_.fn.dataTableInit();

                $("#c_search").click(function () {
                    this_.fn.search();
                });

                //点击保存按钮，执行表单提交方法
                $("#save").click(function () {
                    this_.fn.save();
                })

                //点击确定按钮，执行表单提交方法
                $("#update").click(function () {
                    this_.fn.updata();
                })

                this_.fn.dropperInit();
                $("#removeImg").click(function () {
                    this_.fn.clearImageViewAndDelete();
                })

                this_.fn.dropperInit1();
                $("#removeImg1").click(function () {
                    this_.fn.clearImageViewAndDelete1();
                })

                $("#batchDel").click(function () {
                    var checkBox = $("#dataTables tbody tr").find('input[type=checkbox]:checked');
                    var ids = checkBox.getInputId();
                    this_.fn.batchDeleteUser(ids);
                });
            },
            //搜索
            search: function () {
                this_.v.dTable.ajax.reload();
                $(":checkbox").removeAttr("checked");
            },
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
            },
            clearImageView: function () {
                $("#image").val("");
                $("#headImage").find(".image_show").html("");
                $("#headImage").find(".image_handle").show();
                $("#headImage").find(".dropper-input").val("");
            },
            viewImage: function (image) {
                if (image) {
                    $("#headImage").find(".dropper-input").val("");
                    $("#headImage").find(".image_handle").hide();
                    $("#headImage").find(".image_show").show();
                    $("#image").val(image);
                    $("#headImage").find(".image_show").html("<img id='ssimgid' src='" + image + "' class='img-responsive' >");
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
            clearImageViewAndDelete1: function () {
                var path = $("#ssimgid1").prop("src");
                $.ajax({
                            url: "backend/utils/deleteImage",
                            data: {
                                path: path
                            }
                        }
                );
                $("#image1").val("");
                $("#headImage1").find(".image_show").html("");
                $("#headImage1").find(".image_handle").show();
                $("#headImage1").find(".dropper-input").val("");
            },
            clearImageView1: function () {
                $("#image1").val("");
                $("#headImage1").find(".image_show").html("");
                $("#headImage1").find(".image_handle").show();
                $("#headImage1").find(".dropper-input").val("");
            },
            viewImage1: function (image) {
                if (image) {
                    $("#headImage1").find(".dropper-input").val("");
                    $("#headImage1").find(".image_handle").hide();
                    $("#headImage1").find(".image_show").show();
                    $("#image1").val(image);
                    $("#headImage1").find(".image_show").html("<img id='ssimgid1' src='" + image + "' class='img-responsive' >");
                }
            }
            ,
            dropperInit1: function () {
                $("#headImage1" + " .dropped").dropper({
                    postKey: "file",
                    action: "backend/utils/saveImage",
                    postData: {thumbSizes: '480x320'},
                    label: "把文件拖拽到此处"
                }).on("fileComplete.dropper", this_.fn.onFileComplete1)
                        .on("fileError.dropper", this_.fn.onFileError1);
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
            ,
            onFileComplete1: function (e, file, response) {
                if (response != '' && response != null) {
                    this_.fn.viewImage1(response);
                } else {
                    $bluemobi.notify("抱歉上传失败", "error");
                }
            }
            ,
            onFileError1: function (e, file, error) {
                $bluemobi.notify(error, "error");
            }
            ,
            dataTableInit: function () {
                this_.v.dTable = $bluemobi.dataTable($('#dataTables'), {
                    "processing": true,
                    "serverSide": true,
                    "searching": false,
                    "ordering": false,
                    "ajax": {
                        "url": "backend/material/list",
                        "type": "POST"
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "id"},
                        {"data": "id"},
                        {"data": "id"},
                        {"data": "id"},
                        {"data": "id"},
                        {"data": "id"},
                        {"data": "id"},
                        {"data": ""}
                    ],
                    "columnDefs": [{
                        "data": null,
                        "defaultContent": "",
                        "targets": -1
                    }],
                    "createdRow": function (row, data) {
                        $('td', row).eq(0).html("<input type='checkbox' value=" + data.id + ">");
                        if (data.material == null) {
                            $('td', row).eq(2).html("" + data.goods.user.account + "");
                            if (data.goods.user.nickname == null) {
                                $('td', row).eq(3).html("   ");
                            } else {
                                $('td', row).eq(3).html("" + data.goods.user.nickname + "");
                            }
                            $('td', row).eq(4).html("--");
                            $('td', row).eq(5).html("" + data.goods.styleTagName + "");
                            $('td', row).eq(6).html("" + data.goods.spaceTagName + "");
                            $('td', row).eq(7).html("" + data.goods.kindTagName + "");
                            $('td', row).eq(8).html(showGoodsImg + upLoadMaterialImg + dfl);
                        } else {
                            if (data.goods == null) {
                                $('td', row).eq(8).html(showMaterialImg + updateMaterialImg + dfl);
                            } else {
                                $('td', row).eq(8).html(showGoodsImg + showMaterialImg + updateMaterialImg + dfl);
                            }
                            $('td', row).eq(2).html("" + data.material.user.account + "");
                            if (data.material.user.nickname == null) {
                                $('td', row).eq(3).html("   ");
                            } else {
                                $('td', row).eq(3).html("" + data.material.user.nickname + "");
                            }
                            $('td', row).eq(4).html("" + data.material.createTime + "");
                            $('td', row).eq(5).html("" + data.material.styleTag + "");
                            $('td', row).eq(6).html("" + data.material.spaceTag + "");
                            $('td', row).eq(7).html("" + data.material.kindTagName + "");
                        }
                    },
                    rowCallback: function (row, data) {
                        //查看商品图操作
                        $('td', row).last().find(".showGoodsImg").click(function () {
                            $("#goodsImg").prop('src', data.image);
                            this_.fn.showGoodsImg("查看商品图片");
                        });

                        //上传素材操作
                        $('td', row).last().find(".upLoadMaterialImg").click(function () {

                            $("#kindTag1").html(data.goods.kindTagName);

                            var htStName = data.goods.styleTagName;
                            var stName = "";
                            for (var i = 0; i < htStName.length; i++) {
                                stName = stName + htStName[i] + "    ";
                            }
                            $("#styleTag1").html(stName);

                            var htSpName = data.goods.spaceTagName;
                            var spName = "";
                            for (var i = 0; i < htSpName.length; i++) {
                                spName = spName + htSpName[i] + "    ";
                            }
                            $("#spaceTag1").html(spName);

                            xs(0);
                            this_.fn.showModal("上传商品素材");
                            $("#goodsImageId").val(data.id);
                        });

                        //查看素材图操作
                        $('td', row).last().find(".showMaterialImg").click(function () {
                            $("#materialImg").prop('src', data.material.image);
                            $("#kindTag").html(data.material.kindTagName);

                            var htStName = data.material.styleTagName;
                            var stName = "";
                            for (var i = 0; i < htStName.length; i++) {
                                stName = stName + htStName[i] + "    ";
                            }
                            $("#styleTag").html(stName);

                            $("#spaceTag").html("<lable class='control-label'>" + stName + "</lable>");
                            var htSpName = data.material.spaceTagName;
                            var spName = "";
                            for (var i = 0; i < htSpName.length; i++) {
                                spName = spName + htSpName[i] + "    ";
                            }
                            $("#spaceTag").html(spName);

                            this_.fn.showMaterialImg("查看素材图片");
                        });

                        //编辑素材图
                        $('td', row).last().find(".updataMaterialImg").click(function () {
                            this_.fn.clearImageView1();
                            $bluemobi.clearForm($("#updateMaterialModal"));
                            $("#updateMaterialId").val(data.material.id);
                            $("#tagList1").val(data.material.kindTagId);

                            //初始化标签
                            addTag(data.material.styleTagMap, "selectedbox2");
                            addTag(data.material.spaceTagMap, "selectedbox3");

                            //初始化视图
                            this_.fn.viewImage1(data.material.image);

                            this_.fn.updateMaterialImg("编辑素材图片");
                        });

                        // 单个用户删除操作
                        $('td', row).last().find(".delete").click(function () {
                            this_.fn.deleteUser(data.id);
                        });
                    },
                    "fnServerParams": function (aoData) {
                        aoData.id = $("#ID").val();
                        aoData.styleId = $("#styleList").val();
                        aoData.spaceId = $("#spaceList").val();
                        aoData.tagtagId = $("#flList").val();
                    },
                    "fnDrawCallback": function (row) {
                        $bluemobi.uiform();
                    }
                });
            }
            ,
            deleteUser: function (id) {
                $bluemobi.optNotify(function () {
                    $bluemobi.ajax("backend/material/delete", {
                        id: id
                    }, function (result) {
                        if (result.status == "0") {
                            $bluemobi.notify(result.msg, "success");
                            this_.v.dTable.ajax.reload();
                        } else {
                            $bluemobi.notify(result.msg, "error");
                        }
                    });
                }, "确定删除该商品图么？", "确定");
            }
            ,
            batchDeleteUser: function (ids) {
                if (ids.length > 0) {
                    $bluemobi.optNotify(function () {
                        $bluemobi.ajax("backend/material/deletes", {
                            ids: JSON.stringify(ids)
                        }, function (result) {
                            if (result.status == "0") {
                                $bluemobi.notify(result.msg, "success");
                            } else {
                                $bluemobi.notify(result.msg, "error");
                            }
                            this_.v.dTable.ajax.reload();
                            $(":checkbox").removeAttr("checked");
                        })
                    }, "确认将选中项批量删除？", "确定");
                }
            }
            ,
            getTagList: function () {

                $bluemobi.ajax("backend/utils/kindTag/list", null, function (result) {
                    if (null != result) {
                        // 获取返回的分类列表信息，并循环绑定到label中
                        var content = "<option value=''>全部</option>";
                        jQuery.each(result, function (i, item) {
                            content += "<option value='" + item.id + "'>" + item.name + "</option>";
                        });
                        $('#flList').append(content);
                        $('#tagList').append(content);
                        $('#tagList1').append(content);
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

                $bluemobi.ajax("backend/utils/styleTag/mapList", null, function (result) {
                    //找到父节点
                    var $div = $(".upInitbox");//根据ID找节点
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
                    $(".upInitbox").find(".tag").unbind("click").click(function () {
                        var tagid = $(this).attr("tagid");
                        var tagtype = $(this).attr("tagtype");
                        var len = $(".selectedbox2 [tagid='" + tagid + "'][tagtype='" + tagtype + "']").length;
                        if (len == 0) {
                            var t = $(this).clone();
                            t.find("a").removeClass("none");
                            $(".selectedbox2").append(t);
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

                $bluemobi.ajax("backend/utils/spaceTag/mapList", null, function (result) {
                    //找到父节点
                    var $div = $(".upInitbox1");//根据ID找节点
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
                    $(".upInitbox1").find(".tag").unbind("click").click(function () {
                        var tagid = $(this).attr("tagid");
                        var tagtype = $(this).attr("tagtype");
                        var len = $(".selectedbox3 [tagid='" + tagid + "'][tagtype='" + tagtype + "']").length;
                        if (len == 0) {
                            var t = $(this).clone();
                            t.find("a").removeClass("none");
                            $(".selectedbox3").append(t);
                        }
                    })
                });
            },
            showModal: function (title) {
                this_.fn.clearImageView();
                $("#modal").modal("show");
                $bluemobi.clearForm($("#modal"));
                if (title) {
                    $("#modal .modal-title").text(title);
                }
            },
            showGoodsImg: function (title) {
                $("#goodsImgModal").modal("show");
                $bluemobi.clearForm($("#goodsImgModal"));
                if (title) {
                    $("#goodsImgModal .modal-title").text(title);
                }
            },
            showMaterialImg: function (title) {
                $("#materialModal").modal("show");
                $bluemobi.clearForm($("#materialModal"));
                if (title) {
                    $("#materialModal .modal-title").text(title);
                }
            },
            updateMaterialImg: function (title) {
                $("#updateMaterialModal").modal("show");
                if (title) {
                    $("#updateMaterialModal .modal-title").text(title);
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
                var imgId = $("#image").val();
                var kingTag = $("#tagList").val();

                $("#spaceTagIds").val(spaceTagIds);
                $("#styleTagIds").val(styleTagIds);
                $("#form1").ajaxSubmit({
                    dataType: "json",
                    success: function (result) {
                        this_.fn.responseComplete(result, true);
                    }
                });

                //重置上传素材的Model
                $("#goodsImageId").val();
                this_.fn.clearImageView();
                $("#selectedbox").html("");
                $("#selectedbox1").html("");
            },
            updata: function () {
                if (!$('#form2').isValid()) {
                    return false;
                }
                ;

                //获取空间标签IDs
                var spaceTagIds = "";
                //获取风格标签IDs
                var styleTagIds = "";
                $(".selectedbox2").find(".tag").each(function () {
                    var tagid = $(this).attr("tagid");
                    var tagtype = $(this).attr("tagtype");
                    if (styleTagIds != "") {
                        styleTagIds += ",";
                    }
                    styleTagIds += tagid;

                });

                $(".selectedbox3").find(".tag").each(function () {
                    var tagid = $(this).attr("tagid");
                    var tagtype = $(this).attr("tagtype");
                    if (spaceTagIds != "") {
                        spaceTagIds += ",";
                    }
                    spaceTagIds += tagid;
                });
                //获取图片ID
                var imgId = $("#image").val();
                var kingTag = $("#tagList1").val();

                $("#spaceTagIds1").val(spaceTagIds);
                $("#styleTagIds1").val(styleTagIds);
                $("#form2").ajaxSubmit({
                    dataType: "json",
                    success: function (result) {
                        this_.fn.responseComplete(result, true);
                    }
                });
                $("#updateMaterialModal").modal("hide");
                //重置编辑素材的Model
                //updateMaterialId在失败后不失效，所以不重置
                this_.fn.clearImageView1();
                $("#selectedbox2").html("");
                $("#selectedbox3").html("");
            },
            responseComplete: function (result, action) {
                if (result.status == "0") {
                    if (action) {
                        this_.v.dTable.ajax.reload(null, false);
                    } else {
                        this_.v.dTable.ajax.reload();
                    }

                    $bluemobi.notify(result.msg, "success");
                    $("#modal").modal("hide");
                } else {
                    $bluemobi.notify(result.msg, "error");
                }
            },
            remove: function (_this) {
                $(_this).parent().remove();
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

    //n = 0时隐藏，n=1时显示
    function xs(n) {
        if (n == 0) {
            $("#xs").css({
                display: "block"
            });
            $("#xs1").css({
                display: "block"
            });
            $("#xs2").css({
                display: "block"
            });
            $("#bxs1").css({
                display: "none"
            });
            $("#bxs2").css({
                display: "none"
            });
            $("#bxs3").css({
                display: "none"
            });
        } else if (n == 1) {
            $("#xs").css({
                display: "none"
            });
            $("#xs1").css({
                display: "none"
            });
            $("#xs2").css({
                display: "none"
            });
            $("#bxs1").css({
                display: "block"
            });
            $("#bxs2").css({
                display: "block"
            });
            $("#bxs3").css({
                display: "block"
            });
        }
    }

    $(document).ready(function () {
        this_.fn.init();
    });

</script>

</html>