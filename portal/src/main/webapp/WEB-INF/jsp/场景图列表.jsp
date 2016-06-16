<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="inc/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="inc/meta.jsp" %>
    <meta name="description" content="">
    <meta name="author" content="">
    <title>场景图列表</title>
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
        }

        .slh {
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
    </style>
    <script>
        function goodsDetail(id) {
            window.location.href = _basePath + "backend/goods/shows?id=" + id;
        }
    </script>
</head>

<body>

<div id="posts" class="wrapper">

    <%@ include file="inc/nav.jsp" %>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">场景图列表</h1>
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
                                <div class="form-group" style="width: 10px;">
                                </div>
                                <div class="form-group">
                                    <label>名称：</label><input type="text" id="name" class="form-control input-sm"/>
                                </div>
                                <div class="form-group" style="width: 10px;">
                                </div>
                                <div class="form-group">
                                    <label>发布者：</label><input type="text" id="author" class="form-control input-sm"/>
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
                                <br/>
                                <br/>

                                <div class="form-group" style="width: 190px;">
                                    <label style="width:40%;">推荐状态：</label><select id="isRecommend" name="isRecommend"
                                                                                   style="width: 60%;"
                                                                                   class="form-control">
                                    <option value=''>全部</option>
                                    <option value='yes'>已推荐</option>
                                    <option value='no'>未推荐</option>
                                </select>
                                </div>
                                <div class="form-group" style="width: 10px;">
                                </div>
                                <div class="form-group">
                                    <button type="button" id="c_search" class="btn btn-info btn-sm">搜索</button>
                                </div>
                            </form>
                            <p></p>
                            <a href="javascript:void(0)" id="new" class="btn btn-outline btn-primary btn-lg"
                               role="button">添加场景图
                            </a>
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
                                    <col class="gradeA odd" style="width: 18%;"/>
                                    <col class="gradeA even"/>
                                    <col class="gradeA odd"/>
                                    <col class="gradeA even"/>
                                    <col class="gradeA odd"/>
                                </colgroup>
                                <thead>
                                <tr>
                                    <th><input type="checkbox" onclick="$bluemobi.checkAll(this)" class="checkall"/>
                                    </th>
                                    <th>ID</th>
                                    <th>图片名称</th>
                                    <th>发布账户</th>
                                    <th>发布者</th>
                                    <th>创建时间</th>
                                    <th>风格种类</th>
                                    <th>空间种类</th>
                                    <th>推荐状态</th>
                                    <th>点击</th>
                                    <th>收藏</th>
                                    <th>点赞</th>
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
                            <form id="form1" method="post" action="#" class="form-horizontal"
                                  role="form">

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">发布者:</label>

                                    <div class="col-sm-5">
                                        <input type="text" class="form-control" id="nickName"
                                               style="background-color: #ffffff" readonly/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">发布者账号:</label>

                                    <div class="col-sm-5">
                                        <input type="text" class="form-control" id="account"
                                               style="background-color: #ffffff" readonly/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">图片名称:</label>

                                    <div class="col-sm-5">
                                        <input type="text" class="form-control" id="picName"
                                               style="background-color: #ffffff" readonly/>
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
                                    <label class="col-sm-3 control-label">图片介绍:</label>

                                    <div class="col-sm-5">
                                        <input type="text" class="form-control" id="picDescription"
                                               style="background-color: #ffffff" readonly/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">图片:</label>

                                    <div class="col-sm-5">
                                        <img id="img" alt="" src="" style="height: 170px;width: 200px;">
                                    </div>
                                </div>
                                <div class="form-group" id="goodsInfo" style="display: none;">
                                    <hr/>
                                    <h4 style="font-size: 18px;margin: 0px;line-height: 1.42857;font-weight: 500;margin-left: 15px;">
                                        该场景图下商品信息</h4>
                                    <hr/>
                                    <table id="goodsTable"
                                           style="text-align: left;font-size: 16px;font-weight: 400;width: 500px;margin-left: 30px;">
                                        <tr>
                                            <th width="100px" style="text-align: center;"><label>商品图片</label></th>
                                            <th width="400px"><label>商品名称</label></th>
                                        </tr>

                                    </table>
                                </div>
                            </form>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal end -->
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
            id: "this_",
            list: [],
            dTable: null
        },
        fn: {
            init: function () {

                //加载分类标签
                this_.fn.getTagList();

                this_.fn.dataTableInit();

                $("#c_search").click(function () {
                    this_.fn.search();
                });

                $("#batchDel").click(function () {
                    var checkBox = $("#dataTables tbody tr").find('input[type=checkbox]:checked');
                    var ids = checkBox.getInputId();
                    this_.fn.batchDeleteUser(ids);
                });

                $("#new").click(function () {
                    window.location.href = "backend/scene/addSceneUI";
                });
            },
            //搜索
            search: function () {
                this_.v.dTable.ajax.reload();
                $(":checkbox").removeAttr("checked");
            },
            dataTableInit: function () {
                this_.v.dTable = $bluemobi.dataTable($('#dataTables'), {
                    "processing": true,
                    "serverSide": true,
                    "searching": false,
                    "ordering": false,
                    "ajax": {
                        "url": "backend/scene/list",
                        "type": "POST"
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "id"},
                        {"data": "name"},
                        {"data": "user.account"},
                        {"data": "user.nickname"},
                        {"data": "createTime"},
                        {"data": "styleTagName"},
                        {"data": "spaceTagName"},
                        {"data": "isRecommend"},
                        {"data": "seeNum"},
                        {"data": "collectionNum"},
                        {"data": "praiseNum"},
                        {"data": ""}
                    ],
                    "columnDefs": [{
                        "data": null,
                        "defaultContent": "<button type='button' title='推荐' class='btn btn-success btn-circle edit'>" + "<i class='fa fa-check-circle-o tuiJan'></i>" + "</button>" + "&nbsp;&nbsp;" + "<button type='button' title='查看' class='btn btn-primary btn-circle shows'>" + "<i class='fa fa-eye'></i>" + "</button>" + "&nbsp;&nbsp;" + "<button type='button' title='编辑场景图' class='btn btn-primary btn-circle updata'>" + "<i class='fa fa-edit'></i>" + "</button>" + "&nbsp;&nbsp;" + "<button type='button' title='删除' class='btn btn-danger btn-circle delete'>" + "<i class='fa fa-trash-o'></i>" + "</button>",
                        "targets": -1
                    }],
                    "createdRow": function (row, data) {
                        $('td', row).eq(0).html("<input type='checkbox' value=" + data.id + ">");
                    },
                    rowCallback: function (row, data) {
                        //渲染样式
                        if (data.isRecommend == "yes") {
                            $('td', row).last().find(".edit").addClass("btn-danger");
                            $('td', row).last().find(".edit").attr("title", "取消推荐");
                            $('td', row).last().find(".tuiJan").removeClass().addClass("fa fa-ban");
                            $('td', row).eq(8).html("已推荐");
                        } else {
                            $('td', row).last().find(".edit").addClass("btn-success");
                            $('td', row).last().find(".edit").attr("title", "推荐");
                            $('td', row).last().find(".tuiJan").removeClass().addClass("fa fa-check-circle-o");
                            $('td', row).eq(8).html("未推荐");
                        }

                        // 推荐/取消推荐操作
                        $('td', row).last().find(".edit").click(function () {
                            var msg = "";
                            var status = "";
                            if (data.isRecommend == "yes") {
                                msg = "取消推荐";
                                status = "no";
                            } else {
                                msg = "推荐";
                                status = "yes";
                            }
                            this_.fn.changeRecommend(data.id, status, msg);
                        });

                        $('td', row).last().find(".updata").click(function () {
                            //location.href = _basePath + "backend/scene/updataUI?id=" + data.id;
                            window.open(_basePath + "backend/scene/updataUI?id=" + data.id);
                        });
                        
                        //查看操作
                        $('td', row).last().find(".shows").click(function () {
                            this_.fn.showModal("查看场景图");
                            $("#nickName").val(data.user.nickname);
                            $("#account").val(data.user.account);
                            var htStName = data.styleTagName;
                            var stName = "";
                            for (var i = 0; i < htStName.length; i++) {
                                stName = stName + htStName[i] + "    ";
                            }
                            $("#styleTag").html(stName);

                            $("#spaceTag").html("<lable class='control-label'>" + stName + "</lable>");
                            var htSpName = data.spaceTagName;
                            var spName = "";
                            for (var i = 0; i < htSpName.length; i++) {
                                spName = spName + htSpName[i] + "    ";
                            }
                            $("#spaceTag").html(spName);
                            $("#picName").val(data.name);
                            $("#picDescription").val(data.info);
                            $("#img").prop('src', data.image);

                            //初始化商品信息列表
                            $(".zszszs").each(function () {
                                $(this).remove();
                            });
                            if (data.goodsMaps.length == 0) {
                                $("#goodsInfo").css({
                                    display: "none"
                                });
                            } else {
                                $("#goodsInfo").css({
                                    display: "block"
                                });
                                //选中表格
                                var $table = $("#goodsTable");
                                for (var i = 0; i < data.goodsMaps.length; i++) {
                                    var goods = data.goodsMaps[i];
                                    var $tr = $("<tr class='zszszs'></tr>");
                                    $tr.appendTo($table);
                                    var $td = $("<td align='center'></td>");
                                    $td.appendTo($tr);
                                    var $img = $("<img style='width: 30px;height: 30px;cursor: pointer;' src='" + goods.goodsPath + "' onclick='goodsDetail(" + goods.goodsId + ")'/>");
                                    $img.appendTo($td);
                                    var $td1 = $("<td></td>");
                                    $td1.appendTo($tr);
                                    var $lable = $("<label class='slh' style='width: 400px;font-size: 14px;line-height: 40px;margin:0px;'>" + goods.goodsName + "</lable>");
                                    $lable.appendTo($td1);
                                }
                            }
                        });

                        // 单个用户删除操作
                        $('td', row).last().find(".delete").click(function () {
                            this_.fn.deleteUser(data.id);
                        });
                    },
                    "fnServerParams": function (aoData) {
                        aoData.id = $("#ID").val();
                        aoData.name = $("#name").val();
                        aoData.author = $("#author").val();
                        aoData.isRecommend = $("#isRecommend").val();
                        aoData.styleId = $("#styleList").val();
                        aoData.spaceId = $("#spaceList").val();
                    },
                    "fnDrawCallback": function (row) {
                        $bluemobi.uiform();
                    }
                });
            },
            changeRecommend: function (id, status, msg) {
                $bluemobi.optNotify(function () {
                    $bluemobi.ajax("backend/scene/changeRecommend", {
                        id: id,
                        isRecommend: status
                    }, function (result) {
                        if (result.status == "0") {
                            $bluemobi.notify(result.msg, "success");
                            this_.v.dTable.ajax.reload();
                        } else {
                            $bluemobi.notify(result.msg, "error");
                        }
                    });
                }, "确定" + msg + "这个场景图么？", "确定");
            },
            deleteUser: function (id) {
                $bluemobi.optNotify(function () {
                    $bluemobi.ajax("backend/scene/delete", {
                        id: id
                    }, function (result) {
                        if (result.status == "0") {
                            $bluemobi.notify(result.msg, "success");
                            this_.v.dTable.ajax.reload();
                        } else {
                            $bluemobi.notify(result.msg, "error");
                        }
                    });
                }, "如果该场景图应用到了素材图，会把该场景图关联的素材图一起删除，确定删除么？", "确定");
            },
            batchDeleteUser: function (ids) {
                if (ids.length > 0) {
                    $bluemobi.optNotify(function () {
                        $bluemobi.ajax("backend/scene/deletes", {
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
                    }, "如果该场景图应用到了素材图，会把该场景图关联的素材图一起删除，确定删除选中的批量项么？", "确定");
                }
            },
            showModal: function (title) {
                $("#modal").modal("show");
                $bluemobi.clearForm($("#modal"));
                if (title) {
                    $("#modal .modal-title").text(title);
                }
            },
            getTagList: function () {

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
        }
    }

    $(document).ready(function () {
        this_.fn.init();
    });

</script>

</html>