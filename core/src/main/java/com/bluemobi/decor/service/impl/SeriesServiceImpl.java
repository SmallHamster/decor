package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.SeriesDao;
import com.bluemobi.decor.dao.SeriesSceneDao;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.service.*;
import com.bluemobi.decor.thread.UserHasUpdateThread;
import com.bluemobi.decor.utils.ClassUtil;
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
 * Created by gaoll on 2015/7/9.
 */
@Service
@Transactional(readOnly = true)
public class SeriesServiceImpl implements SeriesService {


    @Autowired
    private SeriesDao seriesDao;
    @Autowired
    private CommentUpdateStatusService commentUpdateStatusService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private PraiseService praiseService;
    @Autowired
    private SeriesSceneDao seriesSceneDao;

    @Autowired
    private SeriesSceneService seriesSceneService;

    @Autowired
    private SceneService sceneService;

    @Autowired
    private SeriesTagService seriesTagService;

    @Autowired
    private CollectionService collectionService;

    @Autowired
    private AttentionService attentionService;

    @Autowired
    private UserService userService;

    @Override
    public List<Series> findAll() {
        return seriesDao.findAll();
    }

    @Override
    public Page<Series> find(int pageNum, int pageSize) {

        return seriesDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));

    }

    @Override
    public Page<Series> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public Series getById(int id) {
        return seriesDao.findOne(id);
    }

    @Override
    @Transactional
    public Series deleteById(int id) {
        // 删除系列图之前，先删除该系列图的所有场景图关联，然后再执行删除操作
        List<SeriesScene> list = seriesSceneService.iFindBySeries(seriesDao.findOne(id));
        if (null != list && list.size() > 0) {
            for (SeriesScene seriesScene : list) {
                seriesSceneService.deleteById(seriesScene.getId());
            }
        }
        //删除所有收藏夹里的系列图
        collectionService.deleteByObjectIdAndObjectType(id, "series");
        Series series = getById(id);

        if (series.getSeriesTag() != null) {
            SeriesTag seriesTag = seriesTagService.getById(series.getSeriesTag().getId());
            seriesTag.setNum(seriesTag.getNum() > 0 ? seriesTag.getNum() - 1 : 0);
            seriesTagService.update(seriesTag);
        }

        seriesDao.delete(series);
        return series;
    }

    @Override
    @Transactional
    public Series create(Series series) {
        series.setCreateTime(new Date());
        if(series.getCollectionNum() == null){
            series.setCollectionNum(0);
        }
        if(series.getPraiseNum() == null){
            series.setPraiseNum(0);
        }
        if(series.getSeeNum() == null){
            series.setSeeNum(0);
        }
        seriesDao.save(series);

        // 修改用户的系列图数量
        User user = userService.getById(series.getUser().getId());
        user.setOpus(user.getOpus() + 1);
        userService.update(user);

        return series;
    }

    @Override
    @Transactional
    public Series update(Series o) {
        Series dest = getById(o.getId());
        ClassUtil.copyProperties(dest, o);
        return seriesDao.save(dest);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    @Override
    public Page<Series> iPage(int pageNum, int pageSize, final String condition, final Integer seriesTagId) {
        Page<Series> page = seriesDao.findAll(new Specification<Series>() {
            @Override
            public Predicate toPredicate(Root<Series> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                // 模糊查询搜索范围：描述信息，标签名称
                if (StringUtils.isNotEmpty(condition)) {
                    Predicate predicate1 = cb.like(root.get("info").as(String.class), "%" + condition + "%");
                    Predicate predicate2 = cb.like(root.get("seriesTag").get("name").as(String.class), "%" + condition + "%");
                    Predicate predicate = cb.or(predicate1, predicate2);
                    predicateList.add(predicate);
                }
                if (seriesTagId != null) {
                    Predicate predicate = cb.equal(root.get("seriesTag").get("id").as(String.class), seriesTagId);
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
    public Page<Series> iPageMy(int pageNum, int pageSize, final Integer userId) {
        Page<Series> page = seriesDao.findAll(new Specification<Series>() {
            @Override
            public Predicate toPredicate(Root<Series> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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

    // 创建系列图
    @Override
    @Transactional
    public void iAddSeries(Integer userId, Integer seriesTagId, String info, String sceneIds) {
        // 保存系列图
        Series series = new Series();
        User user = new User();
        user.setId(userId);
        SeriesTag seriesTag = new SeriesTag();
        seriesTag.setId(seriesTagId);
        if (info == null) {
            info = "";
        }
        series.setUser(user);
        series.setSeriesTag(seriesTag);
        series.setInfo(info);

        // 封面图,取第一个场景图的封面
        if (StringUtils.isNotEmpty(sceneIds)) {
            String[] arr = sceneIds.split(",");
            Scene scene = sceneService.getById(Integer.parseInt(arr[0]));
            series.setCover(scene.getImage());
            series.setThumbnailCover(scene.getThumbnailImage());
        }
        series = create(series);

        // 保存系列图场景图信息
        if (StringUtils.isNotEmpty(sceneIds)) {
            String[] arr = sceneIds.split(",");
            for (int i = 0; i < arr.length; i++) {
                SeriesScene seriesScene = new SeriesScene();
                Scene scene = new Scene();
                scene.setId(Integer.parseInt(arr[i]));
                seriesScene.setSeries(series);
                seriesScene.setScene(scene);
                seriesSceneService.create(seriesScene);
            }

        }
        if (seriesTagId != null) {
            seriesTag = seriesTagService.getById(seriesTagId);
            seriesTag.setNum(seriesTag.getNum() + 1);
            seriesTagService.update(seriesTag);
        }

        new UserHasUpdateThread(attentionService, userId).start();

    }

    // 创建系列图
    @Override
    @Transactional
    public void pcAddSeries(Integer userId, Integer seriesTagId, String info, String sceneIds) {
        iAddSeries(userId,seriesTagId,info,sceneIds);
    }

    @Override
    public List<Series> iFindSeriesByUser(User user) {
        return seriesDao.iFindSeriesByUser(user);
    }

    @Override
    public String getHeadPath(Integer seriesId) {
        List<Scene> sceneList = seriesSceneService.findSceneListBySeriesId(seriesId);
        if (sceneList != null && sceneList.size() > 0) {
            return sceneList.get(0).getImage();
        } else {
            return "";
        }
    }

    @Override
    public int findSeries(String info) {
        int count = 0;
        List<Series> list = seriesDao.findSeries(info);
        if (null != list && list.size() > 0) {
            count = list.size();
        }
        return count;
    }

    @Override
    public Page<Series> pageByParams(int pageNum, int pageSize, final Integer id, final String author, final Integer seriesTagId) {
        Page<Series> page = seriesDao.findAll(new Specification<Series>() {
            @Override
            public Predicate toPredicate(Root<Series> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (null != id) {
                    Predicate predicate = cb.equal(root.get("id").as(Integer.class), id);
                    predicateList.add(predicate);
                }

                if (null != author) {
                    Predicate predicate = cb.like(root.get("user").get("nickname").as(String.class), "%" + author + "%");
                    predicateList.add(predicate);
                }

                if (null != seriesTagId) {
                    Predicate predicate = cb.equal(root.get("seriesTag").get("id").as(String.class), seriesTagId);
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

    @Transactional
    @Override
    public void deleteBySeriesId(Integer seriesId) {
        Series series = getById(seriesId);
        if (series.getCover() != null) {
            UploadUtils.deleteFile(series.getCover());
        }
        if (series.getSeriesTag() != null) {
            SeriesTag seriesTag = seriesTagService.getById(series.getSeriesTag().getId());
            seriesTag.setNum(seriesTag.getNum() > 0 ? seriesTag.getNum() - 1 : 0);
            seriesTagService.update(seriesTag);
        }
        //删除场景系列图关系
        seriesSceneDao.deleteBySeriesId(seriesId);
        //删除场景图时要删除收藏夹
        collectionService.deleteByObjectIdAndObjectType(seriesId, "series");
        //删除关联点赞信息
        praiseService.deleteByObjectIdAndObjectType(seriesId, "series");
        //删除场景图的评论信息
        commentService.deleteByObjectIdAndObjectType(seriesId, "series");
        //删除该系列图的用户评论记录
        commentUpdateStatusService.deleteByObjectIdAndObjectType(seriesId,"series");
        //删除系列图
        seriesDao.delete(seriesId);
    }

    @Transactional
    @Override
    public void insert(Integer userId, Integer tagId, String info, String sceneIds) {
        String[] scIds = sceneIds.split(",");

        //创建系列图
        User user = new User();
        user.setId(userId);
        Series series = new Series();
        series.setUser(user);
        SeriesTag seriesTag = new SeriesTag();
        seriesTag.setId(tagId);
        series.setSeriesTag(seriesTag);
        series.setInfo(info);

        // 将第一张场景图的url设置为该系列图的封面
        String cover = sceneService.getById(Integer.parseInt(scIds[0])).getImage();
        series.setCover(cover);
        series = create(series);

        //创建系列图与场景图对应关系
        for (String sceneId : scIds) {
            SeriesScene seriesScene = new SeriesScene();
            seriesScene.setSeries(series);
            Scene scene = new Scene();
            scene.setId(Integer.parseInt(sceneId));
            seriesScene.setScene(scene);
            seriesSceneService.create(seriesScene);
        }
    }

    @Override
    public Page<Series> pcPage(int pageNum, int pageSize, final String name, final Integer seriesTagId) {
        Page<Series> page = seriesDao.findAll(new Specification<Series>() {
            @Override
            public Predicate toPredicate(Root<Series> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                // 模糊查询搜索范围：描述信息，标签名称
                if (StringUtils.isNotEmpty(name)) {
                    Predicate predicate1 = cb.like(root.get("info").as(String.class), "%" + name + "%");
                    Predicate predicate2 = cb.like(root.get("seriesTag").get("name").as(String.class), "%" + name + "%");
                    Predicate predicate = cb.or(predicate1, predicate2);
                    predicateList.add(predicate);
                }
                if (seriesTagId != null) {
                    Predicate predicate = cb.equal(root.get("seriesTag").get("id").as(String.class), seriesTagId);
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
    public List<Series> sameTypeSeries(final Integer seriesId) {
        int needCount = 6; // 还需要数量，最大为6

        // 先获取场景的空间类型和风格类型
        Series series = getById(seriesId);
        final Integer seriesTagId = series.getSeriesTag().getId();

        List<Series> list1 = new ArrayList<Series>();
        Page<Series> page1 = seriesDao.findAll(new Specification<Series>() {
            @Override
            public Predicate toPredicate(Root<Series> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (seriesTagId != null) {
                    Predicate predicate = cb.equal(root.get("seriesTag").get("id").as(Integer.class), seriesTagId);
                    predicateList.add(predicate);
                }
                if (seriesId != null) {
                    Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), seriesId);
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
        if(list1 == null){
            list1 = new ArrayList<Series>();
        }

        // 从所有的里面查询6条数据
        List<Series> list2 = new ArrayList<Series>();
        Page<Series> page2 = seriesDao.findAll(new Specification<Series>() {
            @Override
            public Predicate toPredicate(Root<Series> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (seriesId != null) {
                    Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), seriesId);
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
        list2 = page2.getContent();
        if(list2 == null){
            list2 = new ArrayList<Series>();
        }

        List<Series> list = new ArrayList<Series>();
        list.addAll(list1);
        needCount = needCount - list.size();

        if(needCount > 0){
            for (int i = 0; i < list2.size(); i++) {
                if(!list.contains(list2.get(i)) && needCount > 0){
                    list.add(list2.get(i));
                    needCount--;
                }
            }
        }

        return list;
    }

    @Override
    public Page<Series> pcFindSeriesPage( final User user, int pageNum, int pageSize) {
        Page<Series> page = seriesDao.findAll(new Specification<Series>() {
            @Override
            public Predicate toPredicate(Root<Series> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (user!=null) {
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

        }, new PageRequest(pageNum-1, pageSize, Sort.Direction.DESC, "createTime"));
        List<Series> seriesList=page.getContent();
        for (Series series:seriesList){
            int sceneNum=seriesSceneService.pcFindBySeries(series).size();
            series.setSceneNum(sceneNum);
        }

        return  page;
    }

    @Override
    public Page<Series> pageOrderByPraise(int pageNum, int pageSize,final Integer userId) {
        Sort sort = new Sort(Sort.Direction.DESC, "praiseNum").and(new Sort(Sort.Direction.DESC, "seeNum"));
        Page<Series> page = seriesDao.findAll(new Specification<Series>() {
            @Override
            public Predicate toPredicate(Root<Series> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (userId!=null) {
                    Predicate predicate = cb.equal(root.get("user").get("id").as(Integer.class),userId);
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
        }, new PageRequest(pageNum-1, pageSize, sort));
        return  page;
    }

    @Override
    @Transactional
    public void seeNumAdd(Integer id) {
        Series series = getById(id);
        Integer seeNum = series.getSeeNum();
        if(seeNum == null){
            seeNum = 0;
        }
        series.setSeeNum(seeNum + 1);
        update(series);
    }
}