$(function () {
    /* header交互*/ 
    //页头列表展开收起
    $('.header .nav').on('click',function  () {
        var $list = $('.header .list');
        $list.slideToggle();
    });
    // 点击搜索按钮切换
    $('.header .search').on('click',function  () {
        var $box = $('.header .searchBox'),
            $logo = $('.header .logo'),
            val = $('.header .searchBox .searchText').val();
        if ( $box.css('display') == "none" ) {
            $box.css('display','block');
            $logo.css('display','none');
        } else{
            if (val == "undefined" || val == "") {
                $box.css('display','none');
                $logo.css('display','inline-block');
            } else{
                //页面跳转代码
                var v = $("#searchType").html();
                var type = "goods";
                if(v == "设计师"){
                    type = "designer";
                }
                if(v == "作品"){
                    type = "series";
                }
                var name = val.trim();
                window.location.href='mobile/forward/to?type='+type+'&name='+name;
            }
        };
    });
    // 搜索列表展开收起
    $('.header .searchBox>span').on('click',function  () {
        var $list = $('.header .searchBox .typeList');
        $list.toggleClass('on');
        $(this).toggleClass('on');
    });

    $('.header .searchBox .typeList').on('click','li',function  () {
        var str = $(this).text();
        $('.header .searchBox>span').text(str);
        console.log($(this));
        $(this).parent().removeClass('on');
        $('.header .searchBox>span').removeClass('on');
        return false;
    });

    // 筛选展开收起
    $('.filterBox .filterBtn').on('click',function () {
        var box = $('.filterBox .detailBox'),
            b_h = box.height();
            console.log(b_h);
        if (box.css('display') == 'none') {
            box.css({
                'display':'block',
                'height':'0'
            });
            
            box.animate({
                'height': b_h
            });
        }else{
            box.animate({
                'height': 0
            },function  () {
                box.css({
                    'display':'none',
                    'height':'auto'
                });
            });
        }
    });
    // 点击取消 筛选收起
    $('.filterBox .conBottom .cancel').on('click',function () {
        var box = $('.filterBox .detailBox'),
            b_h = box.height();
            console.log(b_h);
        
        box.animate({
            'height': 0
        },function  () {
            box.css({
                'display':'none',
                'height':'auto'
            });
        });
        
    });

    // 分类切换
    $('.filterBox .tabsList').on('click','li',function () {
        var $this = $(this);
        $this.addClass('on').siblings().removeClass('on');
        
    });

});