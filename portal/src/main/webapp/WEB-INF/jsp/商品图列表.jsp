<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="inc/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="inc/meta.jsp" %>
    <meta name="description" content="">
    <meta name="author" content="">
    <title>商品图片表</title>
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
                <h1 class="page-header">商品图片表</h1>
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
                                <div class="form-group">
                                    <label style="width: 10px;"></label>
                                </div>
                                <div class="form-group">
                                    <label>名称：</label><input type="text" id="goodsName" class="form-control input-sm"/>
                                </div>
                                <div class="form-group">
                                    <label style="width: 10px;"></label>
                                </div>
                                <div class="form-group" style="width: 140px;">
                                    <label style="width:33%;">分类：</label><select id="tagList" name="tagList"
                                                                                 style="width: 67%;"
                                                                                 class="form-control"></select>
                                </div>
                                <div class="form-group">
                                    <label style="width: 10px;"></label>
                                </div>
                                <div class="form-group" style="width: 180px;">
                                    <label style="width:40%;">风格分类：</label><select
                                        id="styleList" name="styleList"
                                        style="width: 60%;"
                                        class="form-control"></select>
                                </div>
                                <div class="form-group">
                                    <label style="width: 10px;"></label>
                                </div>
                                <div class="form-group" style="width: 180px;">
                                    <label style="width:40%;">空间分类：</label><select
                                        id="spaceList" name="spaceList"
                                        style="width: 60%;"
                                        class="form-control"></select>
                                </div>
                                <br/>
                                <br/>

                                <div class="form-group" style="width: 170px;">
                                    <label style="width:30%;">状态：</label><select id="isPass" name="isPass"
                                                                                 style="width: 70%;"
                                                                                 class="form-control">
                                    <option value=''>全部</option>
                                    <option value='init'>待审核</option>
                                    <option value='yes'>审核通过</option>
                                    <option value='no'>审核不通过</option>
                                </select>
                                </div>
                                <div class="form-group">
                                    <label style="width: 10px;"></label>
                                </div>
                                <div class="form-group">
                                    <button type="button" id="c_search" class="btn btn-info btn-sm">搜索</button>
                                </div>
                            </form>

                            <p></p>
                            <a href="javascript:void(0)" id="new" class="btn btn-outline btn-primary btn-lg"
                               role="button">添加商品图
                            </a>
                            <a href="javascript:void(0)" id="batchDel" class="btn btn-outline btn-danger btn-lg"
                               role="button">批量删除</a>
                            <a href="javascript:void(0)" id="batchImp" class="btn btn-outline btn-primary btn-lg"
                               role="button">批量导入</a>
                        </div>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="dataTables">
                                <colgroup>
                                    <col class="gradeA odd" style="width: 5%;"/>
                                    <col class="gradeA even"/>
                                    <col class="gradeA odd" style="width: 15%;"/>
                                    <col class="gradeA even" style="width: 10%;"/>
                                    <col class="gradeA odd"/>
                                    <col class="gradeA even" style="width: 11%;"/>
                                    <col class="gradeA odd" style="width: 9%;"/>
                                    <col class="gradeA even" style="width: 6%;"/>
                                    <col class="gradeA odd" style="width: 9%;"/>
                                    <col class="gradeA odd" style="width: 5%;"/>
                                    <col class="gradeA odd" style="width: 5%;"/>
                                    <col class="gradeA odd" style="width: 5%;"/>
                                    <col class="gradeA odd" style="width: 5%;"/>
                                    <col class="gradeA even" style="width: 20%;"/>
                                </colgroup>
                                <thead>
                                <tr>
                                    <th><input type="checkbox" onclick="$bluemobi.checkAll(this)" class="checkall"/>
                                    </th>
                                    <th>ID</th>
                                    <th>图片名称</th>
                                    <th>发布者账号</th>
                                    <th>发布者</th>
                                    <th>风格种类</th>
                                    <th>空间种类</th>
                                    <th>类别</th>
                                    <th>状态</th>
                                    <th>点击</th>
                                    <th>收藏</th>
                                    <th>点赞</th>
                                    <th>推荐状态</th>
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
</div>
<!-- /#wrapper -->

<%@ include file="inc/footer.jsp" %>
</body>

<script type="text/javascript">

    //审核通过操作按钮
    var passYes = "<button type='button' title='审核通过' class='btn btn-success btn-circle passYes'>" + "<i class='fa fa-check'></i>" + "</button>" + "&nbsp;&nbsp;";
    //审核不通过操作按钮
    var passNo = "<button type='button' title='审核不通过' class='btn btn-danger btn-circle passNo'>" + "<i class='fa fa-times'></i>" + "</button>" + "&nbsp;&nbsp;";
    //默认显示查看和编辑，删除按钮
    var dfl = "<button type='button' title='推荐' class='btn btn-success btn-circle edit'>" + "<i class='fa fa-check-circle-o tuiJan'></i>" + "</button>" + "&nbsp;&nbsp;" + "<button type='button' title='查看' class='btn btn-primary btn-circle shows'>" + "<i class='fa fa-eye'></i>" + "</button>" + "&nbsp;&nbsp;" + "<button type='button' title='编辑商品图' class='btn btn-primary btn-circle updataGoods'>" + "<i class='fa fa-edit'></i>" + "</button>" + "&nbsp;&nbsp;" + "<button type='button' title='删除' class='btn btn-danger btn-circle delete'>" + "<i class='fa fa-trash-o'></i>" + "</button>";

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

                $("#new").click(function () {
                    location.href = _basePath + "backend/goods/saveUI";
                });

                this_.fn.dataTableInit();

                $("#c_search").click(function () {
                    this_.fn.search();
                });

                $("#batchDel").click(function () {
                    var checkBox = $("#dataTables tbody tr").find('input[type=checkbox]:checked');
                    var ids = checkBox.getInputId();
                    this_.fn.batchDeleteUser(ids);
                });

                $("#batchImp").click(function () {
                    window.location.href = _basePath + "backend/goods/batchImportUI";
                });

            },
            //搜索
            search: function () {
                this_.v.dTable.ajax.reload();
                $(":checkbox").removeAttr("checked");
            },
            dataTableInit: function () {
                var showButton = "";
                this_.v.dTable = $bluemobi.dataTable($('#dataTables'), {
                    "processing": true,
                    "serverSide": true,
                    "searching": false,
                    "ordering": false,
                    "ajax": {
                        "url": "backend/goods/list",
                        "type": "POST"
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "id"},
                        {"data": "name"},
                        {"data": "user.account"},
                        {"data": "user.nickname"},
                        {"data": "styleTagName"},
                        {"data": "spaceTagName"},
                        {"data": "kindTagName"},
                        {"data": "isPass"},
                        {"data": "seeNum"},
                        {"data": "collectionNum"},
                        {"data": "praiseNum"},
                        {"data": "isRecommend"},
                        {"data": ""}
                    ],
                    "columnDefs": [{
                        "data": null,
                        "defaultContent": "",
                        "targets": -1
                    }],
                    "createdRow": function (row, data) {
                        $('td', row).eq(0).html("<input type='checkbox' value=" + data.id + ">");
                    },
                    rowCallback: function (row, data) {
                        if (data.isPass == 'yes') {
                            $('td', row).eq(8).html('审核通过');
                            $('td', row).eq(13).html(dfl);
                        } else if (data.isPass == 'no') {
                            $('td', row).eq(8).html('审核不通过');
                            $('td', row).eq(13).html(passYes + dfl);
                        } else if (data.isPass == 'init') {
                            $('td', row).eq(8).html('待审核');
                            $('td', row).eq(13).html(passYes + passNo + dfl);
                        }
                        //渲染样式
                        if (data.isRecommend == "yes") {
                            $('td', row).last().find(".edit").addClass("btn-danger");
                            $('td', row).last().find(".edit").attr("title", "取消推荐");
                            $('td', row).last().find(".tuiJan").removeClass().addClass("fa fa-ban");
                            $('td', row).eq(12).html("已推荐");
                        } else {
                            $('td', row).last().find(".edit").addClass("btn-success");
                            $('td', row).last().find(".edit").attr("title", "推荐");
                            $('td', row).last().find(".tuiJan").removeClass().addClass("fa fa-check-circle-o");
                            $('td', row).eq(12).html("未推荐");
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
                        //查看操作
                        $('td', row).last().find(".shows").click(function () {
                            location.href = _basePath + "backend/goods/shows?id=" + data.id;
                        });

                        //编辑操作
                        $('td', row).last().find(".updataGoods").click(function () {
                            location.href = _basePath + "backend/goods/updataUI?id=" + data.id;
                        });

                        //审核通过操作
                        $('td', row).last().find(".passYes").click(function () {
                            this_.fn.examineYes(data.id);
                        });

                        //审核不通过操作
                        $('td', row).last().find(".passNo").click(function () {
                            this_.fn.examineNo(data.id);
                        });

                        // 单个用户删除操作
                        $('td', row).last().find(".delete").click(function () {
                            this_.fn.deleteUser(data.id);
                        });
                    },
                    "fnServerParams": function (aoData) {
                        aoData.id = $("#ID").val();
                        aoData.goodsName = $("#goodsName").val();
                        aoData.kindTagId = $("#tagList").val();
                        aoData.styleId = $("#styleList").val();
                        aoData.spaceId = $("#spaceList").val();
                        aoData.isPass = $("#isPass").val();
                    },
                    "fnDrawCallback": function (row) {
                        $bluemobi.uiform();
                    }
                });
            },
            changeRecommend: function (id, status, msg) {
                $bluemobi.optNotify(function () {
                    $bluemobi.ajax("backend/goods/changeRecommend", {
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
                }, "确定" + msg + "这个商品图么？", "确定");
            },
            deleteUser: function (id) {
                $bluemobi.optNotify(function () {
                    $bluemobi.ajax("backend/goods/delete", {
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
            },
            examineYes: function (id) {
                $bluemobi.optNotify(function () {
                    $bluemobi.ajax("backend/goods/examineYes", {
                        id: id
                    }, function (result) {
                        if (result.status == "0") {
                            $bluemobi.notify(result.msg, "success");
                            this_.v.dTable.ajax.reload();
                        } else {
                            $bluemobi.notify(result.msg, "error");
                        }
                    });
                }, "确定审核通过该商品图么？", "确定");
            },
            examineNo: function (id) {
                $bluemobi.optNotify(function () {
                    $bluemobi.ajax("backend/goods/examineNo", {
                        id: id
                    }, function (result) {
                        if (result.status == "0") {
                            $bluemobi.notify(result.msg, "success");
                            this_.v.dTable.ajax.reload();
                        } else {
                            $bluemobi.notify(result.msg, "error");
                        }
                    });
                }, "确定审核不通过该商品图么？", "确定");
            },
            batchDeleteUser: function (ids) {
                if (ids.length > 0) {
                    $bluemobi.optNotify(function () {
                        $bluemobi.ajax("backend/goods/deletes", {
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
            },
            getTagList: function () {
                $bluemobi.ajax("backend/utils/kindTag/list", null, function (result) {
                    if (null != result) {
                        // 获取返回的分类列表信息，并循环绑定到label中
                        var content = "<option value=''>全部</option>";
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
            }
        }
    }

    $(document).ready(function () {
        this_.fn.init();
    });

</script>

</html>