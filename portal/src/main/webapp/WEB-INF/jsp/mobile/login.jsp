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
				<!-- <input class="text password" type="password" placeholder="密码" >
				<div class="verifyCode clearfix">
					<input class="vcL" type="text" placeholder="验证码">
					<input class="vcR" type="button" value="获取验证码">
				</div> -->
				<div class="keep">
					<div class="check on"></div>
					<span>保持登录</span>
				</div>
				<input class="loginBtn" type="submit" value="登录">
				<a href="javascript:;" class="register">注册账号</a>
			</div>
			<div class="thirdPart">
				<a href="javascript:;" class="way qq"></a>
				<a href="javascript:;" class="way wx"></a>
				<a href="javascript:;" class="way sina"></a>
			</div>
			<div class="agreement">点击注册即为认同 <a href="javascript:;">《注册协议》</a></div>
		</div>
		<script src="static/mobile/js/jquery.min.js"></script>
		<script src="static/mobile/js/global.js"></script>
		<script>
			$(function(){
				$(".loginBtn").click(function(){
					window.location.href = _basePath + "mobile/forward/to?type=index";
				});
			});
		</script>
	</body>
</html>
