package com.bluemobi.decor.portal.controller.pc;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.PcPageFactory;
import com.bluemobi.decor.portal.util.SessionUtils;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 系列图
 * Created by gaoll on 2015/3/3.
 */
@Controller
@RequestMapping(value = "/pc/series")
public class SeriesController4Pc extends CommonController {

    @Autowired
    private SeriesTagService seriesTagService;

    @Autowired
    private SeriesService seriesService;

    @Autowired
    private SeriesSceneService seriesSceneService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private CollectionService collectionService;

    @Autowired
    private PraiseService praiseService;

    @Autowired
    private AttentionService attentionService;
    @Autowired
    private SceneGoodsService sceneGoodsService;

    // 查询page
    @RequestMapping(value = "/page")
    public void list(HttpServletRequest request,
                     HttpServletResponse response,
                     Integer pageNum,
                     Integer pageSize,
                     String name,
                     Integer seriesTagId,
                     Integer userId){
        try {
            if(pageNum == null){
                pageNum = 1;
            }
                pageSize = 4;
            Page<Series> page = seriesService.pcPage(pageNum, pageSize, name, seriesTagId);
            for (Series series:page.getContent()){
                Integer seriesId = series.getId();
                List<Scene> sceneList = seriesSceneService.findSceneListBySeriesId(seriesId);
                // 场景数量
                if(sceneList == null){
                    series.setSceneNum(0);
                }else {
                    series.setSceneNum(sceneList.size());
                }

                // 设置第2张显示图片
                series.setImage("");
                for (int i = 0; i < sceneList.size(); i++) {
                    Scene scene = sceneList.get(i);
                    if(!series.getCover().equals(scene.getImage())){
                        series.setImage(scene.getImage());
                    }
                }
                if(StringUtils.isEmpty(series.getImage())){
                    series.setImage(series.getCover());
                }

                // 是否收藏
                Boolean flag2 = collectionService.isCollectionSeries(userId, seriesId);
                if(flag2){
                    series.setIsCollection("yes");
                }else {
                    series.setIsCollection("no");
                }
                User user=series.getUser();
                if (user.getRoleType().equals("admin")||user.getRoleType()=="admin"){
                    user.setNickname("Décor");
                }
                series.setUser(user);
            }
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // ajax 系列图分类列表
    @RequestMapping(value = "/ajaxSeriesTagList")
    public void ajaxSeriesTagList(HttpServletRequest request,
                                HttpServletResponse response){
        try {
            List<SeriesTag> list = seriesTagService.all();
            WebUtil.print(response, new Result(true).data(list));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // forward to 详情页
    @RequestMapping(value = "/detail")
    public String detail(ModelMap modelMap,
                     HttpServletRequest request,
                     Integer seriesId){
        Series series = seriesService.getById(seriesId);
        List<Scene> sceneList = seriesSceneService.findSceneListBySeriesId(seriesId);
        if(CollectionUtils.isNotEmpty(sceneList)){
            for(Scene scene : sceneList){
                // 评论数
                List<Comment> commentList = commentService.findListByObjectIdAndType(scene.getId(),"scene");
                scene.setCommentNum(CollectionUtils.isEmpty(commentList)?0:commentList.size());
                // 商品数
                List<SceneGoods> goodsList = sceneGoodsService.listBySceneId(scene.getId());
                scene.setGoodsNum(CollectionUtils.isEmpty(goodsList)?0:goodsList.size());
            }
        }
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

        String infoHtml = "";
        List<Series> seriesList = seriesService.findSeriesByUser(user);
        if(CollectionUtils.isNotEmpty(seriesList)){
            modelMap.put("userSeriesNum",seriesList.size());
            Series series1 = seriesList.get(0);
            if(series1.getSeriesTag() != null && series1.getSeriesTag().getName() != null){
                infoHtml = "<h3>刚刚更新了设计系列图：<strong><a href=\"pc/series/detail?seriesId="+series1.getId()+"\">《"+series1.getSeriesTag().getName()+"》</a></strong></h3>";
            }
        }else {
            modelMap.put("userSeriesNum",0);
        }
        modelMap.put("infoHtml",infoHtml);

        return "pc/系列图详情";
    }


    // ajax系列图评论列表
    @RequestMapping(value = "/ajaxSeriesComment")
    public void ajaxSeriesComment(HttpServletRequest request,
                                 HttpServletResponse response,
                                 Integer seriesId){
        try {
            User user = (User) SessionUtils.get(Constant.SESSION_PC_USER);
            List<Comment> commentList = commentService.listCommentIncludeReply(seriesId,"series");
            for (Comment comment : commentList){
                comment.setIsPraise("no");
                if(user != null){
                    Integer userId = user.getId();
                    Integer commentId = comment.getId();
                    Boolean flag = praiseService.isPraise(userId, commentId, Constant.PRAISE_TYPE_COMMENT);
                    if(flag){
                        comment.setIsPraise("yes");
                    }
                }
                if(comment.getReplyList() != null && comment.getReplyList().size() > 0){
                    for (Reply reply : comment.getReplyList()){
                        reply.setIsPraise("no");
                        if(user != null){
                            Integer replyId = reply.getId();
                            Boolean flag = praiseService.isPraise(user.getId(), replyId, Constant.PRAISE_TYPE_COMMENT);
                            if(flag){
                                reply.setIsPraise("yes");
                            }
                        }
                    }
                }
            }
            WebUtil.print(response, new Result(true).data(commentList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // ajax查询同类型商品
    @RequestMapping(value = "/ajaxSameTypeSeries")
    public void ajaxSameTypeSeries(HttpServletRequest request,
                                  HttpServletResponse response,
                                  Integer seriesId){
        try {
            List<Series> seriesList = seriesService.sameTypeSeries(seriesId);
            List<Series> newList = new ArrayList<Series>();
            if(CollectionUtils.isNotEmpty(seriesList)){
                for (int i = 0; i < 4; i++) {
                    newList.add(seriesList.get(i));
                }
            }
            WebUtil.print(response, new Result(true).data(newList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }


    // ajax 新增商品
    @RequestMapping(value = "/pcCreateSeries")
    public void pcCreateSeries(HttpServletRequest request,
                              HttpServletResponse response,
                              Integer seriesTagId,
                              String info,
                              String sceneIds){
        try {
            User user = (User)SessionUtils.get(Constant.SESSION_PC_USER);
            if(user==null){
                WebUtil.print(response, new Result(false).msg("请先登录!"));
                return;
            }
            if(seriesTagId == null){
                WebUtil.print(response, new Result(false).msg("请选择分类!"));
                return;
            }
            if(StringUtils.isEmpty(info)){
                WebUtil.print(response, new Result(false).msg("请输入介绍信息!"));
                return;
            }
            if(StringUtils.isEmpty(sceneIds)){
                WebUtil.print(response, new Result(false).msg("请选择场景图!"));
                return;
            }

            seriesService.pcAddSeries(user.getId(),seriesTagId,info,sceneIds);

            WebUtil.print(response, new Result(true).msg("新增系列图成功!"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }



}
