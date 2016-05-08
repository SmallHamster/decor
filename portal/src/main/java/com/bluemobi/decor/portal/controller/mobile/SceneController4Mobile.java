package com.bluemobi.decor.portal.controller.mobile;

import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.PcPageFactory;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.*;
import com.bluemobi.decor.utils.JsonUtil;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/mobile/scene")
public class SceneController4Mobile extends CommonController {

    @Autowired
    private SeriesService seriesService;
    @Autowired
    private SceneGoodsService sceneGoodsService;
    @Autowired
    private SeriesSceneService seriesSceneService;
    @Autowired
    private SceneService sceneService;
    @Autowired
    private CommentService commentService;


    @RequestMapping(value = "/detail")
    public String detail(ModelMap modelMap,
                         HttpServletRequest request,
                         Integer sceneId){

        Scene scene = sceneService.getById(sceneId);
        sceneService.seeNumAdd(sceneId);
        List<Goods> goodsList = sceneGoodsService.findGoods(sceneId);
        modelMap.put("goodsNum",CollectionUtils.isEmpty(goodsList)?0:goodsList.size());
        User user=scene.getUser();
        if (user.getRoleType().equals("admin")||user.getRoleType()=="admin"){
            user.setNickname("Décor");
        }
        scene.setUser(user);
        modelMap.put("scene",scene);
        modelMap.put("goodsList",goodsList);

        List<Series> seriesList = seriesService.iFindSeriesByUser(user);
        if(CollectionUtils.isNotEmpty(seriesList)){
            modelMap.put("userSeriesNum",seriesList.size());
        }else {
            modelMap.put("userSeriesNum",0);
        }

        List<Comment> commentList = commentService.findListByObjectIdAndType(sceneId,"scene");
        modelMap.put("commentList",commentList);
        modelMap.put("commentNum",CollectionUtils.isEmpty(commentList)?0:commentList.size());

        //来自系列图
        String comeFromSeries = "";
        List<Series> list = seriesSceneService.findSeriesListBySceneId(sceneId);
        if(CollectionUtils.isNotEmpty(list)){
            comeFromSeries = list.get(0).getSeriesTag().getName();
        }
        modelMap.put("comeFromSeries",comeFromSeries);
        return "mobile/scene_detail";
    }



}
