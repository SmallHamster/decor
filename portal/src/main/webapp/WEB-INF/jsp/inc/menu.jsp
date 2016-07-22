<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var url = _basePath + "backend/utils/home/list";
        $.ajax({
            url: url,
            type: 'GET',
            dataType: 'json',
            async: false,
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    var item = data[i];
                    var zItems = item.zMaps;
                    var $ul = $("#side-menu");
                    var $li = $("<li></li>");
                    $li.appendTo($ul);
                    var $a = $("<a href='#'></a>");
                    $a.appendTo($li);
                    var $i = $("<i class='" + item.style + "'></i>");
                    $i.appendTo($a);
                    var $lable = $("<lable>" + item.name + "</lable>");
                    $lable.appendTo($a);
                    var $span = $("<span class='fa arrow'></span>");
                    $span.appendTo($a);

                    if (zItems.length > 0) {
                        var $ul1 = $("<ul class='nav nav-second-level'></ul>");
                        $ul1.appendTo($li);
                    }

                    for (var j = 0; j < zItems.length; j++) {
                        var zItem = zItems[j];
                        var $li1 = $("<li></li>");
                        $li1.appendTo($ul1);
                        var $a1 = $("<a href='" + zItem.url + "'></a>");
                        $a1.appendTo($li1);
                        var $i1 = $("<i class='" + zItem.style + "'></i>");
                        $i1.appendTo($a1);
                        var $lable1 = $("<lable>" + zItem.name + "</lable>");
                        $lable1.appendTo($a1);
                    }
                }
            }
        });

        // 修改diss类的父级li样式
        $('.diss').parent().parent().css('display', 'none');
    });
</script>
<div class="navbar-default sidebar" role="navigation">
    <div class="sidebar-nav navbar-collapse">
        <ul class="nav" id="side-menu">
            <li>
                <a href="backend/home"><i class="fa fa-home fa-fw"></i>首页</a>
            </li>
        </ul>
    </div>
    <!-- /.sidebar-collapse -->
</div>
<!-- /.navbar-static-side -->

