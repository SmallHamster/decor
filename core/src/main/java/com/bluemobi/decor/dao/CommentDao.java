package com.bluemobi.decor.dao;

import com.bluemobi.decor.entity.Comment;
import com.bluemobi.decor.entity.Praise;
import com.bluemobi.decor.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by tuyh on 2015/7/9 17:12.
 */
public interface CommentDao extends JpaRepository<Comment, Integer>, JpaSpecificationExecutor<Comment> {

    @Query("select a from Comment a where a.user = ?1 and a.objectId = ?2 and a.objectType = ?3")
    public List<Comment> iFindByUserAndObjectId(User user, Integer objectId, String objectType);

    @Query("select a from Comment a where a.objectId = ?1 and a.objectType = ?2 order by a.createTime desc")
    public List<Comment> findCommentByObjectIdAndObjectType(Integer objectId, String objectType);

    @Query("select a from Comment a where a.objectId = ?1 and a.objectType = ?2 order by a.createTime desc")
    public Page<Comment> pageByObjectIdAndObjectType(Integer objectId, String objectType, Pageable pageable);

    @Query("select a from Comment a where a.user = ?1 and a.pid = 0")
    public List<Comment> iGetCommentNumByUser(User user);

    @Query("select a from Comment a where a.user = ?1 and a.pid > 0")
    public List<Comment> iGetCommentNumByUser2(User user);

    @Query("select a from Comment a where a.pid = ?1")
    public List<Comment> iFindReply(Integer pid);

    @Query("select a from Comment a where a.pid = ?1 order by a.createTime desc")
    public List<Comment> listReply(Integer pid);

    //删除回复
    @Modifying
    @Query("delete from Comment a where a.pid=?1")
    public void deletebyPid(Integer pId);

    @Query("select a from Comment a where a.objectId = ?1 and a.objectType = ?2")
    public List<Comment> findListByObjectIdAndType(Integer objectId, String objectType);
}