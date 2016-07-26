<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="common/meta.jsp" %>
    <%@ include file="common/css.jsp" %>
    <title><fmt:message key="info.shejishiliebiao"/></title>
    <link href="static/pc/css/common.css" rel="stylesheet" type="text/css">
    <link href="static/pc/css/all.css" rel="stylesheet" type="text/css">

</head>

<body>
<div class="wrapper">

    <%@ include file="common/header.jsp" %>
    <div class="search-condition" style="display: none;">
        <input type="hidden" id="sort" value=""/>
        <input type="hidden" id="cur-page" value="user"/>
        <input type="hidden" id="userId" value="${user.id}"/>
        <input type="hidden" id="provinceId" value=""/>
        <input type="hidden" id="cityId" value=""/>
        <input type="hidden" class="name" value="${name}"/>
    </div>
    <div class="cantainer">
        <div class="content pt20 pb60 clearfix">
            <!--左侧内容-->
            <div class="pagestyle">
                <ul class="page_list">
                    <li>
                        <h3><fmt:message key="info.xuanzesheng"/><i class="iicon i-next i-nexted"></i></h3>

                        <div class="sort sorted clearfix" id="div_province">
                            <a class="active" onclick="replace()"><fmt:message key="info.quanbu"/></a>
                        </div>
                    </li>
                    <li>
                        <h3><fmt:message key="info.xuanzheshi"/><i class="iicon i-next i-nexted"></i></h3>

                        <div class="sort sorted clearfix" id="cityDiv" style="display: none;">

                        </div>
                    </li>
                </ul>
                <div class="code">
                    <img src="static/pc/images/code_bg.jpg"/>

                    <p><fmt:message key="info.shaoyishao,xiazaiPadban"/></p>
                </div>
            </div>
            <!--右边内容区-->
            <div class="R-content">
                <div class="breadcrumb"><a><fmt:message key="info.shejishi"/></a><a onclick="replace()"><fmt:message
                        key="info.quanbu"/></a><span></span>
                </div>
                <div class="pack">
                    <ul class="list-pack clearfix">

                    </ul>
                </div>
                <div class="kind">
                    <div class="most tc">
                        <h3 class="curp">
                            <span class="active"><fmt:message key="info.bengyuezuihuo"/></span>
                            <span><fmt:message key="info.fengshizuiduo"/></span>
                            <span><fmt:message key="info.xilietuzuiduo"/></span>
                        </h3>
                    </div>
                    <div class="below" style="text-align: center">
                    </div>
                </div>
            </div>
        </div>
        <!-- 分页 -->
        <%@ include file="common/page.jsp" %>
        <!-- footer -->
        <%@ include file="common/footer.jsp" %>

    </div>
    <!--右侧悬浮-->
    <%@ include file="common/other.jsp" %>

    <script type="text/template" id="regPopupCont">
        <div class="collectbag">
            <h3 class="h-title"><fmt:message key="info.baocundaoshoucangjia"/></h3>

            <div class="paper clearfix">
                <img src="img/paper_bg.jpg"/>

                <div class="paperTxt">
                    <div class="version">
                        <div class="select_input rel">
                            <i class="iicon search-select search-select2 abs"></i>
                            <span class="select-text"><fmt:message key="info.qingxuanzhewenjianjia"/></span>
                            <select>
                                <option><fmt:message key="info.sucai"/></option>
                                <option><fmt:message key="info.xilietu"/></option>
                                <option><fmt:message key="info.shangpintu"/></option>
                                <option><fmt:message key="info.sejishi"/></option>
                                <option><fmt:message key="info.zhixun"/></option>
                            </select>
                        </div>
                    </div>
                    <div class="version"><input type="text" placeholder="<fmt:message key="info.xinjianwenjianjia"/>"/>
                    </div>
                </div>
            </div>
            <p class="Txtname"><fmt:message key="info.wenjianjiamiaosu"/></p>
            <textarea class="tare"></textarea>

            <div class="Btn">
                <button name="case-no"><fmt:message key="info.quxiao"/></button>
                <button name="case-ok"><fmt:message key="info.queding"/></button>
            </div>
        </div>
    </script>

    <script type="text/javascript" src="static/pc/js/base.js"></script>
    <script type="text/javascript">
        var register;
        var thisPage = rpage; // 分页对象 rpage存在于page.jsp
        /*初始化*/
        $(function () {
            ajaxShowProvince();
            ajaxPageUser();
            ajaxMaxFans();
            pageUserBySort();
        })
        //展示图片的切换
        function showImg() {
            $(".banner-ul").find("li:first").addClass("current");
            scrollBannerInit({s_wrapper: ".belBanner"});

            var register = new dialogBox({
                popupBoxW: 520,
                popupBoxH: 530,
                contentHtml: $('#regPopupCont').html()
            });
            $(".opera span.i-collect").click(function () {
                register.showDlg();
            });
        }
        /*fans最多 案例数最多*/
        function pageUserBySort() {
            $(".most span").unbind("click").click(function () {
                $(".most span").removeClass("active")
                $(this).addClass("active");
                if ($(this).text() == "<fmt:message key="info.bengyuezuihuo"/>") {
                    $(".search-condition").find("#sort").val("");
                } else if ($(this).text() == "<fmt:message key="info.fengshizuiduo"/>") {
                    $(".search-condition").find("#sort").val("fans");
                } else if ($(this).text() == "<fmt:message key="info.xilietuzuiduo"/>") {
                    $(".search-condition").find("#sort").val("sort");
                }
                ajaxPageUser();
            })

        }
        /*显示所有省份*/
        function ajaxShowProvince() {
            $bluemobi.ajax("pc/user/showProvince", {}, function (result) {
                if (result.status == "0") {
                    $bluemobi.notify(result.msg, "success");
                    var html = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var province = result.data[i];
                        var provinceName = province.name;
                        html += '<a onclick="ajaxShowCity(\'' + provinceName + '\',' + province.id + ')">' + provinceName + '</a>';
                        // var html = '<a onclick="ajaxShowCity(\'' + provinceName + '\',' + province.id + ')">' + provinceName + '</a>';
                        // $(".active").eq(1).after(html);
                        $("#div_province").hide();
                    }
                    $("#div_province").append(html);
                }
            });
        }
        function replace() {
            location.reload();
        }
        /*点击获得省份下的城市*/
        function ajaxShowCity(province, provinceId) {
            var provinceName = province;
            $(".sorted a").removeClass("active");
            $(".sorted a:contains('" + province + "')").addClass("active");
            $("#provinceId").val(provinceId);
            $(".breadcrumb a").eq(1).text(provinceName);
            $bluemobi.ajax("pc/user/showCity", {provinceId: provinceId}, function (result) {
                if (result.status == "0") {
                    $bluemobi.notify(result.msg, "success");
                    var html = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var city = result.data[i];
                        html += "<a  cityId='" + city.id + "'>" + city.name + "</a>"
                    }
                    $(".sorted").eq(1).html(html);
                    $(".sorted").eq(1).find("a").unbind("click").click(function () {
                        $(".search-condition").find("#cityId").val($(this).attr("cityId"))
                        ajaxPageUser();
                    })
                    ajaxPageUser();
                }
            });
        }

        /* 根据城市 省份 模糊查询 查出列表*/
        function ajaxPageUser() {
            var sort = $(".search-condition").find("#sort").val();
            var cityId = $(".search-condition").find("#cityId").val();
            var name = $(".search-condition").find(".name").val();
            if (cityId != null) {
                $("#cityDiv a[cityId!='" + cityId + "']").removeClass("active");
                $("a[cityId='" + cityId + "']").addClass("active");
                $(".breadcrumb span").eq(0).text($("a[cityId='" + cityId + "']").text());
            }
            if (thisPage.pageSize > 4) {
                thisPage.pageSize = 4;
            }
            var provinceId = $("#provinceId").val();
            var data = {
                cityId: cityId,
                name: name,
                sort: sort,
                provinceId: provinceId,
                pageNum: thisPage.pageNum,
                pageSize: thisPage.pageSize,
                totalPage: thisPage.totalPage
            }
            $(".below").html('');
            $bluemobi.ajax("pc/user/pageUsers", data, function (result) {
                if (result.status == "0") {
                    $bluemobi.notify(result.msg, "success");
                    var html = '';
                    if (result.data.list.length > 0) {
                        $(".below").css('background', '#fff');
                        $(".below").css('text-align', 'left');

                        for (var i = 0; i < result.data.list.length; i++) {
                            var user = result.data.list[i];
                            if (user.info == null) {
                                user.info = '';
                            }
                            if (user.info.length > 130) {
                                user.info = user.info.substring(0, 130) + "..."
                            }
                            if (user.nickname == null) {
                                user.nickname = '';
                            }
                            if (user.headImage == '') {
                                user.headImage = "static/pc/images/peoplePhoto.jpg"
                            }
                            if (null == user.mobile || user.mobile == '') {
                                user.mobile = '<fmt:message key="info.zanwujilu"/>';
                            }
                            if (user.isShow == 'yes') {

                            } else {
                                user.mobile = '<fmt:message key="info.baomi"/>';
                            }
                            html += "  <div class='belowCent clearfix'>\
                        <div class='belBanner'><ul class='banner-ul'>";
                            if (null != user.seriesList && user.seriesList.length > 0) {
                                for (var j = 0; j < user.seriesList.length; j++) {
                                    var series = user.seriesList[j];
                                    series.cover = series.cover + "?imageView2/1/w/400/h/270";
                                    html += "<li><a href='pc/series/detail?seriesId=" + series.id + "'><img src='" + series.cover + "'/></a></li>";
                                }
                            } else {
                                html += "<li><a href='javascript:void(0)'><img src='static/images/default_cover.jpg'/></a></li>";
                            }
                            html += "</ul>\
                        <div class='banner-btn'></div>\
                        </div>\
                        <div class='belMain'>\
                        <dl class='intro'>\
                        <dt class='fl'><img src=" + user.headImage + "></dt>\
                        <dd>\
                        <h3><span class='fr'>" + user.mobile + "</span>" + user.nickname + "</h3>\
                        <p class='reply'>\
                        <span class='starry'>\
                        <i class='iicon star'></i>\
                        <i class='iicon star'></i>\
                        <i class='iicon star'></i>\
                        <i class='iicon star'></i>\
                        <i class='iicon '></i>\
                        </span>\
                        </p>\
                        <p class='addres'><i class='iicon locat mr10'></i><span>'" + user.province.name + "&nbsp&nbsp" + user.city.name + "'</span></p>\
                        </dd>\
                        </dl>\
                        <p class='txt'>" + user.info + "<a href='pc/user/detail?userId=" + user.id + "'><fmt:message key="info.gengduo"/>></a></p>\
                        </div></div>"
                        }

                        $(".below").html(html);

                        thisPage.init(result.data.page, " ajaxPageUser");
                        $(".page_rgt_pageNum").html(thisPage.pageNum);
                        $(".page_rgt_totalPage").html(thisPage.totalPage);
                        showImg();
                    } else {
                        $(".below").css('background', 'none');
                        $(".below").css('text-align', 'center');
                        $(".below").html('<span style="font-size: larger;">暂无内容</span>');
                    }
                } else {
                    $(".below").css('background', 'none');
                    $(".below").css('text-align', 'center');
                    $(".below").html('<span style="font-size: larger;">暂无内容</span>');
                }
            });
        }
        /*查询FANS最多的4位用户*/
        function ajaxMaxFans() {
            $bluemobi.ajax("pc/user/maxFans", {}, function (result) {
                if (result.status == "0") {
                    $bluemobi.notify(result.msg, "success");
                    var html = '';
                    for (var i = 0; i < result.data.length; i++) {
                        var user = result.data[i]
                        if (user.info == null) {
                            user.info = '';
                        }
                        if (user.info.length > 19) {
                            user.info = user.info.substring(0, 19) + "..."
                        }
                        if (user.nickname == null) {
                            user.nickname = '';
                        }
                        if (user.headImage == '') {
                            user.headImage = "static/pc/images/peoplePhoto.jpg"
                        }
                        if (user.sex == '0') {
                            user.sex = "bit"
                        } else if (user.sex == '1') {
                            user.sex = "bit2"
                        } else if (user.sex == '2') {
                            user.sex = "privacy"
                        }
                        html += "  <li><div class='head abs' ><a href='pc/user/detailPage?userId=" + user.id + "'><img src=" + user.headImage + "?imageView2/1/w/82/h/82></a><i class='" + user.sex + "'></i></div>\
                        <div class='focus abs'><i class='iicon i-focus mr10'></i><span>" + user.fans + "</span></div>\
                        <h3 class='tc'><a href='pc/user/detail?userId=" + user.id + "'style='color:#000000;'' >" + user.nickname + "</a></h3>\
                        <p class='addres'><i class='iicon locat mr10'></i><span>" + user.province.name + "&nbsp&nbsp" + user.city.name + "</span></p>\
                        <p class='txt'>" + user.info + "</p>\
                        </li>"
                    }
                    $(".list-pack ").html(html);
                    $(".head i").remove("i[class=privacy]");
                }
            });
        }
    </script>
</body>
</html>