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
    <link href="static/pc/css/personalInfo.css" rel="stylesheet" type="text/css">

</head>

<body>
<div class="wrapper">

    <%@ include file="common/header.jsp" %>
    <div class="search-condition" style="display: none;">
    </div>

    <div class="container">
        <div class="content mt20 mb20">
            <p class="color6 fs16 pt20"><fmt:message key="info.zhanghaoshezhi"/></p>
            <ul class="accountTabs mt20">
                <li onClick="showObject('user')"><fmt:message key="info.jibenziliao"/></li>
                <li onClick="showObject('photo')"><fmt:message key="info.gerentouxiang"/></li>
                <li onClick="showObject('password')"><fmt:message key="info.mima"/>
</li>
                <li onClick="showObject('third-party')"><fmt:message key="info.disanfangbangding"/>
</li>
            </ul>
            <div class="accountCont" id="user">
                <div class="p-item">
                    <label class="pr10"><fmt:message key="info.dengluzhanghao"/>:
</label><span></span>
                </div>
                <div class="p-item">
                    <label class="pr10"><fmt:message key="info.nicheng"/>:
</label><input type="text" placeholder="">
                </div>
                <div class="p-item sex">
                    <label class="pr10"><fmt:message key="info.xingbie"/>:
</label>
                    <span class="male"><i class="iicon checkbox "></i><fmt:message key="info.nan"/>
</span>
                    <span class="female"><i class="iicon checkbox"></i><fmt:message key="info.nv"/>
</span>
                    <span class="forsecret"><i class="iicon checkbox"></i><fmt:message key="info.baomi"/>
</span>
                </div>
                <div class="p-item">
                    <label class="pr10"><fmt:message key="info.lianxifangshi"/>:
</label><input type="text" placeholder="">
                    <span class="pl20"><i class="iicon i-check vt "></i><fmt:message key="info.sheweibukejian"/>
</span>
                </div>
                <div class="p-item">
                    <label class="pr10"><fmt:message key="info.suozaichengshi"/>:
</label>
                    <div class="select_input inline-b rel" style="width: 150px;">
                        <i class="iicon dropdown abs"></i>
                        <span class="select-text fs16" style="width: 100px;"><fmt:message key="info.qingxuanzesheng"/>
</span>
                        <select style="width: 150px;"class="provinceSelect">
                        </select>
                    </div>
                    <div class="select_input inline-b rel ml20" style="width: 150px;">
                        <i class="iicon dropdown abs"></i>
                        <span class="select-text fs16 " style="width: 100px;"><fmt:message key="info.qingxuanzeshi"/>
</span>
                        <select style="width: 150px;" class="citySelect">
                        </select>
                    </div>
                </div>
                <div class="p-item">
                    <label class="pr10"><fmt:message key="info.gerenzhuye"/>
：</label><input type="text" placeholder="">
                </div>
                <div class="p-item">
                    <label class="pr10 vt"><fmt:message key="info.gerenjianjie"/>
：</label><textarea style="width: 80%"></textarea>
                </div>
                <div class="p-item pt20">
                    <label></label>
                    <button class="btn blackBtn w150" onClick="saveUser()"><fmt:message key="info.baocun"/>
</button>
                </div>
            </div>
            <div class="accountCont clearfix" id="photo">
                <div class="myPortrait fl">
                    <img class="curp" src="${session_pc_user.headImage}" width="280" height="280">
                    <div class="dropped" style="display: none"></div>
                </div>
                <div class="fl ml20">
                    <p class="fs12 color3 pb5"><fmt:message key="info.dajiadoushiyoutouyouliandepengyou,shangchuantouxiangrangtajiagengkuairenshinin"/>
</p>
                    <p class="fs12 color3"><fmt:message key="info.xuanzexihuandetupianzuoweinindetouxiang"/>：</p>

                    <div style="margin-top: 180px;">
                        <button class="btn blackBtn w150" onClick="saveUserHeadImage()"><fmt:message key="info.baocun"/></button>
                        <p class="color9 fs12 mt10"><fmt:message key="info.keyishangchuanjpg,gif,pnggeshidetupian,qiewenjianxiaoyu2M"/></p>
                    </div>
                </div>
            </div>
            <div class="accountCont" id="password">
                <div class="p-item">
                    <label><fmt:message key="info.dangqianmima"/>：</label>
                    <input type="password">
                </div>
                <div class="p-item">
                    <label><fmt:message key="info.xinmima"/>：</label>
                    <input type="password">
                </div>
                <div class="p-item">
                    <label><fmt:message key="info.quedingxinmima"/>：</label>
                    <input type="password">
                </div>
                <div class="p-item validate">
                    <label><fmt:message key="info.yanzhengma"/>：</label>
                    <input type="text">
                    <img src="kaptcha.jpg" class="ml10" id="codeImg">
                    <a href="javascript:changeImg()" class="fs16 colorBlack ml10" id="ig"><fmt:message key="info.huanyizhang"/></a>
                </div>
                <div class="p-item">
                    <label></label>
                    <button class="btn blackBtn w150 mt20" onClick="ajaxPassword()" ><fmt:message key="info.baocunshezhi"/></button>
                </div>
            </div>
            <div class="accountCont" style="padding: 0" id="third-party">
                <div class="explain border_bottom fs16 colorBlack">
                    <span class="inline-b"><fmt:message key="info.shifoubangding"/></span>
                    <span class="inline-b"><fmt:message key="info.tongbushuoming"/></span>
                </div>
                <div class="explain-item">
                    <div class="item mb20 fs16 _weibo">
                        <span class="inline-b pl20" style="width: 275px"><i class="iicon weibo"></i><span
                                class="pl20"><fmt:message key="info.xinlangweibo"/></span></span>
                        <span class="inline-b" style="width: 275px">
                            <a class="bindingAccount" ><fmt:message key="info.zhanghaobangding"/></a>
                            <a class="binded" style="display: none"><fmt:message key="info.yibangding"/></a>
                            <a class="cancel pl10" style="display: none"><fmt:message key="info.quxiao"/></a>
                        </span>
                        <span class="inline-b fs12 color9" style="width: 550px"><fmt:message
                                key="info.ninhaiweibangdingxinlangweiboqingdianjibangdingweibojinxingbangding"/></span>
                    </div>
                    <div class="item mb20 fs16 _qq">
                        <span class="inline-b pl20" style="width: 275px"><i class="iicon qq"></i><span
                                class="pl20">QQ</span></span>
                         <span class="inline-b" style="width: 275px">
                            <a class="bindingAccount" ><fmt:message key="info.zhanghaobangding"/></a>
                            <a class="binded" style="display: none"><fmt:message key="info.yibangding"/></a>
                            <a class="cancel pl10" style="display: none"><fmt:message key="info.quxiao"/></a>
                        </span>
                        <span class="inline-b fs12 colorBlack" style="width: 550px"><fmt:message
                                key="info.ninyijingbangdingQQzhanghao,zaishoujihuofabushikexuanzetongbudaonindeQQkongjian"/></span>
                    </div>
                    <div class="item mb20 fs16 _weixin">
                        <span class="inline-b pl20" style="width: 275px"><i class="iicon weixin"></i><span class="pl20"><fmt:message
                                key="info.weixin"/></span></span>
                         <span class="inline-b" style="width: 275px">
                            <a class="bindingAccount" ><fmt:message key="info.zhanghaobangding"/></a>
                            <a class="binded" style="display: none"><fmt:message key="info.yibangding"/></a>
                            <a class="cancel pl10" style="display: none"><fmt:message key="info.quxiao"/></a>
                        </span>
                        <span class="inline-b fs12 color9" style="width: 550px"><fmt:message
                                key="info.ninhaiweibangdingweixinqingdianjibangdingweixinjinxingbangding"/></span>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- footer -->
    <%@ include file="common/footer.jsp" %>

</div>
<!--右侧悬浮-->
<%@ include file="common/other.jsp" %>


<script type="text/javascript" src="static/pc/js/base.js"></script>
<link href="static/js/plugins/dropper/jquery.fs.dropper.css" rel="stylesheet">
<script src="static/js/plugins/dropper/jquery.fs.dropper.js"></script>
<script type="text/javascript">
    $(function () {
        // 图片上传
        $("#photo .dropped").dropper({
            postKey: "file",
            action: "pc/upload/uploadImageToQiniu",
            postData: {},
            label: ""
        }).on("fileComplete.dropper", function(e, file, response){
            $("#photo img").attr("src",response.image);
        }).on("fileError.dropper", function(){
            console.log("upload error")
        });
        $("#photo img").unbind("click").click(function(){
            $("#photo .dropped .dropper-dropzone").trigger("click");
        });

        showObject("user");
        ajaxFindUser();
        findThirdInfo();
    });

    //第三方类型(微信:2,QQ:3,,新浪:4)
    function findThirdInfo(){
        var userId = $("#sessionUserId").val();
        $bluemobi.ajax("pc/userThird/findInfo", {userId: userId}, function (result) {
            debugger
            if (result.status == "0") {
                for (var i = 0; i < result.data.length; i++) {
                    var userThird = result.data[i];
                    var _class = "._weixin";
                   if(userThird.type == "2"){
                       _class = "._weixin";
                   }
                   if(userThird.type == "3"){
                       _class = "._qq";
                   }
                   if(userThird.type == "4"){
                       _class = "._weibo";
                   }
                    $("#third-party").find(_class).find(".binded").show();
                    $("#third-party").find(_class).find(".cancel").show();
                    $("#third-party").find(_class).find(".bindingAccount").hide();
                }
            }
        });
    }

    //加载用户信息
    function ajaxFindUser() {
        var userId = $("#sessionUserId").val();
        $bluemobi.ajax("pc/userSetting/findUserById", {userId: userId}, function (result) {
            if (result.status == "0") {
                var user = result.data;
                if(user.account==null){
                    user.account='';
                }
                $("#user span").eq(0).text(user.account);
                $("#user input").eq(0).val(user.nickname);
                if (user.sex == '0') {
                    $(".male ").find("i").addClass("checked");
                } else if (user.sex == '1') {
                    $(".female ").find("i").addClass("checked");
                } else {
                    $(".forsecret ").find("i").addClass("checked");
                }
                $("#user input").eq(1).attr('placeholder',user.mobile);
                if(user.isShow=='no'){
                    $("#user span").eq(4).find("i").addClass("checked");
                }
                if(user.province.name!=null){
                    $("#user span").eq(5).text(user.province.name);
                }
                $("#user span").eq(6).text(user.city.name);
                if(user.website==null){
                    user.website='';
                }
                $("#user input").eq(2).val(user.website);
                if(user.info==null){
                    user.info='';
                }
                $("#user textarea").eq(0).text(user.info)
                init();
            }
        });
    }
    //保存修改用户信息
    function saveUser(){
        var userId = $("#sessionUserId").val();
        var userAccount=$("#user span").eq(0).text();
        var userNickname=$("#user input").eq(0).val();
        if(userNickname==''){
            userNickname=$("#user input").eq(0).attr("placeholder");
        }
        var userSex;
        if( $(".male ").find("i").hasClass("checked")){
            userSex="0"
        }else if($(".female ").find("i").hasClass("checked")){
            userSex="1"
        }else {
            userSex="2"
        }
        var userMobile= $("#user input").eq(1).attr('placeholder');
        var userIsShow;
        if($("#user span").eq(4).find("i").hasClass("checked")){
          userIsShow='no'
        }else{
            userIsShow='yes'
        }
        var userCityName= $(".citySelect option:selected").text();
        var userWebsite=$("#user input").eq(2).val();
        if(userWebsite==''){
            userWebsite=$("#user input").eq(2).attr('placeholder');
        }
        var userInfo=$("#user textarea").eq(0).val();
        var data={
            userId:userId,
            userAccount:userAccount,
            userNickname:userNickname,
            userSex:userSex,
            userMobile:userMobile,
            userIsShow:userIsShow,
            userCityName:userCityName,
            userWebsite:userWebsite,
            userInfo:userInfo
        }
        $bluemobi.ajax("pc/userSetting/saveUser", data, function (result) {
            if (result.status == "0") {
                $bluemobi.notify(result.msg, "success");
            }
        });
    }

    function init(){
        ajaxProvince();
        var provinceId = $(".provinceSelect option:selected").val();
        ajaxCity(provinceId);
        // 当省份更改时，自动加载对应的城市信息
        $('.provinceSelect').change(function() {
            var id = $('.provinceSelect').val();
            ajaxCity(id);
        });
    }
    function ajaxProvince(){
        jQuery.ajax({
            dataType: 'json',
            url: 'pc/comm/ajaxProvince',
            type:"post",
            data: {},
            async: false,
            success: function (result) {
                if (result.status == "0") {
                    var html = '';
                    for(var i=0;i<result.data.length;i++){
                        var province = result.data[i];
                        html += '<option value='+province.id+'>'+province.name+'</option>';
                    }
                    $(".provinceSelect").html(html);
                    $(".provinceSelect option").each(function () {
                        if ($(this).text() == $("#user span").eq(5).text()) {
                            $(this).attr("selected", true);
                        }
                    });
                }
            }
        });
    }

    function ajaxCity(provinceId){
        $(".citySelect").find("option").remove();
        $bluemobi.ajax("pc/comm/ajaxCity",{provinceId:provinceId},function(result){
            if (result.status == "0") {
                var html = '';
                for(var i=0;i<result.data.length;i++){
                    var city = result.data[i];
                    html += '<option value='+city.id+'>'+city.name+'</option>';
                }
                $(".citySelect").html(html);
                $(".citySelect option").each(function () {
                    if ($(this).text() == $("#user span").eq(6).text()) {
                        $(this).attr("selected", true);
                    }
                });
                $("#user span").eq(6).text( $(".citySelect option:selected").text());
            }
        });
    }
    //点击按钮
    function showObject(id){
        if(id=="user"){
            $(".accountTabs li").removeClass("current");
            $(".accountTabs li").eq(0).addClass("current");
        }else if(id=="photo"){
            $(".accountTabs li").removeClass("current");
            $(".accountTabs li").eq(1).addClass("current");
        }else if(id=="password"){
            $(".accountTabs li").removeClass("current");
            $(".accountTabs li").eq(2).addClass("current");
            //加载验证码
        }else if(id=="third-party"){
            $(".accountTabs li").removeClass("current");
            $(".accountTabs li").eq(3).addClass("current");
        }
        $(".accountCont").hide();
        $("#"+id).show();
    }
    //跟换验证码图片
    function changeImg(){
        $("#codeImg").attr("src",'kaptcha.jpg?' + Math.floor(Math.random()*100))
    }
    //修改密码
    function ajaxPassword(){
        var currentPassword=$("#password input").eq(0).val()
        var newPassword=$("#password input").eq(1).val()
        var newPasswordTo=$("#password input").eq(2).val()
        var code=$("#password input").eq(3).val()
        var userId = $("#sessionUserId").val();
        var reg=/^(?![^a-zA-Z]+$)(?!\D+$).{6,15}$/;
        if(!reg.test(newPassword)){
            $bluemobi.notify("<fmt:message key="info.mimabixuwei6-15weideshuzihezimudezuhe"/>", "error");
            return false;
        }
        if(newPassword==newPasswordTo) {
            if (userId == "") {
                loginPopup.showDlg();
                return false;
            }
            $bluemobi.ajax("pc/userSetting/changePassword", {
                userId: userId,
                currentPassword: currentPassword,
                newPassword: newPassword,
                code:code
            }, function (result) {
                if (result.status == "0") {
                    $bluemobi.notify(result.msg, "success");
                    $("#password input").val("");
                }
            })
        }else{
            $bluemobi.notify("<fmt:message key="info.liangcimimabuyizhi"/>", "error");
            return false
        }

    }

    // 保存用户头像
    function saveUserHeadImage(){
        var headImage = $("#photo img").attr("src");
        $bluemobi.ajax("pc/userSetting/saveUserHeadImage",{headImage:headImage},function(result){
            if (result.status == "0") {
                $bluemobi.notify(result.msg, "success");
            }
        });
    }

</script>
</body>
</html>