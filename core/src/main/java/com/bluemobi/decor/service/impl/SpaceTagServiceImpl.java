package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.SpaceTagDao;
import com.bluemobi.decor.entity.KindTag;
import com.bluemobi.decor.entity.SpaceTag;
import com.bluemobi.decor.service.SpaceTagService;
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
public class SpaceTagServiceImpl implements SpaceTagService {

    @Autowired
    private SpaceTagDao spaceTagDao;

    @Override
    public List<SpaceTag> findAll() {
        return spaceTagDao.findAll(new PageRequest(0, 100, Sort.Direction.DESC, "createDate")).getContent();
    }

    @Override
    public Page<SpaceTag> find(int pageNum, int pageSize) {
        return spaceTagDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));
    }

    @Override
    public Page<SpaceTag> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public SpaceTag getById(int id) {
        return spaceTagDao.findOne(id);
    }

    @Override
    @Transactional
    public SpaceTag deleteById(int id) {
        SpaceTag spaceTag = getById(id);
        spaceTagDao.delete(spaceTag);
        return spaceTag;
    }

    @Override
    @Transactional
    public SpaceTag create(SpaceTag spaceTag) {
        if (spaceTag.getNum() == null) {
            spaceTag.setNum(0);
        }
        spaceTagDao.save(spaceTag);
        return spaceTag;
    }

    @Override
    @Transactional
    public SpaceTag update(SpaceTag o) {
        SpaceTag dest = getById(o.getId());
        ClassUtil.copyProperties(dest, o);
        return spaceTagDao.save(dest);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    @Override
    public Page<SpaceTag> iFindSpaceSortPage(Integer pageNum, Integer pageSize) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id");

        Page<SpaceTag> page = spaceTagDao.findAll(new Specification<SpaceTag>() {
            @Override
            public Predicate toPredicate(Root<SpaceTag> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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
    public Page<SpaceTag> iPage(int pageNum, int pageSize) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id");

        Page<SpaceTag> page = spaceTagDao.findAll(new Specification<SpaceTag>() {
            @Override
            public Predicate toPredicate(Root<SpaceTag> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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
    public List<SpaceTag> listByIds(List<Integer> ids) {
        return spaceTagDao.listByIds(ids);
    }

    @Override
    public Page<SpaceTag> backendFindByCondition(int pageNum, int pageSize, final String name, final String id) {
        Page<SpaceTag> page = spaceTagDao.findAll(new Specification<SpaceTag>() {
            @Override
            public Predicate toPredicate(Root<SpaceTag> root, CriteriaQuery<?> query, CriteriaBuilder cb) {

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
    public void updateSpaceTagSeviceNum(Integer spaceTagId, int num) {
        if (spaceTagId != null) {
            SpaceTag spaceTag = this.getById(spaceTagId);
            spaceTag.setNum(spaceTag.getNum() + num);
            this.update(spaceTag);
        }
    }

    @Override
    public String getTagStr(String spaceTagIds) {
        if(StringUtils.isEmpty(spaceTagIds)){
            return "";
        }
        spaceTagIds = spaceTagIds.replace("@","");
        String str = "";
        String[] arr  = spaceTagIds.split(",");
        for (int i = 0; i < arr.length; i++) {
            try {
                Integer id = Integer.parseInt(arr[i]);
                SpaceTag spaceTag = getById(id);
                if(spaceTag != null && spaceTag.getName() != null){
                    if(str != ""){
                        str += ",";
                    }
                    str += spaceTag.getName();
                }
            }catch (Exception e){
                continue;
            }
        }
        return str;
    }

    @Override
    public List<SpaceTag> all() {
        return spaceTagDao.all();
    }
}
