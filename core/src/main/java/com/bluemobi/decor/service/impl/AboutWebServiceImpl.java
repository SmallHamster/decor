package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.AboutWebDao;
import com.bluemobi.decor.entity.AboutWeb;
import com.bluemobi.decor.service.AboutWebService;
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
 * Created by tuyh on 2015/7/23.
 */
@Service
@Transactional(readOnly = true)
public class AboutWebServiceImpl implements AboutWebService {

    @Autowired
    private AboutWebDao aboutWebDao;

    @Override
    public List<AboutWeb> findAll() {
        return aboutWebDao.findAll();
    }

    @Override
    public Page<AboutWeb> find(int pageNum, int pageSize) {

        return aboutWebDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));

    }

    @Override
    public Page<AboutWeb> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public AboutWeb getById(int id) {
        return aboutWebDao.findOne(id);
    }

    @Override
    @Transactional
    public AboutWeb deleteById(int id) {
        AboutWeb aboutWeb = getById(id);
        aboutWebDao.delete(aboutWeb);
        return aboutWeb;
    }

    @Override
    @Transactional
    public AboutWeb create(AboutWeb aboutWeb) {
        aboutWebDao.save(aboutWeb);
        return aboutWeb;
    }

    @Override
    @Transactional
    public AboutWeb update(AboutWeb aboutWeb) {
        return aboutWebDao.save(aboutWeb);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    @Override
    public Page<AboutWeb> pageWithTitle(int pageNum, int pageSize, final String title) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.ASC, "id");

        Page<AboutWeb> page = aboutWebDao.findAll(new Specification<AboutWeb>() {
            @Override
            public Predicate toPredicate(Root<AboutWeb> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (StringUtils.isNotEmpty(title)) {
                    Predicate predicate = cb.like(root.get("title").as(String.class), "%" + title + "%");
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
    public AboutWeb iGetAboutUS() {
        return aboutWebDao.iGetAboutUS(1);
    }

    @Override
    public List<AboutWeb> all() {
        return aboutWebDao.all();
    }
}