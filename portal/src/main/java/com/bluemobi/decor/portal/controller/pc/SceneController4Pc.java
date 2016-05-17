package com.bluemobi.decor.portal.controller.pc;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.PcPageFactory;
import com.bluemobi.decor.portal.util.SessionUtils;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.*;
import com.bluemobi.decor.utils.JsonUtil;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 场景
 * Created by gaoll on 2015/3/3.
 */
@Controller
@RequestMapping(value = "/pc/scene")
public class SceneController4Pc extends CommonController {

    @Autowired
    private SceneService sceneService;

    @Autowired
    private SeriesService seriesService;

    @Autowired
    private SceneGoodsService sceneGoodsService;

    @Autowired
    private SeriesSceneService seriesSceneService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private PraiseService praiseService;

    @Autowired
    private CollectionService collectionService;

    // 查询page
    @RequestMapping(value = "/page")
    public void list(HttpServletRequest request,
                     HttpServletResponse response,
                     Integer pageNum,
                     Integer pageSize,
                     String name,
                     Integer spaceTagId,
                     Integer styleTagId,
                     Integer userId) {
        try {
            if (pageNum == null) {
                pageNum = 1;
            }
            if (pageSize == null) {
                pageSize = 9;
            }
            Page<Scene> page = sceneService.pcPage(pageNum, pageSize, name, spaceTagId, styleTagId);
            for (Scene scene : page.getContent()) {
                // 判断是否收藏是否点赞
                if (userId != null) {
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
                User user = scene.getUser();
                if (user.getRoleType().equals("admin") || user.getRoleType() == "admin") {
                    user.setNickname("Décor");
                }
                scene.setUser(user);
            }

            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // forward to 场景图详情页
    @RequestMapping(value = "/detail")
    public String detail(ModelMap modelMap,
                         HttpServletRequest request,
                         Integer sceneId) {
        Scene scene = sceneService.getById(sceneId);
        sceneService.seeNumAdd(sceneId);
        List<Map<String, Object>> sceneGoodsMap = new ArrayList<Map<String, Object>>();
        List<SceneGoods> sgs = sceneGoodsService.listBySceneId(sceneId);
        for (SceneGoods sg : sgs) {
            Map<String, Object> sceneGood = new HashMap<String, Object>();
            sceneGood.put("goodsId", sg.getGoods().getId());
            sceneGood.put("goodsImage", sg.getGoods().getCover());
            sceneGood.put("goodsPrice", sg.getGoods().getPrice());
            sceneGood.put("goodsInfo", sg.getGoods().getInfo());
            sceneGood.put("goodsName", sg.getGoods().getName());
            String[] xy = sg.getPosition().split("_");
            String x = xy[0];
            String y = xy[1];
            sceneGood.put("x", x);
            sceneGood.put("y", y);
            sceneGoodsMap.add(sceneGood);
        }
        String jsonSceneGoods = JsonUtil.obj2Json(sceneGoodsMap);
        modelMap.put("jsonSceneGoods", jsonSceneGoods);
        User user = scene.getUser();
        if (user.getRoleType().equals("admin") || user.getRoleType() == "admin") {
            user.setNickname("Décor");
        }
        scene.setUser(user);
        modelMap.put("scene", scene);

        List<Series> seriesList = seriesService.iFindSeriesByUser(user);
        if (CollectionUtils.isNotEmpty(seriesList)) {
            modelMap.put("userSeriesNum", seriesList.size());
        } else {
            modelMap.put("userSeriesNum", 0);
        }

        Page<Comment> page = commentService.pageCommentIncludeReply(sceneId, "scene", 1, 5);

        modelMap.put("totalPages", page.getTotalPages());
        modelMap.put("pageNum", page.getNumber() + 1);
        modelMap.put("pageSize", page.getSize());

        return "pc/场景图详情";
    }

    // ajax查询场景中的商品
    @RequestMapping(value = "/ajaxGoodsListBySceneId")
    public void ajaxGoodsListBySceneId(HttpServletRequest request,
                                       HttpServletResponse response,
                                       Integer sceneId) {
        try {
            // 场景中的商品
            List<Goods> goodsList = sceneGoodsService.listGoods(sceneId);
            WebUtil.print(response, new Result(true).data(goodsList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // ajax查询场景所属系列图
    @RequestMapping(value = "/ajaxSeriesBySceneId")
    public void ajaxSeriesBySceneId(HttpServletRequest request,
                                    HttpServletResponse response,
                                    Integer sceneId) {
        try {
            // 场景所属的系列
            List<Series> seriesList = seriesSceneService.findSeriesListBySceneId(sceneId);
            WebUtil.print(response, new Result(true).data(seriesList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // ajax查询同类型场景6条
    @RequestMapping(value = "/ajaxSameTypeScene")
    public void ajaxSameTypeScene(HttpServletRequest request,
                                  HttpServletResponse response,
                                  Integer sceneId) {
        try {
            List<Scene> sceneList = sceneService.sameTypeScene(sceneId);
            WebUtil.print(response, new Result(true).data(sceneList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // ajax查询场景评论列表
    @RequestMapping(value = "/ajaxSceneComment")
    public void ajaxSceneComment(HttpServletResponse response,
                                 Integer sceneId,
                                 Integer pageNum,
                                 Integer pageSize) {
        try {
            User user = (User) SessionUtils.get(Constant.SESSION_PC_USER);
            Page<Comment> page = commentService.pageCommentIncludeReply(sceneId, "scene", pageNum, pageSize);
            for (Comment comment : page.getContent()) {
                comment.setIsPraise("no");
                if (user != null) {
                    Integer userId = user.getId();
                    Integer commentId = comment.getId();
                    Boolean flag = praiseService.isPraise(userId, commentId, Constant.PRAISE_TYPE_COMMENT);
                    if (flag) {
                        comment.setIsPraise("yes");
                    }
                }
                if (comment.getReplyList() != null && comment.getReplyList().size() > 0) {
                    for (Reply reply : comment.getReplyList()) {
                        reply.setIsPraise("no");
                        if (user != null) {
                            Integer replyId = reply.getId();
                            Boolean flag = praiseService.isPraise(user.getId(), replyId, Constant.PRAISE_TYPE_COMMENT);
                            if (flag) {
                                reply.setIsPraise("yes");
                            }
                        }
                    }
                }
            }
            WebUtil.print(response, new Result(true).data(page.getContent()));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // ajax 新增商品
    @RequestMapping(value = "/pcCreateScene")
    public void pcCreateScene(HttpServletRequest request,
                              HttpServletResponse response,
                              String name,
                              String styleTagIds,
                              String spaceTagIds,
                              String info,
                              String image,
                              String thumbnailImage,
                              String goodsIds,
                              String positons,
                              String isShow) {
        try {
            User user = (User) SessionUtils.get(Constant.SESSION_PC_USER);
            if (user == null) {
                WebUtil.print(response, new Result(false).msg("请先登录!"));
                return;
            }
            if (StringUtils.isEmpty(styleTagIds)) {
                WebUtil.print(response, new Result(false).msg("请选择风格分类!"));
                return;
            }
            if (StringUtils.isEmpty(spaceTagIds)) {
                WebUtil.print(response, new Result(false).msg("请选择空间分类!"));
                return;
            }
            if (StringUtils.isEmpty(info)) {
                WebUtil.print(response, new Result(false).msg("请输入介绍信息!"));
                return;
            }
            if (StringUtils.isEmpty(image)) {
                WebUtil.print(response, new Result(false).msg("请上传图片!"));
                return;
            }
            if (StringUtils.isEmpty(goodsIds)) {
                WebUtil.print(response, new Result(false).msg("请为场景选择商品!"));
                return;
            }

            sceneService.pcAddScene(user.getId(), name, spaceTagIds, styleTagIds, info, isShow, image, thumbnailImage, goodsIds, positons);

            WebUtil.print(response, new Result(true).msg("新增场景图成功!"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }


}
