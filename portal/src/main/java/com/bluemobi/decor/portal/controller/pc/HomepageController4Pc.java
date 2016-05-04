package com.bluemobi.decor.portal.controller.pc;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.*;
import com.bluemobi.decor.utils.SessionUtils;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * 首页
 * Created by gaoll on 2015/3/3.
 */
@Controller
@RequestMapping(value = "/pc/homepage")
public class HomepageController4Pc extends CommonController {

    @Autowired
    private AdService adService;

    @Autowired
    private SceneService sceneService;
    @Autowired
    private SeriesService seriesService;

    @Autowired
    private MessageService messageService;

    @Autowired
    private PraiseService praiseService;

    @Autowired
    private CollectionService collectionService;

    // ajax查询广告
    @RequestMapping(value = "/ajaxAd")
    public void ajaxAd(HttpServletRequest request,
                       HttpServletResponse response) {
        try {
            List<Ad> adList = adService.pcList();
            WebUtil.print(response, new Result(true).data(adList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // 查询喜欢数由高到低的系列图9张
    @RequestMapping(value = "/ajaxSeries")
    public void ajaxSeries(HttpServletRequest request,
                                   HttpServletResponse response) {
        try {
            Page<Series> page = seriesService.pageOrderByPraise(1,9);
            List<Series> seriesList = new ArrayList<Series>();
            if(page != null && CollectionUtils.isNotEmpty(page.getContent())){
                seriesList = page.getContent();
            }
            WebUtil.print(response, new Result(true).data(seriesList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // ajax查询推荐的场景
    @RequestMapping(value = "/ajaxRecommendScene")
    public void ajaxRecommendScene(HttpServletRequest request,
                                   HttpServletResponse response) {
        try {
            List<Scene> sceneList = sceneService.pcRecommendList();
            User user = (User) SessionUtils.get(Constant.SESSION_PC_USER);
            for (Scene scene : sceneList) {
                // 判断是否收藏是否点赞
                if (user != null) {
                    Integer userId = user.getId();
                    Integer sceneId = scene.getId();
                    Boolean flag = praiseService.isPraise(userId, sceneId, Constant.PRAISE_TYPE_SCENE);
                    if (flag) {
                        scene.setIsPraise("yes");
                    } else {
                        scene.setIsPraise("no");
                    }

                    Boolean flag2 = collectionService.isCollectionScene(userId, sceneId);
                    if (flag2) {
                        scene.setIsCollection("yes");
                    } else {
                        scene.setIsCollection("no");
                    }
                } else {
                    scene.setIsPraise("no");
                    scene.setIsCollection("no");
                }
            }
            WebUtil.print(response, new Result(true).data(sceneList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // ajax查询推荐的咨询
    @RequestMapping(value = "/ajaxRecommendMessage")
    public void ajaxRecommendMessage(HttpServletRequest request,
                                     HttpServletResponse response, Integer userId) {
        try {
            List<Message> adList = messageService.pcRecommendList();
            for (Message message : adList) {
                // 判断是否收藏
                if (userId != null) {
                    Integer messageId = message.getId();
                    boolean judge = messageService.ajaxJudgeCollection(messageId, userId);
                    if (judge) {
                        message.setIfCollect(1);
                    } else {
                        message.setIfCollect(0);
                    }

                } else {
                    message.setIfCollect(0);
                }
            }
            WebUtil.print(response, new Result(true).data(adList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }


}
