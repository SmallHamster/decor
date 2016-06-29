<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="footer">
    <div class="center">
        <div class="pull-left logo-footer">
            <img src="static/pc-1.1/images/logo-footer.png" title="DECOR" alt="DECOR" width="187" height="38" />
            装修、建材、家居、商务一站式服务
        </div>
        <div class="pull-left navi">
            <h3>网站导航</h3>
            <p><a href="pc/forward/to?type=goods"><fmt:message key="info.quanbushangpin"/></a>
                <a href="pc/forward/to?type=scene"><fmt:message key="info.quanbuchangjing"/></a>
                <a href="pc/forward/to?type=scene" id="showAllSeries"><fmt:message key="info.xilietuzhanshi"/></a>
            </p>
            <p><a href="pc/forward/to?type=user"><fmt:message key="info.zhaoshejishi"/></a><a
                    href="pc/forward/to?type=message"><fmt:message key="info.zixun"/></a></p>

            <p><a class="userUpload"><fmt:message key="info.shangchuanshangpin"/></a><a
                    class="userUpload"><fmt:message key="info.chuangjianchangjing"/></a><a
                    class="userUpload"><fmt:message key="info.tianjiaxilietu"/></a></p>
        </div>
        <div class="pull-left navi">
            <h3><fmt:message key="info.guanyuwomen"/></h3>

            <p><a href="pc/forward/aboutWeb" id="aboutWeb"><fmt:message key="info.guanyuwangzhan"/></a><a
                    href="pc/forward/aboutWeb" id="aboutWe"><fmt:message key="info.lianxiwomen"/></a></p>
        </div>
        <div class="pull-right qcode">
            <img src="static/pc-1.1/images/qcode.jpg" title="扫一扫，下载pad版" alt="扫一扫，下载pad版" width="152" height="152" />
            扫一扫，下载pad版
        </div>
    </div>
</div>

<script src="static/pc/js/jquery-1.11.1.min.js"></script>
<script src="static/js/plugins/notify-bootstap.min.js"></script>
<script src="static/pc/global.js"></script>
<style>

</style>

<!-- 未登录提示框 -->
<script type="text/template" id="loginNoticePopupCont">
    <div class='Poplogo'><img src='static/pc/images/login_logo.png'/></div>
    <p class="tc fs16 color3" style="margin: 60px;"><fmt:message key="info.ninshangweidenglu"/>。</p>
    <div class="mt20 tc loginNotice">
        <button class="btn blackBtn confirmBtn"><fmt:message key="info.queding"/></button>
        <button class="btn blackBtn cancelBtn"><fmt:message key="info.quxiao"/></button>
    </div>
</script>
<!-- 登录框 -->
<script type="text/template" id="loginPopupCont">
    <div class='Poplogo'><img src='static/pc/images/login_logo.png'/></div>
    <div class="form loginDiv">
        <div class="form-item rel">
            <span class="iicon phone abs"></span>
            <input type="text" class="loginmobile" placeholder="<fmt:message key="info.shoujihao"/>"
                   onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
        </div>
        <div class="form-item rel">
            <span class="iicon password abs"></span><input type="password" class="loginpassword"
                                                           placeholder="<fmt:message key="info.mima"/>">
        </div>
        <div class="agree clearfix">
            <span class="iicon i-check checked"></span>
            <span class="color6 pl5 vb"><fmt:message key="info.jizhuwo"/></span>
            <span class="error colorRed pl10 vb"></span>
            <a class="fr color6 findpwd"><fmt:message key="info.wangjimima"/></a>
        </div>
        <button class="btn blackBtn registerBtn doLoginBtn"><fmt:message key="info.denglu"/></button>
        <p class="tr color6 fs16"><fmt:message key="info.haimeiyouzhanghao"/><a class="colorRed goRegister"><fmt:message
                key="info.lijizhuce"/></a></p>

        <div id="thirdDiv" class="registerWay tc">
            <!--<a href="#" class="iicon wechat"></a>
            <a href="#" class="iicon qq"></a>
            <a href="#" class="iicon weibo"></a>-->
            <span id="hzy_fast_login"></span>
        </div>
    </div>
</script>

<script type="text/javascript" src="http://open.51094.com/user/myscript/156a86c6f2d4e2.html"></script>

<!-- 收藏弹出框 -->
<script type="text/template" id="collectPopupCont">
    <div class="collectbag collectDlg">
        <h3 class="h-title"><fmt:message key="info.baocundaoshoucangjia"/></h3>

        <div class="paper clearfix">
            <img src="static/pc/img/paper_bg.jpg" width="124" height="124"/>

            <div class="paperTxt">
                <div class="version">
                    <div class="select_input rel">
                        <i class="iicon search-select search-select2 abs"></i>
                        <span class="select-text"><fmt:message key="info.qingxuanzewenjianjia"/></span>
                        <input type="hidden" class="favoriteId" value=""/>
                        <select></select>
                    </div>
                </div>
                <div class="version"><input type="text" class="favoriteName" placeholder="<fmt:message key="info.xinjianwenjianjia"/>"/></div>
            </div>
        </div>
        <p class="Txtname"><fmt:message key="info.wenjianjiamiaoshu"/></p>
        <textarea class="tare favoriteInfo" maxlength="200"></textarea>

        <div class="Btn">
            <button class="okbtn" name="case-no"><fmt:message key="info.queding"/></button>
            <button class="nobtn" name="case-ok"><fmt:message key="info.quxiao"/></button>
        </div>
    </div>
</script>
<!-- 注册弹出框 -->
<script type="text/template" id="registerPopupCont">
    <div class='Poplogo'><img src='static/pc/images/login_logo.png'/></div>
    <div class="form registerDiv">
        <div class="form-item rel">
            <span class="iicon phone abs"></span><input type="text" maxlength="11" placeholder="<fmt:message key="info.shoujihao"/>"
                                                        onkeyup="this.value=this.value.replace(/\D/g,'')"
                                                        onafterpaste="this.value=this.value.replace(/\D/g,'')">
        </div>
        <div class="form-item rel">
            <span class="iicon nickname abs"></span><input type="text" maxlength="50" placeholder="<fmt:message key="info.nichen"/>">
        </div>
        <div class="form-item rel">
            <span class="iicon password abs"></span><input type="password" maxlength="16" placeholder="<fmt:message key="info.mima"/>">
        </div>
        <div class="clearfix">
            <div class="form-item rel fl" style="width: 315px">
                <span class="iicon validate abs"></span><input type="text" style="width: 250px;" maxlength="10"
                                                               placeholder="<fmt:message key="info.duanxinyanzhengma"/>"
                                                               onkeyup="this.value=this.value.replace(/\D/g,'')"
                                                               onafterpaste="this.value=this.value.replace(/\D/g,'')">
            </div>
            <div class="fr curp">
                <button class="btn blackBtn sendCodeBtn" defaultVal="<fmt:message key="info.fasongyanzhengma"/>"><fmt:message key="info.fasongyanzhengma"/></button>
            </div>
        </div>
        <div class="agree">
            <span class="iicon i-check"></span>
            <span class="color6 pl5 vb"></span>
            <span class="colorc vb curp _registerRule"><fmt:message key="info.zhucexieyi"/></span>
        </div>
        <button class="btn blackBtn registerBtn"><fmt:message key="info.zhuce"/></button>
        <p class="tr color6 fs16 curp goLogin"><fmt:message key="info.yiyouzhanghao"/></p>

        <div id="thirdDiv2" class="registerWay tc">
            <%--<a href="#" class="iicon wechat"></a>--%>
            <%--<a href="#" class="iicon qq"></a>--%>
            <%--<a href="#" class="iicon weibo"></a>--%>
        </div>
    </div>
</script>
<!-- 找回密码 -->
<script type="text/template" id="findPasswordPopupCont">
    <div class='Poplogo'><img src='static/pc/images/login_logo.png'/></div>
    <p class="tc fs16 color3 mb20"><fmt:message key="info.zhaohuimima"/></p>
    <div class="form findPasswordDiv">
        <div class="form-item rel">
            <span class="iicon phone abs"></span><input type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" placeholder="<fmt:message key="info.qingshuruninzhucedeshoujihao"/>">
        </div>
        <div class="clearfix">
            <div class="form-item rel fl" style="width: 315px">
                <span class="iicon validate abs"></span><input type="text" style="width: 250px;" placeholder="<fmt:message key="info.duanxinyanzhengma"/>">
            </div>
            <div class="fr">
                <button class="btn blackBtn sendCodeBtn" defaultVal="<fmt:message key="info.huoquyanzhengma"/>"><fmt:message key="info.huoquyanzhengma"/></button>
            </div>
        </div>
        <button class="btn blackBtn registerBtn"><fmt:message key="info.xiayibu"/></button>
        <p class="tr color6 fs16"><fmt:message key="info.ninhaimeiyouzhanghao"/><a class="colorRed goRegister"><fmt:message key="info.lijizhuce"/>></a></p>
    </div>
</script>
<!-- 重置密码 -->
<script type="text/template" id="resetPasswordPopupCont">
    <div class='Poplogo'><img src='static/pc/images/login_logo.png'/></div>
    <p class="tc fs16 color3 mb20">重置密码</p>
    <div class="form resetPasswordDiv">
        <div class="form-item rel">
            <span class="iicon password abs"></span><input type="password" placeholder="<fmt:message key="info.shuruzuixinmima"/>">
        </div>
        <div class="form-item rel">
            <span class="iicon password abs"></span><input type="password" placeholder="<fmt:message key="info.querenxinmima"/>">
        </div>
        <input type="hidden" class="_mobile" value=""/>
        <button class="btn blackBtn registerBtn"><fmt:message key="info.queding"/></button>
    </div>
</script>
<!-- 注册协议 -->
<script type="text/template" id="registerRulePopupCont">
    <div class='Poplogo'><img src='static/pc/images/login_logo.png'/></div>
    <div class="ruleCont">
        <p class="tc fs16 color3 bold registerRule"><fmt:message key="info.zhucexieyi"/></p>

        <p class="para mt10">
            参考消息网5月19日报道
            台媒称，继中巴经济走廊、中俄高铁等项目后，大陆推动“一带一路”布局又有新动作。宁波海事局官方微博15日公布，中泰两国在广州签署“克拉运河”合作备忘录，让这项延宕10年的世纪大工程向正式开工跨出一大步；初步预估，该项目需耗时10年、投资总额280亿美元，一旦开通，大陆的“马六甲困局”也将迎刃而解。
        </p>

        <p class="para">
            据台湾中时电子报5月18日报道，“克拉运河”是指从泰国克拉地峡区域，挖掘一条沟通太平洋的泰国湾与印度洋的安达曼海的运河，修建完成后，国际海运线将不必绕过新加坡、取道马六甲海峡，航程至少缩短约1200公里，可省2至5天航运时间；以10万吨油轮来算，单次能省下35万美元的运费。
        </p>
    </div>
</script>
<!-- 意见反馈 -->
<script type="text/template" id="feedbackPopupCont">
    <div class="innerdiv feedbackDiv">
        <h3 class="popup-title"><fmt:message key="info.yijianfankui"/><i class="iicon close" name="case-ok"></i></h3>

        <div class="view"><textarea placeholder="<fmt:message key="info.qingshurunindeyijian"/>" maxlength="200"></textarea></div>
        <div class="aBtn tc">
            <button name="case-ok"><fmt:message key="info.tijiao"/></button>
        </div>
    </div>
</script>
<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1258419071'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/z_stat.php%3Fid%3D1258419071%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script>
<script type="text/javascript">
    var loginNoticePopup; // 登录提示弹出框
    var loginPopup; // 登录弹出框
    var collectPopup; // 收藏弹出框
    var registerPopup; // 注册弹出框
    var findPasswrodPopup; // 找回密码
    var resetPasswordPopup; // 重置密码
    var registerRulePopup; // 注册协议
    var feedbackPopup; // 意见反馈
    $(function () {
        $('#showAllSeries').click(function () {
            sessionStorage.setItem("showSeries", "showSeries");
        })
        $("#aboutWe").click(function () {
            sessionStorage.setItem("about", "aboutWe")
        })
        $("#aboutWeb").click(function () {
            sessionStorage.setItem("about", "aboutWeb")
        })
        $(".userUpload").unbind("click").click(function () {
            var sessionUserId = $("#sessionUserId").val();
            // 用户未登录，则弹出未登录提示框
            if (sessionUserId == "") {
                loginPopup.showDlg();
                return false;
            }
            if ($(this).text() == "<fmt:message key="info.shangchuanshangpin"/>") {
                sessionStorage.setItem("upload", "goods");
            } else if ($(this).text() == "<fmt:message key="info.chuangjianchangjing"/>") {
                sessionStorage.setItem("upload", "scene");
            } else if ($(this).text() == "<fmt:message key="info.tianjiaxilietu"/>") {
                sessionStorage.setItem("upload", "series");
            }
            window.location.href = 'pc/user/detailHomePage';
        })
        // 提示登录弹出框
        loginNoticePopup = new dialogBox({
            popupBoxW: 520,
            popupBoxH: 340,
            contentHtml: $('#loginNoticePopupCont').html()
        });
        // 提示登录弹出框 按钮事件
        $(".loginNotice .confirmBtn").unbind("click").click(function () {
            loginPopup.showDlg();
            loginNoticePopup.hideDlg();
        });
        $(".loginNotice .cancelBtn").unbind("click").click(function () {
            loginNoticePopup.hideDlg();
        });
        // 登录弹出框
        loginPopup = new dialogBox({
            popupBoxW: 520,
            popupBoxH: 484,
            contentHtml: $('#loginPopupCont').html()
        });
        // 登录弹出框按钮事件
        $(".loginBtn").unbind("click").click(function () {
            loginPopup.showDlg();
        });
        $(".loginDiv .doLoginBtn").unbind("click").click(function () {
            login.in($(".loginDiv .loginmobile").val(), $(".loginDiv .loginpassword").val());
        });
        $(".loginDiv .goRegister").unbind("click").click(function () {
            $("#thirdDiv2").html($("#thirdDiv").html());
            showRegisterDiv();
            loginPopup.hideDlg();
        });
        $(".loginDiv .findpwd").unbind("click").click(function () {
            hideOtherDlg();
            findPasswrodPopup.showDlg();
        });

        // 找回密码弹出框
        findPasswrodPopup = new dialogBox({
            popupBoxW: 520,
            popupBoxH: 425,
            contentHtml: $('#findPasswordPopupCont').html()
        });

        $(".findPasswordDiv .goRegister").unbind("click").click(function () {
            hideOtherDlg();
            showRegisterDiv();
        });
        $(".findPasswordDiv .sendCodeBtn").unbind("click").click(function () { // 发送验证码
            pcSendMobileCode2FindPassword();
        });
        $(".findPasswordDiv .registerBtn").unbind("click").click(function () { // 下一步，调到重置页面
            pcFindPasswordCheckCode();

        });

        // 重置密码弹出框
        resetPasswordPopup = new dialogBox({
            popupBoxW: 520,
            popupBoxH: 400,
            contentHtml: $('#resetPasswordPopupCont').html()
        });
        $(".resetPasswordDiv .registerBtn").unbind("click").click(function () {
            pcResetPassword();
        });

        // 收藏弹出框
        collectPopup = new dialogBox({
            popupBoxW: 520,
            popupBoxH: 530,
            contentHtml: $('#collectPopupCont').html()
        });

        // 注册弹出框
        registerPopup = new dialogBox({
            popupBoxW: 520,
            popupBoxH: 600,
            contentHtml: $('#registerPopupCont').html()
        });

        $(".registerDiv .registerBtn").unbind("click").click(function () {
            pcUserRegister();
        });
        $(".registerDiv .sendCodeBtn").unbind("click").click(function () {
            pcSendMobileCode();
        });
        $(".registerDiv .goLogin").unbind("click").click(function () {
            hideOtherDlg();
            loginPopup.showDlg();
        });
        $(".registerDiv ._registerRule").unbind("click").click(function () {
            registerRulePopup.showDlg();
        });

        // 注册协议
        registerRulePopup = new dialogBox({
            popupBoxW: 520,
            popupBoxH: 569,
            contentHtml: $('#registerRulePopupCont').html()
        });

        // 意见反馈
        feedbackPopup = new dialogBox({
            popupBoxW: 520,
            popupBoxH: 520,
            contentHtml: $('#feedbackPopupCont').html()
        });
        $(".push li.idea").unbind("click").click(function () {
            feedbackPopup.showDlg();
        });
        $(".feedbackDiv button").unbind("click").click(function () {
            pcSaveFeedback();
        });

        headerPart.init();
        collectDlg.init();

        Array.prototype.remove = function (val) {
            var index = this.indexOf(val);
            if (index > -1) {
                this.splice(index, 1);
            }
        };
    });

    function showRegisterDiv(){
        $("#thirdDiv2").html($("#thirdDiv").html());
        registerPopup.showDlg();
    }

    function hideOtherDlg() {
        loginNoticePopup.hideDlg();
        loginPopup.hideDlg();
        collectPopup.hideDlg();
        registerPopup.hideDlg();
        findPasswrodPopup.hideDlg();
        resetPasswordPopup.hideDlg();
        registerRulePopup.hideDlg();
        feedbackPopup.hideDlg();
    }

    // 整个页面的header部分统一处理，主要包括查询和导航样式
    var headerPart = {
        init: function () {
            headerPart.globalSearchInit();
            headerPart.curPageInit();
        },
        globalSearchInit: function () {
            // header查询 查询类型回写
            var type = $("#search_type").val();
//            if (type == "scene") {
//                $(".header_r select option").eq(0).attr("selected", true);
//                $(".header_r .select-text").text($(".header_r select option").eq(0).text());
//            } else if (type == "goods") {
//                $(".header_r select option").eq(1).attr("selected", true);
//                $(".header_r .select-text").text($(".header_r select option").eq(1).text());
//            } else if (type == "series") {
//                $(".header_r select option").eq(2).attr("selected", true);
//                $(".header_r .select-text").text($(".header_r select option").eq(2).text());
//            } else if (type == "user") {
//                $(".header_r select option").eq(3).attr("selected", true);
//                $(".header_r .select-text").text($(".header_r select option").eq(3).text());
//            } else if (type == "message") {
//                $(".header_r select option").eq(4).attr("selected", true);
//                $(".header_r .select-text").text($(".header_r select option").eq(4).text());
//            }

            $("#searchArea").find("li").each(function(){
                var li = $(this);
                li.click(function(){
                    var type = $(this).find("a").html();
                    $("#typeValue").html(type);
                    if (type == "<fmt:message key="info.changjingtu"/>") {
                        type = "scene";
                    } else if (type == "<fmt:message key="info.shangpintu"/>") {
                        type = "goods";
                    } else if (type == "<fmt:message key="info.xilietu"/>") {
                        type = "series";
                    } else if (type == "<fmt:message key="info.shejishi"/>") {
                        type = "user";
                    } else if (type == "<fmt:message key="info.zixun"/>") {
                        type = "message";
                    }
                    $("#search_type").val(type);
                });
            });

            // header查询
            $("#search").unbind("click").click(function () {
                var name = $("#searchText").val();
                name = encodeURIComponent(encodeURIComponent(name));
                var type = $("#typeValue").html();
                if (type == "<fmt:message key="info.changjingtu"/>") {
                    type = "scene";
                } else if (type == "<fmt:message key="info.shangpintu"/>") {
                    type = "goods";
                } else if (type == "<fmt:message key="info.xilietu"/>") {
                    type = "series";
                } else if (type == "<fmt:message key="info.shejishi"/>") {
                    type = "user";
                } else if (type == "<fmt:message key="info.zixun"/>") {
                    type = "message";
                }
                $("#search_type").val(type);
//                var url = "pc/forward/to?type=" + type;
//                if (name != "") {
//                    url += "&name=" + name;
//                }
//                $("#alink").attr("href", url)
//                document.getElementById("alink").click();
            });
//            $(".search_text").unbind("keyup").keyup(function (event) {
//                if (event.keyCode == 13) { // enter 键
//                    $(".search_btn").trigger("click");
//                }
//            });
//
//            $(".header_r .search-icon").unbind("click").click(function () {
//                $(".search_btn").trigger("click");
//            });
        },
        curPageInit: function () {
            var v = $("#cur-page").val();
            var index = 0;
            if(v=="scene"){
                index=0;
            }else if(v=="goods"){
                index=1;
            }else if(v=="series"){
                index=2;
            }else if(v=="user"){
                index=3;
            }else if(v=="message"){
                index=4;
            }
            $("#typeSelect").find("li").eq(index).trigger("click");
//            $(".header .menu ul li").removeClass("active");
//            if (v == "scene") {
//                $(".header .menu ul li").eq(0).addClass("active");
//            }
//            else if (v == "goods") {
//                $(".header .menu ul li").eq(1).addClass("active");
//            }
//            else if (v == "user") {
//                $(".header .menu ul li").eq(2).addClass("active");
//            }
//            else if (v == "message") {
//                $(".header .menu ul li").eq(3).addClass("active");
//            }
        }
    };

    var login = {
        in: function (username, password) {
            if (username == "") {
                $(".loginDiv .error").text("<fmt:message key="info.shoujihaobunengweikong"/>");
                return false;
            }
            if (username.length<11) {
                $(".loginDiv .error").text("手机号少于11位");
                return false;
            }
            if (password == "") {
                $(".loginDiv .error").text("<fmt:message key="info.mimabunengweikong"/>");
                return false;
            }
            $bluemobi.ajax("pc/user/login", {username: username, password: password}, function (result) {
                if (result.status == "0") {
                    location.reload(true);
                } else {
                    $(".loginDiv .error").text("<fmt:message key="info.yonghuminghuomimacuowu"/>");
                }
            });

        },
        out: function () {
            $bluemobi.ajax("pc/user/logout", {}, function (result) {
                if (result.status == "0") {
                    location.href='index';
                }
            });
        }

    };

    // 收藏弹出框
    var collectDlg = {
        init: function () {
            // 选择收藏夹事件
            $(document).on("change", ".collectDlg select", function () {
                var favoriteId = $(".collectDlg select option:selected").val();
                var cover = $(".collectDlg select option:selected").attr("cover");
                $(".collectDlg .favoriteId").val(favoriteId);
                $(".collectDlg img").attr("src", cover);
            });
        },
        // 显示弹出框
        show: function (objectId, objectType, collectSuccessCallback) {
            var userId = $("#sessionUserId").val();
            if (userId == "") {
                loginPopup.showDlg();
                return false;
            }
            // 清空新文件夹名称和描述
            $(".collectDlg .favoriteName").val("");
            $(".collectDlg .favoriteInfo").val("");

            // 判断是否有文件夹列表，如果没有就从后台查询
            if ($(".collectDlg select").html() == "") {
                collectDlg.loadFavoriteList(userId);
            }

            collectPopup.showDlg();

            $(".collectDlg .okbtn").unbind("click").click(function () {
                var favoriteId = $(".collectDlg .favoriteId").val();
                var favoriteName = $(".collectDlg .favoriteName").val();
                var favoriteInfo = $(".collectDlg .favoriteInfo").val();
                collectDlg.collect(objectId, objectType, favoriteId, favoriteName, favoriteInfo, userId, collectSuccessCallback);
            });
            $(".collectDlg .nobtn").unbind("click").click(function () {
                collectPopup.hideDlg();
            });
        },
        // 加载收藏夹select
        loadFavoriteList: function (userId) {
            jQuery.ajax({
                dataType: 'json',
                url: 'pc/collect/ajaxFavoriteList',
                type: "post",
                data: {userId: userId},
                async: false,
                success: function (result) {
                    if (result.status == "0") {
                        var html = '';
                        for (var i = 0; i < result.data.length; i++) {
                            var favorite = result.data[i];
                            html += '<option cover="' + favorite.cover + '" value="' + favorite.id + '">' + favorite.name + '</option>';
                        }
                        $(".collectDlg select").html(html);

                        // 默认把第一个设置为选中
                        if (html != "") {
                            var favoriteId = $(".collectDlg select option:selected").val();
                            var selectText = $(".collectDlg select option:selected").text();
                            var cover = $(".collectDlg select option:selected").attr("cover")
                            $(".collectDlg .favoriteId").val(favoriteId);
                            $(".collectDlg .select-text").html(selectText);
                            $(".collectDlg img").attr("src", cover);
                        }
                    }
                }
            });
        },
        // 收藏   :如果favoriteName不为空，则表示新建收藏夹，如果favoriteName为空，则一定要有favoriteId
        collect: function (objectId, objectType, favoriteId, favoriteName, favoriteInfo, userId, collectSuccessCallback) {
            if (favoriteId == "" && favoriteName == "") {
                $bluemobi.notify("<fmt:message key="info.qingxuanzeshoucangjia"/>", "error");
                return false;
            }

            $bluemobi.ajax("pc/collect/collect", {
                objectId: objectId,
                objectType: objectType,
                favoriteId: favoriteId,
                favoriteName: favoriteName,
                favoriteInfo: favoriteInfo,
                userId: userId
            }, function (result) {
                if (result.status == "0") {
                    $bluemobi.notify("<fmt:message key="info.shoucangchenggong"/>", "success");
                    collectPopup.hideDlg();
                    collectSuccessCallback();
                    if (favoriteName != "") {
                        collectDlg.loadFavoriteList(userId);
                    }
                } else {
                    $bluemobi.notify(result.msg, "error");
                }
            });
        },
        // 取消收藏
        cancelCollect: function (objectId, objectType, collectSuccessCallback) {
            var userId = $("#sessionUserId").val();
            if (userId == "") {
                loginPopup.showDlg();
                return false;
            }
            $bluemobi.ajax("pc/collect/cancelCollect", {
                userId: userId,
                objectId: objectId,
                objectType: objectType
            }, function (result) {
                if (result.status == "0") {
                    $bluemobi.notify(result.msg, "success");
                    collectSuccessCallback();
                } else {
                    $bluemobi.notify(result.msg, "error");
                }
            });
        }
    };

    var commFun = {
        // 判断是否关注,第一个参数：被关注用户id，第2个参数：当前用户id
        isAttention: function (userId, fansId) {
            var flag = false;
            jQuery.ajax({
                dataType: 'json',
                url: "pc/comm/isAttention",
                type: "post",
                data: {userId: userId, fansId: fansId},
                async: false,
                success: function (result) {
                    if (result.status == "0") {
                        flag = result.data;
                    }
                }
            });
            return flag;
        },
        // 判断是否点赞
        isPraise: function (userId, objectId, objectType) {
            var flag = false;
            jQuery.ajax({
                dataType: 'json',
                url: "pc/comm/isPraise",
                type: "post",
                data: {userId: userId, objectId: objectId, objectType: objectType},
                async: false,
                success: function (result) {
                    if (result.status == "0") {
                        flag = result.data;
                    }
                }
            });
            return flag;
        },
        // 判断是否收藏
        isCollect: function (userId, objectId, objectType) {
            var flag = false;
            jQuery.ajax({
                dataType: 'json',
                url: "pc/comm/isCollect",
                type: "post",
                data: {userId: userId, objectId: objectId, objectType: objectType},
                async: false,
                success: function (result) {
                    if (result.status == "0") {
                        flag = result.data;
                    }
                }
            });
            return flag;
        },
        // 关注
        attention: function (userId, fansId, callback) {
            jQuery.ajax({
                dataType: 'json',
                url: "pc/comm/attention",
                type: "post",
                data: {userId: userId, fansId: fansId},
                async: false,
                success: function (result) {
                    callback(result);
                }
            });
        },
        // 取消关注
        cancelAttention: function (userId, fansId, callback) {
            jQuery.ajax({
                dataType: 'json',
                url: "pc/comm/cancelAttention",
                type: "post",
                data: {userId: userId, fansId: fansId},
                async: false,
                success: function (result) {
                    callback(result);
                }
            });
        },
        // 点赞
        praise: function (userId, objectId, objectType, callback) {
            jQuery.ajax({
                dataType: 'json',
                url: "pc/praise/praise",
                type: "post",
                data: {userId: userId, objectId: objectId, objectType: objectType},
                async: false,
                success: function (result) {
                    callback(result);
                }
            });
        },
        // 取消点赞
        cancelPraise: function (userId, objectId, objectType, callback) {
            jQuery.ajax({
                dataType: 'json',
                url: "pc/praise/cancelPraise",
                type: "post",
                data: {userId: userId, objectId: objectId, objectType: objectType},
                async: false,
                success: function (result) {
                    callback(result);
                }
            });
        },
        handlerAttention:function(){
            var fansId = $("#sessionUserId").val();
            var userId = $("#creator").val();
            var flag = commFun.isAttention(userId,fansId);
            if(flag){
                $("#cancelAttention").show();
            }else{
                $("#attention").show();
            }
            $("#attention").unbind("click").click(function(){
                if($("#sessionUserId").val()==""){
                    loginPopup.showDlg();
                    return false;
                }
                commFun.attention(userId,fansId,function(result){
                    if (result.status == "0") {
//                        $bluemobi.notify(result.msg,"success");
                        location.reload();
                    }
                });
            });
            $("#cancelAttention").unbind("click").click(function(){
                if($("#sessionUserId").val()==""){
                    loginPopup.showDlg();
                    return false;
                }
                commFun.cancelAttention(userId,fansId,function(result){
                    if (result.status == "0") {
//                        $bluemobi.notify(result.msg,"success");
                        location.reload();
                    }
                });
            });
        }

    };


    // 发送验证码
    function pcSendMobileCode() {
        var mobile = $(".registerDiv").find("input").eq(0).val();
        if (mobile == "") {
            $(".registerDiv").find("input").eq(0).focus();
            $bluemobi.notify("<fmt:message key="info.shoujihaobunengweikong"/>", "error");
            return false;
        }
        if (mobile.length<11) {
            $(".registerDiv").find("input").eq(0).focus();
            $bluemobi.notify("手机号少于11位", "error");
            return false;
        }
        _changeBtn = $(".registerDiv .sendCodeBtn");
        if(_changeBtn.text()!=_changeBtn.attr("defaultVal")){
            return false;
        }
        $bluemobi.ajax("pc/user/sendMessage", {mobile: mobile}, function (result) {
            if (result.status == "0") {
                $bluemobi.notify(result.msg, "success");
                btnValueChange();
            } else {
                $bluemobi.notify(result.msg, "error");
            }
        });
    }

//    clearTimeout(_time);
    var _changeBtn;
    var _time;
    function btnValueChange(){
        var obj = _changeBtn;
        var btnValue = obj.attr("defaultVal");
        var text=obj.text();
        if(text==btnValue){
            text = 60;
        }else if(text>0){
            text=text-1;
        }else{
            text =btnValue;
        }
        obj.text(text);
        if(text!=btnValue){
            _time=setTimeout("btnValueChange()", 1000);
        }
    }

    // 用户注册
    function pcUserRegister() {
        var mobile = $(".registerDiv").find("input").eq(0).val();
        var nickname = $(".registerDiv").find("input").eq(1).val();
        var password = $(".registerDiv").find("input").eq(2).val();
        var code = $(".registerDiv").find("input").eq(3).val();
        if (mobile == "") {
            $(".registerDiv").find("input").eq(0).focus();
            $bluemobi.notify("<fmt:message key="info.shoujihaobunengweikong"/>", "error");
            return false;
        }
        if (mobile.length<11) {
            $(".registerDiv").find("input").eq(0).focus();
            $bluemobi.notify("手机号少于11位", "error");
            return false;
        }
        if (nickname == "") {
            $(".registerDiv").find("input").eq(1).focus();
            $bluemobi.notify("<fmt:message key="info.nichenbukeweikong"/>", "error");
            return false;
        }
        if (password == "") {
            $(".registerDiv").find("input").eq(2).focus();
            $bluemobi.notify("<fmt:message key="info.mimabunengweikong"/>", "error");
            return false;
        }
        if (code == "") {
            $(".registerDiv").find("input").eq(3).focus();
            $bluemobi.notify("<fmt:message key="info.duanxinyanzhengmabukeweikong"/>", "error");
            return false;
        }
        if (!$(".registerDiv .agree").find("span").eq(0).hasClass("checked")) {
            $bluemobi.notify("<fmt:message key="info.qingyueduzhucexieyi"/>", "error");
            return false;
        }

        $bluemobi.ajax("pc/user/register", {
            mobile: mobile,
            nickname: nickname,
            password: password,
            code: code
        }, function (result) {
            if (result.status == "0") {
                $bluemobi.notify(result.msg, "success");
                registerPopup.hideDlg();
                $(".registerDiv").find("input").eq(0).val('');
                $(".registerDiv").find("input").eq(1).val('');
                $(".registerDiv").find("input").eq(2).val('');
                $(".registerDiv").find("input").eq(3).val('');

                $bluemobi.ajax("pc/user/login", {username: mobile, password: password}, function (result) {
                    if (result.status == "0") {
                        location.reload(true);
                    } else {
                        $(".loginDiv .error").text("<fmt:message key="info.yonghuminghuomimacuowu"/>");
                    }
                });
            } else {
                $bluemobi.notify(result.msg, "error");
            }
        });
    }

    // 找回密码发送验证码
    function pcSendMobileCode2FindPassword() {
        var mobile = $(".findPasswordDiv").find("input").eq(0).val();
        if (mobile == "") {
            $(".findPasswordDiv").find("input").eq(0).focus();
            $bluemobi.notify("<fmt:message key="info.shoujihaobunengweikong"/>", "error");
            return false;
        }
        if (mobile.length<11) {
            $(".findPasswordDiv").find("input").eq(0).focus();
            $bluemobi.notify("手机号少于11位", "error");
            return false;
        }
        _changeBtn = $(".findPasswordDiv .sendCodeBtn");
        if(_changeBtn.text()!=_changeBtn.attr("defaultVal")){
            return false;
        }
        $bluemobi.ajax("pc/user/sendMessage2FindPassword", {mobile: mobile}, function (result) {
            if (result.status == "0") {
                $bluemobi.notify(result.msg, "success");
                btnValueChange();
            } else {
                $bluemobi.notify(result.msg, "error");
            }
        });
    }

//    var _time;
//    var _timeIndex=0;
//    function testChange(){
//        var obj = $(".findPasswordDiv .sendCodeBtn");
//        var _val = $(".findPasswordDiv .sendCodeBtn").attr("_val");
//        var val = $(".findPasswordDiv .sendCodeBtn").html();
//        if(_timeIndex==0){
//            val= 10;
//        }else if(val == 0){
//            val =_val;
//        }else {
//            val = val*1-1;
//        }
//        obj.html(val);
//        _timeIndex+=1;
//        _time=setTimeout("testChange()", 1000)
//    }

    // 找回密码验证验证码
    function pcFindPasswordCheckCode() {
        var mobile = $(".findPasswordDiv").find("input").eq(0).val();
        var code = $(".findPasswordDiv").find("input").eq(1).val();
        if (mobile == "") {
            $(".findPasswordDiv").find("input").eq(0).focus();
            $bluemobi.notify("<fmt:message key="info.shoujihaobunengweikong"/>", "error");
            return false;
        }
        if (mobile.length<11) {
            $(".findPasswordDiv").find("input").eq(0).focus();
            $bluemobi.notify("手机号少于11位", "error");
            return false;
        }
        if (code == "") {
            $(".findPasswordDiv").find("input").eq(1).focus();
            $bluemobi.notify("<fmt:message key="info.yanzhengmabukeweikong"/>", "error");
            return false;
        }
        $bluemobi.ajax("pc/user/pcFindPasswordCheckCode", {mobile: mobile, code: code}, function (result) {
            if (result.status == "0") {
                $bluemobi.notify(result.msg, "success");
                $(".resetPasswordDiv ._mobile").val(mobile);
                hideOtherDlg();
                resetPasswordPopup.showDlg(); // 显示重置密码框
            } else {
                $bluemobi.notify(result.msg, "error");
            }
        });
    }

    // 重置密码
    function pcResetPassword() {
        var password = $(".resetPasswordDiv").find("input").eq(0).val();
        var password1 = $(".resetPasswordDiv").find("input").eq(1).val();
        var mobile = $(".resetPasswordDiv ._mobile").val();
        if (password == "") {
            $(".resetPasswordDiv").find("input").eq(0).focus();
            $bluemobi.notify("<fmt:message key="info.mimabunengweikong"/>", "error");
            return false;
        }
        if (password1 == "") {
            $(".resetPasswordDiv").find("input").eq(1).focus();
            $bluemobi.notify("<fmt:message key="info.mimabunengweikong"/>", "error");
            return false;
        }
        if (password != password1) {
            $(".resetPasswordDiv").find("input").eq(1).focus();
            $bluemobi.notify("<fmt:message key="info.liangcimimabuyizhi"/>", "error");
            return false;
        }
        $bluemobi.ajax("pc/user/pcResetPassword", {mobile: mobile, password: password}, function (result) {
            if (result.status == "0") {
                $bluemobi.notify(result.msg, "success");
                hideOtherDlg();
            } else {
                $bluemobi.notify(result.msg, "error");
            }
        });
    }

    // 保存意见反馈
    function pcSaveFeedback() {
        var userId = $("#sessionUserId").val();
        // 用户未登录，则弹出未登录提示框
        if (userId == "") {
            loginPopup.showDlg();
            return false;
        }
        var content = $(".feedbackDiv textarea").val();
        if (content == "") {
            $(".feedbackDiv textarea").focus();
            $bluemobi.notify("<fmt:message key="info.qingshuruneirong"/>", "error");
            return false;
        }
        $bluemobi.ajax("pc/user/pcSaveFeedback", {content: content}, function (result) {
            if (result.status == "0") {
                $bluemobi.notify(result.msg, "success");
                hideOtherDlg();
            } else {
                $bluemobi.notify(result.msg, "error");
            }
        });
    }

    function test() {
        $bluemobi.notify("test", "error");
    }

</script>