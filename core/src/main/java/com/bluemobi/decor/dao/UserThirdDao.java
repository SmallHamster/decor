package com.bluemobi.decor.dao;

import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.entity.UserThird;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by tuyh on 2015/7/7 17:06.
 */
public interface UserThirdDao extends JpaRepository<UserThird, Integer>, JpaSpecificationExecutor<UserThird> {

    @Query("select a from UserThird a where a.open_id =?1 and a.type =?2")
    public List<UserThird> iFindByOpenId(String open_id, String type);

    @Query("select a from UserThird a where a.user =?1")
    public List<UserThird> iFindUserThirdWithUser(User user);

    @Query("select a from UserThird a where a.user =?1 and a.open_id = ?2 and a.type = ?3")
    public UserThird iCheckBinding(User user, String openId, String type);

    @Query("select a from UserThird a where a.open_id = ?1 and a.type = ?2")
    public UserThird findByOpenidAndType(String openId, String type);

    @Query("select a from UserThird a where a.user.id = ?1 and a.type = ?2")
    public List<UserThird> findByUserIdAndType(Integer userId, String type);
}