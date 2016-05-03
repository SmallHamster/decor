package com.bluemobi.decor.service;

import com.bluemobi.decor.entity.Comment;
import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.service.common.ICommonService;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * Created by tuyh on 2015/7/9 17:13.
 */
public interface CommentService extends ICommonService<Comment> {

    // 根据用户ID和评论源ID查询指定评论信息
    public Comment iFindByUserAndObjectId(User user, Integer objectId, String objectType);

    // 获取用户评论数 or 回复数
    public int iGetCommentNumByUser(User user, Integer type);

    // 根据评论ID获取对应的评论回复列表
    public List<Comment> iFindReply(Integer pid);

    public List<Comment> findListByObjectIdAndType(Integer objectId, String objectType);

    // 根据评论ID获取对应的评论回复列表
    public List<Comment> listReply(Integer pid);

    // 查询用户评论列表
    public Page<Comment> iFindCommentPage(Integer userId, Integer pageNum, Integer pageSize);

    // 查询用户评论列表
    public Page<Comment> findCommentPage(Integer userId, Integer pageNum, Integer pageSize);

    // 评论列表查询（商品图评论 or 场景图评论）
    public Page<Comment> iFindCommentPages(Integer objectId, String objectType, Integer pageNum, Integer pageSize);

    public Page<Comment> backendFindByCondition(int pageNum,
                                                int pageSize,
                                                final String username,
                                                final String pid);

    //根据评论对象删除评论与回复
    public void deleteByObjectIdAndObjectType(Integer objectId, String objectType);

    //根据评论对象删除评论与回复
    public List<Comment> listCommentIncludeReply(Integer objectId,String objectType);

    // 保存评论信息
    public void createComment(Integer userId,
                              Integer objectId,
                              String objectType,
                              String content);

    public void iCreateCommentBusiness(Comment comment);
}