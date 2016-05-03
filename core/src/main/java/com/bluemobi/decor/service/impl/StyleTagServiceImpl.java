package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.StyleTagDao;
import com.bluemobi.decor.entity.SeriesTag;
import com.bluemobi.decor.entity.SpaceTag;
import com.bluemobi.decor.entity.StyleTag;
import com.bluemobi.decor.service.StyleTagService;
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
public class StyleTagServiceImpl implements StyleTagService {

    @Autowired
    private StyleTagDao styleTagDao;

    @Override
    public List<StyleTag> findAll() {
        return styleTagDao.findAll(new PageRequest(0, 100, Sort.Direction.DESC, "createDate")).getContent();
    }

    @Override
    public Page<StyleTag> find(int pageNum, int pageSize) {
        return styleTagDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "createDate"));
    }

    @Override
    public Page<StyleTag> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public StyleTag getById(int id) {
        return styleTagDao.findOne(id);
    }

    @Override
    @Transactional
    public StyleTag deleteById(int id) {
        StyleTag styleTag = getById(id);
        styleTagDao.delete(styleTag);
        return styleTag;
    }

    @Override
    @Transactional
    public StyleTag create(StyleTag styleTag) {
        if (styleTag.getNum() == null) {
            styleTag.setNum(0);
        }
        styleTagDao.save(styleTag);
        return styleTag;
    }

    @Override
    @Transactional
    public StyleTag update(StyleTag o) {
        StyleTag dest = getById(o.getId());
        ClassUtil.copyProperties(dest, o);
        return styleTagDao.save(dest);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    @Override
    public Page<StyleTag> iFindStyleSortPage(Integer pageNum, Integer pageSize) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "createDate");

        Page<StyleTag> page = styleTagDao.findAll(new Specification<StyleTag>() {
            @Override
            public Predicate toPredicate(Root<StyleTag> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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
    public List<StyleTag> listByIds(List<Integer> ids) {
        return styleTagDao.listByIds(ids);
    }

    @Override
    public Page<StyleTag> backendFindByCondition(int pageNum, int pageSize, final String name, final String id, final String bum) {
        Page<StyleTag> page = styleTagDao.findAll(new Specification<StyleTag>() {
            @Override
            public Predicate toPredicate(Root<StyleTag> root, CriteriaQuery<?> query, CriteriaBuilder cb) {

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
    public void updateStyleTagSeviceNum(Integer styleTagId, int num) {
        if (styleTagId != null) {
            StyleTag styleTag = this.getById(styleTagId);
            styleTag.setNum(styleTag.getNum() + num);
            this.update(styleTag);
        }
    }

    @Override
    public String getTagStr(String styleTagIds) {
        if(StringUtils.isEmpty(styleTagIds)){
            return "";
        }
        styleTagIds = styleTagIds.replace("@","");
        String str = "";
        String[] arr  = styleTagIds.split(",");
        for (int i = 0; i < arr.length; i++) {
            try {
                Integer id = Integer.parseInt(arr[i]);
                StyleTag styleTag = getById(id);
                if(styleTag != null && styleTag.getName() != null){
                    if(str != ""){
                        str += ",";
                    }
                    str += styleTag.getName();
                }
            }catch (Exception e){
                continue;
            }
        }
        return str;
    }

    @Override
    public List<StyleTag> all() {
        return styleTagDao.all();
    }
}