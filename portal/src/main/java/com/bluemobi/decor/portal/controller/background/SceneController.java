package com.bluemobi.decor.portal.controller.background;

import com.bluemobi.decor.common.factory.DataTableFactory;
import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.SessionUtils;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.*;
import com.bluemobi.decor.utils.ComFun;
import com.bluemobi.decor.utils.JsonUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 场景图Controller
 * Created by reny on 2015/7/21.
 */
@Controller
@RequestMapping(value = "/backend/scene")
public class SceneController extends CommonController {
    @Autowired
    private SceneService sceneService;
    @Autowired
    private SpaceTagService spaceTagService;
    @Autowired
    private StyleTagService styleTagService;
    @Autowired
    private SceneGoodsService sceneGoodsService;
    @Autowired
    private GoodsService goodsService;

    @RequestMapping(value = "/index")
    public String index() {
        return "场景图列表";
    }

    /**
     * 分页获取商品图片列表
     */
    @RequestMapping(value = "/list")
    public void list(HttpServletRequest request,
                     HttpServletResponse response,
                     Integer draw,
                     Integer start,
                     Integer length,
                     Integer id, String name,
                     String author, String isRecommend,
                     String styleId, String spaceId,
                     ModelMap model) {

        try {
            int pageNum = getPageNum(start, length);
            Page<Scene> page = sceneService.findScenes(id, name, author, styleId, spaceId, isRecommend, pageNum, length);
            for (Scene scene : page.getContent()) {
                //获取空间标签
                String spTagIdsT = scene.getSpaceTagIds();
                //标签名称的集合
                List<String> spaceTagNames = new ArrayList<String>();
                if (StringUtils.isNotEmpty(spTagIdsT)) {
                    //把@1@,@2@,@3@类型的ids转换成1,2,3
                    List<Integer> tagIds = ComFun.tagsToList(scene.getSpaceTagIds());
                    //循环给tagNames集合添加标签名称
                    for (Integer tagId : tagIds) {
                        SpaceTag spaceTag = spaceTagService.getById(tagId);
                        if (spaceTag != null) {
                            spaceTagNames.add(spaceTag.getName());
                        } else {
                            spaceTagNames.add("数据问题");
                        }
                    }
                } else {
                    spaceTagNames.add("暂无空间标签");
                }
                scene.setSpaceTagName(spaceTagNames);

                //风格标签名称的集合
                List<String> styleTagNames = new ArrayList<String>();
                //获取风格标签
                String stTagIdsT = scene.getSpaceTagIds();
                if (StringUtils.isNotEmpty(stTagIdsT)) {
                    //把@1@,@2@,@3@类型的ids转换成1,2,3
                    List<Integer> tagIds = ComFun.tagsToList(scene.getStyleTagIds());
                    //循环给tagNames集合添加标签名称
                    for (Integer tagId : tagIds) {
                        StyleTag styleTag = styleTagService.getById(tagId);
                        if (styleTag != null) {
                            styleTagNames.add(styleTag.getName());
                        } else {
                            styleTagNames.add("数据问题");
                        }
                    }
                } else {
                    styleTagNames.add("暂无风格标签");
                }
                scene.setStyleTagName(styleTagNames);

                List<SceneGoods> scenceGoods = sceneGoodsService.listBySceneId(scene.getId());
                List<Map<String, Object>> goodsMaps = new ArrayList<Map<String, Object>>();
                for (SceneGoods sceneGood : scenceGoods) {
                    if (sceneGood.getGoods() != null) {
                        Goods goods = goodsService.getById(sceneGood.getGoods().getId());
                        Map<String, Object> map = new HashMap<String, Object>();
                        map.put("goodsId", goods.getId());
                        map.put("goodsName", goods.getName());
                        map.put("goodsPath", goods.getCover());
                        goodsMaps.add(map);
                    }
                }
                scene.setGoodsMaps(goodsMaps);
            }
            Map<String, Object> result = DataTableFactory.fitting(draw, page);
            WebUtil.print(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 分页获取商品图片列表
     */
    @RequestMapping(value = "/findImageList", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> findImageList(HttpServletRequest request,
                                             HttpServletResponse response,
                                             String name, String author, String styleId,
                                             String spaceId, Integer pageNum, ModelMap model) {
        if (pageNum == null) {
            pageNum = 1;
        }
        //场景图列表
        List<Map<String, Object>> sceneImageList = new ArrayList<Map<String, Object>>();
        Page<Scene> page = sceneService.findScenes(null, name, author, styleId, spaceId, null, pageNum, 12);
        //总页数
        int totalPage = page.getTotalPages();
        if (pageNum > totalPage) {
            page = sceneService.findScenes(null, null, author, styleId, spaceId, null, 1, 12);
            pageNum = 1;
        }
        for (Scene scene : page.getContent()) {
            Map<String, Object> sceneImage = new HashMap<String, Object>();
            sceneImage.put("sceneId", scene.getId());
            sceneImage.put("sceneImage", scene.getImage());
            sceneImageList.add(sceneImage);
        }
        //分页信息
        List<Map<String, Object>> pageInfos = new ArrayList<Map<String, Object>>();
        //初始化跳转到第一页
        Map<String, Object> pageFrist = new HashMap<String, Object>();
        pageFrist.put("pageNum", 1);
        pageInfos.add(pageFrist);
        int index = 0;
        if (totalPage < 10) {
            index = totalPage - 2;
        } else {
            index = 10 - 2;
        }
        for (int i = 0; i < index; i++) {//除去首页尾页，只显示8个数字
            Map<String, Object> pageinfo = new HashMap<String, Object>();
            int indexPageNum = 1;
            if (pageNum > totalPage - 7) {
                indexPageNum = totalPage - index + i;
            } else if (pageNum - 8 <= 1) {
                indexPageNum = i + 2;
            } else {
                indexPageNum = pageNum + i;
            }
            pageinfo.put("pageNum", indexPageNum);
            pageInfos.add(pageinfo);
        }
        //初始化跳转到尾页
        Map<String, Object> pageLast = new HashMap<String, Object>();
        if (totalPage != 1 && totalPage != 0) {
            pageLast.put("pageNum", totalPage);
        }
        pageInfos.add(pageLast);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("sceneImageList", sceneImageList);
        map.put("pageInfos", pageInfos);
        map.put("totalPage", totalPage);
        return map;
    }

    /**
     * 删除单个场景图
     */
    @RequestMapping(value = "/delete")
    public void delete(HttpServletRequest request,
                       HttpServletResponse response,
                       Integer id) {
        try {
            sceneService.deleteScenes(id);
            WebUtil.print(response, new Result(true).msg("操作成功！"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败！"));
        }
    }

    /**
     * 删除多个场景图
     */
    @RequestMapping(value = "/deletes")
    public void deletes(HttpServletRequest request,
                        HttpServletResponse response,
                        String ids) {
        try {
            int[] arrayId = JsonUtil.json2Obj(ids, int[].class);
            sceneService.deleteScenes(arrayId);
            WebUtil.print(response, new Result(true).msg("操作成功！"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败！"));
        }
    }

    @RequestMapping("/changeRecommend")
    public void changeRecommend(HttpServletRequest request,
                                HttpServletResponse response,
                                Integer id,
                                String isRecommend) {
        String msg = "";
        if (isRecommend.equals("yes")) {
            msg = "推荐";
        } else {
            msg = "取消推荐";
        }
        try {
            sceneService.changeRecommend(id, isRecommend);
            WebUtil.print(response, new Result(true).msg(msg + "成功！"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg(msg + "失败！"));
        }
    }

    @RequestMapping(value = "/addSceneUI")
    public String addSceneUI() {
        return "添加场景图";
    }

    @RequestMapping(value = "/save")
    public void save(HttpServletRequest request,
                     HttpServletResponse response,
                     String sceneName, String styleTagIds,
                     String spaceTagIds, String info,
                     String image, String isShow, String isRecommend,
                     String goodsIds) {//goodsIds: 1!50_50,2!100_100

        Integer userId = null == SessionUtils.getCurrentUser() ? 0 : SessionUtils.getCurrentUser().getId();
        if (userId == 0) {
            WebUtil.print(response, new Result(false).msg("暂未登录！"));
            return;
        }
        if (StringUtils.isEmpty(sceneName)) {
            WebUtil.print(response, new Result(false).msg("请给场景一个名称！"));
            return;
        }
        if (StringUtils.isEmpty(styleTagIds)) {
            WebUtil.print(response, new Result(false).msg("至少选择一个风格分类！"));
            return;
        }
        if (StringUtils.isEmpty(spaceTagIds)) {
            WebUtil.print(response, new Result(false).msg("至少选择一个空间分类类型！"));
            return;
        }
        if (StringUtils.isEmpty(image)) {
            WebUtil.print(response, new Result(false).msg("请给场景一个图片！"));
            return;
        }
        if (StringUtils.isEmpty(isShow)) {
            WebUtil.print(response, new Result(false).msg("请设置场景是否显示！"));
            return;
        }
        if (StringUtils.isEmpty(isRecommend)) {
            WebUtil.print(response, new Result(false).msg("请设置场景是否推荐！"));
            return;
        }
        List<Map<String, Object>> goodsMap = new ArrayList<>();
        if (StringUtils.isNotEmpty(goodsIds)) {
            String[] goodsIdStr = goodsIds.split(",");
            if (goodsIdStr.length > 0) {
                for (String gId : goodsIdStr) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    String[] idAndPosition = gId.split("!");
                    if (idAndPosition.length == 2) {
                        map.put("id", idAndPosition[0]);
                        map.put("position", idAndPosition[1]);
                        goodsMap.add(map);
                    } else {
                        WebUtil.print(response, new Result(false).msg("请给商品选定坐标！"));
                        return;
                    }
                }
            }
        }
        try {
            sceneService.insert(userId, sceneName, styleTagIds, spaceTagIds, info, image, isShow, isRecommend, goodsMap);
            WebUtil.print(response, new Result(true).msg("操作成功！"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败！"));
        }
    }

    @RequestMapping(value = "/updataUI")
    public String updataUI(HttpServletRequest request,
                           HttpServletResponse response,
                           Integer id,
                           ModelMap model) {
        Scene scene = sceneService.getById(id);
        if (scene != null) {
            //风格分类初始化
            if (StringUtils.isNotEmpty(scene.getStyleTagIds())) {
                List<Integer> tagIds = ComFun.tagsToList(scene.getStyleTagIds());
                List<Map<String, Object>> styleMap = new ArrayList<Map<String, Object>>();
                //循环给tagNames集合添加标签名称
                for (Integer tagId : tagIds) {
                    StyleTag styleTag = styleTagService.getById(tagId);
                    Map<String, Object> m = new HashMap<String, Object>();
                    m.put("id", tagId);
                    if (styleTag != null) {
                        m.put("name", styleTag.getName());
                    } else {
                        m.put("name", "数据问题");
                    }
                    m.put("type", "styleLx");
                    styleMap.add(m);
                }
                String jsonStyle = JsonUtil.obj2Json(styleMap);
                model.put("jsonStyle", jsonStyle);
            }

            //空间分类初始化
            if (StringUtils.isNotEmpty(scene.getSpaceTagIds())) {
                List<Integer> tagIds = ComFun.tagsToList(scene.getSpaceTagIds());
                List<Map<String, Object>> spaceMap = new ArrayList<Map<String, Object>>();
                //循环给tagNames集合添加标签名称
                for (Integer tagId : tagIds) {
                    SpaceTag spaceTag = spaceTagService.getById(tagId);
                    Map<String, Object> m = new HashMap<String, Object>();
                    m.put("id", tagId);
                    if (spaceTag != null) {
                        m.put("name", spaceTag.getName());
                    } else {
                        m.put("name", "数据问题");
                    }
                    m.put("type", "spaceLx");
                    spaceMap.add(m);
                }
                String jsonSpace = JsonUtil.obj2Json(spaceMap);
                model.put("jsonSpace", jsonSpace);
            }

            List<Map<String, Object>> sceneGoodsMap = new ArrayList<Map<String, Object>>();
            List<SceneGoods> sgs = sceneGoodsService.listBySceneId(id);
            for (SceneGoods sg : sgs) {
                Map<String, Object> sceneGood = new HashMap<String, Object>();
                sceneGood.put("goodsId", sg.getGoods().getId());
                sceneGood.put("goodsImage", sg.getGoods().getCover());
                String[] xy = sg.getPosition().split("_");
                String x = xy[0];
                String y = xy[1];
                sceneGood.put("x", x);
                sceneGood.put("y", y);
                sceneGoodsMap.add(sceneGood);
            }
            String jsonSceneGoods = JsonUtil.obj2Json(sceneGoodsMap);
            model.put("jsonSceneGoods", jsonSceneGoods);
            model.put("scene", scene);
        }
        return "编辑场景图";
    }

    @RequestMapping(value = "/updata")
    public void updata(HttpServletRequest request,
                       HttpServletResponse response, Integer sceneId,
                       String sceneName, String styleTagIds,
                       String spaceTagIds, String info,
                       String image, String isShow, String isRecommend,
                       String goodsIds) {//goodsIds: 1!50_50,2!100_100

        Integer userId = null == SessionUtils.getCurrentUser() ? 0 : SessionUtils.getCurrentUser().getId();
        if (userId == 0) {
            WebUtil.print(response, new Result(false).msg("暂未登录！"));
            return;
        }
        if (StringUtils.isEmpty(sceneName)) {
            WebUtil.print(response, new Result(false).msg("请给场景一个名称！"));
            return;
        }
        
        if (StringUtils.isEmpty(styleTagIds)) {
            WebUtil.print(response, new Result(false).msg("至少选择一个风格分类！"));
            return;
        }
        if (StringUtils.isEmpty(spaceTagIds)) {
            WebUtil.print(response, new Result(false).msg("至少选择一个空间分类类型！"));
            return;
        }
        if (StringUtils.isEmpty(image)) {
            WebUtil.print(response, new Result(false).msg("请给场景一个图片！"));
            return;
        }
        if (StringUtils.isEmpty(isShow)) {
            WebUtil.print(response, new Result(false).msg("请设置场景是否显示！"));
            return;
        }
        if (StringUtils.isEmpty(isRecommend)) {
            WebUtil.print(response, new Result(false).msg("请设置场景是否推荐！"));
            return;
        }
        List<Map<String, Object>> goodsMap = new ArrayList<>();
        if (StringUtils.isNotEmpty(goodsIds)) {
            String[] goodsIdStr = goodsIds.split(",");
            if (goodsIdStr.length > 0) {
                for (String gId : goodsIdStr) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    String[] idAndPosition = gId.split("!");
                    if (idAndPosition.length == 2) {
                        map.put("id", idAndPosition[0]);
                        map.put("position", idAndPosition[1]);
                        goodsMap.add(map);
                    } else {
                        WebUtil.print(response, new Result(false).msg("请给商品选定坐标！"));
                        return;
                    }
                }
            }
        }
        try {
            sceneService.updata(sceneId, sceneName, styleTagIds, spaceTagIds, info, image, isShow, isRecommend, goodsMap);
            WebUtil.print(response, new Result(true).msg("操作成功！"));
        } catch (Exception e) {
            e.getStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败！"));
        }
    }
}
