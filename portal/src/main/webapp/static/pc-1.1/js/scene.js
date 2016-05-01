$(function(){

	//图片轮播
	function roll($layer){
		var $img = [],
			cur, intval, lock = false,
			$handlers = $layer.find('div.handlerList');

		$layer.find('ul li').each(function(i){
			$img.push($(this));
			$handlers.append('<span></span>');
		});

		cur = $img.length - 1;
		cur = cur < 0 ? 0 : cur;

		$layer.find('div.list').on({
			mouseenter : function(){ lock = true;},
			mouseleave : function(){ lock = false;}
		});

		$layer.find('.handler-prev').click(function(){
			show(cur - 1);
		});

		$layer.find('.handler-next').click(function(){
			show(cur + 1);
		});

		function show(n){
			if(cur == n || lock){ loop(); return}
			else if(n < 0) n = $img.length - 1;
			else if(n > $img.length - 1) n = 0;
			$img[cur].stop().fadeOut('slow');
			$handlers.find('span:eq(' + cur + ')').removeClass('cur');
			$img[n].stop().fadeIn('slow');
			$handlers.find('span:eq(' + n + ')').addClass('cur');
			cur = n;
			loop();
		}

		function loop(){
			clearInterval(intval);
			intval = setTimeout(function(){ show(cur + 1)}, 5000);
		}

		show(0);
	
	}

	roll($('div.scene-show'));

});