package com.bluemobi.decor.dao;

import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.entity.UserThird;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by gaoll on 2015/3/3.
 */
public interface UserDao extends JpaRepository<User, Integer>,JpaSpecificationExecutor<User> {

    @Query("select a from User a where a.mobile =?1 and a.password = ?2")
    public List<User> iFindByMobileAndPassword(String mobile,String password);

    @Query("select a from User a where a.mobile =?1")
    public List<User> iFindByMobile(String mobile);

    @Query("select a from User a where a.nickname =?1")
    public List<User> iFindByNickname(String nickname);

    @Query("select a from User a where a.account =?1")
    public List<User> findByAccount(String account);

    @Query("select a from User a where a.mobile =?1 and a.password = ?2")
    public List<User> getByMobileAndPassword(String mobile,String password);

    @Query("select a from User a where a.nickname =?1 and a.password = ?2")
    public List<User> getByNicknameAndPassword(String nickname,String password);

    @Query("select a from User a")
    public List<User> allUser();
}
