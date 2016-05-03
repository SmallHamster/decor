//返回顶部插件
jQuery.fn.backTop = function(){
	var defaults = {
        time : 1000,
        check : true,
        top : 0,
        hideTop : 100,
        event : 'click'
	};
	return this.each(function(options){
		var option = $.extend({}, defaults, options),
			$win = $(window), $doc = $(document),
            $this = $(this), timer;
            //开启检测
            if(option.check){
                $win.scroll(function(){
                    clearTimeout(timer);
                    timer = setTimeout(function(){
                        check();
                    }, 200);
                });
                //第一次检测
                check();
            }

            /*****初始化****/
            //回到顶部事件绑定
            $this.on(option.event, function(){
                goTop();
            });

            //检测按钮位置
            function check(){
                var scrollTop = $win.scrollTop();
                if(scrollTop > option.hideTop) $this.stop().fadeIn();
                else $this.stop().fadeOut();
                //$this.stop().animate({scrollTop : scrollTop}, option.time);
            }
		
		 function goTop(n){
            var me = $(this), time = nGetTime();
            n = (isNaN(n) || n > 0) ? option.top : n;
            $('html,body').stop().animate({scrollTop : n}, time);
            setTimeout(function(){
                me.trigger("goTopcoplete.UIBakckTop");
            }, time);
            //动态获取执行时间
            function nGetTime(){
                var $win = $(window), $doc = $(document),
                    scrollTop = $win.scrollTop(), docHeight = $doc.height(),
                    time;
                time = option.time * scrollTop / docHeight;
                time = time > 100 ? time : 100;
                return time;
            }
        }
	});
};

//cookie控制
jQuery.cookie = function(name, value, options) {
    if (typeof value != 'undefined') {
        options = options || {};
        if (value === null) {
            value = '';
            options.expires = -1;
        }
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toUTCString();
        }
        var path = options.path ? '; path=' + (options.path) : '';
        var domain = options.domain ? '; domain=' + (options.domain) : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
    } else {
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
};

/*placehodler*/
(function(a) {
    function k(b) {
        var c = {}, d = /^jQuery\d+$/;
        return a.each(b.attributes, function(a, b) {
            b.specified && !d.test(b.name) && (c[b.name] = b.value);
        }), c;
    }
    function l(c, d) {
        var e = this, f = a(this);
        if (e.value === f.attr(b ? "placeholder-x" : "placeholder") && f.hasClass(j.customClass)) if (e.value = "", 
        f.removeClass(j.customClass), f.data("placeholder-password")) {
            if (f = f.hide().nextAll('input[type="password"]:first').show().attr("id", f.removeAttr("id").data("placeholder-id")), 
            c === !0) return f[0].value = d, d;
            f.focus();
        } else e == n() && e.select();
    }
    function m(c) {
        var d, i, e = this, f = a(this), g = e.id;
        if (!c || "blur" !== c.type || !f.hasClass(j.customClass)) if ("" === e.value) {
            if ("password" === e.type) {
                if (!f.data("placeholder-textinput")) {
                    try {
                        d = f.clone().prop({
                            type: "text"
                        });
                    } catch (h) {
                        d = a("<input>").attr(a.extend(k(this), {
                            type: "text"
                        }));
                    }
                    d.removeAttr("name").data({
                        "placeholder-enabled": !0,
                        "placeholder-password": f,
                        "placeholder-id": g
                    }).bind("focus.placeholder", l), f.data({
                        "placeholder-textinput": d,
                        "placeholder-id": g
                    }).before(d);
                }
                e.value = "", f = f.removeAttr("id").hide().prevAll('input[type="text"]:first').attr("id", f.data("placeholder-id")).show();
            } else i = f.data("placeholder-password"), i && (i[0].value = "", f.attr("id", f.data("placeholder-id")).show().nextAll('input[type="password"]:last').hide().removeAttr("id"));
            f.addClass(j.customClass), f[0].value = f.attr(b ? "placeholder-x" : "placeholder");
        } else f.removeClass(j.customClass);
    }
    function n() {
        try {
            return document.activeElement;
        } catch (a) {}
    }
    var h, i, b = !1, c = "[object OperaMini]" === Object.prototype.toString.call(window.operamini), d = "placeholder" in document.createElement("input") && !c && !b, e = "placeholder" in document.createElement("textarea") && !c && !b, f = a.valHooks, g = a.propHooks, j = {};
    d && e ? (i = a.fn.placeholder = function() {
        return this;
    }, i.input = !0, i.textarea = !0) : (i = a.fn.placeholder = function(c) {
        var e = {
            customClass: "placeholder"
        };
        return j = a.extend({}, e, c), this.filter((d ? "textarea" : ":input") + "[" + (b ? "placeholder-x" : "placeholder") + "]").not("." + j.customClass).not(":radio, :checkbox, [type=hidden]").bind({
            "focus.placeholder": l,
            "blur.placeholder": m
        }).data("placeholder-enabled", !0).trigger("blur.placeholder");
    }, i.input = d, i.textarea = e, h = {
        get: function(b) {
            var c = a(b), d = c.data("placeholder-password");
            return d ? d[0].value : c.data("placeholder-enabled") && c.hasClass(j.customClass) ? "" : b.value;
        },
        set: function(b, c) {
            var e, f, d = a(b);
            return "" !== c && (e = d.data("placeholder-textinput"), f = d.data("placeholder-password"), 
            e ? (l.call(e[0], !0, c) || (b.value = c), e[0].value = c) : f && (l.call(b, !0, c) || (f[0].value = c), 
            b.value = c)), d.data("placeholder-enabled") ? ("" === c ? (b.value = c, b != n() && m.call(b)) : (d.hasClass(j.customClass) && l.call(b), 
            b.value = c), d) : (b.value = c, d);
        }
    }, d || (f.input = h, g.value = h), e || (f.textarea = h, g.value = h), a(function() {
        a("form").on("submit", function() {
            var b = a("." + j.customClass, this).each(function() {
                l.call(this, !0, "");
            });
            setTimeout(function() {
                b.each(m);
            }, 30);
        });
    }), a(window).bind("beforeunload.placeholder", function() {
        var b = !0;
        try {
            "javascript:void(0)" === document.activeElement.toString() && (b = !1);
        } catch (c) {}
        b && a("." + j.customClass).each(function() {
            this.value = "";
        });
    }));
})(jQuery);

$(function(){

	//返回顶部
	$('.back-top').backTop();

	//placeholder设置
	var $placeholders = $('input[placeholder],textarea[placeholder]');
	if($placeholders.length > 0){
		$placeholders.placeholder();
	}

});