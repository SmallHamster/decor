
$(function(){
        $('.crawTabs .hd li').click(function(){
            if($(this).hasClass("personal")){
                if ($("#sessionUserId").val() == "") {
                    loginPopup.showDlg();
                    return false;
                }else {
                    if($(".imgList").find("ul").html().trim()==""){
                        pageMyCollection();
                    }
                }
            }
            $(this).addClass('on').siblings().removeClass('on');
            var index = $(this).index();
            //$('#load').empty();
            $('#load').empty();
            $('.crawTabs .bd .con').hide();
            $('.crawTabs .bd .con').eq(index).show();
        });
    
    //下拉
    $('.s_xl li').click(function(){
        $(this).find("dl").toggle();
    })

    //标签增加删除
    //var click = $('.goods li a');




    
    drop();
})

function kindTagClick(){
    $('.kindTag li a').click(function() {
        var texts = $(this).find('p').text();
        var show1a = $('.crawTabs .hd li b');
        var nowgeshu = $('.crawTabs .hd li').length;
        for (var i = 0; i < show1a.length; i++) {
            if (show1a.eq(i).attr("title") == texts) {
                $bluemobi.notify("您已打开了一个相同的标签页！", "error");
                return false;
            }
        }
        if (nowgeshu < 5) {
            $.ajax({
                type: 'get',
                url: 'pc/goods/pageGoodsImageByKindTag',
                data: {kindTagId:$(this).attr("kindtagid")},
                async: false,
                dataType: 'json',
                success: function (result) {
                    if (result.status!="0") {
                        $bluemobi.notify(result.msg, "error");
                    } else {
                        // 数据加载成功
                        $('.crawTabs .hd li').removeClass('on');
                        addTab(texts);
                        $('.crawTabs .bd').find('.con').hide();
                        var divhtml='<div class="con">\
                            <div class="tabscon">\
                            <div class="slideBox proClass">\
                            <div class="classList">\
                            <ul class="clearfix">\
                            </ul>\
                            </div>\
                            </div>\
                            </div>\
                            </div>';
                        $('.crawTabs .bd').append(divhtml);

                        // 组装数据
                        var html='';
                        for(var i=0;i<result.data.list.length;i++){
                            var goods = result.data.list[i].goods;
                            if(goods && goods != null && goods != "null"){
                                html+='<li><a ><img src="'+goods.cover+'" alt="" /></a></li>';
                            }
                        }
                        if(html==''){
                            html="暂无数据";
                        }
                        $('.crawTabs .bd .con').last().find("ul").html(html);
                    }
                },
                error: function (err) {
                    $bluemobi.notify("系统异常，请刷新页面后重试！", "error");
                }
            });
        }else{
            $bluemobi.notify("您已打开了3个标签。请关闭部分标签后再打开新标签！", "error");
            return false;
        }

        $('.crawTabs .hd li').click(function(){
            $(this).addClass('on').siblings().removeClass('on');
            var index = $(this).index();
            //$('#load').empty();
            $('#load').empty();
            $('.crawTabs .bd .con').hide();
            $('.crawTabs .bd .con').eq(index).show();
        })
    })
}

function addTab(Name){
    var showName = "";
    if(Name && Name.length>3){
        showName = Name.substring(0,3);
    }
    var add_li = $('<li class="on"><b title="'+Name+'">'+showName+'</b><span class="godel">×</span></li>');
    $('.crawTabs .hd ul').append(add_li);
    $('.crawTabs .bd').find('.con').hide();
    $(".godel").unbind("click").click(function(){
        var index = $('.crawTabs .hd li').index($(this).parent());
        $(this).parent().remove();
        $('.crawTabs .hd li').eq(index-1).addClass('on');
        $('.crawTabs .bd .con').hide();
        $('.crawTabs .bd .con').eq(index).remove();
        $('.crawTabs .bd .con').eq(index-1).show();
    });
}


    //商品详情
    function info(){
        $('.nlist li').click(function(){
            var y = $(this).offset().top;
            var x = $(this).offset().left;
            $(this).siblings().find(".imgInfo").hide();
            $(this).find('.imgInfo').css({
                top: y,
                left: x-340
            }).show();
        })
        $('.close').click(function(event){
            event.stopPropagation();
            $('.imgInfo').hide();
        })
        $('select').searchableSelect();
        $('.searchable-select:last-child').css('float','right');
    }
    
    //拖拽
    function drop(){
        $('.drop').draggable({
            appendTo: "#container",
            helper:"clone" ,
            cursor: "move",
            cursorAt: { top: 56, left: 56 }
        })
        $("#container").droppable({
            accept: '.drop',
            drop: function(event, ui) {
                if($(ui.helper).hasClass('bg')){
                    $(ui.helper).clone().attr("class", "drop1").zIndex(-999).appendTo($(this));
                }else{
                    $(ui.helper).clone().attr("class", "drop1").zIndex(1).appendTo($(this));
                }
            $(".drop1").draggable({
                containment: 'parent',
                cursor: "move",
                handle: "img"
            });
            select();
            del();
            sy();
            xy();
            fx();
            fy();
            leftx();
            rightx();
            big();
            small();
            }
        }); 
    }
    
    
    //选中
    function select(){
        var dian = '<span class="rotatetip"></span><span class="resize-handle resize-handle-nw"></span><span class="resize-handle resize-handle-sw"></span><span class="resize-handle resize-handle-ne"></span><span class="resize-handle resize-handle-se"></span>'
        $('.drop1').click(function(event){
            event.stopPropagation();
            $(this).addClass('imgselected').siblings().removeClass('imgselected');
            if ($(this).has('span').length != 0) {

            }else{
                $(this).append(dian).siblings().find('span').remove();
            };
            resize();
            rotate();
        })

        $('#container').click(function(){
            $(this).find('.drop1').removeClass('imgselected').find('span').remove();
        })
    }

    function rotate(){
        var isrotate;
        var currentTarget = $('.imgselected');
        var oh = currentTarget.height();
        var ow = currentTarget.width();
        var x = currentTarget.offset().left + ow/2,y = currentTarget.offset().top + oh/2;
        var x1 = x,y1 = y-oh/2-25;
        $('.imgselected').on('mousedown', '.rotatetip', function(e) {
            isrotate = true;
            //计算圆心坐标
            $(document).mousemove(function(event){
                if (isrotate==false){
                    return false;
                } 
                $('body').css('cursor','url(images/rotate_arrow.cur) 13 4, crosshair');
                var x2 = event.pageX,y2 = event.pageY;
                var a=Math.sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
                var b=Math.sqrt((x-x2)*(x-x2)+(y-y2)*(y-y2));
                var c=Math.sqrt((x1-x)*(x1-x)+(y1-y)*(y1-y));
                var cosA=(b*b+c*c-a*a)/(2*b*c);
                var arcA = Math.acos(cosA);
                angle = arcA * 180 /Math.PI;
                if(x2<x1){
                    currentTarget.rotate(-angle);
                }
                else{
                    currentTarget.rotate(angle);
                }
            })
            $(document).mouseup(function() {
                isrotate=false;
                $('body').css('cursor','default');
             });
        });
    }

    //放大缩小

    function resize(){
        var isResize;
        var isStartResize;
        var ex,ey,ox,oy,oh,ow,x,y,bl;
        var currentTarget = $('.imgselected');
        
        $('.imgselected').on('mousedown', '.resize-handle-nw', function(e) {
            e.stopPropagation();
            isResize=true;
            ex = e.clientX;
            ey = e.clientY;
            ox = currentTarget.position().left;
            oy = currentTarget.position().top;
            oh = currentTarget.height();
            ow = currentTarget.width();
            bl = ow/oh;
            currentTarget.attr("mode", "re");
            $(document).mousemove(function(event) {
                if (currentTarget.attr("mode") == "me"||isResize==false){
                    return false;
                } 
                isStartResize=true;
                x=event.clientX-ex;
                y=event.clientY-ey;
                currentTarget.css({
                    height: (ow-x)/bl + "px",
                    width: ow-x + "px",
                    left: ox+x + "px",
                    top:oy-(ow-x)/bl + oh+"px"
                });
                currentTarget.find('img').css("height", (ow-x)/bl + "px").css("width", ow-x + "px");
            })
             $(document).mouseup(function() {
                isResize=false;
                isStartResize=false;
                currentTarget.attr("mode", "me");
             });
        });

        $('.imgselected').on('mousedown', '.resize-handle-sw', function(e) {
            isResize=true;
            ex = e.clientX;
            ey = e.clientY;
            ox = currentTarget.position().left;
            oy = currentTarget.position().top;
            oh = currentTarget.height();
            ow = currentTarget.width();
            bl = ow/oh;
            currentTarget.attr("mode", "re");
            resizeMode = 0;
            $(document).mousemove(function(event) {
                if ($(currentTarget).attr("mode") == "me"||isResize==false){
                    return false;
                } 
                isStartResize=true;
                x=event.clientX-ex;
                y=event.clientY-ey;
                currentTarget.css({
                    height: oh+y + "px",
                    width: (oh+y)*bl + "px",
                    left: ox-(oh+y)*bl+ow + "px",
                    top:oy + "px"
                });
                currentTarget.find('img').css("height", oh+y + "px").css("width", (oh+y)*bl + "px");
            })
             $(document).mouseup(function() {
                        isResize=false;
                        isStartResize=false;
                    });
        });

        $('.imgselected').on('mousedown', '.resize-handle-ne', function(e) {
            isResize=true;
            ex = e.clientX;
            ey = e.clientY;
            ox = currentTarget.position().left;
            oy = currentTarget.position().top;
            oh = currentTarget.height();
            ow = currentTarget.width();
            bl = ow/oh;
            currentTarget.attr("mode", "re");
            $(document).mousemove(function(event) {
                if (currentTarget.attr("mode") == "me"||isResize==false){
                    return false;
                } 
                isStartResize=true;
                x=event.clientX-ex;
                y=event.clientY-ey;
                currentTarget.css({
                    height: (ow+x)/bl + "px",
                    width: ow+x + "px",
                    top:oy-(ow+x)/bl+oh+"px",
                    left:ox +"px"
                });
                currentTarget.find('img').css("height", (ow+x)/bl + "px").css("width", ow+x + "px");
            })
             $(document).mouseup(function() {
                        isResize=false;
                        isStartResize=false;
                    });
        });

        $('.imgselected').on('mousedown', '.resize-handle-se', function(e) {
            isResize=true;
            ex = e.clientX;
            ey = e.clientY;
            ox = currentTarget.position().left;
            oy = currentTarget.position().top;
            oh = currentTarget.height();
            ow = currentTarget.width();
            bl = ow/oh;
            currentTarget.attr("mode", "re");
            $(document).mousemove(function(event) {
                if (currentTarget.attr("mode") == "me"||isResize==false){
                    return false;
                } 
                isStartResize=true;
                x=event.clientX-ex;
                y=event.clientY-ey;
                currentTarget.css({
                    height: (ow+x)/bl + "px",
                    width: ow+x + "px",
                    top:oy + "px",
                    left:ox + "px"
                });
                currentTarget.find('img').css("height", (ow+x)/bl + "px").css("width", ow+x + "px");
            })
             $(document).mouseup(function() {
                        isResize=false;
                        isStartResize=false;
                    });
        });

        /*$('.imgselected').mousedown(function(e) {
            isResize=true;
            var currentDisX = e.pageX - $(this).offset().left;
            var currentDisY = e.pageY - $(this).offset().top;
            if ($(this).width() - currentDisX < currentDisTance && ($(this).height() - currentDisY) < currentDisTance) {
                //$(this).css("cursor", "nw-resize");
                $(this).attr("mode", "re");
                resizeMode = 0;
            } else if ($(this).width() - currentDisX < currentDisTance ) {
                $(this).css("cursor", "e-resize");
                $(this).attr("mode", "re");
                resizeMode = 1;
            } else if ($(this).height() - currentDisY < currentDisTance) {
                $(this).css("cursor", "n-resize");
                $(this).attr("mode", "re");
                resizeMode = 2;
            } else {
                if(isStartResize==true)return;
                $(this).css("cursor", "default");
                $(this).attr("mode", "me");
            }
            var currentTarget = $(this);
            var offsetWidth=$(this).width()-$(currentTarget).offset().left;
            var offsetHeight=$(this).height()-$(currentTarget).offset().top;
            $(document).mousemove(function(event) {
                        if ($(currentTarget).attr("mode") == "me"||isResize==false) return;
                        isStartResize=true;
                        var currentX = event.clientX;
                        var currentY = event.clientY;
                        var cursorX = event.pageX - currentDisX; //+$(this).offset().left;
                        var cursorY = event.pageY - currentDisY; //-$(this).offset().top;
                        if (resizeMode == 0) {$(currentTarget).css("height", cursorY+offsetHeight + "px").css("width", cursorX+offsetWidth + "px");$(currentTarget).find('img').css("height", cursorY+offsetHeight + "px").css("width", cursorX+offsetWidth + "px");}
                        else if (resizeMode == 1) {$(currentTarget).css("width", cursorX+offsetWidth + "px");$(currentTarget).find('img').css("width", cursorX+offsetWidth + "px");}
                        else {$(currentTarget).css("height", cursorY+offsetHeight + "px");$(currentTarget).find('img').css("height", cursorY+offsetHeight + "px");}
                    });
                });*/
           
    }
    //删除
    function del(){
        $('.del').click(function(event){
            event.stopPropagation();
            $('.imgselected').remove();
        })
    }

    //复制
    //function clone(){
        $('.fz').click(function(event){
            var left = $('.drop1.imgselected').position().left+20;
            var top = $('.drop1.imgselected').position().top+20;
            var a = $('.imgselected').clone();
            a.css({
                left: left,
                top: top
            })
            $('.drop1').removeClass('imgselected').find('span').remove();
            $("#container").append(a);
            $(".drop1").draggable({
                containment: 'parent',
                cursor: "move",
                handle: "img"
            });
            //$('.drop1').removeClass('imgselected');
            select();
        })
    //}

    //上移一层
    function sy(){
        
        $('.sy').click(function(event){
            event.stopPropagation();
            var zindex = $('.imgselected').zIndex();
            $('.imgselected').zIndex(zindex+1);
        })
    }

    //下移一层
    function xy(){
        $('.xy').click(function(event){
            event.stopPropagation();
            var zindex = $('.imgselected').zIndex();
            $('.imgselected').zIndex(zindex-1);
        })
    }

    //水平翻转
    function fx(){
        var n = 180;
        $('.fx').click(function(event){
            event.stopPropagation();
            $('.imgselected').find('img').css({
                filter: 'fliph',
                transform:"rotateY(" + n + "deg)" ,
                webkitTransform:"rotateY(" + n + "deg)",
                OTransform:"rotateY(" + n + "deg)",
                MozTransform:"rotateY(" + n + "deg)"
            });
            if(n==180){
                n=360
            }else{
                n=180
            }
        })
    }

    //垂直翻转
    function fy(){
        var n = 180;
        $('.fy').click(function(event){
            event.stopPropagation();
            $('.imgselected').find('img').css({
                filter: 'flipv',
                transform:"rotateX(" + n + "deg)" ,
                webkitTransform:"rotateX(" + n + "deg)",
                OTransform:"rotateX(" + n + "deg)",
                MozTransform:"rotateX(" + n + "deg)"
            });
            if(n==180){
                n=360
            }else{
                n=180
            }
        })
    }

    //向左旋转
    function leftx(){
        var angle = 1;
        $('.leftx').click(function(event){
            event.stopPropagation();
             //$('.imgselected').rotate(-angle*15);
             $('.imgselected').css({
                 transform: 'rotate('+ -angle*15 +'deg)',
                 webkitTransform: 'rotate('+ -angle*15 +'deg)',
                 OTransform: 'rotate('+ -angle*15 +'deg)',
                 MozTransform: 'rotate('+ -angle*15 +'deg)'
                 /*-webkit-transform: rotate(angle*15+'deg'),
                 -moz-transform: rotate(angle*15+'deg'),
                 -o-transform: rotate(angle*15+'deg'),
                 -ms-transform: rotate(angle*15+'deg')*/
             });
             angle++;
        })
    }

    //向右旋转
    function rightx(){
        var angle = 1;
        $('.rightx').click(function(event){
            event.stopPropagation();
             $('.imgselected').rotate(angle*15);
             angle++;
        })
    }

    //放大
    function big(){
        
        var w = $("#container").width();
        var h = $("#container").height();
        $('.big').click(function(event){
            event.stopPropagation();
            var img_w = $('.imgselected').width();
            var img_h = $('.imgselected').height();
            if(img_w<w-15 && img_h<h-15){
                $('.imgselected').width(img_w+10);
                $('.imgselected').find('img').width(img_w+10);
                $('.imgselected').height(img_h + 10/img_w*img_h);
                $('.imgselected').find('img').height(img_h + 10/img_w*img_h);
            }
        })
    }

    //缩小
    function small(){
        
        var w = $("#container").width();
        var h = $("#container").height();
        $('.small').click(function(event){
            event.stopPropagation();
            var img_w = $('.imgselected').width();
            var img_h = $('.imgselected').height();
            if(img_w>25 && img_h>25){
                $('.imgselected').width(img_w-10);
                $('.imgselected').find('img').width(img_w-10);
                $('.imgselected').height(img_h - 10/img_w*img_h);
                $('.imgselected').find('img').height(img_h - 10/img_w*img_h);
            }
        })
    }

    //新建
    $('.news').click(function(){
        $('a').remove(".drop1");
    })

    //保存为图片
    function save(){
        //$('#container').Jcrop();
        $('.drop1').removeClass('imgselected').find('span').remove();
        html2canvas( $('#container') ,{
            onrendered: function(canvas){
                document.body.appendChild(canvas);
                var img = canvas.toDataURL("image/png")
                //alert(img)
                //console.log(img)
                //window.location.href=img;
                uploadBase64(img)
            }
        })
    }

    function uploadBase64(image) {
        $.ajax({
            type: 'POST',
            url: 'pc/upload/uploadBase64ImageToQiniu',
            data: {image: image,userId:$("#sessionUserId").val()},
            async: false,
            dataType: 'json',
            success: function (data) {
                if (data.status=="0") {
                    $bluemobi.notify("保存成功", "success");
                } else {
                    $bluemobi.notify(data.msg, "error");
                }
            },
            error: function (err) {
                $bluemobi.notify("系统异常，请刷新页面后重试！", "error");
            }
        });
    }






