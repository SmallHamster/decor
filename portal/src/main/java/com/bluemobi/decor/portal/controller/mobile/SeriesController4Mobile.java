package com.bluemobi.decor.portal.controller.mobile;

import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.Comment;
import com.bluemobi.decor.entity.Scene;
import com.bluemobi.decor.entity.Series;
import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.PcPageFactory;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.AttentionService;
import com.bluemobi.decor.service.CommentService;
import com.bluemobi.decor.service.SeriesSceneService;
import com.bluemobi.decor.service.SeriesService;
import org.apache.commons.collections.CollectionUtils;
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
@RequestMapping(value = "/mobile/series")
public class SeriesController4Mobile extends CommonController {

    @Autowired
    private SeriesService seriesService;
    @Autowired
    private SeriesSceneService seriesSceneService;
    @Autowired
    private AttentionService attentionService;
    @Autowired
    private CommentService commentService;

    @RequestMapping(value = "/page")
    public void list(HttpServletRequest request,
                     HttpServletResponse response,
                     Integer pageNum,
                     Integer pageSize,
                     String name,
                     Integer seriesTagId){
        try {
            if(pageNum == null){
                pageNum = 1;
            }
            if(pageSize == null){
                pageSize = 2;
            }
            Page<Series> page = seriesService.pcPage(pageNum, pageSize, name,seriesTagId);
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
                         Integer seriesId){
        Series series = seriesService.getById(seriesId);
        List<Scene> sceneList = seriesSceneService.findSceneListBySeriesId(seriesId);
        series.setSceneList(sceneList);
        User user=series.getUser();
        if (user.getRoleType().equals("admin")||user.getRoleType()=="admin"){
            user.setNickname("Décor");
        }

        List<Integer> list = attentionService.findFansNum(user);
        Integer attention = list.get(1);
        user.setAttention(attention);

        series.setUser(user);
        modelMap.put("series",series);
        seriesService.seeNumAdd(seriesId);

        List<Series> seriesList = seriesService.iFindSeriesByUser(user);
        if(CollectionUtils.isNotEmpty(seriesList)){
            modelMap.put("userSeriesNum",seriesList.size());
        }else {
            modelMap.put("userSeriesNum",0);
        }

        return "mobile/series_detail";
    }

    @RequestMapping(value = "/userSeries")
    public void userSeries(HttpServletRequest request, HttpServletResponse response, Integer pageNum,
                           Integer pageSize, Integer userId) {
        try {
            Page<Series> page = seriesService.pageOrderByPraise(pageNum, pageSize, userId);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    @RequestMapping(value = "/findSceneListBySeriesId")
    public void findSceneListBySeriesId(HttpServletRequest request,
                     HttpServletResponse response,
                     Integer seriesId){
        try {

            List<Scene> sceneList = seriesSceneService.findSceneListBySeriesId(seriesId);
            if(CollectionUtils.isNotEmpty(sceneList)){
                for (Scene scene : sceneList) {
                    List<Comment> commentList = commentService.findListByObjectIdAndType(scene.getId(),"scene");
                    scene.setCommentNum(CollectionUtils.isEmpty(commentList)?0:commentList.size());
                }
            }
            WebUtil.print(response, new Result(true).data(sceneList));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

}
