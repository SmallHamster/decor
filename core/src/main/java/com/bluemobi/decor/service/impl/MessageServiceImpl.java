package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.MessageDao;
import com.bluemobi.decor.entity.CollectionMessage;
import com.bluemobi.decor.entity.Message;
import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.service.CollectionMessageService;
import com.bluemobi.decor.service.MessageService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by tuyh on 2015/7/14.
 */
@Service
@Transactional(readOnly = true)
public class MessageServiceImpl implements MessageService {

    @Autowired
    private MessageDao messageDao;

    @PersistenceContext
    private EntityManager em;

    @Autowired
    private CollectionMessageService collectionMessageService;

    @Override
    public List<Message> findAll() {
        return messageDao.findAll();
    }

    @Override
    public Page<Message> find(int pageNum, int pageSize) {
        return messageDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));
    }

    @Override
    public Page<Message> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public Message getById(int id) {
        return messageDao.findOne(id);
    }

    @Override
    @Transactional
    public Message deleteById(int id) {
        // 删除资讯时，先删除相关联的收藏信息
        List<CollectionMessage> list = collectionMessageService.findInfoWithMessage(messageDao.findOne(id));
        if (null != list && list.size() > 0) {
            for (CollectionMessage collectionMessage : list) {
                collectionMessageService.deleteById(collectionMessage.getId());
            }
        }

        Message message = getById(id);
        messageDao.delete(message);
        return message;
    }

    @Override
    @Transactional
    public Message create(Message message) {
        messageDao.save(message);
        return message;
    }

    @Override
    @Transactional
    public Message update(Message message) {
        return messageDao.save(message);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    @Override
    public Page<Message> iFindMessagePage(Integer ifAll, Integer pageNum, Integer pageSize) {
        // ifAll是否更多
        // 0=是，1=否
        if (null != ifAll && ifAll == 0) {
            return messageDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));
        } else {
            return messageDao.findAll(new PageRequest(0, 3, Sort.Direction.DESC, "id"));
        }
    }

    @Override
    public Page<Message> findMessagePage(final Integer tagId, final String title, Integer pageNum, Integer pageSize) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.ASC, "showTurn");

        Page<Message> page = messageDao.findAll(new Specification<Message>() {
            @Override
            public Predicate toPredicate(Root<Message> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (null != tagId) {
                    Predicate predicate = cb.equal(root.get("messageTag").get("id").as(Integer.class), tagId);
                    predicateList.add(predicate);
                }

                if (null != title) {
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
    @Transactional
    public void changeRecommend(Integer id, String isRecommend) {
        Message message = messageDao.findOne(id);
        if (isRecommend.equals("yes")) {
            message.setRecommendTime(new Date());
        }
        if (isRecommend.equals("no")) {
            message.setRecommendTime(null);
        }

        message.setIsRecommend(isRecommend);
        messageDao.save(message);
    }

    @Override
    public Message showToMain() {
        List<Message> list = messageDao.showToMain();
        if (null != list && list.size() > 0) {
            return list.get(0);
        } else {
            return null;
        }
    }

    @Override
    public List<Message> pcRecommendList() {
        return messageDao.recommendList();
    }

    @Override
    public Page<Message> pcPage(int pageNum, int pageSize, final Integer tagId, final String name) {
        Page<Message> page = messageDao.findAll(new Specification<Message>() {
            @Override
            public Predicate toPredicate(Root<Message> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;
                if (StringUtils.isNotEmpty(name)) {
                    Predicate predicate = cb.like(root.get("title").as(String.class), "%" + name + "%");
                    predicateList.add(predicate);
                }
                if (tagId != null) {
                    Predicate predicate = cb.equal(root.get("messageTag").get("id").as(Integer.class), tagId);
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
    public List SameTypeMessage(final Integer messageId) {
        int needCount = 6; // 还需要数量，最大为6

        // 先获取资讯的类型和是否推荐
        Message message = getById(messageId);
        Integer messageTag = message.getMessageTag().getId();
        final String messageIsRecommendToT = "yes";

        // 用2个条件（同类型并且推荐的，按时间先后排序）去匹配查询6条数据
        List<Message> messagesList1 = new ArrayList<Message>();
        final Integer fMessageTag1 = messageTag;
        if (messageTag != null && messageIsRecommendToT != null) {
            Page<Message> page1 = messageDao.findAll(new Specification<Message>() {
                @Override
                public Predicate toPredicate(Root<Message> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                    List<Predicate> predicateList = new ArrayList<Predicate>();
                    Predicate result = null;

                    if (fMessageTag1 != null) {
                        Predicate predicate = cb.equal(root.get("messageTag").get("id").as(Integer.class), fMessageTag1);
                        predicateList.add(predicate);
                    }
                    if (messageIsRecommendToT != null) {
                        Predicate predicate = cb.equal(root.get("isRecommend").as(String.class), messageIsRecommendToT);
                        predicateList.add(predicate);
                    }
                    if (messageId != null) {
                        Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), messageId);
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

            }, new PageRequest(1 - 1, 6, Sort.Direction.DESC, "recommendTime"));
            messagesList1 = page1.getContent();
            if (messagesList1 == null) {
                messagesList1 = new ArrayList<Message>();
            }
        }
        // 用同类型去匹配查询6条数据
        List<Message> messagesList2 = new ArrayList<Message>();
        final Integer fMessageTag2 = messageTag;
        if (fMessageTag2 != null) {
            Page<Message> page2 = messageDao.findAll(new Specification<Message>() {
                @Override
                public Predicate toPredicate(Root<Message> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                    List<Predicate> predicateList = new ArrayList<Predicate>();
                    Predicate result = null;

                    if (fMessageTag2 != null) {
                        Predicate predicate = cb.equal(root.get("messageTag").get("id").as(Integer.class), fMessageTag2);
                        predicateList.add(predicate);
                    }
                    if (messageId != null) {
                        Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), messageId);
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
            messagesList2 = page2.getContent();
            if (messagesList2 == null) {
                messagesList2 = new ArrayList<Message>();
            }
        }

        // 用推荐类型去匹配查询最新6条数据
        List<Message> messagesList3 = new ArrayList<Message>();
        if (messageIsRecommendToT != null) {
            Page<Message> page2 = messageDao.findAll(new Specification<Message>() {
                @Override
                public Predicate toPredicate(Root<Message> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                    List<Predicate> predicateList = new ArrayList<Predicate>();
                    Predicate result = null;

                    if (messageIsRecommendToT != null) {
                        Predicate predicate = cb.like(root.get("isRecommend").as(String.class), messageIsRecommendToT);
                        predicateList.add(predicate);
                    }
                    if (messageId != null) {
                        Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), messageId);
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

            }, new PageRequest(1 - 1, 6, Sort.Direction.DESC, "recommendTime"));
            messagesList3 = page2.getContent();
            if (messagesList3 == null) {
                messagesList3 = new ArrayList<Message>();
            }
        }

        // 从所有的里面查询6条数据
        List<Message> messagesList4 = new ArrayList<Message>();
        Page<Message> page4 = messageDao.findAll(new Specification<Message>() {
            @Override
            public Predicate toPredicate(Root<Message> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                if (messageId != null) {
                    Predicate predicate = cb.notEqual(root.get("id").as(Integer.class), messageId);
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
        messagesList4 = page4.getContent();
        if (messagesList4 == null) {
            messagesList4 = new ArrayList<Message>();
        }

        List<Message> messagesList = new ArrayList<Message>();
        messagesList.addAll(messagesList1);
        needCount = needCount - messagesList.size();

        if (needCount > 0) {
            for (int i = 0; i < messagesList2.size(); i++) {
                if (!messagesList.contains(messagesList2.get(i)) && needCount > 0) {
                    messagesList.add(messagesList2.get(i));
                    needCount--;
                }
            }
        }

        if (needCount > 0) {
            for (int i = 0; i < messagesList3.size(); i++) {
                if (!messagesList.contains(messagesList3.get(i)) && needCount > 0) {
                    messagesList.add(messagesList3.get(i));
                    needCount--;
                }
            }
        }

        if (needCount > 0) {
            for (int i = 0; i < messagesList4.size(); i++) {
                if (!messagesList.contains(messagesList4.get(i)) && needCount > 0) {
                    messagesList.add(messagesList4.get(i));
                    needCount--;
                }
            }
        }
        return messagesList;
    }

    @Override
    public List<Message> PageJump(final Integer messageId) {
        String mId = messageId.toString();
        String sql = "SELECT id,title FROM message WHERE id IN ( SELECT CASE WHEN SIGN(id - " + mId + ") > 0 THEN MIN(id) WHEN SIGN(id -  " + mId + ") < 0 THEN MAX(id) END AS id FROM message  WHERE  id <> " + mId + "  GROUP BY SIGN(id - " + mId + "))";
        Query query = em.createNativeQuery(sql);
        List<Object[]> objects = query.getResultList();
        List<Message> messagesList = new ArrayList<Message>();
        for (Object[] object : objects) {
            Message message = new Message();
            message.setId((Integer) object[0]);
            message.setTitle((String) object[1]);
            messagesList.add(message);
        }
        if (messagesList.size() == 1) {
            Message messageN = new Message();
            messageN.setId(messageId);
            messageN.setTitle("无");
            if (messagesList.get(0).getId() < messageId) {
                messagesList.add(messageN);
            } else {
                messagesList.add(0, messageN);
            }
        }
        return messagesList;
    }

    @Override
    @Transactional
    public void collectionMessage(final Integer messageId, final Integer userId) {
        CollectionMessage collectionMessage = new CollectionMessage();
        Message message = new Message();
        message.setId(messageId);
        collectionMessage.setMessage(message);
        User user = new User();
        user.setId(userId);
        collectionMessage.setUser(user);
        if (collectionMessageService.iFindCollectionWithUser(user, message) == null) {
            collectionMessageService.create(collectionMessage);
        }
    }

    @Override
    @Transactional
    public void cancelledMessage(final Integer messageId, final Integer userId) {
        Message message = new Message();
        message.setId(messageId);
        User user = new User();
        user.setId(userId);
        List<CollectionMessage> list = collectionMessageService.pcFindCollectionWithUser(user, message);
        if (list.size() > 0) {
            collectionMessageService.deleteById(list.get(0).getId());
        }
    }

    @Override
    public boolean ajaxJudgeCollection(Integer messageId, Integer userId) {
        Message message = new Message();
        message.setId(messageId);
        User user = new User();
        user.setId(userId);
        List<CollectionMessage> collectionMessageList = collectionMessageService.pcFindCollectionWithUser(user, message);
        if (collectionMessageList.size() == 0) {
            return false;
        }
        return true;
    }

    @Override
    @Transactional
    public int messageCollectionAdd(Integer messageId, boolean addOrDel) {
        Message message = messageDao.findOne(messageId);
        if (addOrDel) {
            message.setCollectionNum(message.getCollectionNum() + 1);
        } else {
            message.setCollectionNum(message.getCollectionNum() - 1);
        }
        messageDao.save(message);
        return message.getCollectionNum();
    }


}