<%--
  Created by IntelliJ IDEA.
  User: xiaoj
  Date: 2015/10/30
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
  <%@ include file="common/meta.jsp" %>
  <%@ include file="common/css.jsp" %>
  <title><fmt:message key="info.guanyuwangzhan"/></title>
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
    <div class="content clearfix mt20 mb20">
      <div class="leftNav fl">
        <ul>
          <li><a ><fmt:message key="info.guanyuwomen"/></a></li>
          <li><a ><fmt:message key="info.lianxiwomen"/></a></li>
          <li><a ><fmt:message key="info.shiyongtiaokuan"/></a></li>
          <li><a ><fmt:message key="info.yinsicelue"/></a></li>
        </ul>
      </div>
      <div class="rightCont fr">
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
  var guanyuwomen = '';
  var lianxiwomen = '';
  var shiyongtiaokuan = '';
  var yinsicelue = '';
$(function(){
  $bluemobi.ajax("pc/aboutWeb/all", {}, function (result) {
    if (result.status == "0") {
      for (var i = 0; i < result.data.length; i++) {
        var aboutWeb = result.data[i];
        if(aboutWeb.title == "关于我们"){
          guanyuwomen = aboutWeb.content;
        }
        if(aboutWeb.title == "联系我们"){
          lianxiwomen = aboutWeb.content;
        }
        if(aboutWeb.title == "使用条款"){
          shiyongtiaokuan = aboutWeb.content;
        }
        if(aboutWeb.title == "隐私策略"){
          yinsicelue = aboutWeb.content;
        }
      }
    }
  });

  window.onload = function() {
    var about = sessionStorage.getItem("about");
    if(about == 'aboutWe') {
     $(".leftNav ul li").eq(1).trigger("click");
    }else if(about == 'aboutWeb') {
      $(".leftNav ul li").eq(0).trigger("click");
    }
    sessionStorage.setItem("about",""); //销毁 from 防止在b页面刷新 依然触发$('#xxx').click()
  }
  $(".leftNav ul").find("li").click(function(){
    $(".leftNav ul li").removeClass("current");
    $(this).addClass("current");
    var html='';
    if($(this).text()=='<fmt:message key="info.guanyuwomen"/>'){
      html=guanyuwomen;
    }else if($(this).text()=='<fmt:message key="info.lianxiwomen"/>'){
      html=lianxiwomen;
    }else if($(this).text()=='<fmt:message key="info.shiyongtiaokuan"/>'){
      html=shiyongtiaokuan;
    }else if($(this).text()=='<fmt:message key="info.yinsicelue"/>'){
      html=yinsicelue;
    }
    $(".rightCont").html(html);
  })
})

</script>
</body>
</html>