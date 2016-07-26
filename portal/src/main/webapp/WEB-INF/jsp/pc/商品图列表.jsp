<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="common/meta.jsp" %>
    <%@ include file="common/css.jsp" %>
    <title><fmt:message key="info.shouye"/></title>
    <link href="static/pc/css/common.css" rel="stylesheet" type="text/css">
    <link href="static/pc/css/all.css" rel="stylesheet" type="text/css">

</head>

<body>
<div class="wrapper">

    <%@ include file="common/header.jsp" %>

    <input type="hidden" id="cur-page" value="goods"/>
    <div class="search-condition" style="display: none;">
        <input type="hidden" class="kindTagId" value="${kindTagId}"/>
        <input type="hidden" class="styleTagId" value="${styleTagId}"/>
        <input type="hidden" class="spaceTagId" value="${spaceTagId}"/>
        <input type="hidden" class="name" value="${name}"/>
    </div>

    <div class="cantainer">
        <div class="content pt20 pb60 clearfix">
            <!--左侧内容-->
            <div class="pagestyle">
                <ul class="page_list">
                    <li>
                        <h3><fmt:message key="info.chanpinfenlei"/><i class="iicon i-next"></i></h3>

                        <div class="sort sorted clearfix kindTagList">

                        </div>
                    </li>
                    <li>
                        <h3><fmt:message key="info.kongjianfenlei"/><i class="iicon i-next"></i></h3>

                        <div class="sort sorted clearfix spaceTagList">

                        </div>
                    </li>
                    <li>
                        <h3><fmt:message key="info.fenggefenlei"/><i class="iicon i-next"></i></h3>

                        <div class="sort sorted clearfix styleTagList">

                        </div>
                    </li>
                </ul>
                <div class="code">
                    <img src="static/pc/img/code_bg.jpg"/>

                    <p><fmt:message key="info.shaoyishao,xiazaiPadban"/></p>
                </div>
            </div>
            <!--右边内容区-->
            <div class="R-content">
                <div class="breadcrumb"><a><fmt:message key="info.shangpin"/></a><a class="kindTagName"><fmt:message key="info.chanpinfenlei"/></a><a class="spaceTagName"><fmt:message key="info.kongjianfenlei"/></a><a class="styleTagName"><fmt:message key="info.fenggefenlei"/></a>
                </div>
                <div class="column clearfix">
                    <div class="list_sort">
                        <span class="iicon cell active"></span><span class=" iicon cell_2"></span><span class="iicon cell_3"></span>
                    </div>
                    <div class="page_rgt">
                        <a class="iicon back"></a><span>page <span class="page_rgt_pageNum">0</span> of <span class="page_rgt_totalPage">0</span></span><a class="iicon next"></a>
                    </div>
                </div>

                <div class="image-list" style="text-align: center"></div>

                <!-- 分页 -->
                <%@ include file="common/page.jsp" %>
            </div>
        </div>
    </div>


    <!-- footer -->
    <%@ include file="common/footer.jsp" %>

</div>
<!--右侧悬浮-->
<%@ include file="common/other.jsp" %>

<script type="text/javascript" src="static/pc/js/base.js"></script>
<script type="text/javascript">
    var register;
    var thisPage = rpage; // 分页对象 rpage存在于page.jsp
    var pageMode = "maximum"; // 分页模式 ： maximun,mid,minimum
    $(function () {
        register = new dialogBox({
            popupBoxW: 520,
            popupBoxH: 530,
            contentHtml: $('#regPopupCont').html()
        });

        $(".list_sort").find("span").each(function (index) {
            $(this).unbind("click").click(function () {
                $(".list_sort").find("span").removeClass("active");
                $(this).addClass("active");
                if (index == 0) {
                    pageMode = "maximum";
                } else if (index == 1) {
                    pageMode = "mid";
                } else {
                    pageMode = "minimum";
                }
                ajaxPageGoods("pageAttributeInit");
            });
        });

        $(".page_rgt").find(".back").unbind("click").click(function () {
            $(".pagination").find(".first").trigger("click");
        });
        $(".page_rgt").find(".next").unbind("click").click(function () {
            $(".pagination").find(".last").trigger("click");
        });

        ajaxKindTagList(); // 加载种类分类
        ajaxStyleTagList(); // 加载风格分类
        ajaxSpaceTagList(); // 加载空间分类
        ajaxPageGoods();
    });

    // 加载种类分类
    function ajaxKindTagList() {
        $bluemobi.ajax("pc/comm/ajaxKindTagList", {}, function (result) {
            if (result.status == "0") {
                var html = '';
                html += '<a kindtagid="">全部</a>';
                for (var i = 0; i < result.data.length; i++) {
                    var kindTag = result.data[i];
                    html += '<a kindtagid="' + kindTag.id + '">' + kindTag.name + '</a>';
                }
                $(".kindTagList").html(html);
                $(".kindTagList").find("a").each(function () {
                    $(this).unbind("click").click(function () {
                        $(".kindTagList").find("a").removeClass("active");
                        $(this).addClass("active");
                        $(".kindTagId").val($(this).attr("kindtagid"));
                        $(".kindTagName").html($(this).html());
                        ajaxPageGoods("pageAttributeInit");
                    });
                });
                // 回写选中效果
                var kindTagId = $(".search-condition").find(".kindTagId").val();
                $(".kindTagList").find("a").each(function () {
                    var k = $(this).attr("kindtagid");
                    if (kindTagId != "" && kindTagId == k) {
                        $(this).trigger("click");
                    }
                });
            }
        });
    }

    // 加载风格分类
    function ajaxStyleTagList() {
        $bluemobi.ajax("pc/comm/ajaxStyleTagList", {}, function (result) {
            if (result.status == "0") {
                var html = '';
                html += '<a styletagid="">全部</a>';
                for (var i = 0; i < result.data.length; i++) {
                    var styleTag = result.data[i];
                    html += '<a styletagid="' + styleTag.id + '">' + styleTag.name + '</a>';
                }
                $(".styleTagList").html(html);
                $(".styleTagList").find("a").each(function () {
                    $(this).unbind("click").click(function () {
                        $(".styleTagList").find("a").removeClass("active");
                        $(this).addClass("active");
                        $(".styleTagId").val($(this).attr("styletagid"));
                        $(".styleTagName").html($(this).html());
                        ajaxPageGoods("pageAttributeInit");
                    });
                });
                // 回写选中效果
                var styleTagId = $(".search-condition").find(".styleTagId").val();
                $(".styleTagList").find("a").each(function () {
                    var k = $(this).attr("styletagid");
                    if (styleTagId != "" && styleTagId == k) {
                        $(this).trigger("click");
                    }
                });
            }
        });
    }

    // 加载空间分类
    function ajaxSpaceTagList() {
        $bluemobi.ajax("pc/comm/ajaxSpaceTagList", {}, function (result) {
            if (result.status == "0") {
                var html = '';
                html += '<a spacetagid="">全部</a>';
                for (var i = 0; i < result.data.length; i++) {
                    var spacetag = result.data[i];
                    html += '<a spacetagid="' + spacetag.id + '">' + spacetag.name + '</a>';
                }
                $(".spaceTagList").html(html);
                $(".spaceTagList").find("a").each(function () {
                    $(this).unbind("click").click(function () {
                        $(".spaceTagList").find("a").removeClass("active");
                        $(this).addClass("active");
                        $(".spaceTagId").val($(this).attr("spacetagid"));
                        $(".spaceTagName").html($(this).html());
                        ajaxPageGoods("pageAttributeInit");
                    });
                });
                // 回写选中效果
                var spaceTagId = $(".search-condition").find(".spaceTagId").val();
                $(".spaceTagList").find("a").each(function () {
                    var k = $(this).attr("spacetagid");
                    if (spaceTagId != "" && spaceTagId == k) {
                        $(this).trigger("click");
                    }
                });
            }
        });
    }

    function ajaxPageGoods(action) {
        if (action && action == "pageAttributeInit") {
            thisPage.pageAttributeInit();
        }

        if (pageMode == "maximum") {
            thisPage.pageSize = 20;
        } else if (pageMode == "mid") {
            thisPage.pageSize = 12;
        } else {
            thisPage.pageSize = 8;
        }

        var kindTagId = $(".search-condition").find(".kindTagId").val();
        var styleTagId = $(".search-condition").find(".styleTagId").val();
        var spaceTagId = $(".search-condition").find(".spaceTagId").val();
        var name = $(".search-condition").find(".name").val();
        var userId = $("#sessionUserId").val();
        var data = {kindTagId: kindTagId, styleTagId: styleTagId, spaceTagId: spaceTagId, name: name, userId: userId, pageNum: thisPage.pageNum, pageSize: thisPage.pageSize};
        $bluemobi.ajax("pc/goods/page", data, function (result) {
            if (result.status == "0") {
                var html = '';
                if (pageMode == "maximum") {
                    html += '<ul class="product-list3 clearfix">';
                } else if (pageMode == "mid") {
                    html += '<ul class="product-list product-list2 clearfix">';
                } else {
                    html += '<ul class="product-list4 clearfix">';
                }
                if (result.data.list.length > 0) {
                    for (var i = 0; i < result.data.list.length; i++) {
                        var goods = result.data.list[i];
                        var collectClass = "i-collect"; // 收藏按钮样式
                        var praiseClass = "i-praise"; // 点赞按钮样式
                        if (goods.isCollection && goods.isCollection == "yes") {
                            collectClass = "i-collect2";
                        }
                        if (goods.isPraise && goods.isPraise == "yes") {
                            praiseClass = "i-praise2";
                        }
                        var showName = '';
                        if (goods.user.roleType == "admin") {
                            showName = 'Décor';
                        } else {
                            showName = '<a href="javascript:void(0)" onclick="toUserInfo(' + goods.user.id + ')">' + goods.user.nickname + '</a>';
                        }
                        $bluemobi.subStrAdminNick(goods, "Décor")
                        if (pageMode == "maximum") {
                            html += '<li goodsid=' + goods.id + '><div class="pro_img">\
                        <a href="pc/goods/detail?goodsId=' + goods.id + '"><img src="' + goods.cover + '?imageView2/1/w/200/h/172"/></a>\
                        <div class="opera abs tr">\
                        <div class="stick clearfix"></div>\
                        <span class="' + collectClass + ' fl _collect"><i class="iicon"></i></span>\
                        <span class="' + praiseClass + ' fr _praise"><i class="iicon"></i></span>\
                        </div>\
                        </div>\
                        <div class="pro_txt">\
                        <h3 class="slh" title="' + goods.name + '">' + goods.name + '</h3>\
                        <p class="tr slh">' + showName + '</p>\
                        </div>\
                        </li>';
                        } else if (pageMode == "mid") {
                            html += '<li goodsid=' + goods.id + '><div class="pro_img">\
                        <a href="pc/goods/detail?goodsId=' + goods.id + '"><img src="' + goods.cover + '?imageView2/1/w/275/h/275"/></a>\
                        <div class="opera abs tr">\
                        <div class="stick clearfix"></div>\
                        <span class="' + collectClass + ' fl _collect"><i class="iicon"></i></span>\
                        <span class="' + praiseClass + ' fr _praise"><i class="iicon"></i></span>\
                        </div>\
                        </div>\
                        <div class="pro_txt clearfix">\
                        <span class="fl slh" style="width: 130px" title="' + goods.name + '">' + goods.name + '</span>\
                        <span class="fr">' + showName + '</span>\
                        </div>\
                        </li>';
                        } else {
                            html += '<li goodsid=' + goods.id + '><div class="pro_img">\
                        <a href="pc/goods/detail?goodsId=' + goods.id + '"><img src="' + goods.cover + '?imageView2/1/w/420/h/290"/></a>\
                        <div class="opera abs tr">\
                        <div class="stick clearfix"></div>\
                        <span class="' + collectClass + ' fl _collect"><i class="iicon"></i></span>\
                        <span class="' + praiseClass + ' fr _praise"><i class="iicon"></i></span>\
                        </div>\
                        </div>\
                        <div class="pro_txt clearfix">\
                        <span class="fl slh" style="width: 200px" title="' + goods.name + '">' + goods.name + '</span>\
                        <span class="fr">' + showName + '</span>\
                        </div>\
                        </li>';
                        }
                    }
                    html += '</ul>';
                    $(".image-list").html(html);
                    thisPage.init(result.data.page, "ajaxPageGoods");

                    $(".page_rgt_pageNum").html(thisPage.pageNum);
                    $(".page_rgt_totalPage").html(thisPage.totalPage);

                    //图片文字滑动效果
                    $(".pro_img").hover(function () {
                        $(this).find(".opera").stop().animate({"padding": "10px 0", "height": "20px"}, 200)
                    }, function () {
                        $(this).find(".opera").stop().animate({"padding": "0px", "height": "0px"}, 200)
                    });

                    // 绑定收藏、点赞的点击事件
                    $(".image-list").find("li").each(function () {
                        var goodsId = $(this).attr("goodsid");
                        $(this).find("._collect").unbind("click").click(function () {
                            var currCollectBtn = $(this);
                            if (currCollectBtn.hasClass("i-collect")) {
                                collectDlg.show(goodsId, "goods", function () {
                                    currCollectBtn.addClass("i-collect2").removeClass("i-collect");
                                });
                            } else if (currCollectBtn.hasClass("i-collect2")) {
                                collectDlg.cancelCollect(goodsId, "goods", function () {
                                    currCollectBtn.addClass("i-collect").removeClass("i-collect2");
                                });
                            }
                        });
                        $(this).find("._praise").unbind("click").click(function () {
                            praiseOrCancelPraise($("#sessionUserId").val(), goodsId, $(this));
                        });
                    });
                } else {
                    $(".image-list").html('<span style="font-size: larger;">暂无内容</span>');
                }
            } else {
                $(".image-list").html('<span style="font-size: larger;">暂无内容</span>');
            }
        });
    }

    // 点赞/取消点赞
    function praiseOrCancelPraise(userId, goodsId, $obj) {
        if (userId == "") {
            loginPopup.showDlg();
            return false;
        }
        if ($obj.hasClass("i-praise")) { // 点赞
            $bluemobi.ajax("pc/praise/praise", {userId: userId, objectId: goodsId, objectType: "goods"}, function (result) {
                if (result.status == "0") {
                    $obj.removeClass("i-praise").addClass("i-praise2");
                    $bluemobi.notify(result.msg, "success");
                } else {
                    $bluemobi.notify(result.msg, "error");
                }
            });
        } else if ($obj.hasClass("i-praise2")) { // 取消点赞
            $bluemobi.ajax("pc/praise/cancelPraise", {userId: userId, objectId: goodsId, objectType: "goods"}, function (result) {
                if (result.status == "0") {
                    $obj.removeClass("i-praise2").addClass("i-praise");
                    $bluemobi.notify(result.msg, "success");
                } else {
                    $bluemobi.notify(result.msg, "error");
                }
            });
        }
    }

    // 跳转到用户界面
    function toUserInfo(userId) {
        location.href = "pc/user/detailPage?userId=" + userId;
    }
</script>
</body>
</html>