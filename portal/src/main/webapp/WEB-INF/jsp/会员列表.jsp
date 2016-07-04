<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="inc/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="inc/meta.jsp" %>
    <meta name="description" content="">
    <meta name="author" content="">
    <title>会员列表</title>
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
                <h1 class="page-header">会员列表</h1>
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
                                    <label>呢称：</label><input type="text" id="nickname" class="form-control input-sm"/>
                                </div>
                                <div class="form-group">
                                    <label>账号：</label><input type="text" id="account" class="form-control input-sm"/>
                                </div>
                                <div class="form-group">
                                    <button type="button" id="c_search" class="btn btn-info btn-sm">搜索</button>
                                </div>
                            </form>
                            <p></p>
                            <a href="javascript:void(0)" id="batchNo" class="btn btn-outline btn-danger btn-lg"
                               role="button">批量禁用</a>
                            <a href="javascript:void(0)" id="batchYes" class="btn btn-outline btn-success btn-lg"
                               role="button">批量启用</a>
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
                                    <col class="gradeA odd"/>
                                    <col class="gradeA even"/>
                                    <col class="gradeA odd"/>
                                </colgroup>
                                <thead>
                                <tr>
                                    <th><input type="checkbox" onclick="$bluemobi.checkAll(this)" class="checkall"/>
                                    </th>
                                    <th>ID</th>
                                    <th>呢称</th>
                                    <th>账号</th>
                                    <th>联系方式</th>
                                    <th>是否推荐</th>
                                    <th>粉丝数</th>
                                    <th>状态</th>
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

    var user_ = {
        v: {
            id: "user_",
            list: [],
            dTable: null
        },
        fn: {
            init: function () {
                user_.fn.dataTableInit();

                $("#c_search").click(function () {
                    var ID = $('#ID').val();
                    var reg = new RegExp("^[0-9]*$");
                    if(!reg.test(ID)){
                        $bluemobi.notify("ID必须为纯数字", "error");
                        return;
                    }
                    user_.fn.search();
                });

                $("#batchYes").click(function () {
                    var checkBox = $("#dataTables tbody tr").find('input[type=checkbox]:checked');
                    var ids = checkBox.getInputId();
                    user_.fn.batchChangeStatus(ids, "enable", "启用");
                });

                $("#batchNo").click(function () {
                    var checkBox = $("#dataTables tbody tr").find('input[type=checkbox]:checked');
                    var ids = checkBox.getInputId();
                    user_.fn.batchChangeStatus(ids, "disable", "禁用");
                });
            },
            //搜索
            search: function () {
                user_.v.dTable.ajax.reload();
                $(":checkbox").removeAttr("checked");
            },
            dataTableInit: function () {
                user_.v.dTable = $bluemobi.dataTable($('#dataTables'), {
                    "processing": true,
                    "serverSide": true,
                    "searching": false,
                    "ordering": false,
                    "ajax": {
                        "url": "backend/user/list",
                        "type": "POST"
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "id"},
                        {"data": "nickname"},
                        {"data": "account"},
                        {"data": "mobile"},
                        {"data": "isRecommend"},
                        {"data": "fans"},
                        {"data": "status"},
                        {"data": ""}
                    ],
                    "columnDefs": [{
                        "data": null,
                        "defaultContent": "<button type='button' title='推荐' class='btn btn-success btn-circle edit'>" + "<i class='fa fa-check-circle-o tuiJan'></i>" + "</button>" + "&nbsp;&nbsp;" + "<button type='button' title='编辑' class='btn btn-primary btn-circle shows'>" + "<i class='fa fa-edit'></i>" + "</button>" + "&nbsp;&nbsp;" + "<button type='button' title='禁用' class='btn btn-circle delete'>" + "<i class='fa fa-undo deleteStatus'></i>" + "</button>",
                        "targets": -1
                    }],
                    "createdRow": function (row, data, index) {
                        user_.v.list.push(data);
                        $('td', row).eq(0).html("<input type='checkbox' value=" + data.id + ">");
                    },
                    rowCallback: function (row, data) {
                        if (data.status == "enable") {
                            $('td', row).eq(7).html("启用");
                            $('td', row).last().find(".delete").addClass("btn-danger");
                            $('td', row).last().find(".delete").attr("title", "禁用");
                        } else {
                            $('td', row).eq(7).html("禁用");
                            $('td', row).last().find(".delete").addClass("btn-success");
                            $('td', row).last().find(".delete").attr("title", "启用");
                        }

                        //渲染样式
                        if (data.isRecommend == "yes") {
                            $('td', row).eq(5).html("已推荐");
                            $('td', row).last().find(".edit").addClass("btn-danger");
                            $('td', row).last().find(".edit").attr("title", "取消推荐");
                            $('td', row).last().find(".tuiJan").removeClass().addClass("fa fa-ban");
                        } else {
                            $('td', row).eq(5).html("未推荐");
                            $('td', row).last().find(".edit").addClass("btn-success");
                            $('td', row).last().find(".edit").attr("title", "推荐");
                            $('td', row).last().find(".tuiJan").removeClass().addClass("fa fa-check-circle-o");
                        }

                        //查看/编辑操作
                        $('td', row).last().find(".shows").click(function () {
                            location.href = _basePath + "backend/user/shows?id=" + data.id;
                        });

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
                            user_.fn.changeRecommend(data.id, status, msg);
                        });

                        // 单个用户启用/禁用操作
                        $('td', row).last().find(".delete").click(function () {
                            var msg = "";
                            var status = "";
                            if (data.status == "enable") {
                                msg = "禁用";
                                status = "disable";
                            } else {
                                msg = "启用";
                                status = "enable";
                            }
                            user_.fn.changeStatus(data.id, status, msg);
                        });
                    },
                    "fnServerParams": function (aoData) {
                        aoData.id = $("#ID").val();
                        aoData.nickname = $("#nickname").val();
                        aoData.account = $("#account").val();
                    },
                    "fnDrawCallback": function (row) {
                        $bluemobi.uiform();
                    }
                });
            },
            changeRecommend: function (id, status, msg) {
                $bluemobi.optNotify(function () {
                    $bluemobi.ajax("backend/user/changeRecommend", {
                        id: id,
                        isRecommend: status
                    }, function (result) {
                        if (result.status == "0") {
                            $bluemobi.notify(result.msg, "success");
                            user_.v.dTable.ajax.reload();
                        } else {
                            $bluemobi.notify(result.msg, "error");
                        }
                    });
                }, "确定" + msg + "该用户么？", "确定");
            },
            changeStatus: function (id, status, msg) {
                $bluemobi.optNotify(function () {
                    $bluemobi.ajax("backend/user/changeStatus", {
                        id: id,
                        status: status
                    }, function (result) {
                        if (result.status == "0") {
                            $bluemobi.notify(result.msg, "success");
                            user_.v.dTable.ajax.reload();
                        } else {
                            $bluemobi.notify(result.msg, "error");
                        }
                    });
                }, "确定" + msg + "该用户么？", "确定");
            },
            batchChangeStatus: function (ids, txt, msg) {
                if (ids.length > 0) {
                    $bluemobi.optNotify(function () {
                        $bluemobi.ajax("backend/user/batchChangeStatus", {
                            ids: JSON.stringify(ids),
                            status: txt
                        }, function (result) {
                            if (result.status == "0") {
                                $bluemobi.notify("批量" + msg + "成功", "success");
                            } else {
                                $bluemobi.notify("批量" + msg + "失败", "error");
                            }
                            user_.v.dTable.ajax.reload();
                            $(":checkbox").removeAttr("checked");
                        })
                    }, "确认将选中项批量" + msg + "？", "确定");
                }
            }
        }
    }

    $(document).ready(function () {
        user_.fn.init();
    });

</script>

</html>