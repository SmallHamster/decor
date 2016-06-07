function test1 () {
	var tempStr = document.getElementById('test').value;
	if (tempStr === "请输入您要查找的内容") {
		document.getElementById('test').value = "";
	}
}
function test2 () {
	var tempStr = document.getElementById('test').value;
	if (tempStr === "") {
		document.getElementById('test').value = "请输入您要查找的内容";
	}
}
$(function(){
	//document.oncontextmenu = function () {
	//	return false
	//};
	//下拉
	$(".select").each(function(){
		var s=$(this);
		var z=parseInt(s.css("z-index"));
		var dt=$(this).children("dt");
		var dd=$(this).children("dd");
		var _show=function(){dd.slideDown(200);dt.addClass("cur set");s.css("z-index",z+1);};   //展开效果
		var _hide=function(){dd.slideUp(200);dt.removeClass("cur set");s.css("z-index",z);};    //关闭效果
		dt.click(function(){dd.is(":hidden")?_show():_hide();});
		dd.find("a").click(function(){dt.html($(this).html());_hide();});     //选择效果（如需要传值，可自定义参数，在此处返回对应的“value”值 ）
		$("body").click(function(i){ !$(i.target).parents(".select").first().is(s) ? _hide():"";});
	});
	//主体部分
	//jQuery(".picFocus").slide({
	//	mainCell: ".bd ul",
	//	effect: "left",
	//	autoPlay: true,
	//	trigger: "click"
	//});
	////设计系列图
	//jQuery(".design-top-right").slide({
	//	titCell: ".hd ul",
	//	mainCell: ".bd ul",
	//	autoPage: true,
	//	effect: "left",
	//	autoPlay: true,
	//	vis: 1,
	//	trigger: "click"
	//});
	$(".design-list li:nth-child(3n)").css({'margin-right': '0',"float":"right"});
});

$(document).ready(function(){
    //var $category = $('.design-list li:gt(5)');
	//$category.hide();
	//$("#showMore").click(function(){
	//	$category.show();
	//	$(this).find('.look-more').addClass('hide');
	//	$(this).find('.pages').addClass('show');
	//});
});
$(document).ready(function(){	
	//var $category1 = $('.comment-list ul li:gt(3)');
	//$category1.hide();
	//$("#showMore1").click(function(){
	//	$category1.show();
	//	$(this).find('.look-more').addClass('hide');
	//	$(this).find('.pages').addClass('show');
	//});
});

//返回顶部
$(document).ready(function(){	
	//gotop
	$(".gotop").hide();
	$(window).scroll(function(){
		if ($(window).scrollTop()>100){
			$(".gotop").fadeIn(500);
		}else{
			$(".gotop").fadeOut(500);
		}
	});
	//当点击跳转链接后，回到页面顶部位置
	$(".gotop").click(function(){
		$('body,html').animate({scrollTop:0},800);
		return false;
	});

	////图片轮播
	//function roll($layer){
	//	var $img = [],
	//		cur, intval, lock = false,
	//		$handlers = $layer.find('div.handlerList');
    //
	//	$layer.find('ul li').each(function(i){
	//		$img.push($(this));
	//		$handlers.append('<span></span>');
	//	});
    //
	//	cur = $img.length - 1;
	//	cur = cur < 0 ? 0 : cur;
    //
	//	$layer.find('div.list').on({
	//		mouseenter : function(){ lock = true;},
	//		mouseleave : function(){ lock = false;}
	//	});
    //
	//	$handlers.find('span').each(function(i){
	//		$(this).click(function(){
	//			clearTimeout(intval);
	//			show(i);
	//		});
	//	});
    //
	//	$layer.find('.handler-prev').click(function(){
	//		show(cur - 1);
	//	});
    //
	//	$layer.find('.handler-next').click(function(){
	//		show(cur + 1);
	//	});
    //
	//	function show(n){
	//		if(cur == n || lock){ loop(); return}
	//		else if(n < 0) n = $img.length - 1;
	//		else if(n > $img.length - 1) n = 0;
	//		$img[cur].stop().fadeOut('slow');
	//		$handlers.find('span:eq(' + cur + ')').removeClass('cur');
	//		$img[n].stop().fadeIn('slow');
	//		$handlers.find('span:eq(' + n + ')').addClass('cur');
	//		cur = n;
	//		loop();
	//	}
    //
	//	function loop(){
	//		clearInterval(intval);
	//		intval = setTimeout(function(){ show(cur + 1)}, 5000);
	//	}
    //
	//	show(0);
    //
	//}

	//roll($('div.streamer'));
});

//缩略图
(function(){
	function G(s){
		return document.getElementById(s);
	}
	function getStyle(obj, attr){
		if(obj.currentStyle){
			return obj.currentStyle[attr];
		}else{
			return getComputedStyle(obj, false)[attr];
		}
	}
	function Animate(obj, json){
		if(obj.timer){
			clearInterval(obj.timer);
		}
		obj.timer = setInterval(function(){
			for(var attr in json){
				var iCur = parseInt(getStyle(obj, attr));
				iCur = iCur ? iCur : 0;
				var iSpeed = (json[attr] - iCur) / 5;
				iSpeed = iSpeed > 0 ? Math.ceil(iSpeed) : Math.floor(iSpeed);
				obj.style[attr] = iCur + iSpeed + 'px';
				if(iCur == json[attr]){
					clearInterval(obj.timer);
				}
			}
		}, 30);
	}
	var oPic = G("picBox");
	var oList = G("listBox");
	var oPrev = G("prev");
	var oNext = G("next");
	var oPrevTop = G("prevTop");
	var oNextTop = G("nextTop");
	var oPicLi = oPic.getElementsByTagName("li");
	var oListLi = oList.getElementsByTagName("li");
	var len1 = oPicLi.length;
	var len2 = oListLi.length;
	var oPicUl = oPic.getElementsByTagName("ul")[0];
	var oListUl = oList.getElementsByTagName("ul")[0];
	var w1 = oPicLi[0].offsetWidth;
	var w2 = oListLi[0].offsetWidth;
	oPicUl.style.width = w1 * len1 + "px";
	oListUl.style.width = w2 * len2 + "px";
	var index = 0;
	var num = 5;
	var num2 = Math.ceil(num / 2);
	function Change(){
		Animate(oPicUl, {left: - index * w1});
		if(index < num2){
			Animate(oListUl, {left: 0});
		}else if(index + num2 <= len2){
			Animate(oListUl, {left: - (index - num2 + 1) * w2});
		}else{
			Animate(oListUl, {left: - (len2 - num) * w2});
		}
		for (var i = 0; i < len2; i++) {
			oListLi[i].className = "";
			if(i == index){
				oListLi[i].className = "on";
			}
		}
	}
	oNextTop.onclick = oNext.onclick = function(){
		index ++;
		index = index == len2 ? 0 : index;
		Change();
	}
	oPrevTop.onclick = oPrev.onclick = function(){
		index --;
		index = index == -1 ? len2 -1 : index;
		Change();
	}
	for (var i = 0; i < len2; i++) {
		oListLi[i].index = i;
		oListLi[i].onclick = function(){
			index = this.index;
			Change();
		}
	}
})()