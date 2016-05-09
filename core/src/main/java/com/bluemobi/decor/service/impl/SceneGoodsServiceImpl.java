package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.SceneGoodsDao;
import com.bluemobi.decor.entity.Goods;
import com.bluemobi.decor.entity.Scene;
import com.bluemobi.decor.entity.SceneGoods;
import com.bluemobi.decor.utils.ClassUtil;
import com.bluemobi.decor.service.SceneGoodsService;
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
 * Created by gaoll on 2015/7/8.
 */
@Service
@Transactional(readOnly = true)
public class SceneGoodsServiceImpl implements SceneGoodsService {

    @Autowired
    private SceneGoodsDao sceneGoodsDao;


    @Override
    public List<SceneGoods> findAll() {
        return sceneGoodsDao.findAll();
    }

    @Override
    public Page<SceneGoods> find(int pageNum, int pageSize) {

        return sceneGoodsDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));

    }

    @Override
    public Page<SceneGoods> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public SceneGoods getById(int id) {
        return sceneGoodsDao.findOne(id);
    }

    @Override
    @Transactional
    public SceneGoods deleteById(int id) {
        SceneGoods sceneGoods = getById(id);
        sceneGoodsDao.delete(sceneGoods);
        return sceneGoods;
    }

    @Override
    @Transactional
    public SceneGoods create(SceneGoods sceneGoods) {
        sceneGoodsDao.save(sceneGoods);
        return sceneGoods;
    }

    @Override
    @Transactional
    public SceneGoods update(SceneGoods o) {
        SceneGoods dest = getById(o.getId());
        ClassUtil.copyProperties(dest, o);
        return sceneGoodsDao.save(dest);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    // 最多显示6条
    @Override
    public List<Goods> listGoods(final Integer sceneId) {
        Page<SceneGoods> page = sceneGoodsDao.findAll(new Specification<SceneGoods>() {
            @Override
            public Predicate toPredicate(Root<SceneGoods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (sceneId != null) {
                    Predicate predicate = cb.equal(root.get("scene").get("id").as(Integer.class), sceneId);
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

        List<SceneGoods> list = page.getContent();
        List<Goods> goodsList = new ArrayList<Goods>();
        for (int i = 0; i < list.size(); i++) {
            goodsList.add(list.get(i).getGoods());
        }
        return goodsList;
    }

    @Override
    public List<Scene> listSceneByGoodsId(final Integer goodsId) {
        Page<SceneGoods> page = sceneGoodsDao.findAll(new Specification<SceneGoods>() {
            @Override
            public Predicate toPredicate(Root<SceneGoods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (goodsId != null) {
                    Predicate predicate = cb.equal(root.get("goods").get("id").as(Integer.class), goodsId);
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

        List<SceneGoods> list = page.getContent();
        List<Scene> sceneList = new ArrayList<Scene>();
        for (int i = 0; i < list.size(); i++) {
            sceneList.add(list.get(i).getScene());
        }
        return sceneList;
    }

    @Override
    public List<SceneGoods> listBySceneId(Integer sceneId) {
        return sceneGoodsDao.listBySceneId(sceneId);
    }

    @Override
    public List<Goods> findGoods(Integer sceneId) {
        return sceneGoodsDao.listGoods(sceneId);
    }

    @Override
    public void deleteBySceneId(Integer sceneId) {
        sceneGoodsDao.deleteBySceneId(sceneId);
    }


}