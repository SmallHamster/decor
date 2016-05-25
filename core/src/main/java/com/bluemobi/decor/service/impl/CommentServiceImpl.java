package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.CommentDao;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.service.*;
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
 * Created by tuyh on 2015/7/9.
 */
@Service
@Transactional(readOnly = true)
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentDao commentDao;

    @Autowired
    private CommentUpdateStatusService commentUpdateStatusService;

    @Autowired
    private SeriesService seriesService;
    @Autowired
    private SceneService sceneService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private SpaceTagService spaceTagService;
    @Autowired
    private SeriesTagService seriesTagService;

    @Override
    public List<Comment> findAll() {
        return commentDao.findAll();
    }

    @Override
    public Page<Comment> find(int pageNum, int pageSize) {
        return commentDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));
    }

    @Override
    public Page<Comment> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public Comment getById(int id) {
        return commentDao.findOne(id);
    }

    @Override
    @Transactional
    public Comment deleteById(int id) {
        Comment comment = getById(id);
        commentDao.deletebyPid(comment.getId());
        commentDao.delete(comment);
        return comment;
    }

    @Override
    @Transactional
    public Comment create(Comment comment) {
        if (comment.getPraiseNum() == null) {
            comment.setPraiseNum(0);
        }
        if (comment.getCreateTime() == null) {
            comment.setCreateTime(new Date());
        }
        commentDao.save(comment);
        return comment;
    }

    @Override
    @Transactional
    public Comment update(Comment comment) {
        return commentDao.save(comment);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    @Override
    public Comment iFindByUserAndObjectId(User user, Integer objectId, String objectType) {
        List<Comment> list = commentDao.iFindByUserAndObjectId(user, objectId, objectType);
        if (list != null && list.size() > 0) {
            return list.get(0);
        }
        return null;
    }

    @Override
    public int iGetCommentNumByUser(User user, Integer type) {
        int flag = 0;
        // type为0，即为查询评论数量
        // type不为0，即为查询回复数量
        if (type == 0) {
            flag = commentDao.iGetCommentNumByUser(user).size();
        } else {
            flag = commentDao.iGetCommentNumByUser2(user).size();
        }
        return flag;
    }

    @Override
    public List<Comment> iFindReply(Integer pid) {
        return commentDao.iFindReply(pid);
    }

    @Override
    public List<Comment> findListByObjectIdAndType(Integer objectId, String objectType) {
        return commentDao.findListByObjectIdAndType(objectId, objectType);
    }

    @Override
    public List<Comment> listReply(Integer pid) {
        return commentDao.listReply(pid);
    }

    @Override
    public Page<Comment> iFindCommentPage(final Integer userId, Integer pageNum, Integer pageSize) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id");

        Page<Comment> page = commentDao.findAll(new Specification<Comment>() {
            @Override
            public Predicate toPredicate(Root<Comment> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                // 过滤掉回复
                Predicate predicates = cb.equal(root.get("pid").as(Integer.class), 0);
                predicateList.add(predicates);

                if (null != userId) {
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

        return page;
    }

    @Override
    public Page<Comment> findCommentPage(final Integer userId, Integer pageNum, Integer pageSize) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id");
        Page<Comment> page = commentDao.findAll(new Specification<Comment>() {
            @Override
            public Predicate toPredicate(Root<Comment> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;
                // 过滤掉回复
                Predicate predicates = cb.equal(root.get("pid").as(Integer.class), 0);
                predicateList.add(predicates);
                if (null != userId) {
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
        List<Comment> commentList = page.getContent();
        for (Comment comment : commentList) {
            if (comment.getObjectType().equals("series")) {
                Series series = seriesService.getById(comment.getObjectId());
                comment.setObjectCover(series.getCover());
                comment.setObjectName(series.getInfo());
                if (series.getSeriesTag() != null) {
                    comment.setTags(series.getSeriesTag().getName());
                } else {
                    comment.setTags("");
                }
            } else if (comment.getObjectType().equals("scene")) {
                Scene scene = sceneService.getById(comment.getObjectId());
                comment.setObjectCover(scene.getImage());
                comment.setObjectName(scene.getName());
                String tags = spaceTagService.getTagStr(scene.getSpaceTagIds());
                comment.setTags(tags);
            } else if (comment.getObjectType().equals("goods")) {
                Goods goods = goodsService.getById(comment.getObjectId());
                comment.setObjectCover(goods.getCover());
                comment.setObjectName(goods.getName());
                String tags = spaceTagService.getTagStr(goods.getSpaceTagIds());
                comment.setTags(tags);
            }
        }
        return page;
    }

    @Override
    public Page<Comment> iFindCommentPages(final Integer objectId, final String objectType, Integer pageNum, Integer pageSize) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id");

        Page<Comment> page = commentDao.findAll(new Specification<Comment>() {
            @Override
            public Predicate toPredicate(Root<Comment> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                // 过滤掉回复
                Predicate predicates = cb.equal(root.get("pid").as(Integer.class), 0);
                predicateList.add(predicates);

                if (null != objectId) {
                    Predicate predicate = cb.equal(root.get("objectId").as(Integer.class), objectId);
                    predicateList.add(predicate);
                }

                if (null != objectType) {
                    Predicate predicate = cb.equal(root.get("objectType").as(String.class), objectType);
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

    // 评论列表
    @Override
    public Page<Comment> backendFindByCondition(int pageNum, int pageSize, final String username, final String pid) {
        Page<Comment> page = commentDao.findAll(new Specification<Comment>() {
            @Override
            public Predicate toPredicate(Root<Comment> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                // 商品名
                if (StringUtils.isNotEmpty(username)) {
                    Predicate predicate = cb.like(root.get("user").get("account").as(String.class), "%" + username + "%");
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
    public void deleteByObjectIdAndObjectType(Integer objectId, String objectType) {
        List<Comment> list = commentDao.findCommentByObjectIdAndObjectType(objectId, objectType);
        for (Comment comment : list) {
            this.deleteById(comment.getId());
        }
    }

    @Override
    public List<Comment> listCommentIncludeReply(Integer objectId, String objectType) {
        // 查询评论列表
        List<Comment> commentList = commentDao.findCommentByObjectIdAndObjectType(objectId, objectType);

        // 查询评论列表的回复
        for (int i = 0; i < commentList.size(); i++) {
            List<Comment> replyList = commentDao.listReply(commentList.get(i).getId());
            List<Reply> reList = new ArrayList<Reply>();
            for (int j = 0; j < replyList.size(); j++) {
                Reply reply = new Reply();
                Comment c = replyList.get(j);
                if (c.getUser() != null) {
                    reply.setNickname(c.getUser().getNickname());
                    reply.setHeadImage(c.getUser().getHeadImage());
                }
                reply.setId(c.getId());
                reply.setContent(c.getContent());
                reply.setCreateTime(c.getCreateTime());
                reply.setPraiseNum(c.getPraiseNum());
                reList.add(reply);
            }
            commentList.get(i).setReplyList(reList);
        }
        return commentList;
    }

    @Override
    public Page<Comment> pageCommentIncludeReply(Integer objectId, String objectType, Integer pageNum, Integer pageSize) {
        // 查询评论列表
        Page<Comment> page = commentDao.pageByObjectIdAndObjectType(objectId, objectType, new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));

        // 查询评论列表的回复
        for (int i = 0; i < page.getContent().size(); i++) {
            List<Comment> replyList = commentDao.listReply(page.getContent().get(i).getId());
            List<Reply> reList = new ArrayList<Reply>();
            for (int j = 0; j < replyList.size(); j++) {
                Reply reply = new Reply();
                Comment c = replyList.get(j);
                if (c.getUser() != null) {
                    reply.setNickname(c.getUser().getNickname());
                    reply.setHeadImage(c.getUser().getHeadImage());
                }
                reply.setId(c.getId());
                reply.setContent(c.getContent());
                reply.setCreateTime(c.getCreateTime());
                reply.setPraiseNum(c.getPraiseNum());
                reList.add(reply);
            }
            page.getContent().get(i).setReplyList(reList);
        }
        return page;
    }

    @Override
    @Transactional
    public void createComment(Integer userId, Integer objectId, String objectType, String content) {
        Comment comment = new Comment();
        User user = new User();
        user.setId(userId);
        comment.setUser(user);
        comment.setContent(content);
        comment.setCreateTime(new Date());
        comment.setObjectType(objectType);
        comment.setObjectId(objectId);

        // type为0即是评论，为1即是回复
        if (Constant.COMMENT_TYPE_COMMENT.equals(objectType)) {
            comment.setPid(objectId);
        } else {
            comment.setPid(0);
        }
        create(comment);

        // 记录评论状态
        if (Constant.COMMENT_TYPE_GOODS.equals(objectType)
                || Constant.COMMENT_TYPE_SCENE.equals(objectType)
                || Constant.COMMENT_TYPE_SERIES.equals(objectType)) {
            commentUpdateStatusService.createOrUpdateBusiness(comment.getUser().getId(), comment.getObjectId(), comment.getObjectType());
        }
    }

    @Override
    @Transactional
    public void iCreateCommentBusiness(Comment comment) {
        create(comment);
        String objectType = comment.getObjectType();
        // 记录评论状态
        if (Constant.COMMENT_TYPE_GOODS.equals(objectType)
                || Constant.COMMENT_TYPE_SCENE.equals(objectType)
                || Constant.COMMENT_TYPE_SERIES.equals(objectType)) {
            commentUpdateStatusService.createOrUpdateBusiness(comment.getUser().getId(), comment.getObjectId(), comment.getObjectType());
        }
    }


}