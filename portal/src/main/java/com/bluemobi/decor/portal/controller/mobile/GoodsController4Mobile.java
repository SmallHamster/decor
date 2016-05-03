package com.bluemobi.decor.portal.controller.mobile;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.PcPageFactory;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.CommentService;
import com.bluemobi.decor.service.GoodsImageService;
import com.bluemobi.decor.service.GoodsService;
import com.bluemobi.decor.service.SceneGoodsService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/mobile/goods")
public class GoodsController4Mobile extends CommonController {

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private GoodsImageService goodsImageService;
    @Autowired
    private SceneGoodsService sceneGoodsService;

    @RequestMapping(value = "/page")
    public void list(HttpServletRequest request,
                     HttpServletResponse response,
                     Integer pageNum,
                     Integer pageSize,
                     String name,
                     Integer kindTagId,
                     Integer spaceTagId,
                     Integer styleTagId,
                     Integer userId){
        try {
            if(pageNum == null){
                pageNum = 1;
            }
            if(pageSize == null){
                pageSize = 20;
            }
            Page<Goods> page = goodsService.pcPage(pageNum, pageSize, name,kindTagId, spaceTagId, styleTagId);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    @RequestMapping(value = "/detail")
    public String detail(ModelMap modelMap,
                         HttpServletRequest request,
                         Integer goodsId){
        Goods goods = goodsService.getById(goodsId);
        String tagHtml = "";
        if(StringUtils.isNotEmpty(goods.getTagsStr())){
            String[] arr = goods.getTagsStr().split(",");
            for (int i = 0; i < arr.length; i++) {
                tagHtml += "<li class=\"lab\">"+arr[i]+"</li>";
            }
        }else {
            goods.setTagsStr("");
        }
        List<GoodsImage> goodsImageList = goodsImageService.listByGoodsId(goodsId);
        goods.setGoodsImageList(goodsImageList);
        User user=goods.getUser();
        if (user.getRoleType().equals("admin")||user.getRoleType()=="admin"){
            user.setNickname("Décor");
        }
        goods.setUser(user);
        modelMap.put("goods",goods);
        modelMap.put("tagHtml",tagHtml);
        goodsService.seeNumAdd(goodsId);
        // 查询评论
        List<Comment> commentList = commentService.findListByObjectIdAndType(goodsId,"goods");
        modelMap.put("commentList",commentList);
        modelMap.put("commentNum", CollectionUtils.isEmpty(commentList)?0:commentList.size());
        return "mobile/goods_detail";
    }

    // ajax查询商品所属场景图
    @RequestMapping(value = "/ajaxSceneByGoodsId")
    public void ajaxSceneByGoodsId(HttpServletRequest request,
                                   HttpServletResponse response,
                                   Integer goodsId){
        try {
            List<Scene> sceneList = sceneGoodsService.listSceneByGoodsId(goodsId);
            WebUtil.print(response, new Result(true).data(sceneList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // ajax查询同类型商品
    @RequestMapping(value = "/ajaxSameTypeGoods")
    public void ajaxSameTypeGoods(HttpServletRequest request,
                                  HttpServletResponse response,
                                  Integer goodsId){
        try {
            List<Goods> goodsList = goodsService.sameTypeGoods(goodsId);
            WebUtil.print(response, new Result(true).data(goodsList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

}
