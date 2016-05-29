package com.bluemobi.decor.portal.controller.pc;

import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.CollectionMaterial;
import com.bluemobi.decor.entity.Goods;
import com.bluemobi.decor.entity.GoodsImage;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.PcPageFactory;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.GoodsImageService;
import com.bluemobi.decor.service.GoodsService;
import com.bluemobi.decor.service.MaterialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * 素材Controller
 */
@Controller
@RequestMapping(value = "/pc/material")
public class MaterialController4Pc extends CommonController {
    @Autowired
    private MaterialService materialService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private GoodsImageService goodsImageService;

    // 我收藏的素材图
    @RequestMapping(value = "/pageMyCollection")
    public void pageMyCollection(HttpServletResponse response,
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
                pageSize = 12;
            }
            if (null == userId) {
                WebUtil.printApi(response, new Result(false).msg("用户身份失效，请登录后重试"));
                return;
            }
            Page<CollectionMaterial> page = materialService.pageMyCollection(
                    pageNum, pageSize, userId,name,kindTagId,spaceTagId,styleTagId,null);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("系统异常，请刷新页面后重试!"));
        }
    }

    // 查询有素材图的商品
    @RequestMapping(value = "/pageGoodsHasMaterial")
    public void pageGoodsHasMaterial(HttpServletResponse response,
                                 Integer pageNum,
                                 Integer pageSize,
                                 String name,
                                 Integer kindTagId,
                                 Integer spaceTagId,
                                 Integer styleTagId){
        try {
            if(pageNum == null){
                pageNum = 1;
            }
            if(pageSize == null){
                pageSize = 20;
            }
            Page<Goods> page = goodsService.pageHasMaterial(
                    pageNum, pageSize,name,kindTagId,spaceTagId,styleTagId,null);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("系统异常，请刷新页面后重试!"));
        }
    }

    // 查询有素材图的商品
    @RequestMapping(value = "/getGoodsMaterial")
    public void getGoodsMaterial(HttpServletResponse response,
                                 Integer goodsId){
        try {
            List<GoodsImage> list = goodsImageService.listByGoodsId(goodsId);
            WebUtil.print(response, new Result(true).data(list));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("系统异常，请刷新页面后重试!"));
        }
    }

}
