<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="pagination">
    <a class="disabled first"></a>

    <a class="last"></a>
    <span class="p_text totalpage">共<span class="totalPage"></span>页， 到第</span>
    <input class="gotopage" type="text"/> 页
    <input type="button" class="confirm" value="确定"/>
</div>


<script type="text/javascript">
    // 分页对象
    var rpage = {
        totalNum: 0,
        totalPage: 0,
        currentPage: 1,
        pageNum: 1, // 查询参数
        pageSize: 10, // 查询参数
        queryFun: null, // 查询方法
        init: function (page, funName) {
            rpage.queryFun = eval(funName); // 查询方法
            rpage.totalNum = page.totalNum;
            rpage.currentPage = page.currentPage;
            rpage.totalPage = page.totalPage;
            $(".pagination").find(".totalPage").html(rpage.totalPage); // 显示总页数
            $(".pagination").find(".gotopage").val(rpage.currentPage);

            // 分页页码处理
            var html = '';
            // 总页数<=10
            if (rpage.totalPage <= 0) {
                $(".pagination").css('display', 'none');
            } else if (rpage.totalPage <= 10) {
                // 总页数<=10
                for (var i = 1; i <= rpage.totalPage; i++) {
                    html += '<a class="mid">' + i + '</a>';
                }
                $(".pagination").css('display', '');
            } else {
                // 总页数>10   拼接成  123...45...1213
                // 1
                html += '<a class="mid">1</a>';
                // ...和当前页之间
                if (rpage.currentPage - 1 > 4) {
                    html += '<span class="dots mid">...</span>'
                    for (var j = rpage.currentPage - 3; j < rpage.currentPage; j++) {
                        html += '<a class="mid">' + j + '</a>';
                    }
                } else {
                    for (var j = 2; j < rpage.currentPage; j++) {
                        html += '<a class="mid">' + j + '</a>';
                    }
                }
                // 当前页
                if (rpage.currentPage != 1) {
                    html += '<a class="mid">' + rpage.currentPage + '</a>';
                }
                // 当前页和第2个...之间
                if (rpage.totalPage - rpage.currentPage > 4) {
                    for (var j = rpage.currentPage + 1; j <= rpage.currentPage + 3; j++) {
                        html += '<a class="mid">' + j + '</a>';
                    }
                    html += '<span class="dots mid">...</span>'

                } else {
                    for (var j = rpage.currentPage + 1; j < rpage.totalPage; j++) {
                        html += '<a class="mid">' + j + '</a>';
                    }
                }
                // 末页
                if (rpage.currentPage != rpage.totalPage) {
                    html += '<a class="mid">' + rpage.totalPage + '</a>';
                }

                $(".pagination").css('display', '');
            }
            $(".pagination").find(".mid").remove(); // 清除旧数据
            $(".pagination").find(".first").after(html);

            // 当前页样式
            $(".pagination").find("a").each(function () {
                if ($(this).html() == rpage.currentPage) {
                    $(this).addClass("current");
                }
            });

            // 添加点击事件
            $(".pagination").find("a").each(function () {
                if (!$(this).hasClass("first") && !$(this).hasClass("next")) {
                    $(this).click(function () {
                        rpage.pageNum = $(this).html() * 1;
                        rpage.queryFun();
                    });
                }
            });
            $(".pagination").find(".first").unbind("click").click(function () {
                if(rpage.pageNum > 1){
                    rpage.pageNum = rpage.pageNum - 1;
                    if (rpage.pageNum <= 1) {
                        rpage.pageNum = 1;
                    }
                    rpage.queryFun();
                }
            });
            $(".pagination").find(".last").unbind("click").click(function () {
                if(rpage.pageNum < rpage.totalPage){
                    rpage.pageNum = rpage.pageNum + 1;
                    if (rpage.pageNum >= rpage.totalPage) {
                        rpage.pageNum = rpage.totalPage;
                    }
                    rpage.queryFun();
                }
            });
            $(".pagination").find(".confirm").unbind("click").click(function () {
                var pageNum = $(".pagination").find(".gotopage").val();
                var re = /^\d+$/;
                if (!re.test(pageNum)) {
                    rpage.pageNum = 1;
                } else {
                    if (pageNum < 1 || pageNum > rpage.totalPage) {
                        rpage.pageNum = 1;
                    } else {
                        rpage.pageNum = pageNum * 1;
                    }
                }
                rpage.queryFun();
            });

        },
        pageAttributeInit: function () {
            rpage.totalNum = 0;
            rpage.totalPage = 0;
            rpage.currentPage = 1;
            rpage.pageNum = 1;
            rpage.pageSize = 10;
        }

    }
</script>
