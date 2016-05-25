// JavaScript Document
$(function(){

	//下拉框
	$(document).on("each",".select_input .select-text",function(){
		if($(this).next("select").find('option').not(function(){return !this.selected }).length !=0){
		$(this).text( $(this).next("select").find('option').not(function(){ return !this.selected }).text());
		}
	});
	$(document).on("change",".select_input select",function(){
		var _val = $(this).find('option').not(function(){ return !this.selected }).text();
		$(this).parent(".select_input").find(".select-text").text(_val);
	})
	//图片文字滑动效果
	$(".pro_img").hover(function(){
			$(this).find(".opera").stop().animate({"padding":"10px 0","height":"20px"},200)
	},function(){
			$(this).find(".opera").stop().animate({"padding":"0px","height":"0px"},200)
	});
	//展示
    $(".pro_show li:odd").find(".showTxt").addClass("changTxt");
	$(".pro_show li:odd").find(".showImg").addClass("changImg");
	$(".list_show li:odd").find(".showTxt").removeClass("changTxt");
	$(".list_show li:odd").find(".showImg").removeClass("changImg");
	//右侧悬浮
	$(window).scroll(function(){
		var Top=$(window).scrollTop();
		var Height=$(window).height();
		if(Top>Height/2){
		$(".push").css("display","block");
		}else{
		$(".push").css("display","none");
		};
	});
	//回到顶部
	$(".push li.getTop").click(function(){
		$("html,body").animate({"scrollTop":0},1000);	
	});
	//图库列表
	$(".page_list li h3").click(function(){
		var $that = $(this).find(".i-next");
		if($that.hasClass("i-nexted")){
		  $(this).next(".sort").slideDown();
		  $that.removeClass("i-nexted");	
		}else{
		  $(this).next(".sort").slideUp();	
		  $that.addClass("i-nexted");
		}
	});
	$(".list_sort span").click(function(){
		$(this).addClass("active").siblings().removeClass("active");
	});


	//checkbox
	$(".checkbox,.checkbox-s,.i-check").click(function(){
		if($(this).hasClass("checked")){
			$(this).removeClass("checked");
		} else {
			$(this).addClass("checked");
		}
	});

    //radio sex-select
	$(".sex .checkbox").click(function(){
		$(this).addClass("checked");
		$(this).parent().siblings().children("i").removeClass("checked");
	});
});

/*!
 * [类]弹出框
 */
function dialogBox( configparam ){
	this.config = {
		selfClass:"", 			// 弹出框自定义样式
		contentHtml : "", 		// 弹出框内容
		title : "", 			// 弹出框标题
		popupBoxW : 0, 			// 弹出框自定义宽度
		popupBoxH : 0,			// 弹出框自定义高度
		okFunc : null,			// 确认操作
		cancelFunc : null,		// 取消操作
		initEvent : null,		// 初始化事件绑定
		closeBtnshow : true	,
		coverhide:true,          // 默认点击黑色透明背景隐藏弹出框
		noCover : false          //默认有遮罩层
	};
	if( configparam ){
		$.extend( this.config,configparam );
	}
	//弹出框结构Html
	var _frameHtml = '<div class="popup-wrap none">\
	<div class="popup-cover"></div>\
	<div class="popup-case">\
		<div class="popup-cent">\
		</div></div>\
	</div>';
	var _self = this;
	this.curDlg = $( _frameHtml );
	$("body").append( this.curDlg );

	this.curDlg.find(".popup-cent").html( this.config.contentHtml );

	if( this.config.title ){
		this.curDlg.find(".popup-title").html( this.config.title );
	}
	if( !this.config.closeBtnshow ){
		this.curDlg.find(".btn-close").remove();
	}
	if( this.config.noCover ){
		this.curDlg.find(".popup-cover").remove();
	}

	if( this.config.selfClass ){ //自定义样式
		this.curDlg.addClass( this.config.selfClass );
	}
	if( this.config.popupBoxW ){
		this.curDlg.find(".popup-case").width( this.config.popupBoxW );
	}
	if( this.config.popupBoxH ){
		var centHeight = this.config.popupBoxH - this.curDlg.find(".popup-title").height();
		this.curDlg.find(".popup-case").height( this.config.popupBoxH );
		this.curDlg.find(".popup-cent").css({height:centHeight, "max-height":centHeight});
	}
	if( _self.config.initEvent ){
		_self.config.initEvent( _self.curDlg );
	}

	this.reSetBox();

	this.curDlg.find("[name='case-ok']").unbind("click").bind("click",function(){
		_self.curDlg.hide();
		if( _self.config.okFunc && typeof _self.config.okFunc == "function"){
			_self.config.okFunc( _self.curDlg );
		}
		_self.renewDoc();
	});
	this.curDlg.find("[name='case-no']").unbind("click").bind("click",function(){
		_self.curDlg.hide();
		if( _self.config.cancelFunc && typeof _self.config.cancelFunc == "function"){
			_self.config.cancelFunc( _self.curDlg );
		}
		_self.renewDoc();
	});
	this.curDlg.find(".btn-close").unbind("click").bind("click",function(){
		_self.hideDlg();
	});
	if( this.config.coverhide ) {
		this.curDlg.find(".popup-cover").unbind("click").bind("click",function(){
			_self.hideDlg();
		});
	}
}


/**
 * 弹出框原型
 * 方法
 */
dialogBox.prototype = {
	showDlg : function( showFunc ){
		$('.loginpassword').val('');

		if( showFunc && typeof showFunc == "function" ){ //自定义处理
			showFunc( this.curDlg );
		}
		this.curDlg.show();
		this.reSetBox();
		$("html,body").css("overflow","hidden");
	},
	hideDlg : function( hideFunc ){
		if( hideFunc && typeof hideFunc == "function" ){ //自定义处理
			hideFunc( this.curDlg );
		}
		this.curDlg.hide();
		this.renewDoc();
	},
	refreshBoxContent : function( _content ){
		this.curDlg.find(".popup-cent").html( _content );
	},
	reSetBox : function(){
		var DlgTrueW = this.curDlg.find(".popup-case").outerWidth();
		var DlgTrueH = this.curDlg.find(".popup-case").outerHeight();
		this.curDlg.find(".popup-case").css({marginTop:-DlgTrueH/2,marginLeft:-DlgTrueW/2});
	},
	renewDoc : function(){
		if( !$(".popup-wrap:visible").length ){
			$("html,body").css("overflow-y","auto");
		}

	}
};
//设计师列表幻灯片
function scrollBannerInit( params_config ){
	var config = {
		s_wrapper : ".banner_wrapper", //banner wrapper 样式名称
		s_ul : ".banner-ul",   // banner ul 列表名称
		s_dots : ".banner-btn",// banner btn 名称
		s_lbtn : ".scroll_l", // 向左点击
		s_rbtn : ".scroll_r",  // 向右点击
		animateTime : 500 ,    // 滚动效果用时
		switchTime : 5000 ,   // 滚动间隔用时
		callback : null 
	};
	config = $.extend(config,params_config);		
	$(config.s_wrapper).each(function(){
		var scrollTimer = 0;
		var curIndex = 1;
		var $bannerList = $(this).find(config.s_ul);
		var banner_num = $bannerList.find("li").length;
		var $bannerBtnWrap = $(this).find(config.s_dots);
	
		if( banner_num == 1 ) return;
		// banner_btn UI init
		var s = '';
		for(var i=0; i<banner_num; i++){
			s += '<span></span>';
		}
		$bannerBtnWrap.append( s );
		$bannerBtnWrap.find("span:first").addClass("current");
		
		scrollTimer = window.setInterval( bannerScroll,config.switchTime);
		
		//banner_btn
		$bannerBtnWrap.find("span").mouseenter(function(){		
			curIndex = $(this).index();
			bannerScroll();
			if( scrollTimer ){
				window.clearInterval( scrollTimer );
			}
			scrollTimer = window.setInterval( bannerScroll,config.switchTime );					
		});
		
		//leftBtn,rightBtn
		$(this).find(".scroll_l,.scroll_r").click(function(){
			if( $(this).hasClass("scroll_l") ){ // left click
				curIndex = curIndex - 2;
				if( curIndex == -1 ){
					curIndex = banner_num-1;
				}
			} else { // right click
				if( curIndex == banner_num  ){
					curIndex = 0;
				}
			}		
			if( scrollTimer ){
				window.clearInterval( scrollTimer );
			}		
			bannerScroll();
			scrollTimer = window.setInterval( bannerScroll,config.switchTime );		
		});
		
		function bannerScroll(){
			if( curIndex == banner_num ){
				curIndex = 0;
			}		
			$bannerBtnWrap.find("span").removeClass("current");
			$bannerBtnWrap.find("span").eq( curIndex ).addClass("current");				
			$bannerList.find("li").removeClass("current").stop().css({opacity:0});
			$bannerList.find("li").eq( curIndex ).addClass("current").animate({opacity:1},config.animateTime);
			if( config.callback && typeof config.callback ){
				config.callback(curIndex);
			}
			curIndex ++;
		}

	});
	
}
























































