package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.GoodsDao;
import com.bluemobi.decor.dao.SceneDao;
import com.bluemobi.decor.dao.SceneGoodsDao;
import com.bluemobi.decor.dao.SeriesDao;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.service.*;
import com.bluemobi.decor.thread.UserHasUpdateThread;
import com.bluemobi.decor.utils.*;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.io.File;
import java.util.*;

/**
 * Created by gaoll on 2015/7/6.
 */
@Service
@Transactional(readOnly = true)
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    private GoodsDao goodsDao;
    @Autowired
    private SceneDao sceneDao;
    @Autowired
    private SeriesDao seriesDao;
    @Autowired
    private SceneGoodsDao sceneGoodsDao;
    @Autowired
    private CommentUpdateStatusService commentUpdateStatusService;

    @Autowired
    private MaterialService materialService;

    @Autowired
    private SceneGoodsService sceneGoodsService;

    @Autowired
    private SceneService sceneService;

    @Autowired
    private GoodsImageService goodsImageService;

    @Autowired
    private KindTagService kindTagService;

    @Autowired
    private SpaceTagService spaceTagService;

    @Autowired
    private StyleTagService styleTagService;

    @Autowired
    private CollectionService collectionService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private PraiseService praiseService;

    @Autowired
    private AttentionService attentionService;

    @Autowired
    private UploadImageService uploadImageService;

    @Override
    public List<Goods> findAll() {
        return goodsDao.findAll();
    }

    @Override
    public Page<Goods> find(int pageNum, int pageSize) {
        return goodsDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.ASC, "id"));
    }

    @Override
    public Page<Goods> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public Goods getById(int id) {
        return goodsDao.findOne(id);
    }

    @Override
    @Transactional
    public Goods deleteById(int id) {
        Goods goods = getById(id);
        if (StringUtils.isNotEmpty(goods.getKindTagIds())) {
            String kindTagIds = ComFun.tagsThin(goods.getKindTagIds());
            kindTagService.updateKindTagSeviceNum(Integer.parseInt(kindTagIds), -1);
        }
        if (StringUtils.isNotEmpty(goods.getSpaceTagIds())) {
            List<Integer> spaceTagIds = ComFun.tagsToList(goods.getSpaceTagIds());
            for (Integer spaceTagId : spaceTagIds) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, -1);
            }
        }
        if (StringUtils.isNotEmpty(goods.getStyleTagIds())) {
            List<Integer> styleTagIds = ComFun.tagsToList(goods.getStyleTagIds());
            for (Integer styleTagId : styleTagIds) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, -1);
            }
        }
        goodsDao.delete(goods);
        return goods;
    }

    @Override
    @Transactional
    public Goods create(Goods goods) {
        goods.setCreateTime(new Date());
        goods.setCollectionNum(0);
        goods.setSeeNum(0);
        goods.setPraiseNum(0);
        if (StringUtils.isEmpty(goods.getIsPass())) {
            goods.setIsPass("init");//待审核
        }


        if (StringUtils.isNotEmpty(goods.getKindTagIds())) {
            String kindTagIds = ComFun.tagsThin(goods.getKindTagIds());
            kindTagService.updateKindTagSeviceNum(Integer.parseInt(kindTagIds), 1);
        }
        if (StringUtils.isNotEmpty(goods.getSpaceTagIds())) {
            List<Integer> spaceTagIds = ComFun.tagsToList(goods.getSpaceTagIds());
            for (Integer spaceTagId : spaceTagIds) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, 1);
            }
        }
        if (StringUtils.isNotEmpty(goods.getStyleTagIds())) {
            List<Integer> styleTagIds = ComFun.tagsToList(goods.getStyleTagIds());
            for (Integer styleTagId : styleTagIds) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, 1);
            }
        }
        goodsDao.save(goods);
        return goods;
    }

    @Override
    @Transactional
    public Goods update(Goods o) {
        Goods dest = getById(o.getId());
        ClassUtil.copyProperties(dest, o);
        return goodsDao.save(dest);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    @Override
    public Page<Goods> iPage(int pageNum,
                             int pageSize,
                             final String name,
                             final Integer kindTagId,
                             final Integer spaceTagId,
                             final Integer styleTagId,
                             String sort) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id");
        // collestionMost收藏最多，newest最新发布
        if (sort != null) {
            if ("collestionMost".equals(sort)) {
                pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "collectionNum");
            } else if ("newest".equals(sort)) {
                pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "createTime");
            }
        }

        Page<Goods> page = goodsDao.findAll(new Specification<Goods>() {
            @Override
            public Predicate toPredicate(Root<Goods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (StringUtils.isNotEmpty(name)) {
                    Predicate predicate = cb.like(root.get("name").as(String.class), "%" + name + "%");
                    predicateList.add(predicate);
                }
                if (kindTagId != null) {
                    Predicate predicate = cb.like(root.get("kindTagIds").as(String.class), "%@" + kindTagId + "@%");
                    predicateList.add(predicate);
                }
                if (spaceTagId != null) {
                    Predicate predicate = cb.like(root.get("spaceTagIds").as(String.class), "%@" + spaceTagId + "@%");
                    predicateList.add(predicate);
                }
                if (styleTagId != null) {
                    Predicate predicate = cb.like(root.get("styleTagIds").as(String.class), "%@" + styleTagId + "@%");
                    predicateList.add(predicate);
                }

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }
                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, pageRequest);

        return page;
    }

    @Override
    public Page<Goods> iPageMy(int pageNum, int pageSize, final Integer userId) {
        Page<Goods> page = goodsDao.findAll(new Specification<Goods>() {
            @Override
            public Predicate toPredicate(Root<Goods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (userId != null) {
                    Predicate predicate = cb.equal(root.get("user").get("id").as(Integer.class), userId);
                    predicateList.add(predicate);
                }

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }
                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));

        return page;
    }

    @Override
    @Transactional
    public void addGoods(Integer userId, String name, String kindTagIds, String spaceTagIds, String styleTagIds,
                         String price, String size, String texture, String link, String info,
                         String images,
                         String thumbnailImages,
                         String isHeads,
                         String isTurns) {
        Goods goods = new Goods();
        User user = new User();
        user.setId(userId);
        goods.setUser(user);
        goods.setName(name);
        // kindTagIds只会有一个
        if (StringUtils.isNotEmpty(kindTagIds)) {
            goods.setKindTagIds("@" + kindTagIds + "@");
        }
        if (StringUtils.isNotEmpty(spaceTagIds)) {
            String str = "";
            String[] arr = spaceTagIds.split(",");
            for (int i = 0; i < arr.length; i++) {
                if (i != 0) {
                    str += ",";
                }
                str += "@" + arr[i] + "@";
            }
            goods.setSpaceTagIds(str);
        }
        if (StringUtils.isNotEmpty(styleTagIds)) {
            String str = "";
            String[] arr = styleTagIds.split(",");
            for (int i = 0; i < arr.length; i++) {
                if (i != 0) {
                    str += ",";
                }
                str += "@" + arr[i] + "@";
            }
            goods.setStyleTagIds(str);
        }
        // tagsStr
        String tagsStr = getGoodsTagsStr(kindTagIds, spaceTagIds, styleTagIds);
        goods.setTagsStr(tagsStr);

        // 是否有素材图 hasMaterial
        String hasMaterial = "no";
        if (StringUtils.isNotEmpty(isTurns)) {
            String[] tArr = isTurns.split(",");
            for (int i = 0; i < tArr.length; i++) {
                if ("yes".equals(tArr[i])) {
                    hasMaterial = "yes";
                    break;
                }
            }
        }
        goods.setHasMaterial(hasMaterial);

        // 封面图
        String[] hArr = isHeads.split(",");
        for (int i = 0; i < hArr.length; i++) {
            if ("yes".equals(hArr[i])) {
                String[] arr1 = images.split(",");
                String[] tarr1 = thumbnailImages.split(",");
                try {
                    goods.setCover(arr1[i]);
                    goods.setThumbnailCover(tarr1[i]);
                } catch (Exception e) {

                }
            }
        }

        goods.setPrice(price);
        goods.setSize(size);
        goods.setTexture(texture);
        goods.setLink(link);
        goods.setInfo(info);
        goods = create(goods);

        // 保存商品图片
        if (StringUtils.isNotEmpty(images)) {
            String[] arr1 = images.split(",");
            String[] tarr1 = thumbnailImages.split(",");
            String[] arr2 = isHeads.split(",");
            String[] arr3 = isTurns.split(",");
            for (int i = 0; i < arr1.length; i++) {
                GoodsImage goodsImage = new GoodsImage();
                goodsImage.setGoods(goods);
                goodsImage.setImage(arr1[i]);
                goodsImage.setThumbnailImage(tarr1[i]);
                goodsImage.setIsHead(arr2[i]);
                goodsImage.setIsTurnMaterial(arr3[i]);
                goodsImageService.create(goodsImage);
            }

        }

        // 更新用户的更新信息
        new UserHasUpdateThread(attentionService, userId).start();
    }

    @Override
    public List<Goods> iFindGoodsByUser(User user) {
        return goodsDao.iFindGoodsByUser(user);
    }

    // 获取商品封面图
    @Override
    public String getHeadPath(Integer goodsId) {
        List<GoodsImage> goodsImageList = goodsImageService.listByGoodsId(goodsId);
        // 没有图片
        if (goodsImageList == null || goodsImageList.size() == 0) {
            return "";
        }

        // 有图片
        GoodsImage gi = new GoodsImage();
        gi = goodsImageList.get(0);
        for (int i = 0; i < goodsImageList.size(); i++) {
            GoodsImage t = goodsImageList.get(i);
            if ("yes".equals(t.getIsHead())) {
                gi = t;
                break;
            }
        }
        return gi.getImage();
    }

    @Override
    public String getGoodsTagsStr(Integer goodsId) {
        Goods goods = getById(goodsId);
        String kindTagIds = goods.getKindTagIds();
        String spaceTagIds = goods.getSpaceTagIds();
        String styleTagIds = goods.getStyleTagIds();
        List<Integer> kindTagIdList = ComFun.tagsToList(kindTagIds);
        List<Integer> spaceTagIdList = ComFun.tagsToList(spaceTagIds);
        List<Integer> styleTagIdList = ComFun.tagsToList(styleTagIds);
        List<KindTag> kindTagList = kindTagService.listByIds(kindTagIdList);
        List<SpaceTag> spaceTagList = spaceTagService.listByIds(spaceTagIdList);
        List<StyleTag> styleTagList = styleTagService.listByIds(styleTagIdList);
        String names = "";
        for (int i = 0; i < kindTagList.size(); i++) {
            if (names != "") {
                names += ",";
            }
            names += kindTagList.get(i).getName();
        }
        for (int i = 0; i < spaceTagList.size(); i++) {
            if (names != "") {
                names += ",";
            }
            names += spaceTagList.get(i).getName();
        }
        for (int i = 0; i < styleTagList.size(); i++) {
            if (names != "") {
                names += ",";
            }
            names += styleTagList.get(i).getName();
        }
        return names;
    }

    public String getGoodsTagsStr(String kindTagIds, String spaceTagIds, String styleTagIds) {
        List<Integer> kindTagIdList = ComFun.tagsToList(kindTagIds);
        List<Integer> spaceTagIdList = ComFun.tagsToList(spaceTagIds);
        List<Integer> styleTagIdList = ComFun.tagsToList(styleTagIds);
        List<KindTag> kindTagList = kindTagService.listByIds(kindTagIdList);
        List<SpaceTag> spaceTagList = spaceTagService.listByIds(spaceTagIdList);
        List<StyleTag> styleTagList = styleTagService.listByIds(styleTagIdList);
        String names = "";
        for (int i = 0; i < kindTagList.size(); i++) {
            if (names != "") {
                names += ",";
            }
            names += kindTagList.get(i).getName();
        }
        for (int i = 0; i < spaceTagList.size(); i++) {
            if (names != "") {
                names += ",";
            }
            names += spaceTagList.get(i).getName();
        }
        for (int i = 0; i < styleTagList.size(); i++) {
            if (names != "") {
                names += ",";
            }
            names += styleTagList.get(i).getName();
        }
        return names;
    }

    // 是否有素材
    @Override
    public Boolean hasMaterial(Integer goodsId) {
        List<GoodsImage> goodsImageList = goodsImageService.listByGoodsId(goodsId);
        for (int i = 0; i < goodsImageList.size(); i++) {
            if ("yes".equals(goodsImageList.get(i).getIsTurnMaterial())) {
                return true;
            }
        }
        return false;
    }

    @Override
    public int findGoodsCount(String name) {
        int count = 0;
        List<Goods> list = goodsDao.findGoods(name);
        if (null != list && list.size() > 0) {
            count = list.size();
        }
        return count;
    }

    @Override
    public Page<Goods> findGoods(final Integer id, final String goodsName, final Integer kindTagId, final String styleId, final String spaceId, final String isPass, int pageNum, int pageSize) {

        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "isRecommend", "id");

        Page<Goods> page = goodsDao.findAll(new Specification<Goods>() {
            @Override
            public Predicate toPredicate(Root<Goods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (id != null) {
                    Predicate predicate = cb.equal(root.get("id").as(Integer.class), id);
                    predicateList.add(predicate);
                }
                if (StringUtils.isNotEmpty(goodsName)) {
                    Predicate predicate = cb.like(root.get("name").as(String.class), "%" + goodsName + "%");
                    predicateList.add(predicate);
                }
                if (kindTagId != null) {
                    Predicate predicate = cb.like(root.get("kindTagIds").as(String.class), "%@" + kindTagId + "@%");
                    predicateList.add(predicate);
                }
                if (StringUtils.isNotEmpty(styleId)) {
                    Predicate predicate = cb.like(root.get("styleTagIds").as(String.class), "%@" + styleId + "@%");
                    predicateList.add(predicate);
                }
                if (StringUtils.isNotEmpty(spaceId)) {
                    Predicate predicate = cb.like(root.get("spaceTagIds").as(String.class), "%@" + spaceId + "@%");
                    predicateList.add(predicate);
                }
                if (StringUtils.isNotEmpty(isPass)) {
                    Predicate predicate = cb.equal(root.get("isPass").as(String.class), isPass);
                    predicateList.add(predicate);
                }

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }
                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, pageRequest);

        return page;
    }

    @Transactional
    @Override
    public void deleteGoods(Integer goodsId) {
        //删除场景图与商品图的关系
        sceneGoodsDao.deleteByGoodsId(goodsId);
        //删除商品时要删除收藏夹
        collectionService.deleteByObjectIdAndObjectType(goodsId, "goods");
        //删除商品的评论信息
        commentService.deleteByObjectIdAndObjectType(goodsId, "goods");
        //删除关联点赞信息
        praiseService.deleteByObjectIdAndObjectType(goodsId, "goods");
        //删除该系列图的用户评论记录
        commentUpdateStatusService.deleteByObjectIdAndObjectType(goodsId, "goods");
        //删除商品图片关系
        goodsImageService.deleteByGoodsId(goodsId);
        Goods goods = this.getById(goodsId);
        if (StringUtils.isNotEmpty(goods.getKindTagIds())) {
            String kindTagIds = ComFun.tagsThin(goods.getKindTagIds());
            kindTagService.updateKindTagSeviceNum(Integer.parseInt(kindTagIds), -1);
        }
        if (StringUtils.isNotEmpty(goods.getSpaceTagIds())) {
            List<Integer> spaceTagIds = ComFun.tagsToList(goods.getSpaceTagIds());
            for (Integer spaceTagId : spaceTagIds) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, -1);
            }
        }
        if (StringUtils.isNotEmpty(goods.getStyleTagIds())) {
            List<Integer> styleTagIds = ComFun.tagsToList(goods.getStyleTagIds());
            for (Integer styleTagId : styleTagIds) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, -1);
            }
        }
        //删除商品图
        goodsDao.delete(goodsId);
    }

    @Transactional
    @Override
    public void deleteGoods(int[] goodsId) {
        for (Integer id : goodsId) {
            this.deleteGoods(id);
        }
    }

    @Transactional
    @Override
    public void insert(String goodsName, String goodsKindTagId, String spaceTagIds, String styleTagIds, String price, String size, String texture, String link, String info, String images, String cover, String isTurnMaterialIds, Integer userId) {
        Goods goods = new Goods();
        User user = new User();
        user.setId(userId);
        goods.setUser(user);
        goods.setName(goodsName);
        // kindTagIds只会有一个
        if (StringUtils.isNotEmpty(goodsKindTagId)) {
            goods.setKindTagIds("@" + goodsKindTagId + "@");
        }
        if (StringUtils.isNotEmpty(spaceTagIds)) {
            String str = "";
            String[] arr = spaceTagIds.split(",");
            for (int i = 0; i < arr.length; i++) {
                if (i != 0) {
                    str += ",";
                }
                str += "@" + arr[i] + "@";
            }
            goods.setSpaceTagIds(str);
        }
        if (StringUtils.isNotEmpty(styleTagIds)) {
            String str = "";
            String[] arr = styleTagIds.split(",");
            for (int i = 0; i < arr.length; i++) {
                if (i != 0) {
                    str += ",";
                }
                str += "@" + arr[i] + "@";
            }
            goods.setStyleTagIds(str);
        }
        // tagsStr
        String tagsStr = getGoodsTagsStr(goodsKindTagId, spaceTagIds, styleTagIds);
        goods.setTagsStr(tagsStr);

        // 是否有素材图 hasMaterial
        if (StringUtils.isEmpty(isTurnMaterialIds)) {
            goods.setHasMaterial("no");
        } else {
            goods.setHasMaterial("yes");
        }

        //封面图
        goods.setCover(cover);

        goods.setPrice(price);
        goods.setSize(size);
        goods.setTexture(texture);
        goods.setLink(link);
        goods.setInfo(info);
        goods = create(goods);

        // 保存商品图片
        if (StringUtils.isNotEmpty(images)) {
            String[] arr1 = images.split(",");
            String[] arr3 = isTurnMaterialIds.split(",");
            for (int i = 0; i < arr1.length; i++) {
                String image = arr1[i];
                GoodsImage goodsImage = new GoodsImage();
                goodsImage.setGoods(goods);
                goodsImage.setImage(arr1[i]);
                if (arr1[i].equals(cover)) {
                    goodsImage.setIsHead("yes");
                } else {
                    goodsImage.setIsHead("no");
                }

                for (String path : arr3) {
                    if (image.equals(path)) {
                        goodsImage.setIsTurnMaterial("yes");
                        break;
                    } else {
                        goodsImage.setIsTurnMaterial("no");
                    }
                }
                goodsImageService.create(goodsImage);
            }

        }

    }

    @Override
    @Transactional
    public void pcInsert(String name, String kindTagIds, String spaceTagIds, String styleTagIds, String price, String size,
                         String texture, String link, String info,
                         String images,
                         String thumbnailImages,
                         String cover,
                         String thumbnailCover,
                         String isTurnMaterials, Integer userId) {
        Goods goods = new Goods();
        User user = new User();
        user.setId(userId);
        goods.setUser(user);
        goods.setName(name);
        goods.setKindTagIds(kindTagIds);
        goods.setSpaceTagIds(spaceTagIds);
        goods.setStyleTagIds(styleTagIds);
        // tagsStr
        String tagsStr = getGoodsTagsStr(kindTagIds, spaceTagIds, styleTagIds);
        goods.setTagsStr(tagsStr);

        // 是否有素材图 hasMaterial
        if (StringUtils.isNotEmpty(isTurnMaterials) && isTurnMaterials.contains("yes")) {
            goods.setHasMaterial("yes");
        } else {
            goods.setHasMaterial("no");
        }

        //封面图
        goods.setCover(cover);
        goods.setThumbnailCover(thumbnailCover);

        goods.setPrice(price);
        goods.setSize(size);
        goods.setTexture(texture);
        goods.setLink(link);
        goods.setInfo(info);
        goods = create(goods);

        // 保存商品图片
        if (StringUtils.isNotEmpty(images)) {
            String[] arr1 = images.split(",");
            String[] tarr1 = thumbnailImages.split(",");
            String[] arr3 = isTurnMaterials.split(",");
            for (int i = 0; i < arr1.length; i++) {
                String image = arr1[i];
                GoodsImage goodsImage = new GoodsImage();
                goodsImage.setGoods(goods);
                goodsImage.setImage(arr1[i]);
                goodsImage.setThumbnailImage(tarr1[i]);
                if (arr1[i].equals(cover)) {
                    goodsImage.setIsHead("yes");
                } else {
                    goodsImage.setIsHead("no");
                }
                goodsImage.setIsTurnMaterial(arr3[i]);
                goodsImageService.create(goodsImage);
            }
        }
    }

    @Transactional
    @Override
    public void update(Integer goodsId, String goodsName, String goodsKindTagId, String spaceTagIds, String styleTagIds, String price, String size, String texture, String link, String info, String images, String cover, String isTurnMaterialIds) {
        goodsImageService.clearByGoodsId(goodsId);
        Goods goods = this.getById(goodsId);
        goods.setName(goodsName);
        // kindTagIds只会有一个
        if (StringUtils.isNotEmpty(goodsKindTagId)) {
            goods.setKindTagIds("@" + goodsKindTagId + "@");
        }
        if (StringUtils.isNotEmpty(spaceTagIds)) {
            String str = "";
            String[] arr = spaceTagIds.split(",");
            for (int i = 0; i < arr.length; i++) {
                if (i != 0) {
                    str += ",";
                }
                str += "@" + arr[i] + "@";
            }
            goods.setSpaceTagIds(str);
        }
        if (StringUtils.isNotEmpty(styleTagIds)) {
            String str = "";
            String[] arr = styleTagIds.split(",");
            for (int i = 0; i < arr.length; i++) {
                if (i != 0) {
                    str += ",";
                }
                str += "@" + arr[i] + "@";
            }
            goods.setStyleTagIds(str);
        }
        // tagsStr
        String tagsStr = getGoodsTagsStr(goodsKindTagId, spaceTagIds, styleTagIds);
        goods.setTagsStr(tagsStr);

        // 是否有素材图 hasMaterial
        if (StringUtils.isEmpty(isTurnMaterialIds)) {
            goods.setHasMaterial("no");
        } else {
            goods.setHasMaterial("yes");
        }

        //封面图
        goods.setCover(cover);

        goods.setPrice(price);
        goods.setSize(size);
        goods.setTexture(texture);
        goods.setLink(link);
        goods.setInfo(info);
        goods = update(goods);

        // 保存商品图片
        if (StringUtils.isNotEmpty(images)) {
            String[] arr1 = images.split(",");
            String[] arr3 = isTurnMaterialIds.split(",");
            for (int i = 0; i < arr1.length; i++) {
                String image = arr1[i];
                GoodsImage goodsImage = new GoodsImage();
                goodsImage.setGoods(goods);
                goodsImage.setImage(arr1[i]);
                if (arr1[i].equals(cover)) {
                    goodsImage.setIsHead("yes");
                } else {
                    goodsImage.setIsHead("no");
                }

                for (String path : arr3) {
                    if (image.equals(path)) {
                        goodsImage.setIsTurnMaterial("yes");
                        break;
                    } else {
                        goodsImage.setIsTurnMaterial("no");
                    }
                }
                goodsImageService.create(goodsImage);
            }

        }

    }

    @Transactional
    @Override
    public Map<String, Object> batchImport(Integer userId, int sceneIndex, int goodsIndex) {
        //传递消息的map
        Map<String, Object> messageMap = new HashMap<String, Object>();
        //封装用户
        User user = new User();
        user.setId(userId);
        //商品与场景都从Session中获取
        List<Map<String, Object>> sceneList = null;
        if (SessionUtils.get("sceneList") != null) {
            sceneList = (List<Map<String, Object>>) SessionUtils.get("sceneList");
        }
        if (sceneList == null && sceneList.size() < 1) {
            messageMap.put("message", "浏览器缓存问题，请清空缓存再次执行此操作！");
            messageMap.put("code", "0");
            messageMap.put("color", "red");
            return messageMap;
        }

        List<Map<String, Object>> goodsList = null;
        if (SessionUtils.get("goodsList") != null) {
            goodsList = (List<Map<String, Object>>) SessionUtils.get("goodsList");
        }
        if (goodsList == null && goodsList.size() < 1) {
            messageMap.put("message", "浏览器缓存问题，请清空缓存再次执行此操作！");
            messageMap.put("code", "0");
            messageMap.put("color", "red");
            return messageMap;
        }

        if (goodsIndex > goodsList.size() - 1) {
            messageMap.put("message", "全部上传完成！");
            messageMap.put("code", "0");
            messageMap.put("color", "green");
            return messageMap;
        }
        //上传场景图 优先上传场景图
        if (sceneIndex <= sceneList.size() - 1) {
            //name,imagePath,space,style,info,isShow
            Map<String, Object> map = sceneList.get(sceneIndex);
            messageMap.put("sceneIndex", sceneIndex + 1);
            if (map.size() != 6) {
                messageMap.put("message", "请确认(" + map.get("name") + ")场景图所有数据正确，空字段没有忘掉空格，上传失败！");
                messageMap.put("code", "1");
                messageMap.put("color", "red");
                return messageMap;
            }
            Scene scene = new Scene();
            if (map.get("name") != null) {
                int inx = sceneService.findScenes(map.get("name").toString());//核实场景图名称是否已存在
                if (inx > 0) {
                    messageMap.put("message", "(" + map.get("name") + ")场景图名称已存在，上传失败！");
                    messageMap.put("code", "1");
                    messageMap.put("color", "red");
                    return messageMap;
                }
                scene.setName(map.get("name").toString());
            } else {
                messageMap.put("message", "(" + map.get("name") + ")场景图名称数据存在问题，上传失败！");
                messageMap.put("code", "1");
                messageMap.put("color", "red");
                return messageMap;
            }
            if (map.get("imagePath") != null) {
                File file = new File(map.get("imagePath").toString());
                String imagePath = UploadUtils.uploadFile(file);
                String thumbnailImagePath = uploadImageService.uploadThumbImage2Qiniu(file);
                scene.setImage(imagePath);
                scene.setThumbnailImage(thumbnailImagePath);
            } else {
                messageMap.put("message", "(" + map.get("name") + ")场景图图片存在问题，上传失败！");
                messageMap.put("code", "1");
                messageMap.put("color", "red");
                return messageMap;
            }
            if (map.get("space") != null) {
                String s = ComFun.tagsFat(map.get("space").toString());
                scene.setSpaceTagIds(s);
            } else {
                messageMap.put("message", "(" + map.get("name") + ")场景图空间类型存在问题，上传失败！");
                messageMap.put("code", "1");
                messageMap.put("color", "red");
                return messageMap;
            }
            if (map.get("style") != null) {
                String s = ComFun.tagsFat(map.get("style").toString());
                scene.setStyleTagIds(s);
            } else {
                messageMap.put("message", "(" + map.get("name") + ")场景图风格类型存在问题，上传失败！");
                messageMap.put("code", "1");
                messageMap.put("color", "red");
                return messageMap;
            }
            if (map.get("info") != null) {
                scene.setInfo(map.get("info").toString());
            } else {
                scene.setInfo("");
            }
            if (map.get("isShow") != null) {
                scene.setIsShow(map.get("isShow").toString());
            } else {
                messageMap.put("message", "(" + map.get("name") + ")场景图(isShow)是否显示存在问题，上传失败！");
                messageMap.put("code", "1");
                messageMap.put("color", "red");
                return messageMap;
            }
            //默认不推荐
            scene.setIsRecommend("no");
            //设置用户
            scene.setUser(user);
            //设置当前时间
            scene.setCreateTime(new Date());
            sceneService.create(scene);
            //上传成功
            if (sceneIndex < sceneList.size() - 1) {
                messageMap.put("message", "(" + map.get("name") + ")场景图上传成功");
            } else {
                messageMap.put("message", "(" + map.get("name") + ")场景图上传成功，场景图上传完成，开始上传商品");
            }
            messageMap.put("code", "1");
            messageMap.put("color", "green");
            return messageMap;
        } else {//进入这里代表场景图已经上传完毕
            if (goodsIndex <= goodsList.size() - 1) {
                //name,texture,link,info,price,size,space,style,kind,goodsImages,materialImages,scene
                Map<String, Object> map = goodsList.get(goodsIndex);
                messageMap.put("goodsIndex", goodsIndex + 1);
                if (map.size() != 12) {
                    messageMap.put("message", "请确认(" + map.get("name") + ")商品图所有数据正确，空字段没有忘掉空格，上传失败！");
                    messageMap.put("code", "1");
                    messageMap.put("color", "red");
                    return messageMap;
                }
                Goods goods = new Goods();
                goods.setUser(user);
                if (map.get("name") != null) {
                    int inx = findGoodsCount(map.get("name").toString());//核实商品图名称是否已存在
                    if (inx > 0) {
                        messageMap.put("message", "(" + map.get("name") + ")商品图名称已存在，上传失败！");
                        messageMap.put("code", "1");
                        messageMap.put("color", "red");
                        return messageMap;
                    }
                    goods.setName(map.get("name").toString());
                } else {
                    messageMap.put("message", "(" + map.get("name") + ")商品图名称数据存在问题，上传失败！");
                    messageMap.put("code", "1");
                    messageMap.put("color", "red");
                    return messageMap;
                }
                if (map.get("texture") != null) {
                    goods.setTexture(map.get("texture").toString());
                }
                if (map.get("link") != null) {
                    goods.setLink(map.get("link").toString());
                }
                if (map.get("info") != null) {
                    goods.setInfo(map.get("info").toString());
                }
                if (map.get("price") != null) {
                    goods.setPrice(map.get("price").toString());
                } else {
                    goods.setPrice("");
                }
                if (map.get("size") != null) {
                    goods.setSize(map.get("size").toString());
                }
                if (map.get("space") != null) {
                    String s = ComFun.tagsFat(map.get("space").toString());
                    goods.setSpaceTagIds(s);
                } else {
                    messageMap.put("message", "(" + map.get("name") + ")商品图空间类型存在问题，上传失败！");
                    messageMap.put("code", "1");
                    messageMap.put("color", "red");
                    return messageMap;
                }
                if (map.get("style") != null) {
                    String s = ComFun.tagsFat(map.get("style").toString());
                    goods.setStyleTagIds(s);
                } else {
                    messageMap.put("message", "(" + map.get("name") + ")商品图风格类型存在问题，上传失败！");
                    messageMap.put("code", "1");
                    messageMap.put("color", "red");
                    return messageMap;
                }
                if (map.get("kind") != null) {
                    String s = ComFun.tagsFat(map.get("kind").toString());
                    goods.setKindTagIds(s);
                } else {
                    messageMap.put("message", "(" + map.get("name") + ")商品图分类存在问题，上传失败！");
                    messageMap.put("code", "1");
                    messageMap.put("color", "red");
                    return messageMap;
                }
                //所有商品所属图片设置
                List<Map<String, Object>> imageMaps = new ArrayList<Map<String, Object>>();
                if (map.get("goodImages") != null) {
                    List<File> files = (List<File>) map.get("goodImages");
                    for (File file : files) {
                        Map<String, Object> imageMap = new HashMap<String, Object>();
                        String image = UploadUtils.uploadFile(file);
                        String thumbnailImage = uploadImageService.uploadThumbImage2Qiniu(file);
                        imageMap.put("isH", "no");
                        if (file.getName().contains("cover")) {
                            //设置封面图
                            goods.setCover(image);
                            goods.setThumbnailCover(thumbnailImage);
                            imageMap.put("isH", "yes");
                        }
                        imageMap.put("image", image);
                        imageMap.put("thumbnailImage", thumbnailImage);
                        imageMap.put("isTurnMaterial", "no");
                        imageMaps.add(imageMap);
                    }
                }
                if (map.get("materialImages") != null) {
                    List<File> files = (List<File>) map.get("materialImages");
                    if (files.size() > 0) {
                        goods.setHasMaterial("yes");
                    } else {
                        goods.setHasMaterial("no");
                    }
                    for (File file : files) {
                        Map<String, Object> imageMap = new HashMap<String, Object>();
                        String image = UploadUtils.uploadFile(file);
                        String thumbnailImage = uploadImageService.uploadThumbImage2Qiniu(file);
                        imageMap.put("isH", "no");
                        if (file.getName().contains("cover")) {
                            //设置封面图
                            goods.setCover(image);
                            imageMap.put("isH", "yes");
                        }
                        imageMap.put("image", image);
                        imageMap.put("thumbnailImage", thumbnailImage);
                        imageMap.put("isTurnMaterial", "yes");
                        imageMaps.add(imageMap);
                    }
                }

                if (StringUtils.isEmpty(goods.getCover())) {
                    messageMap.put("message", "(" + map.get("name") + ")商品图中不包含cover封面图，上传失败！");
                    messageMap.put("code", "1");
                    messageMap.put("color", "red");
                    return messageMap;
                }
                // tagsStr
                String tagsStr = getGoodsTagsStr(map.get("kind").toString(), map.get("space").toString(), map.get("style").toString());
                goods.setTagsStr(tagsStr);

                // 如果是超级管理员，则设置为审核通过
                User currentUser = SessionUtils.getCurrentUser();
                if ("superadmin".equals(currentUser.getMobile())) {
                    goods.setIsPass("yes");
                }

                goods = create(goods);
                //建立商品图片关系
                for (Map<String, Object> gom : imageMaps) {
                    GoodsImage gi = new GoodsImage();
                    gi.setGoods(goods);
                    gi.setImage(gom.get("image").toString());
                    gi.setThumbnailImage(gom.get("image").toString());
                    gi.setIsTurnMaterial(gom.get("isTurnMaterial").toString());
                    if (StringUtils.equals(gom.get("isTurnMaterial").toString(), "yes")) {
                        Material mat = new Material();
                        mat.setUser(user);
                        mat.setKindTagIds(goods.getKindTagIds());
                        mat.setStyleTagIds(goods.getStyleTagIds());
                        mat.setSpaceTagIds(goods.getSpaceTagIds());
                        mat.setImage(gom.get("image").toString());

                        String kindTagStr = kindTagService.getTagStr(map.get("kind").toString());
                        String spaceTagStr = spaceTagService.getTagStr(map.get("space").toString());
                        String styleTagStr = styleTagService.getTagStr(map.get("style").toString());
                        mat.setKindTag(kindTagStr);
                        mat.setSpaceTag(spaceTagStr);
                        mat.setStyleTag(styleTagStr);

                        mat.setCollect(0);
                        mat.setCreateTime(new Date());

                        mat = materialService.create(mat);
                        gi.setMaterial(mat);
                        if (StringUtils.equals(gom.get("isH").toString(), "yes")) {
                            gi.setIsHead("yes");
                        } else {
                            gi.setIsHead("no");
                        }
                    }
                    goodsImageService.create(gi);
                }
                if (map.get("scene") != null) {
                    if (StringUtils.isNotEmpty(map.get("scene").toString())) {
                        String[] sceneNames = map.get("scene").toString().split(",");
                        if (sceneNames.length < 1) {
                            messageMap.put("message", "(" + map.get("name") + ")商品图所属场景数据存在问题，商品图上传成功，建立联系失败！");
                            messageMap.put("code", "1");
                            messageMap.put("color", "green");
                            return messageMap;
                        }
                        for (String sceneName : sceneNames) {
                            List<Scene> scene = sceneService.findScenesByName(sceneName);
                            if (scene != null && scene.size() > 0) {
                                //暂时做取第一条处理
                                Scene sc = scene.get(0);
                                SceneGoods sg = new SceneGoods();
                                sg.setGoods(goods);
                                sg.setScene(sc);
                                sg.setPosition("0.5_0.5");
                                sceneGoodsService.create(sg);
                            } else {
                                messageMap.put("message", "(" + map.get("name") + ")商品图所属场景不存在，商品图上传成功，建立联系失败！");
                                messageMap.put("code", "1");
                                messageMap.put("color", "green");
                                return messageMap;
                            }
                        }
                    }
                } else {
                    messageMap.put("message", "(" + map.get("name") + ")商品图所属场景存在问题，商品图上传成功，建立联系失败！");
                    messageMap.put("code", "1");
                    messageMap.put("color", "green");
                    return messageMap;
                }

                //上传成功
                if (goodsIndex < goodsList.size() - 1) {
                    messageMap.put("message", "(" + map.get("name") + ")商品图上传成功");
                    messageMap.put("code", "1");
                } else {
                    messageMap.put("message", "(" + map.get("name") + ")商品图上传成功，全部上传完成！");
                    messageMap.put("code", "0");
                }

                messageMap.put("color", "green");
                return messageMap;
            }
        }
        return messageMap;
    }

    @Override
    public Page<Goods> pageToMain(int pageNum, int pageSize) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id");

        Page<Goods> page = goodsDao.findAll(new Specification<Goods>() {
            @Override
            public Predicate toPredicate(Root<Goods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }
                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, pageRequest);

        return page;
    }

    @Override
    public Page<Goods> pcPage(int pageNum, int pageSize, final String name, final Integer kindTagId, final Integer spaceTagId, final Integer styleTagId) {
        Page<Goods> page = goodsDao.findAll(new Specification<Goods>() {
            @Override
            public Predicate toPredicate(Root<Goods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (StringUtils.isNotEmpty(name)) {
                    Predicate predicate = cb.like(root.get("name").as(String.class), "%" + name + "%");
                    predicateList.add(predicate);
                }
                if (kindTagId != null) {
                    Predicate predicate = cb.like(root.get("kindTagIds").as(String.class), "%@" + kindTagId + "@%");
                    predicateList.add(predicate);
                }
                if (spaceTagId != null) {
                    Predicate predicate = cb.like(root.get("spaceTagIds").as(String.class), "%@" + spaceTagId + "@%");
                    predicateList.add(predicate);
                }
                if (styleTagId != null) {
                    Predicate predicate = cb.like(root.get("styleTagIds").as(String.class), "%@" + styleTagId + "@%");
                    predicateList.add(predicate);
                }

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }
                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "isRecommend", "id"));

        return page;
    }

    @Override
    public List<Goods> sameTypeGoods(final Integer goodsId) {
        int needCount = 6; // 还需要数量，最大为6

        // 先获取场景的空间类型和风格类型
        Goods goods = getById(goodsId);
        String kindTags = goods.getKindTagIds();
        String styleTagS = goods.getStyleTagIds();
        String spaceTags = goods.getSpaceTagIds();
        String kindTag = "";
        String styleTag = "";
        String spaceTag = "";

        if (kindTags.split(",").length > 0) {
            kindTag = kindTags.split(",")[0];
        }

        if (styleTagS.split(",").length > 0) {
            styleTag = styleTagS.split(",")[0];
        }

        if (spaceTags.split(",").length > 0) {
            spaceTag = spaceTags.split(",")[0];
        }

        // 用2个类型去匹配查询6条数据
        final String fKindTag1 = kindTag;
        final String fSpaceTag1 = spaceTag;
        final String fStyleTag1 = styleTag;
        List<Goods> list1 = new ArrayList<Goods>();
        if (StringUtils.isNotEmpty(fSpaceTag1) && StringUtils.isNotEmpty(fStyleTag1)) {
            Page<Goods> page1 = goodsDao.findAll(new Specification<Goods>() {
                @Override
                public Predicate toPredicate(Root<Goods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                    List<Predicate> predicateList = new ArrayList<Predicate>();
                    Predicate result = null;

                    if (StringUtils.isNotEmpty(fKindTag1)) {
                        Predicate predicate = cb.like(root.get("kindTagIds").as(String.class), fKindTag1);
                        predicateList.add(predicate);
                    }
                    if (StringUtils.isNotEmpty(fSpaceTag1)) {
                        Predicate predicate = cb.like(root.get("spaceTagIds").as(String.class), fSpaceTag1);
                        predicateList.add(predicate);
                    }
                    if (StringUtils.isNotEmpty(fStyleTag1)) {
                        Predicate predicate = cb.like(root.get("styleTagIds").as(String.class), fStyleTag1);
                        predicateList.add(predicate);
                    }
                    if (goodsId != null) {
                        Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), goodsId);
                        predicateList.add(predicate);
                    }

                    if (predicateList.size() > 0) {
                        result = cb.and(predicateList.toArray(new Predicate[]{}));
                    }
                    if (result != null) {
                        query.where(result);
                    }

                    return query.getRestriction();
                }

            }, new PageRequest(1 - 1, 6, Sort.Direction.DESC, "id"));
            list1 = page1.getContent();
            if (list1 == null) {
                list1 = new ArrayList<Goods>();
            }
        }

        // 用空间类型去匹配查询6条数据
        List<Goods> list2 = new ArrayList<Goods>();
        final String fKindTag2 = spaceTag;
        if (StringUtils.isNotEmpty(fKindTag2)) {
            Page<Goods> page2 = goodsDao.findAll(new Specification<Goods>() {
                @Override
                public Predicate toPredicate(Root<Goods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                    List<Predicate> predicateList = new ArrayList<Predicate>();
                    Predicate result = null;

                    if (StringUtils.isNotEmpty(fKindTag2)) {
                        Predicate predicate = cb.like(root.get("kindTagIds").as(String.class), fKindTag2);
                        predicateList.add(predicate);
                    }

                    if (predicateList.size() > 0) {
                        result = cb.and(predicateList.toArray(new Predicate[]{}));
                    }
                    if (goodsId != null) {
                        Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), goodsId);
                        predicateList.add(predicate);
                    }
                    if (result != null) {
                        query.where(result);
                    }

                    return query.getRestriction();
                }

            }, new PageRequest(1 - 1, 6, Sort.Direction.DESC, "id"));
            list2 = page2.getContent();
            if (list2 == null) {
                list2 = new ArrayList<Goods>();
            }
        }

        // 用空间类型去匹配查询6条数据
        List<Goods> list3 = new ArrayList<Goods>();
        final String fSpaceTag3 = spaceTag;
        if (StringUtils.isNotEmpty(fSpaceTag3)) {
            Page<Goods> page3 = goodsDao.findAll(new Specification<Goods>() {
                @Override
                public Predicate toPredicate(Root<Goods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                    List<Predicate> predicateList = new ArrayList<Predicate>();
                    Predicate result = null;

                    if (StringUtils.isNotEmpty(fSpaceTag3)) {
                        Predicate predicate = cb.like(root.get("spaceTagIds").as(String.class), fSpaceTag3);
                        predicateList.add(predicate);
                    }

                    if (predicateList.size() > 0) {
                        result = cb.and(predicateList.toArray(new Predicate[]{}));
                    }
                    if (goodsId != null) {
                        Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), goodsId);
                        predicateList.add(predicate);
                    }
                    if (result != null) {
                        query.where(result);
                    }

                    return query.getRestriction();
                }

            }, new PageRequest(1 - 1, 6, Sort.Direction.DESC, "id"));
            list3 = page3.getContent();
            if (list3 == null) {
                list3 = new ArrayList<Goods>();
            }
        }

        // 用风格类型去匹配查询6条数据
        List<Goods> list4 = new ArrayList<Goods>();
        final String fStyleTag4 = styleTag;
        if (StringUtils.isNotEmpty(fStyleTag4)) {
            Page<Goods> page4 = goodsDao.findAll(new Specification<Goods>() {
                @Override
                public Predicate toPredicate(Root<Goods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                    List<Predicate> predicateList = new ArrayList<Predicate>();
                    Predicate result = null;

                    if (StringUtils.isNotEmpty(fStyleTag4)) {
                        Predicate predicate = cb.like(root.get("styleTagIds").as(String.class), fStyleTag4);
                        predicateList.add(predicate);
                    }
                    if (goodsId != null) {
                        Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), goodsId);
                        predicateList.add(predicate);
                    }

                    if (predicateList.size() > 0) {
                        result = cb.and(predicateList.toArray(new Predicate[]{}));
                    }
                    if (result != null) {
                        query.where(result);
                    }

                    return query.getRestriction();
                }

            }, new PageRequest(1 - 1, 6, Sort.Direction.DESC, "id"));
            list4 = page4.getContent();
            if (list4 == null) {
                list4 = new ArrayList<Goods>();
            }
        }

        // 从所有的里面查询6条数据
        List<Goods> list5 = new ArrayList<Goods>();
        Page<Goods> page5 = goodsDao.findAll(new Specification<Goods>() {
            @Override
            public Predicate toPredicate(Root<Goods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (goodsId != null) {
                    Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), goodsId);
                    predicateList.add(predicate);
                }

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }
                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, new PageRequest(1 - 1, 6, Sort.Direction.DESC, "id"));
        list5 = page5.getContent();
        if (list5 == null) {
            list5 = new ArrayList<Goods>();
        }

        List<Goods> list = new ArrayList<Goods>();
        list.addAll(list1);
        needCount = needCount - list.size();

        if (needCount > 0) {
            for (int i = 0; i < list2.size(); i++) {
                if (!list.contains(list2.get(i)) && needCount > 0) {
                    list.add(list2.get(i));
                    needCount--;
                }
            }
        }

        if (needCount > 0) {
            for (int i = 0; i < list3.size(); i++) {
                if (!list.contains(list3.get(i)) && needCount > 0) {
                    list.add(list3.get(i));
                    needCount--;
                }
            }
        }

        if (needCount > 0) {
            for (int i = 0; i < list4.size(); i++) {
                if (!list.contains(list4.get(i)) && needCount > 0) {
                    list.add(list4.get(i));
                    needCount--;
                }
            }
        }

        if (needCount > 0) {
            for (int i = 0; i < list5.size(); i++) {
                if (!list.contains(list5.get(i)) && needCount > 0) {
                    list.add(list5.get(i));
                    needCount--;
                }
            }
        }

        return list;
    }

    @Override
    public Page<Goods> pcFindGoodsPage(final User user, int pageNum, int pageSize) {
        Page<Goods> page = goodsDao.findAll(new Specification<Goods>() {
            @Override
            public Predicate toPredicate(Root<Goods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (user != null) {
                    Predicate predicate = cb.equal(root.get("user").get("id").as(Integer.class), user.getId());
                    predicateList.add(predicate);
                }

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }
                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "createTime"));
        return page;
    }

    @Override
    public List<PicObj> pcFindPicObj(final User user) {
        //找出商品图最新的4张
        Page<Goods> goodsPage = goodsDao.findAll(new Specification<Goods>() {
            @Override
            public Predicate toPredicate(Root<Goods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (user != null) {
                    Predicate predicate = cb.equal(root.get("user").get("id").as(Integer.class), user.getId());
                    predicateList.add(predicate);
                }

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }
                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, new PageRequest(1 - 1, 4, Sort.Direction.DESC, "createTime"));
        Page<Scene> scenesPage = sceneDao.findAll(new Specification<Scene>() {
            @Override
            public Predicate toPredicate(Root<Scene> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (user != null) {
                    Predicate predicate = cb.equal(root.get("user").get("id").as(Integer.class), user.getId());
                    predicateList.add(predicate);
                }

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }
                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, new PageRequest(1 - 1, 4, Sort.Direction.DESC, "createTime"));
        Page<Series> seriesPage = seriesDao.findAll(new Specification<Series>() {
            @Override
            public Predicate toPredicate(Root<Series> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (user != null) {
                    Predicate predicate = cb.equal(root.get("user").get("id").as(Integer.class), user.getId());
                    predicateList.add(predicate);
                }

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }
                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, new PageRequest(1 - 1, 4, Sort.Direction.DESC, "createTime"));
        List<PicObj> picObjList = new ArrayList<PicObj>();
        List<Goods> goodsList = goodsPage.getContent();
        List<Scene> sceneList = scenesPage.getContent();
        List<Series> seriesList = seriesPage.getContent();
        for (Goods goods : goodsList) {
            PicObj picObj = new PicObj();
            picObj.setId(goods.getId());
            picObj.setObjectType("goods");
            picObj.setImage(goods.getCover());
            picObj.setCreateTime(goods.getCreateTime());
            picObjList.add(picObj);
        }
        for (Scene scene : sceneList) {
            PicObj picObj = new PicObj();
            picObj.setId(scene.getId());
            picObj.setObjectType("scene");
            picObj.setImage(scene.getImage());
            picObj.setCreateTime(scene.getCreateTime());
            picObjList.add(picObj);
        }
        for (Series series : seriesList) {
            PicObj picObj = new PicObj();
            picObj.setId(series.getId());
            picObj.setObjectType("series");
            picObj.setImage(series.getCover());
            picObj.setCreateTime(series.getCreateTime());
            picObjList.add(picObj);
        }
        return picObjList;
    }

    @Override
    @Transactional
    public void changeRecommend(Integer id, String isRecommend) {
        Goods goods = goodsDao.findOne(id);
        goods.setIsRecommend(isRecommend);
        if ("yes".equals(isRecommend)) {
            goods.setRecommendTime(new Date());
        } else {
            goods.setRecommendTime(null);
        }
        goodsDao.save(goods);
    }

    @Override
    @Transactional
    public void seeNumAdd(Integer goodsId) {
        Goods goods = getById(goodsId);
        Integer seeNum = goods.getSeeNum();
        if (seeNum == null) {
            seeNum = 0;
        }
        goods.setSeeNum(seeNum + 1);
        update(goods);
    }
}