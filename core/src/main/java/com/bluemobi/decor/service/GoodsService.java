package com.bluemobi.decor.service;

import com.bluemobi.decor.entity.Goods;
import com.bluemobi.decor.entity.PicObj;
import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.service.common.ICommonService;
import com.bluemobi.decor.service.moduleHandler.SeeNumHandler;
import org.springframework.data.domain.Page;

import java.util.List;
import java.util.Map;

/**
 * Created by gaoll on 2015/3/13.
 */
public interface GoodsService extends ICommonService<Goods>,SeeNumHandler {

    public Page<Goods> iPage(int pageNum,
                             int pageSize,
                             String name,
                             Integer kindTagId,
                             Integer spaceTagId,
                             Integer styleTagId,
                             String sort);

    public Page<Goods> iPageMy(int pageNum,
                               int pageSize,
                               Integer userId);

    public void addGoods(Integer userId,
                         String name,
                         String kindTagIds,
                         String spaceTagIds,
                         String styleTagIds,
                         String price,
                         String size,
                         String texture,
                         String link,
                         String info,
                         String images,
                         String thumbnailImages,
                         String isHeads,
                         String isTurns);

    // 查询特定用户的商品图信息
    public List<Goods> iFindGoodsByUser(User user);

    // 获取商品封面图
    public String getHeadPath(Integer goodsId);

    public String getGoodsTagsStr(Integer goodsId);

    public Boolean hasMaterial(Integer goodsId);

    // 查询商品图总数量
    public int findGoodsCount(String name);

    //通过ID，商品名称，商品类别，审核状态来筛选商品集合
    public Page<Goods> findGoods(Integer id,
                                 String goodsName,
                                 Integer kindTagId,
                                 String styleId,
                                 String spaceId,
                                 String isPass,
                                 int pageNum,
                                 int pageSize);

    //删除商品图片
    public void deleteGoods(Integer goodsId);

    //批量删除商品图片
    public void deleteGoods(int[] goodsId);

    //新增商品
    public void insert(String goodsName,
                       String goodsKindTagId,
                       String spaceTagIds,
                       String styleTagIds,
                       String price,
                       String size,
                       String texture,
                       String link,
                       String info,
                       String images,
                       String cover,
                       String isTurnMaterialIds,
                       Integer userId);

    //新增商品
    public void pcInsert(String name,
                       String kindTagIds,
                       String spaceTagIds,
                       String styleTagIds,
                       String price,
                       String size,
                       String texture,
                       String link,
                       String info,
                       String images,
                       String thumbnailImages,
                       String cover,
                       String thumbnailCover,
                       String isTurnMaterials,
                       Integer userId);

    //编辑商品
    public void update(Integer goodsId,
                       String goodsName,
                       String goodsKindTagId,
                       String spaceTagIds,
                       String styleTagIds,
                       String price,
                       String size,
                       String texture,
                       String link,
                       String info,
                       String images,
                       String cover,
                       String isTurnMaterialIds);

    /**
     * 批量导入场景图与商品图
     *
     * @param userId        当前登录用户ID
     * @param sceneIndex    第几张场景图
     * @param goodsIndex    第几张商品图
     * @return 返回的消息
     */
    public Map<String, Object> batchImport(Integer userId, int sceneIndex, int goodsIndex);

    //通过ID，商品名称，商品类别，审核状态来筛选商品集合
    public Page<Goods> pageToMain(int pageNum, int pageSize);

    public Page<Goods> pcPage(int pageNum,
                             int pageSize,
                             String name,
                             Integer kindTagId,
                             Integer spaceTagId,
                             Integer styleTagId);

    // 查询6条同类商品
    List<Goods> sameTypeGoods(Integer goodsId);

    public Page<Goods> pcFindGoodsPage(User user,int pageNum,int pageSize);
    //找出指定用户最新上传的4张图片
    public List<PicObj> pcFindPicObj(User user);

    // 推荐 or 取消推荐场景图
    public void changeRecommend(Integer id, String isRecommend);
}
