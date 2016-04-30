package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.SceneDao;
import com.bluemobi.decor.dao.SceneGoodsDao;
import com.bluemobi.decor.dao.SeriesSceneDao;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.service.*;
import com.bluemobi.decor.thread.UserHasUpdateThread;
import com.bluemobi.decor.utils.ClassUtil;
import com.bluemobi.decor.utils.ComFun;
import com.bluemobi.decor.utils.UploadUtils;
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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by gaoll on 2015/7/7.
 */
@Service
@Transactional(readOnly = true)
public class SceneServiceImpl implements SceneService {

    @Autowired
    private SceneDao sceneDao;

    @Autowired
    private SpaceTagService spaceTagService;

    @Autowired
    private StyleTagService styleTagService;

    @Autowired
    private SceneGoodsService sceneGoodsService;

    @Autowired
    private SceneGoodsDao sceneGoodsDao;

    @Autowired
    private SeriesSceneDao seriesSceneDao;

    @Autowired
    private CollectionService collectionService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private PraiseService praiseService;

    @Autowired
    private AttentionService attentionService;
    @Autowired
    private CommentUpdateStatusService commentUpdateStatusService;

    @Override
    public List<Scene> findAll() {
        return sceneDao.findAll();
    }

    @Override
    public Page<Scene> find(int pageNum, int pageSize) {

        return sceneDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));

    }

    @Override
    public Page<Scene> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public Scene getById(int id) {
        return sceneDao.findOne(id);
    }

    @Override
    @Transactional
    public Scene deleteById(int id) {
        Scene scene = getById(id);
        if (StringUtils.isNotEmpty(scene.getSpaceTagIds())) {
            List<Integer> spaceTagIds = ComFun.tagsToList(scene.getSpaceTagIds());
            for (Integer spaceTagId : spaceTagIds) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, -1);
            }
        }
        if (StringUtils.isNotEmpty(scene.getStyleTagIds())) {
            List<Integer> styleTagIds = ComFun.tagsToList(scene.getStyleTagIds());
            for (Integer styleTagId : styleTagIds) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, -1);
            }
        }
        sceneDao.delete(scene);
        return scene;
    }

    @Override
    @Transactional
    public Scene create(Scene scene) {
        scene.setCreateTime(new Date());
        scene.setIsRecommend("no");
        if (StringUtils.isNotEmpty(scene.getSpaceTagIds())) {
            List<Integer> spaceTagIds = ComFun.tagsToList(scene.getSpaceTagIds());
            for (Integer spaceTagId : spaceTagIds) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, 1);
            }
        }
        if (StringUtils.isNotEmpty(scene.getStyleTagIds())) {
            List<Integer> styleTagIds = ComFun.tagsToList(scene.getStyleTagIds());
            for (Integer styleTagId : styleTagIds) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, 1);
            }
        }
        if (scene.getSeeNum() == null) {
            scene.setSeeNum(0);
        }
        if (scene.getCollectionNum() == null) {
            scene.setCollectionNum(0);
        }
        if (scene.getPraiseNum() == null) {
            scene.setPraiseNum(0);
        }
        sceneDao.save(scene);
        return scene;
    }

    @Override
    @Transactional
    public Scene createAndRecommend(Scene scene) {
        scene.setCreateTime(new Date());
        if (StringUtils.isNotEmpty(scene.getSpaceTagIds())) {
            List<Integer> spaceTagIds = ComFun.tagsToList(scene.getSpaceTagIds());
            for (Integer spaceTagId : spaceTagIds) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, 1);
            }
        }
        if (StringUtils.isNotEmpty(scene.getStyleTagIds())) {
            List<Integer> styleTagIds = ComFun.tagsToList(scene.getStyleTagIds());
            for (Integer styleTagId : styleTagIds) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, 1);
            }
        }
        sceneDao.save(scene);
        return scene;
    }

    @Transactional
    @Override
    public void updata(Integer sceneId, String sceneName, String styleTagIds, String spaceTagIds, String info, String image, String isShow, String isRecommend, List<Map<String, Object>> goodsMap) {
        Scene scene = getById(sceneId);
        if (StringUtils.isNotEmpty(scene.getSpaceTagIds())) {
            List<Integer> spp = ComFun.tagsToList(scene.getSpaceTagIds());
            for (Integer spaceTagId : spp) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, -1);
            }
        }
        if (StringUtils.isNotEmpty(scene.getStyleTagIds())) {
            List<Integer> stt = ComFun.tagsToList(scene.getStyleTagIds());
            for (Integer styleTagId : stt) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, -1);
            }
        }
        scene.setName(sceneName);
        scene.setInfo(info);
        scene.setImage(image);
        scene.setIsShow(isShow);
        if (StringUtils.equals(isRecommend, "yes")) {
            scene.setRecommendTime(new Date());
        }
        if (StringUtils.equals(isRecommend, "no")) {
            scene.setRecommendTime(null);
        }
        scene.setIsRecommend(isRecommend);
        if (StringUtils.isNotEmpty(spaceTagIds)) {
            String str = "";
            String[] arr = spaceTagIds.split(",");
            for (int i = 0; i < arr.length; i++) {
                if (i != 0) {
                    str += ",";
                }
                str += "@" + arr[i] + "@";
            }
            scene.setSpaceTagIds(str);
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
            scene.setStyleTagIds(str);
        }
        scene = update(scene);
        if (StringUtils.isNotEmpty(scene.getSpaceTagIds())) {
            List<Integer> spp = ComFun.tagsToList(scene.getSpaceTagIds());
            for (Integer spaceTagId : spp) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, 1);
            }
        }
        if (StringUtils.isNotEmpty(scene.getStyleTagIds())) {
            List<Integer> stt = ComFun.tagsToList(scene.getStyleTagIds());
            for (Integer styleTagId : stt) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, 1);
            }
        }

        sceneGoodsService.deleteBySceneId(sceneId);
        for (Map<String, Object> map : goodsMap) {
            SceneGoods sceneGoods = new SceneGoods();
            sceneGoods.setScene(scene);
            Goods goods = new Goods();
            goods.setId(Integer.parseInt(map.get("id").toString()));
            sceneGoods.setGoods(goods);
            sceneGoods.setPosition(map.get("position").toString());
            sceneGoodsService.create(sceneGoods);
        }
    }

    @Override
    public List<Scene> pcRecommendList() {
        List<Scene> list = sceneDao.recommendList();
        List<Scene> resultList = new ArrayList<Scene>();

        if (null != list && list.size() > 0) {
            if (list.size() > 6) {
                for (int i = 0; i < 6; i++) {
                    resultList.add(list.get(i));
                }
            } else {
                resultList = list;
            }
        }

        return resultList;
    }

    @Override
    public Page<Scene> pcPage(int pageNum, int pageSize, final String name, final Integer spaceTagId, final Integer styleTagId) {
        Page<Scene> page = sceneDao.findAll(new Specification<Scene>() {
            @Override
            public Predicate toPredicate(Root<Scene> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (StringUtils.isNotEmpty(name)) {
                    Predicate predicate = cb.like(root.get("name").as(String.class), "%" + name + "%");
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

    // 查询同类型场景6条
    @Override
    public List<Scene> sameTypeScene(final Integer sceneId) {
        int needCount = 6; // 还需要数量，最大为6

        // 先获取场景的空间类型和风格类型
        Scene scene = getById(sceneId);
        String styleTagS = scene.getStyleTagIds();
        String spaceTags = scene.getSpaceTagIds();
        String styleTag = "";
        String spaceTag = "";
        if (styleTagS.indexOf(",") != -1) {
            styleTag = spaceTags.substring(0, spaceTags.indexOf(","));
        }
        if (spaceTag.indexOf(",") != -1) {
            spaceTag = spaceTags.substring(0, spaceTags.indexOf(","));
        }

        // 用2个类型去匹配查询6条数据
        final String fSpaceTag1 = spaceTag;
        final String fStyleTag1 = styleTag;
        List<Scene> sceneList1 = new ArrayList<Scene>();
        if (StringUtils.isNotEmpty(fSpaceTag1) && StringUtils.isNotEmpty(fStyleTag1)) {
            Page<Scene> page1 = sceneDao.findAll(new Specification<Scene>() {
                @Override
                public Predicate toPredicate(Root<Scene> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                    List<Predicate> predicateList = new ArrayList<Predicate>();
                    Predicate result = null;

                    if (StringUtils.isNotEmpty(fSpaceTag1)) {
                        Predicate predicate = cb.like(root.get("spaceTagIds").as(String.class), fSpaceTag1);
                        predicateList.add(predicate);
                    }
                    if (StringUtils.isNotEmpty(fStyleTag1)) {
                        Predicate predicate = cb.like(root.get("styleTagIds").as(String.class), fStyleTag1);
                        predicateList.add(predicate);
                    }
                    if (sceneId != null) {
                        Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), sceneId);
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
            sceneList1 = page1.getContent();
            if (sceneList1 == null) {
                sceneList1 = new ArrayList<Scene>();
            }
        }

        // 用空间类型去匹配查询6条数据
        List<Scene> sceneList2 = new ArrayList<Scene>();
        final String fSpaceTag2 = spaceTag;
        if (StringUtils.isNotEmpty(fSpaceTag2)) {
            Page<Scene> page2 = sceneDao.findAll(new Specification<Scene>() {
                @Override
                public Predicate toPredicate(Root<Scene> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                    List<Predicate> predicateList = new ArrayList<Predicate>();
                    Predicate result = null;

                    if (StringUtils.isNotEmpty(fSpaceTag2)) {
                        Predicate predicate = cb.like(root.get("spaceTagIds").as(String.class), fSpaceTag2);
                        predicateList.add(predicate);
                    }
                    if (sceneId != null) {
                        Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), sceneId);
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
            sceneList2 = page2.getContent();
            if (sceneList2 == null) {
                sceneList2 = new ArrayList<Scene>();
            }
        }

        // 用风格类型去匹配查询6条数据
        List<Scene> sceneList3 = new ArrayList<Scene>();
        final String fStyleTag2 = styleTag;
        if (StringUtils.isNotEmpty(fStyleTag2)) {
            Page<Scene> page2 = sceneDao.findAll(new Specification<Scene>() {
                @Override
                public Predicate toPredicate(Root<Scene> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                    List<Predicate> predicateList = new ArrayList<Predicate>();
                    Predicate result = null;

                    if (StringUtils.isNotEmpty(fStyleTag2)) {
                        Predicate predicate = cb.like(root.get("styleTagIds").as(String.class), fStyleTag2);
                        predicateList.add(predicate);
                    }
                    if (sceneId != null) {
                        Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), sceneId);
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
            sceneList3 = page2.getContent();
            if (sceneList3 == null) {
                sceneList3 = new ArrayList<Scene>();
            }
        }

        // 从所有的里面查询6条数据
        List<Scene> sceneList4 = new ArrayList<Scene>();
        Page<Scene> page4 = sceneDao.findAll(new Specification<Scene>() {
            @Override
            public Predicate toPredicate(Root<Scene> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (sceneId != null) {
                    Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), sceneId);
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
        sceneList4 = page4.getContent();
        if (sceneList4 == null) {
            sceneList4 = new ArrayList<Scene>();
        }

        List<Scene> sceneList = new ArrayList<Scene>();
        sceneList.addAll(sceneList1);
        needCount = needCount - sceneList.size();

        if (needCount > 0) {
            for (int i = 0; i < sceneList2.size(); i++) {
                if (!sceneList.contains(sceneList2.get(i)) && needCount > 0) {
                    sceneList.add(sceneList2.get(i));
                    needCount--;
                }
            }
        }

        if (needCount > 0) {
            for (int i = 0; i < sceneList3.size(); i++) {
                if (!sceneList.contains(sceneList3.get(i)) && needCount > 0) {
                    sceneList.add(sceneList3.get(i));
                    needCount--;
                }
            }
        }

        if (needCount > 0) {
            for (int i = 0; i < sceneList4.size(); i++) {
                if (!sceneList.contains(sceneList4.get(i)) && needCount > 0) {
                    sceneList.add(sceneList4.get(i));
                    needCount--;
                }
            }
        }

        return sceneList;
    }

    @Override
    public Page<Scene> pcFindScenePage(final User user, int pageNum, int pageSize) {
        Page<Scene> page = sceneDao.findAll(new Specification<Scene>() {
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

        }, new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "createTime"));
        return page;
    }

    @Override
    @Transactional
    public Scene update(Scene o) {
        Scene dest = getById(o.getId());
        ClassUtil.copyProperties(dest, o);
        return sceneDao.save(dest);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    @Override
    public Page<Scene> iPage(int pageNum, int pageSize, final String name, final Integer spaceTagId, final Integer styleTagId,
                             final String sort) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id");
        // collestionMost收藏最多，newest最新发布
        if (sort != null) {
            if ("collestionMost".equals(sort)) {
                pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "collectionNum");
            } else if ("newest".equals(sort)) {
                pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "createTime");
            }
        }

        Page<Scene> page = sceneDao.findAll(new Specification<Scene>() {
            @Override
            public Predicate toPredicate(Root<Scene> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (StringUtils.isNotEmpty(name)) {
                    Predicate predicate = cb.like(root.get("name").as(String.class), "%" + name + "%");
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
    public Page<Scene> iPageMy(int pageNum, int pageSize, final Integer userId, final String name, final Integer spaceTagId) {
        Page<Scene> page = sceneDao.findAll(new Specification<Scene>() {
            @Override
            public Predicate toPredicate(Root<Scene> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (userId != null) {
                    Predicate predicate = cb.equal(root.get("user").get("id").as(Integer.class), userId);
                    predicateList.add(predicate);
                }

                if (StringUtils.isNotEmpty(name)) {
                    Predicate predicate = cb.like(root.get("name").as(String.class), "%" + name + "%");
                    predicateList.add(predicate);
                }
                if (spaceTagId != null) {
                    Predicate predicate = cb.like(root.get("spaceTagIds").as(String.class), "%@" + spaceTagId + "@%");
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
    public Page<Scene> iPageRecommend(int pageNum, int pageSize) {
        Page<Scene> page = sceneDao.findAll(new Specification<Scene>() {
            @Override
            public Predicate toPredicate(Root<Scene> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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

        }, new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "recommendTime"));

        return page;
    }

    @Override
    @Transactional
    public void addScene(Integer userId, String name, String spaceTagIds, String styleTagIds,
                         String info, String isShow, String image, String thumbnailImage, String goodsIds, String positions) {
        // 保存场景
        Scene scene = new Scene();
        User user = new User();
        user.setId(userId);
        scene.setUser(user);
        scene.setName(name);
        scene.setSpaceTagIds(ComFun.tagsFat(spaceTagIds));
        scene.setStyleTagIds(ComFun.tagsFat(styleTagIds));
        scene.setInfo(info);
        scene.setImage(image);
        scene.setThumbnailImage(thumbnailImage);
        scene.setIsShow(isShow);
        scene = create(scene);

        // 保存场景商品图
        if (StringUtils.isNotEmpty(goodsIds)) {
            String[] idArr = goodsIds.split("@");
            String[] posArr = positions.split("@");
            for (int i = 0; i < idArr.length; i++) {
                SceneGoods sceneGoods = new SceneGoods();
                Goods goods = new Goods();
                goods.setId(Integer.parseInt(idArr[i]));
                sceneGoods.setScene(scene);
                sceneGoods.setGoods(goods);
                sceneGoods.setPosition(posArr[i]);
                sceneGoodsService.create(sceneGoods);
            }
        }

        // 更新用户的更新信息
        new UserHasUpdateThread(attentionService, userId).start();
    }

    @Override
    @Transactional
    public void pcAddScene(Integer userId, String name, String spaceTagIds, String styleTagIds,
                           String info, String isShow, String image, String thumbnailImage, String goodsIds, String positions) {
        // 保存场景
        Scene scene = new Scene();
        User user = new User();
        user.setId(userId);
        scene.setUser(user);
        scene.setName(name);
        scene.setSpaceTagIds(ComFun.tagsFat(spaceTagIds));
        scene.setStyleTagIds(ComFun.tagsFat(styleTagIds));
        scene.setInfo(info);
        scene.setImage(image);
        scene.setThumbnailImage(thumbnailImage);
        scene.setIsShow(isShow);
        scene = create(scene);

        // 保存场景商品图
        if (StringUtils.isNotEmpty(goodsIds)) {
            String[] idArr = goodsIds.split("@");
            String[] posArr = positions.split("@");
            for (int i = 0; i < idArr.length; i++) {
                SceneGoods sceneGoods = new SceneGoods();
                Goods goods = new Goods();
                goods.setId(Integer.parseInt(idArr[i]));
                sceneGoods.setScene(scene);
                sceneGoods.setGoods(goods);
                sceneGoods.setPosition(posArr[i]);
                sceneGoodsService.create(sceneGoods);
            }
        }

        // 更新用户的更新信息
        new UserHasUpdateThread(attentionService, userId).start();
    }

    @Override
    @Transactional
    public void updateScene(Integer sceneId, String name, String spaceTagIds, String styleTagIds,
                            String info, String isShow, String image, String goodsIds, String positions) {
        // 保存场景
        Scene scene = getById(sceneId);
        if (StringUtils.isNotEmpty(scene.getSpaceTagIds())) {
            List<Integer> spIds = ComFun.tagsToList(scene.getSpaceTagIds());
            for (Integer spaceTagId : spIds) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, -1);
            }
        }
        if (StringUtils.isNotEmpty(scene.getStyleTagIds())) {
            List<Integer> stIds = ComFun.tagsToList(scene.getStyleTagIds());
            for (Integer styleTagId : stIds) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, -1);
            }
        }
        scene.setName(name);
        scene.setSpaceTagIds(ComFun.tagsFat(spaceTagIds));
        scene.setStyleTagIds(ComFun.tagsFat(styleTagIds));
        scene.setInfo(info);
        scene.setImage(image);
        scene.setIsShow(isShow);
        scene = update(scene);
        if (StringUtils.isNotEmpty(scene.getSpaceTagIds())) {
            List<Integer> spIds = ComFun.tagsToList(scene.getSpaceTagIds());
            for (Integer spaceTagId : spIds) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, 1);
            }
        }
        if (StringUtils.isNotEmpty(scene.getStyleTagIds())) {
            List<Integer> stIds = ComFun.tagsToList(scene.getStyleTagIds());
            for (Integer styleTagId : stIds) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, 1);
            }
        }
        // 删除场景的商品图
        sceneGoodsDao.deleteBySceneId(sceneId);

        // 保存场景商品图
        if (StringUtils.isNotEmpty(goodsIds)) {
            String[] idArr = goodsIds.split("@");
            String[] posArr = positions.split("@");
            for (int i = 0; i < idArr.length; i++) {
                SceneGoods sceneGoods = new SceneGoods();
                Goods goods = new Goods();
                goods.setId(Integer.parseInt(idArr[i]));
                sceneGoods.setScene(scene);
                sceneGoods.setGoods(goods);
                sceneGoods.setPosition(posArr[i]);
                sceneGoodsService.create(sceneGoods);
            }
        }

        // 更新用户的更新信息
        if (scene != null && scene.getUser() != null) {
            new UserHasUpdateThread(attentionService, scene.getUser().getId()).start();
        }


    }

    @Override
    public List<Scene> iFindSceneByUser(User user) {
        return sceneDao.iFindSceneByUser(user);
    }

    @Override
    public int findScenes(String name) {
        int count = 0;
        List<Scene> list = sceneDao.findScenes(name);
        if (null != list && list.size() > 0) {
            count = list.size();
        }
        return count;
    }

    @Override
    public List<Scene> findScenesByName(String name) {
        return sceneDao.findScenesByName(name);
    }

    @Override
    public Page<Scene> findScenes(final Integer id, final String name, final String author, final String styleId, final String spaceId, final String isRecommend, int pageNum, int pageSize) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "isRecommend", "id");
        Page<Scene> page = sceneDao.findAll(new Specification<Scene>() {
            @Override
            public Predicate toPredicate(Root<Scene> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (id != null) {
                    Predicate predicate = cb.equal(root.get("id").as(Integer.class), id);
                    predicateList.add(predicate);
                }

                if (StringUtils.isNotEmpty(name)) {
                    Predicate predicate = cb.like(root.get("name").as(String.class), "%" + name + "%");
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

                if (StringUtils.isNotEmpty(isRecommend)) {
                    Predicate predicate = cb.equal(root.get("isRecommend").as(String.class), isRecommend);
                    predicateList.add(predicate);
                }

                if (StringUtils.isNotEmpty(author)) {
                    Predicate predicate = cb.like(root.get("user").get("nickname").as(String.class), "%" + author + "%");
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
    public void deleteScenes(Integer scenesId) {
        Scene scene = this.getById(scenesId);
        if (scene.getImage() != null) {
            UploadUtils.deleteFile(scene.getImage());
        }
        if (StringUtils.isNotEmpty(scene.getSpaceTagIds())) {
            List<Integer> spIds = ComFun.tagsToList(scene.getSpaceTagIds());
            for (Integer spaceTagId : spIds) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, -1);
            }
        }
        if (StringUtils.isNotEmpty(scene.getStyleTagIds())) {
            List<Integer> stIds = ComFun.tagsToList(scene.getStyleTagIds());
            for (Integer styleTagId : stIds) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, -1);
            }
        }
        //删除场景图与其商品图
        sceneGoodsDao.deleteBySceneId(scenesId);
        //删除场景系列图关系
        seriesSceneDao.deleteBySceneId(scenesId);
        //删除场景图时要删除收藏夹
        collectionService.deleteByObjectIdAndObjectType(scenesId, "scene");
        //删除关联点赞信息
        praiseService.deleteByObjectIdAndObjectType(scenesId, "scene");
        //删除场景图的评论信息
        commentService.deleteByObjectIdAndObjectType(scenesId, "scene");
        //删除该系列图的用户评论记录
        commentUpdateStatusService.deleteByObjectIdAndObjectType(scenesId, "scene");
        //删除场景图
        sceneDao.delete(scenesId);
    }

    @Transactional
    @Override
    public void deleteScenes(int[] scenesId) {
        for (int id : scenesId) {
            this.deleteScenes(id);
        }
    }

    @Override
    @Transactional
    public void changeRecommend(Integer id, String isRecommend) {
        Scene scene = sceneDao.findOne(id);
        scene.setIsRecommend(isRecommend);
        if ("yes".equals(isRecommend)) {
            scene.setRecommendTime(new Date());
        } else {
            scene.setRecommendTime(null);
        }
        sceneDao.save(scene);
    }

    @Override
    public List<Scene> iListMy(final Integer userId, final String spaceTag) {
        PageRequest pageRequest = new PageRequest(0, 6, Sort.Direction.DESC, "id");
        Page<Scene> page = sceneDao.findAll(new Specification<Scene>() {
            @Override
            public Predicate toPredicate(Root<Scene> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (userId != null) {
                    Predicate predicate = cb.equal(root.get("user").get("id").as(Integer.class), userId);
                    predicateList.add(predicate);
                }

                if (spaceTag != null) {
                    Predicate predicate = cb.like(root.get("spaceTagIds").as(String.class), "%@" + spaceTag + "@%");
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

        return page.getContent();
    }

    @Override
    public List<Scene> listMy(final Integer userId, Integer number) {
        PageRequest pageRequest = new PageRequest(0, number, Sort.Direction.DESC, "id");
        Page<Scene> page = sceneDao.findAll(new Specification<Scene>() {
            @Override
            public Predicate toPredicate(Root<Scene> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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

        }, pageRequest);

        return page.getContent();
    }

    @Override
    public List<Scene> list(Integer number) {
        Page<Scene> page = sceneDao.findAll(new Specification<Scene>() {
            @Override
            public Predicate toPredicate(Root<Scene> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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

        }, new PageRequest(0, number, Sort.Direction.DESC, "recommendTime"));

        return page.getContent();
    }

    @Transactional
    @Override
    public void insert(Integer userId, String sceneName, String styleTagIds, String spaceTagIds, String info, String image, String isShow, String isRecommend, List<Map<String, Object>> goodsMap) {
        Scene scene = new Scene();
        User user = new User();
        user.setId(userId);
        scene.setUser(user);
        scene.setName(sceneName);
        scene.setInfo(info);
        scene.setImage(image);
        scene.setIsShow(isShow);
        if (StringUtils.equals(isRecommend, "yes")) {
            scene.setRecommendTime(new Date());
        }
        scene.setIsRecommend(isRecommend);
        if (StringUtils.isNotEmpty(spaceTagIds)) {
            String str = "";
            String[] arr = spaceTagIds.split(",");
            for (int i = 0; i < arr.length; i++) {
                if (i != 0) {
                    str += ",";
                }
                str += "@" + arr[i] + "@";
            }
            scene.setSpaceTagIds(str);
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
            scene.setStyleTagIds(str);
        }
        scene = createAndRecommend(scene);
        for (Map<String, Object> map : goodsMap) {
            SceneGoods sceneGoods = new SceneGoods();
            sceneGoods.setScene(scene);
            Goods goods = new Goods();
            goods.setId(Integer.parseInt(map.get("id").toString()));
            sceneGoods.setGoods(goods);
            sceneGoods.setPosition(map.get("position").toString());
            sceneGoodsService.create(sceneGoods);
        }
    }

    @Transactional
    @Override
    public void seeNumAdd(Integer id) {
        Scene scene = getById(id);
        Integer seeNum = scene.getSeeNum();
        if (seeNum == null) {
            seeNum = 0;
        }
        scene.setSeeNum(seeNum + 1);
        update(scene);
    }
}