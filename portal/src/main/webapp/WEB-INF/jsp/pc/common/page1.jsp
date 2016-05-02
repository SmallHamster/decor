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
    var epage = {
        totalNum:0,
        totalPage:0,
        currentPage:1,
        pageNum:1, // 查询参数
        pageSize:10, // 查询参数
        queryFun:null, // 查询方法
        init:function(page,funName,$obj){
            epage.queryFun=eval(funName); // 查询方法
            epage.totalNum = page.totalNum;
            epage.currentPage = page.currentPage;
            epage.totalPage = page.totalPage;
            $obj.find(".pagination").find(".totalPage").html(epage.totalPage); // 显示总页数
            $obj.find(".pagination").find(".gotopage").val(epage.currentPage);

            // 分页页码处理
            var html = '';
                // 总页数<=10
                if(epage.totalPage<=10){
                    for(var i=1;i<=epage.totalPage;i++){
                        html+='<a class="mid">'+i+'</a>';
                    }
                }
                // 总页数>10   拼接成  123...45...1213
                else{
                    // 1
                    html+='<a class="mid">1</a>';
                    // ...和当前页之间
                    if(epage.currentPage-1>4){
                        html+='<span class="dots mid">...</span>'
                        for(var j = epage.currentPage-3;j<epage.currentPage;j++){
                            html+='<a class="mid">'+j+'</a>';
                        }
                    }else{
                        for(var j = 2;j<epage.currentPage;j++){
                            html+='<a class="mid">'+j+'</a>';
                        }
                    }
                    // 当前页
                    if(epage.currentPage != 1){
                        html+='<a class="mid">'+epage.currentPage+'</a>';
                    }
                    // 当前页和第2个...之间
                    if(epage.totalPage-epage.currentPage>4){
                        for(var j = epage.currentPage+1;j<=epage.currentPage+3;j++){
                            html+='<a class="mid">'+j+'</a>';
                        }
                        html+='<span class="dots mid">...</span>'

                    }else{
                        for(var j = epage.currentPage+1;j<epage.totalPage;j++){
                            html+='<a class="mid">'+j+'</a>';
                        }
                    }
                    // 末页
                    if(epage.currentPage!=epage.totalPage){
                        html+='<a class="mid">'+epage.totalPage+'</a>';
                    }
                }
            $obj.find(".pagination").find(".mid").remove(); // 清除旧数据
            $obj.find(".pagination").find(".first").after(html);

            // 当前页样式
            $obj.find(".pagination").find("a").each(function(){
                if($(this).html()==epage.currentPage){
                    $(this).addClass("current");
                }
            });

            // 添加点击事件
            $obj.find(".pagination").find("a").each(function(){
                if(!$(this).hasClass("first") && !$(this).hasClass("next")){
                    $(this).click(function(){
                        epage.pageNum=$(this).html();
                        epage.queryFun();
                    });
                }
            });
            $obj.find(".pagination").find(".first").unbind("click").click(function(){
                epage.pageNum=epage.pageNum-1;
                if(epage.pageNum<=1){
                    epage.pageNum=1;
                }
                epage.queryFun();
            });
            $obj.find(".pagination").find(".last").unbind("click").click(function(){
                epage.pageNum=epage.pageNum+1;
                if(epage.pageNum>=epage.totalPage){
                    epage.pageNum=epage.totalPage;
                }
                epage.queryFun();
            });
            $obj.find(".pagination").find(".confirm").unbind("click").click(function(){
                var pageNum = $(".pagination").find(".gotopage").val();
                var re = /^\d+$/;
                if(!re.test(pageNum)){
                    epage.pageNum=1;
                }else{
                    if(pageNum<1 || pageNum>epage.totalPage){
                        epage.pageNum=1;
                    }else{
                        epage.pageNum=pageNum*1;
                    }
                }
                epage.queryFun();
            });

        },
        pageAttributeInit:function(){
            epage.totalNum=0;
            epage.totalPage=0;
            epage.currentPage=1;
            epage.pageNum=1;
            epage.pageSize=10;
        }

    }
</script>
