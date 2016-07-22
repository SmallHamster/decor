<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="inc/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="inc/meta.jsp" %>
    <meta name="description" content="">
    <meta name="author" content="">
    <title>后台首页</title>
    <%@ include file="inc/css.jsp" %>

</head>

<body>

<div id="posts" class="wrapper">

    <%@ include file="inc/nav.jsp" %>

    <div id="page-wrapper" style="padding-top: 30px;">
        <%
            String userControl = (String) session.getAttribute("userControl");
            String goodsControl = (String) session.getAttribute("goodsControl");
            String messageControl = (String) session.getAttribute("messageControl");
        %>
        <input id="userControl" type="hidden" value="<%=userControl %>"/>
        <input id="goodsControl" type="hidden" value="<%=goodsControl %>"/>
        <input id="messageControl" type="hidden" value="<%=messageControl %>"/>

        <!-- 首页资讯模块 -->
        <div class="panel panel-info" id="helloToMain">
            <div class="panel-body">
                <h1 style="text-align: center">欢迎进入Decor后台管理系统</h1>
            </div>
        </div>

        <!-- 首页资讯模块 -->
        <div class="panel panel-info" id="messageToMain" style="display: none">
            <div class="panel-heading">
                <h3 class="panel-title">最新资讯</h3>
            </div>
            <div class="panel-body">
                <input type="hidden" id="messageId" value="${message.id}"/>
                <c:if test="${null != message}">
                    <table border="0" style="width: 100%; line-height: 40px;">
                        <tr>
                            <th style="width: 5%;">&nbsp;标题：</th>
                            <td style="width: 80%">${message.title }</td>
                            <td style="text-align: right">${message.createTime }</td>
                        </tr>
                        <tr>
                            <td colspan="3">${message.subContent}</td>
                        </tr>
                    </table>
                </c:if>
                <c:if test="${null == message}">&nbsp;&nbsp;暂无</c:if>
            </div>
            <div class="panel-footer">
                <div class="row">
                    <div class="col-lg-12" style="text-align: right;">
                        <c:if test="${null != message}">
                            <a href="javascript:void(0)" onclick="this_.fn.showMessage()" class="btn btn-info" style="color: white;" role="button">编辑</a>
                            &nbsp;
                        </c:if>
                        <a href="backend/message/index" class="btn btn-info" style="color: white;"role="button">查看更多</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- 首页用户模块 -->
        <div class="panel panel-primary" id="userToMain" style="display: none">
            <div class="panel-heading">
                <h3 class="panel-title">最新用户</h3>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover" id="dataTables">
                        <colgroup>
                            <col class="gradeA odd"/>
                            <col class="gradeA even"/>
                            <col class="gradeA odd"/>
                            <col class="gradeA even"/>
                            <col class="gradeA odd"/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>呢称</th>
                            <th>账号</th>
                            <th>联系方式</th>
                            <th>注册时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="panel-footer">
                <div class="row">
                    <div class="col-lg-12" style="text-align: right;">
                        <a href="backend/user/index" class="btn btn-primary" style="color: white;"
                           role="button">查看更多</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- 首页商品图模块 -->
        <div class="panel panel-success" id="goodsToMain" style="display: none">
            <div class="panel-heading">
                <h3 class="panel-title">最新商品图</h3>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover" id="dataTables1">
                        <colgroup>
                            <col class="gradeA odd"/>
                            <col class="gradeA even"/>
                            <col class="gradeA odd"/>
                            <col class="gradeA even" style="width: 25%;"/>
                            <col class="gradeA odd"/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>图片名称</th>
                            <th>产品类别</th>
                            <th>发布时间</th>
                            <th>状态</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="panel-footer">
                <div class="row">
                    <div class="col-lg-12" style="text-align: right;">
                        <a href="backend/goods/index" class="btn btn-success" style="color: white;"
                           role="button">查看更多</a>
                    </div>
                </div>
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
            id: "this_",
            list: [],
            dTable: null,
            dTable1: null
        },
        fn: {
            init: function () {
                var userControl = $('#userControl').val();
                var goodsControl = $('#goodsControl').val();
                var messageControl = $('#messageControl').val();

                // 判断是否拥有资讯权限
                if (null != messageControl && messageControl != '' && messageControl == '0') {
                    $('#messageToMain').css({'display': 'block'});
                    $('#helloToMain').css({'display': 'none'});
                }

                // 判断是否拥有会员权限
                if (null != userControl && userControl != '' && userControl == '0') {
                    $('#userToMain').css({'display': 'block'});
                    $('#helloToMain').css({'display': 'none'});
                    this_.fn.dataTableInit();
                    $('#dataTables_length').parent().parent().remove();
                    $('#dataTables_info').parent().parent().remove();
                }

                // 判断是否拥有商品图权限
                if (null != goodsControl && goodsControl != '' && goodsControl == '0') {
                    $('#goodsToMain').css({'display': 'block'});
                    $('#helloToMain').css({'display': 'none'});
                    this_.fn.dataTableInitPlus();
                    $('#dataTables1_length').parent().parent().remove();
                    $('#dataTables1_info').parent().parent().remove();
                }
            },
            showMessage: function () {
                var messageId = $('#messageId').val();

                location.href = _basePath + "backend/message/shows?id=" + messageId;
            },
            // 加载用户列表信息
            dataTableInit: function () {
                this_.v.dTable = $bluemobi.dataTable($('#dataTables'), {
                    "processing": false,
                    "serverSide": true,
                    "searching": false,
                    "ordering": false,
                    "ajax": {
                        "url": "backend/user/listToMain",
                        "type": "POST"
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "nickname"},
                        {"data": "account"},
                        {"data": "mobile"},
                        {"data": "createTime"}
                    ]
                });
            },
            // 加载用户列表信息
            dataTableInitPlus: function () {
                this_.v.dTable1 = $bluemobi.dataTable($('#dataTables1'), {
                    "processing": false,
                    "serverSide": true,
                    "searching": false,
                    "ordering": false,
                    "ajax": {
                        "url": "backend/goods/listToMain",
                        "type": "POST"
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "name"},
                        {"data": "kindTagName"},
                        {"data": "createTime"},
                        {"data": "isPass"}
                    ],
                    rowCallback: function (row, data) {
                        if (data.isPass == 'yes') {
                            $('td', row).eq(4).html('审核通过');
                        } else if (data.isPass == 'no') {
                            $('td', row).eq(4).html('审核不通过');
                        } else if (data.isPass == 'init') {
                            $('td', row).eq(4).html('待审核');
                        }
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