<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/taglibs.jsp" %>
<%@ include file="common/meta.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="UTF-8">
		<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
		<meta content="no-cache" http-equiv="pragma">
		<meta content="0" http-equiv="expires">
		<meta content="telephone=no, address=no" name="format-detection">
		<meta name="apple-mobile-web-app-capable" content="yes"> 
		<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
		<title>登录页</title>
		
		<script src="static/mobile/js/flexible.js"></script>
		<link rel="stylesheet" href="static/mobile/css/global.css">
		<link rel="stylesheet" href="static/mobile/css/login.css">
	</head>
	<body>
	<%@ include file="common/header.jsp" %>
		<div class="main">
			<div class="logo">
				<img src="static/mobile/images/main_logo.png" alt="">
			</div>
			<div class="logoName">设计新主张</div>
			<div class="loginBox">
				<div class="title">注册成为DECOR用户</div>
				<input class="text phoneNum" type="text" placeholder="手机号" >
				<input class="text nickname" type="text" placeholder="昵称" >
				<input class="text password" type="password" placeholder="密码" >
				<div class="verifyCode clearfix">
					<input class="vcL code" type="text" placeholder="验证码">
					<input class="vcR sendCodeBtn" defaultVal="获取验证码" type="button" value="获取验证码">
				</div>
				<!-- <div class="keep">
					<div class="check on"></div>
					<span>保持登录</span>
				</div> -->
                <input class="loginBtn" type="submit" value="注册账号">
                <a href="mobile/login/loginPage" class="register">登录</a>
			</div>
			<div class="thirdPart">
				<a href="javascript:;" class="way qq"></a>
				<a href="javascript:;" class="way wx"></a>
				<a href="javascript:;" class="way sina"></a>
			</div>
			<div class="agreement">点击注册即为认同 <a href="javascript:;">《注册协议》</a></div>
		</div>

	<script>
		var $mobile = $(".phoneNum");
		var $nickname = $(".nickname");
		var $password = $(".password");
		var $code = $(".code");
		$(function(){
			$(".loginBtn").click(function(){
				register();
			});
			$(".sendCodeBtn").click(function(){
				sendMobileCode();
			});
		});
		// 发送验证码
		function sendMobileCode() {
			var mobile = $mobile.val().trim();
			if (mobile == "") {
				$mobile.focus();
				$bluemobi.notify("请输入手机号", "error");
				return false;
			}
			_changeBtn = $(".sendCodeBtn");
			if(_changeBtn.val()!=_changeBtn.attr("defaultVal")){
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

		var _changeBtn;
		var _time;
		function btnValueChange(){
			var obj = _changeBtn;
			var btnValue = obj.attr("defaultVal");
			var text=obj.val();
			if(text==btnValue){
				text = 60;
			}else if(text>0){
				text=text-1;
			}else{
				text =btnValue;
			}
			obj.val(text);
			if(text!=btnValue){
				_time=setTimeout("btnValueChange()", 1000);
			}
		}

		// 用户注册
		function register() {
			var mobile = $mobile.val();
			var nickname = $nickname.val();
			var password = $password.val();
			var code = $code.val();
			if (mobile == "") {
				$code.focus();
				$bluemobi.notify("请输入手机号", "error");
				return false;
			}
			if (nickname == "") {
				$nickname.focus();
				$bluemobi.notify("请输入昵称", "error");
				return false;
			}
			if (password == "") {
				$password.focus();
				$bluemobi.notify("请输入密码", "error");
				return false;
			}
			if (code == "") {
				$code.focus();
				$bluemobi.notify("请输入验证码", "error");
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
					$mobile.val('');
					$nickname.val('');
					$password.val('');
					$code.val('');
				} else {
					$bluemobi.notify(result.msg, "error");
				}
			});
		}
	</script>
	</body>
</html>
