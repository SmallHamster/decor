package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.CollectionMaterialDao;
import com.bluemobi.decor.dao.MaterialDao;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.service.*;
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

/**
 * Created by gaoll on 2015/7/6.
 */
@Service
@Transactional(readOnly = true)
public class MaterialServiceImpl implements MaterialService {

    @Autowired
    private MaterialDao materialDao;

    @Autowired
    private GoodsImageService goodsImageService;

    @Autowired
    private CollectionMaterialDao collectionMaterialDao;

    @Autowired
    private CollectionMaterialService collectionMaterialService;

    @Autowired
    private KindTagService kindTagService;

    @Autowired
    private SpaceTagService spaceTagService;

    @Autowired
    private StyleTagService styleTagService;

    @Override
    public List<Material> findAll() {
        return materialDao.findAll();
    }

    @Override
    public Page<Material> find(int pageNum, int pageSize) {
        return materialDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));
    }

    @Override
    public Page<Material> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public Material getById(int id) {
        return materialDao.findOne(id);
    }

    @Override
    @Transactional
    public Material deleteById(int id) {
        List<CollectionMaterial> list = collectionMaterialService.getInfoByMaterial(id);
        if (null != list && list.size() > 0) {
            for (CollectionMaterial collectionMaterial : list) {
                collectionMaterialService.deleteById(collectionMaterial.getId());
            }
        }

        Material material = getById(id);
        if (StringUtils.isNotEmpty(material.getKindTagIds())) {
            String kindTagIds = ComFun.tagsThin(material.getKindTagIds());
            kindTagService.updateKindTagSeviceNum(Integer.parseInt(kindTagIds), -1);
        }
        if (StringUtils.isNotEmpty(material.getSpaceTagIds())) {
            List<Integer> spaceTagIds = ComFun.tagsToList(material.getSpaceTagIds());
            for (Integer spaceTagId : spaceTagIds) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, -1);
            }
        }
        if (StringUtils.isNotEmpty(material.getStyleTagIds())) {
            List<Integer> styleTagIds = ComFun.tagsToList(material.getStyleTagIds());
            for (Integer styleTagId : styleTagIds) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, -1);
            }
        }
        materialDao.delete(material);
        return material;
    }

    @Override
    @Transactional
    public Material create(Material material) {
        if (StringUtils.isNotEmpty(material.getKindTagIds())) {
            String kindTagIds = ComFun.tagsThin(material.getKindTagIds());
            kindTagService.updateKindTagSeviceNum(Integer.parseInt(kindTagIds), 1);
        }
        if (StringUtils.isNotEmpty(material.getSpaceTagIds())) {
            List<Integer> spaceTagIds = ComFun.tagsToList(material.getSpaceTagIds());
            for (Integer spaceTagId : spaceTagIds) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, 1);
            }
        }
        if (StringUtils.isNotEmpty(material.getStyleTagIds())) {
            List<Integer> styleTagIds = ComFun.tagsToList(material.getStyleTagIds());
            for (Integer styleTagId : styleTagIds) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, 1);
            }
        }
        materialDao.save(material);
        return material;
    }

    @Override
    @Transactional
    public Material update(Material o) {
        Material dest = getById(o.getId());
        ClassUtil.copyProperties(dest, o);
        return materialDao.save(dest);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    @Override
    public Page<Material> iPageAll(int pageNum, int pageSize, final String name, final Integer kindTagId, final Integer spaceTagId,
                                   final Integer styleTagId, String sort) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id");
        // collestionMost收藏最多，newest最新发布
        if (sort != null) {
            if ("collestionMost".equals(sort)) {
                pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "collectionNum");
            } else if ("newest".equals(sort)) {
                pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "createTime");
            }
        }

        Page<Material> page = materialDao.findAll(new Specification<Material>() {
            @Override
            public Predicate toPredicate(Root<Material> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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
    public Page<Material> iPageMy(int pageNum, int pageSize, final Integer userId) {
        Page<Material> page = materialDao.findAll(new Specification<Material>() {
            @Override
            public Predicate toPredicate(Root<Material> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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
    public Page<Material> pcPageMy(int pageNum, int pageSize, final Integer userId) {
        Page<Material> page = materialDao.findAll(new Specification<Material>() {
            @Override
            public Predicate toPredicate(Root<Material> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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
    public Page<CollectionMaterial> iPageMyCollection(int pageNum, int pageSize, final Integer userId) {
        Page<CollectionMaterial> page = collectionMaterialDao.findAll(new Specification<CollectionMaterial>() {
            @Override
            public Predicate toPredicate(Root<CollectionMaterial> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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
    public Page<CollectionMaterial> pageMyCollection(int pageNum, int pageSize, final Integer userId,
                                                     final String name,
                                                     final Integer kindTagId,
                                                     final Integer spaceTagId,
                                                     final Integer styleTagId,
                                                     final String sort) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id");
        if (StringUtils.isNotBlank(sort)) {
                pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, sort);
        }
        Page<CollectionMaterial> page = collectionMaterialDao.findAll(new Specification<CollectionMaterial>() {
            @Override
            public Predicate toPredicate(Root<CollectionMaterial> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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
                if (kindTagId != null) {
                    Predicate predicate = cb.like(root.get("material").get("kindTagIds").as(String.class), "%@" + kindTagId + "@%");
                    predicateList.add(predicate);
                }
                if (spaceTagId != null) {
                    Predicate predicate = cb.like(root.get("material").get("spaceTagIds").as(String.class), "%@" + spaceTagId + "@%");
                    predicateList.add(predicate);
                }
                if (styleTagId != null) {
                    Predicate predicate = cb.like(root.get("material").get("styleTagIds").as(String.class), "%@" + styleTagId + "@%");
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
    public Page<Material> iPageWithUser(int pageNum, int pageSize, final Integer kindTagId, final Integer spaceTagId, final Integer styleTagId, String sort, final String name) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.ASC, "id");

        // collectMost收藏最多，
        // newMost最新发布
        if (sort != null) {
            if ("collectMost".equals(sort)) {
                pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "collect");
            } else {
                pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "createTime");
            }
        }

        Page<Material> page = materialDao.findAll(new Specification<Material>() {
            @Override
            public Predicate toPredicate(Root<Material> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (null != kindTagId) {
                    Predicate predicate = cb.like(root.get("kindTagIds").as(String.class), "%@" + kindTagId + "@%");
                    predicateList.add(predicate);
                }

                if (null != spaceTagId) {
                    Predicate predicate = cb.like(root.get("spaceTagIds").as(String.class), "%@" + spaceTagId + "@%");
                    predicateList.add(predicate);
                }

                if (null != styleTagId) {
                    Predicate predicate = cb.like(root.get("styleTagIds").as(String.class), "%@" + styleTagId + "@%");
                    predicateList.add(predicate);
                }

                if (StringUtils.isNotEmpty(name)) {
                    Predicate predicate1 = cb.like(root.get("kindTag").as(String.class), "%" + name + "%");
                    Predicate predicate2 = cb.like(root.get("spaceTag").as(String.class), "%" + name + "%");
                    Predicate predicate3 = cb.like(root.get("styleTag").as(String.class), "%" + name + "%");
                    Predicate predicate = cb.or(predicate1, predicate2, predicate3);
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
    public Material iCheckMaterialByUser(User user, Integer materialId) {
        List<Material> materialList = materialDao.iCheckMaterialByUser(user, materialId);
        if(materialList != null && materialList.size() > 0){
            return materialList.get(0);
        }
        return null;
    }

    @Override
    public int findMaterialCount(String name) {
        return materialDao.count(name);
    }

    @Override
    public Page<Material> findMaterials(final Integer id, int pageNum, int pageSize) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.ASC, "id");

        Page<Material> page = materialDao.findAll(new Specification<Material>() {
            @Override
            public Predicate toPredicate(Root<Material> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (null != id) {
                    Predicate predicate = cb.equal(root.get("id").as(Integer.class), id);
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
    public void deleteMaterial(Integer id) {
        GoodsImage goodsImage = goodsImageService.getById(id);
        if (goodsImage.getImage() != null) {
            UploadUtils.deleteFile(goodsImage.getImage());
        }
        Material material = goodsImage.getMaterial();
        goodsImageService.deleteById(id);
        if (material != null) {
            if (material.getImage() != null) {
                UploadUtils.deleteFile(material.getImage());
            }
            collectionMaterialDao.deleteByMaterialId(material.getId());
            if (StringUtils.isNotEmpty(material.getKindTagIds())) {
                String kindTagIds = ComFun.tagsThin(material.getKindTagIds());
                kindTagService.updateKindTagSeviceNum(Integer.parseInt(kindTagIds), -1);
            }
            if (StringUtils.isNotEmpty(material.getSpaceTagIds())) {
                List<Integer> spaceTagIds = ComFun.tagsToList(material.getSpaceTagIds());
                for (Integer spaceTagId : spaceTagIds) {
                    spaceTagService.updateSpaceTagSeviceNum(spaceTagId, -1);
                }
            }
            if (StringUtils.isNotEmpty(material.getStyleTagIds())) {
                List<Integer> styleTagIds = ComFun.tagsToList(material.getStyleTagIds());
                for (Integer styleTagId : styleTagIds) {
                    styleTagService.updateStyleTagSeviceNum(styleTagId, -1);
                }
            }
            materialDao.delete(material.getId());
        }
    }

    @Transactional
    @Override
    public void deleteMaterial(int[] ids) {
        for (Integer id : ids) {
            this.deleteMaterial(id);
        }
    }

    @Transactional
    @Override
    public void insertMaterial(Integer userId, String image, Integer goodsImageId, String kingTag, String spaceTagIds, String styleTagIds) {

        User user = new User();
        Material material = new Material();

        if (goodsImageId != null) {
            GoodsImage goodsImage = goodsImageService.getById(goodsImageId);
            user.setId(goodsImage.getGoods().getUser().getId());
            material.setUser(user);
            material.setImage(image);
            material.setCreateTime(new Date());
            material.setCollect(0);
            Goods goods = goodsImage.getGoods();
            if (StringUtils.isNotEmpty(goods.getKindTagIds())) {
                String kindTagIds = ComFun.tagsThin(goods.getKindTagIds());
                kindTagService.updateKindTagSeviceNum(Integer.parseInt(kindTagIds), 1);
            }
            if (StringUtils.isNotEmpty(goods.getSpaceTagIds())) {
                List<Integer> spIds = ComFun.tagsToList(goods.getSpaceTagIds());
                for (Integer spaceTagId : spIds) {
                    spaceTagService.updateSpaceTagSeviceNum(spaceTagId, 1);
                }
            }
            if (StringUtils.isNotEmpty(goods.getStyleTagIds())) {
                List<Integer> stIds = ComFun.tagsToList(goods.getStyleTagIds());
                for (Integer styleTagId : stIds) {
                    styleTagService.updateStyleTagSeviceNum(styleTagId, 1);
                }
            }
            material.setKindTagIds(goods.getKindTagIds());
            material.setSpaceTagIds(goods.getSpaceTagIds());
            material.setStyleTagIds(goods.getStyleTagIds());
            String maiKingTag = ComFun.tagsThin(goods.getKindTagIds());
            String maiSpaceTag = ComFun.tagsThin(goods.getSpaceTagIds());
            String maiStyleTag = ComFun.tagsThin(goods.getStyleTagIds());
            // 保存标签的中文
            String kindTagStr = kindTagService.getTagStr(maiKingTag);
            String spaceTagStr = spaceTagService.getTagStr(maiSpaceTag);
            String styleTagStr = styleTagService.getTagStr(maiStyleTag);
            material.setKindTag(kindTagStr);
            material.setSpaceTag(spaceTagStr);
            material.setStyleTag(styleTagStr);
            material = create(material);
            goodsImage.setMaterial(material);
            goodsImageService.update(goodsImage);
        } else {
            user.setId(userId);
            material.setUser(user);
            material.setImage(image);
            material.setCreateTime(new Date());
            material.setCollect(0);
            material = create(material);
            GoodsImage goodsImage = new GoodsImage();
            //设置为确定转为图片，才会在素材列表中显示
            goodsImage.setIsTurnMaterial("yes");

            // 保存标签的中文
            String kindTagStr = kindTagService.getTagStr(kingTag);
            String spaceTagStr = spaceTagService.getTagStr(spaceTagIds);
            String styleTagStr = styleTagService.getTagStr(styleTagIds);
            material.setKindTag(kindTagStr);
            material.setSpaceTag(spaceTagStr);
            material.setStyleTag(styleTagStr);

            String zyKingTag = ComFun.tagsFat(kingTag);
            String zyspIds = null;
            String zystIds = null;
            zyspIds = ComFun.tagsFat(spaceTagIds);
            zystIds = ComFun.tagsFat(styleTagIds);
            material.setKindTagIds(zyKingTag);
            material.setSpaceTagIds(zyspIds);
            material.setStyleTagIds(zystIds);
            if (StringUtils.isNotEmpty(zyKingTag)) {
                String kindTagIds = ComFun.tagsThin(zyKingTag);
                kindTagService.updateKindTagSeviceNum(Integer.parseInt(kindTagIds), 1);
            }
            if (StringUtils.isNotEmpty(zyspIds)) {
                List<Integer> spIds = ComFun.tagsToList(zyspIds);
                for (Integer spaceTagId : spIds) {
                    spaceTagService.updateSpaceTagSeviceNum(spaceTagId, 1);
                }
            }
            if (StringUtils.isNotEmpty(zystIds)) {
                List<Integer> stIds = ComFun.tagsToList(zystIds);
                for (Integer styleTagId : stIds) {
                    styleTagService.updateStyleTagSeviceNum(styleTagId, 1);
                }
            }
            goodsImage.setMaterial(material);
            goodsImageService.create(goodsImage);
        }
    }

    @Transactional
    @Override
    public void updataMaterial(String image, Integer materialId, String kingTag, String spaceTagIds, String styleTagIds) {

        Material material = getById(materialId);
        material.setImage(image);

        // 保存标签的中文
        String kindTagStr = kindTagService.getTagStr(kingTag);
        String spaceTagStr = spaceTagService.getTagStr(spaceTagIds);
        String styleTagStr = styleTagService.getTagStr(styleTagIds);
        material.setKindTag(kindTagStr);
        material.setSpaceTag(spaceTagStr);
        material.setStyleTag(styleTagStr);

        String zyKingTag = null;
        String zySpIds = null;
        String zyStIds = null;
        zyKingTag = ComFun.tagsFat(kingTag);
        zySpIds = ComFun.tagsFat(spaceTagIds);
        zyStIds = ComFun.tagsFat(styleTagIds);
        material.setKindTagIds(zyKingTag);
        material.setSpaceTagIds(zySpIds);
        material.setStyleTagIds(zyStIds);

        String mKingTag = null;
        String mSpIds = null;
        String mStIds = null;
        mKingTag = ComFun.tagsFat(kingTag);
        mSpIds = ComFun.tagsFat(spaceTagIds);
        mStIds = ComFun.tagsFat(styleTagIds);

        if (StringUtils.isNotEmpty(mKingTag)) {
            String kindTagIds = ComFun.tagsThin(mKingTag);
            kindTagService.updateKindTagSeviceNum(Integer.parseInt(kindTagIds), -1);
        }
        if (StringUtils.isNotEmpty(mSpIds)) {
            List<Integer> spIds = ComFun.tagsToList(mSpIds);
            for (Integer spaceTagId : spIds) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, -1);
            }
        }
        if (StringUtils.isNotEmpty(mStIds)) {
            List<Integer> stIds = ComFun.tagsToList(mStIds);
            for (Integer styleTagId : stIds) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, -1);
            }
        }

        if (StringUtils.isNotEmpty(zyKingTag)) {
            String kindTagIds = ComFun.tagsThin(zyKingTag);
            kindTagService.updateKindTagSeviceNum(Integer.parseInt(kindTagIds), 1);
        }
        if (StringUtils.isNotEmpty(zySpIds)) {
            List<Integer> spIds = ComFun.tagsToList(zySpIds);
            for (Integer spaceTagId : spIds) {
                spaceTagService.updateSpaceTagSeviceNum(spaceTagId, 1);
            }
        }
        if (StringUtils.isNotEmpty(zyStIds)) {
            List<Integer> stIds = ComFun.tagsToList(zyStIds);
            for (Integer styleTagId : stIds) {
                styleTagService.updateStyleTagSeviceNum(styleTagId, 1);
            }
        }
        update(material);
    }

    @Override
    public List<Material> listMy(final Integer userId, Integer number) {
        Page<Material> page = materialDao.findAll(new Specification<Material>() {
            @Override
            public Predicate toPredicate(Root<Material> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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

        }, new PageRequest(0, number, Sort.Direction.DESC, "id"));

        return page.getContent();
    }

    @Override
    public List<Material> listMyCollection(final Integer userId, Integer number) {
        Page<CollectionMaterial> page = collectionMaterialDao.findAll(new Specification<CollectionMaterial>() {
            @Override
            public Predicate toPredicate(Root<CollectionMaterial> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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

        }, new PageRequest(0, number, Sort.Direction.DESC, "id"));

        List<Material> list = new ArrayList<Material>();
        if (page.getContent() != null) {
            for (int i = 0; i < page.getContent().size(); i++) {
                CollectionMaterial cm = page.getContent().get(i);
                list.add(cm.getMaterial());
            }
        }
        return list;
    }

    @Override
    public List<Material> list(Integer number) {
        Page<Material> page = materialDao.findAll(new Specification<Material>() {
            @Override
            public Predicate toPredicate(Root<Material> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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

        }, new PageRequest(0, number, Sort.Direction.DESC, "collect"));

        return page.getContent();
    }
}