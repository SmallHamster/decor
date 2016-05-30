package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.KindTagDao;
import com.bluemobi.decor.entity.Favorite;
import com.bluemobi.decor.entity.Feedback;
import com.bluemobi.decor.entity.KindTag;
import com.bluemobi.decor.entity.TResource;
import com.bluemobi.decor.service.KindTagService;
import com.bluemobi.decor.utils.ClassUtil;
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
 * Created by tuyh on 2015/7/8.
 */
@Service
@Transactional(readOnly = true)
public class KindTagServiceImpl implements KindTagService {

    @Autowired
    private KindTagDao kindTagDao;


    @Override
    public List<KindTag> findAll() {
        return kindTagDao.findAll(new PageRequest(0, 100, Sort.Direction.DESC, "createDate")).getContent();
    }

    @Override
    public Page<KindTag> find(int pageNum, int pageSize) {

        return kindTagDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "createDate"));

    }

    @Override
    public Page<KindTag> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public KindTag getById(int id) {
        return kindTagDao.findOne(id);
    }

    @Override
    @Transactional
    public KindTag deleteById(int id) {
        KindTag kindTag = getById(id);
        kindTagDao.delete(kindTag);
        return kindTag;
    }

    @Override
    @Transactional
    public KindTag create(KindTag kindTag) {
        if (kindTag.getNum() == null) {
            kindTag.setNum(0);
        }
        kindTagDao.save(kindTag);
        return kindTag;
    }

    @Override
    @Transactional
    public KindTag update(KindTag o) {
        KindTag dest = getById(o.getId());
        ClassUtil.copyProperties(dest, o);
        return kindTagDao.save(dest);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    @Override
    public Page<KindTag> iFindGoodsSortPage(Integer pageNum, Integer pageSize) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "createDate");

        Page<KindTag> page = kindTagDao.findAll(new Specification<KindTag>() {
            @Override
            public Predicate toPredicate(Root<KindTag> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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
    public Page<KindTag> page(Integer pageNum, Integer pageSize,final String name) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "createDate");
        Page<KindTag> page = kindTagDao.findAll(new Specification<KindTag>() {
            @Override
            public Predicate toPredicate(Root<KindTag> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;
                if (StringUtils.isNotEmpty(name)) {
                    Predicate predicate = cb.like(root.get("name").as(String.class), "%" + name + "%");
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
    public List<KindTag> listByIds(List<Integer> ids) {
        return kindTagDao.listByIds(ids);
    }

    @Override
    public Page<KindTag> backendFindByCondition(int pageNum, int pageSize, final String name, final String image) {
        Page<KindTag> page = kindTagDao.findAll(new Specification<KindTag>() {
            @Override
            public Predicate toPredicate(Root<KindTag> root, CriteriaQuery<?> query, CriteriaBuilder cb) {

                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (StringUtils.isNotEmpty(name)) {
                    Predicate predicate = cb.greaterThanOrEqualTo(root.get("name").as(String.class), name);
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

        }, new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "createDate"));

        return page;
    }

    @Override
    public void updateKindTagSeviceNum(Integer kindTagId, int num) {
        if (kindTagId != null) {
            KindTag kindTag = this.getById(kindTagId);
            kindTag.setNum(kindTag.getNum() + num);
            this.update(kindTag);
        }
    }

    @Override
    public String getTagStr(String kindTagId) {
        if(kindTagId == null){
            return "";
        }else {
            try {
                KindTag kindTag =  getById(Integer.parseInt(kindTagId));
                if (kindTag == null){
                    return "";
                }else {
                    return kindTag.getName();
                }
            }catch (Exception e){
                return "";
            }
        }
    }

    @Override
    public List<KindTag> all() {
        return kindTagDao.all();
    }
}