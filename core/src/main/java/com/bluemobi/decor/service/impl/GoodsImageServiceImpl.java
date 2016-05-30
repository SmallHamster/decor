package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.GoodsImageDao;
import com.bluemobi.decor.entity.GoodsImage;
import com.bluemobi.decor.entity.Material;
import com.bluemobi.decor.utils.ClassUtil;
import com.bluemobi.decor.service.GoodsImageService;
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
import java.util.List;

/**
 * Created by gaoll on 2015/7/6.
 */
@Service
@Transactional(readOnly = true)
public class GoodsImageServiceImpl implements GoodsImageService {

    @Autowired
    private GoodsImageDao goodsImageDao;


    @Override
    public List<GoodsImage> findAll() {
        return goodsImageDao.findAll();
    }

    @Override
    public Page<GoodsImage> find(int pageNum, int pageSize) {

        return goodsImageDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));

    }

    @Override
    public Page<GoodsImage> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public GoodsImage getById(int id) {
        return goodsImageDao.findOne(id);
    }

    @Override
    @Transactional
    public GoodsImage deleteById(int id) {
        GoodsImage goodsImage = getById(id);
        if (goodsImage.getImage() != null) {
            UploadUtils.deleteFile(goodsImage.getImage());
        }
        goodsImageDao.delete(goodsImage);
        return goodsImage;
    }

    @Override
    @Transactional
    public GoodsImage create(GoodsImage goodsImage) {
        goodsImageDao.save(goodsImage);
        return goodsImage;
    }

    @Override
    @Transactional
    public GoodsImage update(GoodsImage o) {
        GoodsImage dest = getById(o.getId());
        ClassUtil.copyProperties(dest, o);
        return goodsImageDao.save(dest);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    @Override
    public List<GoodsImage> listByGoodsId(Integer goodsId) {
        return goodsImageDao.listByGoodsId(goodsId);
    }

    @Override
    public Page<GoodsImage> findMaterial(final Integer materialId, final String styleId, final String spaceId, final String tagId, int pageNum, int pageSize) {

        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id");

        Page<GoodsImage> page = goodsImageDao.findAll(new Specification<GoodsImage>() {
            @Override
            public Predicate toPredicate(Root<GoodsImage> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (materialId != null) {
                    Predicate predicate = cb.equal(root.get("id").as(Integer.class), materialId);
                    predicateList.add(predicate);
                }

                if (StringUtils.isNotEmpty(tagId)) {
                    Predicate predicate = cb.like(root.get("material").get("kindTagIds").as(String.class), "%@" + tagId + "@%");
                    predicateList.add(predicate);
                }

                if (StringUtils.isNotEmpty(styleId)) {
                    Predicate predicate = cb.like(root.get("material").get("styleTagIds").as(String.class), "%@" + styleId + "@%");
                    predicateList.add(predicate);
                }

                if (StringUtils.isNotEmpty(spaceId)) {
                    Predicate predicate = cb.like(root.get("material").get("spaceTagIds").as(String.class), "%@" + spaceId + "@%");
                    predicateList.add(predicate);
                }

                Predicate predicate = cb.equal(root.get("isTurnMaterial").as(String.class), "yes");
                predicateList.add(predicate);


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
    public Page<GoodsImage> pageByKindTag(int pageNum, int pageSize,final String kindTagId) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id");
        Page<GoodsImage> page = goodsImageDao.findAll(new Specification<GoodsImage>() {
            @Override
            public Predicate toPredicate(Root<GoodsImage> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;
                {
                    Predicate predicate = cb.like(root.get("goods").get("kindTagIds").as(String.class), "%@" + kindTagId + "@%");
                    predicateList.add(predicate);
                }
//                {
//                    Predicate predicate = cb.notEqual(root.get("material").as(Material.class), null);
//                    predicateList.add(predicate);
//                }
                {
                    Predicate predicate = cb.isNotNull(root.get("material").as(Material.class));
                    predicateList.add(predicate);
                }
                {
                    Predicate predicate = cb.equal(root.get("isTurnMaterial").as(String.class), "yes");
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
    public void deleteByGoodsId(Integer goodsId) {
        List<GoodsImage> list = this.listByGoodsId(goodsId);
        for (GoodsImage goodsImage : list) {
            if (goodsImage.getImage() != null) {
                UploadUtils.deleteFile(goodsImage.getImage());
            }
        }
        goodsImageDao.deleteByGoodsId(goodsId);
    }

    @Override
    public void clearByGoodsId(Integer goodsId) {
        goodsImageDao.deleteByGoodsId(goodsId);
    }
}