package com.bluemobi.decor.portal.controller.pc;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.PcPageFactory;
import com.bluemobi.decor.portal.util.SessionUtils;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.*;
import com.bluemobi.decor.utils.ComFun;
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

/**
 * 商品
 * Created by gaoll on 2015/3/3.
 */
@Controller
@RequestMapping(value = "/pc/goods")
public class GoodsController4Pc extends CommonController {

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private GoodsImageService goodsImageService;

    @Autowired
    private SceneGoodsService sceneGoodsService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private PraiseService praiseService;

    @Autowired
    private CollectionService collectionService;
    @Autowired
    private KindTagService kindTagService;
    @Autowired
    private SpaceTagService spaceTagService;
    @Autowired
    private StyleTagService styleTagService;

    // 查询page
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
                pageSize = 9;
            }
            Page<Goods> page = goodsService.pcPage(pageNum, pageSize, name,kindTagId, spaceTagId, styleTagId);
            for (Goods goods : page.getContent()){
                // 判断是否收藏是否点赞
                if(userId != null){
                    Integer goodsId = goods.getId();
                    Boolean flag = praiseService.isPraise(userId, goodsId, Constant.PRAISE_TYPE_GOODS);
                    if(flag){
                        goods.setIsPraise("yes");
                    }else {
                        goods.setIsPraise("no");
                    }
                    User user=goods.getUser();
                    if (user.getRoleType().equals("admin")||user.getRoleType()=="admin"){
                        user.setNickname("Décor");
                    }
                    goods.setUser(user);
                    Boolean flag2 = collectionService.isCollectionGoods(userId, goodsId);
                    if(flag2){
                        goods.setIsCollection("yes");
                    }else {
                        goods.setIsCollection("no");
                    }
                }else {
                    goods.setIsPraise("no");
                    goods.setIsCollection("no");
                }
            }

            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // forward to 商品详情页
    @RequestMapping(value = "/detail")
    public String detail(ModelMap modelMap,
                         HttpServletRequest request,
                         Integer goodsId){
        Goods goods = goodsService.getById(goodsId);
        goods.setTagsStr("");
        List<GoodsImage> goodsImageList = goodsImageService.listByGoodsId(goodsId);
        goods.setGoodsImageList(goodsImageList);
        User user=goods.getUser();
        if (user.getRoleType().equals("admin")||user.getRoleType()=="admin"){
            user.setNickname("Décor");
        }
        goods.setUser(user);
        modelMap.put("goods",goods);
        modelMap.put("tagHtml",getTagHtml(goods));

        goodsService.seeNumAdd(goodsId);
        return "pc/商品图详情";
    }

    public String getTagHtml(Goods goods) {
        String tagHtml = "";
        if(goods == null){
            return "";
        }
        String kindTagIds = goods.getKindTagIds();
        String spaceTagIds = goods.getSpaceTagIds();
        String styleTagIds = goods.getStyleTagIds();
        List<Integer> kindTagIdList = ComFun.tagsToList(kindTagIds);
        List<Integer> spaceTagIdList = ComFun.tagsToList(spaceTagIds);
        List<Integer> styleTagIdList = ComFun.tagsToList(styleTagIds);
        List<KindTag> kindTagList = kindTagService.listByIds(kindTagIdList);
        List<SpaceTag> spaceTagList = spaceTagService.listByIds(spaceTagIdList);
        List<StyleTag> styleTagList = styleTagService.listByIds(styleTagIdList);
        if(CollectionUtils.isNotEmpty(kindTagList)){
            for (KindTag kindTag : kindTagList) {
                tagHtml += "<span tagid=\""+kindTag.getId()+"\" tagtype=\"kindTagId\" class=\"bodr\">"+kindTag.getName()+"</span>";
            }
        }
        if(CollectionUtils.isNotEmpty(spaceTagList)){
            for (SpaceTag spaceTag : spaceTagList) {
                tagHtml += "<span tagid=\""+spaceTag.getId()+"\" tagtype=\"spaceTagId\" class=\"bodr\">"+spaceTag.getName()+"</span>";
            }
        }
        if(CollectionUtils.isNotEmpty(styleTagList)){
            for (StyleTag styleTag : styleTagList) {
                tagHtml += "<span tagid=\""+styleTag.getId()+"\" tagtype=\"styleTagId\" class=\"bodr\">"+styleTag.getName()+"</span>";
            }
        }
        return tagHtml;
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

    // ajax查询商品评论列表
    @RequestMapping(value = "/ajaxGoodsComment")
    public void ajaxGoodsComment(HttpServletRequest request,
                                 HttpServletResponse response,
                                 Integer goodsId){
        try {
            User user = (User) SessionUtils.get(Constant.SESSION_PC_USER);
            List<Comment> commentList = commentService.listCommentIncludeReply(goodsId,"goods");
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

    // ajax 新增商品
    @RequestMapping(value = "/pcCreateGoods")
    public void pcCreateGoods(HttpServletRequest request,
                                 HttpServletResponse response,
                                 String name,
                                 String kindTagIds,
                                 String styleTagIds,
                                 String spaceTagIds,
                                 String price,
                                 String texture,
                                 String size,
                                 String link,
                                 String info,
                                 String images,
                                 String thumbnailImages,
                                 String cover,
                                 String thumbnailCover,
                                 String isTurnMaterials){
        try {
            User user = (User)SessionUtils.get(Constant.SESSION_PC_USER);
            if(user==null){
                WebUtil.print(response, new Result(false).msg("请先登录!"));
                return;
            }
            if(StringUtils.isEmpty(name)){
                WebUtil.print(response, new Result(false).msg("商品名为空!"));
                return;
            }
            if(StringUtils.isEmpty(kindTagIds)){
                WebUtil.print(response, new Result(false).msg("请选择种类!"));
                return;
            }
            if(StringUtils.isEmpty(styleTagIds)){
                WebUtil.print(response, new Result(false).msg("请选择风格分类!"));
                return;
            }
            if(StringUtils.isEmpty(spaceTagIds)){
                WebUtil.print(response, new Result(false).msg("请选择空间分类!"));
                return;
            }
            if(StringUtils.isEmpty(price)){
                WebUtil.print(response, new Result(false).msg("请输入价格!"));
                return;
            }
            if(StringUtils.isEmpty(texture)){
                WebUtil.print(response, new Result(false).msg("请输入材质!"));
                return;
            }
            if(StringUtils.isEmpty(size)){
                WebUtil.print(response, new Result(false).msg("请输入尺寸!"));
                return;
            }
            if(StringUtils.isEmpty(link)){
                WebUtil.print(response, new Result(false).msg("请输入购买链接!"));
                return;
            }
            if(StringUtils.isEmpty(info)){
                WebUtil.print(response, new Result(false).msg("请输入描述信息!"));
                return;
            }
            if(StringUtils.isEmpty(images)){
                WebUtil.print(response, new Result(false).msg("请上传商品图片!"));
                return;
            }

            goodsService.pcInsert( name,
                     kindTagIds,
                     spaceTagIds,
                     styleTagIds,
                     price,
                     size,
                     texture,
                     link,
                     info,
                     images,
                     thumbnailImages,
                     cover,
                    thumbnailCover,
                     isTurnMaterials,
                     user.getId());
            WebUtil.print(response, new Result(true).msg("新增成功!"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // page goodsimage
    @RequestMapping(value = "/pageGoodsImageByKindTag")
    public void pageGoodsImageByKindTag(HttpServletRequest request,
                     HttpServletResponse response,
                     Integer pageNum,
                     Integer pageSize,
                     Integer kindTagId){
        try {
            if(pageNum == null){
                pageNum = 1;
            }
            if(pageSize == null){
                pageSize = 12;
            }
            Page<GoodsImage> page = goodsImageService.pageByKindTag(pageNum, pageSize,kindTagId.toString());
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }


}
