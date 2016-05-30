package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.BackgroundDao;
import com.bluemobi.decor.entity.Background;
import com.bluemobi.decor.service.BackgroundService;
import com.bluemobi.decor.utils.ClassUtil;
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
 * Created by gaoll on 2015/9/23.
 */
@Service
@Transactional(readOnly = true)
public class BackgroundServiceImpl implements BackgroundService {

    @Autowired
    private BackgroundDao backgroundDao;


    @Override
    public List<Background> findAll() {
        return backgroundDao.findAll();
    }

    @Override
    public Page<Background> find(int pageNum, int pageSize) {

        return backgroundDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));

    }

    @Override
    public Page<Background> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public Background getById(int id) {
        return backgroundDao.findOne(id);
    }

    @Override
    @Transactional
    public Background deleteById(int id) {
        Background ad = getById(id);
        backgroundDao.delete(ad);
        return ad;
    }

    @Override
    @Transactional
    public Background create(Background ad) {
        backgroundDao.save(ad);
        return ad;
    }

    @Override
    @Transactional
    public Background update(Background o) {
        Background dest = getById(o.getId());
        ClassUtil.copyProperties(dest, o);
        return backgroundDao.save(dest);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    @Override
    public Page<Background> page(int pageNum, int pageSize) {
        Sort sort = new Sort(Sort.Direction.DESC, "status").and(new Sort(Sort.Direction.DESC, "updateTime"));
        Page<Background> page = backgroundDao.findAll(new Specification<Background>() {
            @Override
            public Predicate toPredicate(Root<Background> root, CriteriaQuery<?> query, CriteriaBuilder cb) {

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

        }, new PageRequest(pageNum - 1, pageSize, sort));

        return page;
    }


}