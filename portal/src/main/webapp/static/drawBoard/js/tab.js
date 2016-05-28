$(function(){
	$('.crawTabs .hd li').click(function(){
		$(this).addClass('on').siblings().removeClass('on');
		var index = $(this).index();
		$('.crawTabs .bd .con').hide();
		$('.crawTabs .bd .con').eq(index).show();
	})
	$('.slideList li').click(function(){
        if($(this).hasClass("on")){
            $(this).removeClass('on').find('dl').hide();
        }else{
            $(this).addClass('on').find('dl').show();
        }
	})


    //标签增加删除
    var click = $('.classList li a');
    function add(Name) {
                var add_li = $('<li class="on"><b>' + Name + '</b><span>×</span></li>');
                $('.crawTabs .hd ul').append(add_li);
                $('.crawTabs .bd').find('.con').remove();
            }
    click.click(function() {
        var texts = $(this).find('p').text();
        var href = $(this).attr("name");
        var show1a = $('.crawTabs .hd li b');
        var nowgeshu = $('.crawTabs .hd li').length;
        for (var i = 0; i < show1a.length; i++) {
            if (show1a.eq(i).text() == texts) {
                alert("您已打开了一个相同的标签页！")
                return false;
            }
        }
        if (nowgeshu < 5) {
            $('.crawTabs .hd li').removeClass('on');
            add(texts);
            $('#load').empty();
            $('#load').load(href);
        }else{
            alert('您已打开了3个标签。请关闭部分标签后再打开新标签！');
            return false;
        }
    })
    $('.crawTabs .hd').on('click','ul li span',function(event){
                if($(this).parent().hasClass('on')){
                    $('.crawTabs .hd li').eq($('.crawTabs .hd li').length-2).addClass('on');
                }
                var index = $('.crawTabs .hd li').index($(this).parent());
                $(this).parent().remove();
                $('#load').empty();
                /*$('#div3 iframe').eq(index).remove();
                if($('#div3 iframe:visible').length==0){
                    $('#div3 iframe:last-child').show();
                }*/
                event.stopPropagation();
            })


})