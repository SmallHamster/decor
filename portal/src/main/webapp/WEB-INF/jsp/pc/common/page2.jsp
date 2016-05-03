<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="pagination">
    <a class="disabled first"></a>

    <a class="last"></a>
    <span class="p_text totalpage">共<span class="totalPage"></span>页， 到第</span>
    <input class="gotopage" type="text"/> 页
    <input type="button" class="confirm" value="确定" />
</div>


<script type="text/javascript">
    // 分页对象
    var lpage = {
        totalNum:0,
        totalPage:0,
        currentPage:1,
        pageNum:1, // 查询参数
        pageSize:10, // 查询参数
        queryFun:null, // 查询方法
        init:function(page,funName,$obj){
            lpage.queryFun=eval(funName); // 查询方法
            lpage.totalNum = page.totalNum;
            lpage.currentPage = page.currentPage;
            lpage.totalPage = page.totalPage;
            $obj.find(".pagination").find(".totalPage").html(lpage.totalPage); // 显示总页数
            $obj.find(".pagination").find(".gotopage").val(lpage.currentPage);

            // 分页页码处理
            var html = '';
                // 总页数<=10
                if(lpage.totalPage<=10){
                    for(var i=1;i<=lpage.totalPage;i++){
                        html+='<a class="mid">'+i+'</a>';
                    }
                }
                // 总页数>10   拼接成  123...45...1213
                else{
                    // 1
                    html+='<a class="mid">1</a>';
                    // ...和当前页之间
                    if(lpage.currentPage-1>4){
                        html+='<span class="dots mid">...</span>'
                        for(var j = lpage.currentPage-3;j<lpage.currentPage;j++){
                            html+='<a class="mid">'+j+'</a>';
                        }
                    }else{
                        for(var j = 2;j<lpage.currentPage;j++){
                            html+='<a class="mid">'+j+'</a>';
                        }
                    }
                    // 当前页
                    if(lpage.currentPage != 1){
                        html+='<a class="mid">'+lpage.currentPage+'</a>';
                    }
                    // 当前页和第2个...之间
                    if(lpage.totalPage-lpage.currentPage>4){
                        for(var j = lpage.currentPage+1;j<=lpage.currentPage+3;j++){
                            html+='<a class="mid">'+j+'</a>';
                        }
                        html+='<span class="dots mid">...</span>'

                    }else{
                        for(var j = lpage.currentPage+1;j<lpage.totalPage;j++){
                            html+='<a class="mid">'+j+'</a>';
                        }
                    }
                    // 末页
                    if(lpage.currentPage!=lpage.totalPage){
                        html+='<a class="mid">'+lpage.totalPage+'</a>';
                    }
                }
            $obj.find(".pagination").find(".mid").remove(); // 清除旧数据
            $obj.find(".pagination").find(".first").after(html);

            // 当前页样式
            $obj.find(".pagination").find("a").each(function(){
                if($(this).html()==lpage.currentPage){
                    $(this).addClass("current");
                }
            });

            // 添加点击事件
            $obj.find(".pagination").find("a").each(function(){
                if(!$(this).hasClass("first") && !$(this).hasClass("next")){
                    $(this).click(function(){
                        lpage.pageNum=$(this).html();
                        lpage.queryFun();
                    });
                }
            });
            $obj.find(".pagination").find(".first").unbind("click").click(function(){
                lpage.pageNum=lpage.pageNum-1;
                if(lpage.pageNum<=1){
                    lpage.pageNum=1;
                }
                lpage.queryFun();
            });
            $obj.find(".pagination").find(".last").unbind("click").click(function(){
                lpage.pageNum=lpage.pageNum+1;
                if(lpage.pageNum>=lpage.totalPage){
                    lpage.pageNum=lpage.totalPage;
                }
                lpage.queryFun();
            });
            $obj.find(".pagination").find(".confirm").unbind("click").click(function(){
                var pageNum = $(".pagination").find(".gotopage").val();
                var re = /^\d+$/;
                if(!re.test(pageNum)){
                    lpage.pageNum=1;
                }else{
                    if(pageNum<1 || pageNum>lpage.totalPage){
                        lpage.pageNum=1;
                    }else{
                        lpage.pageNum=pageNum*1;
                    }
                }
                lpage.queryFun();
            });

        },
        pageAttributeInit:function(){
            lpage.totalNum=0;
            lpage.totalPage=0;
            lpage.currentPage=1;
            lpage.pageNum=1;
            lpage.pageSize=10;
        }

    }
</script>
