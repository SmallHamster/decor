package com.bluemobi.decor.dao;

import com.bluemobi.decor.entity.Message;
import com.bluemobi.decor.entity.Scene;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by tuyh on 2015/7/14 9:53.
 */
public interface MessageDao extends JpaRepository<Message, Integer>, JpaSpecificationExecutor<Message> {

    @Query("select a from Message a order by a.createTime DESC")
    public List<Message> showToMain();

    @Query("select a from Message a where a.isRecommend = 'yes' ")
    public List<Message> recommendList();

    @Query("select a from Message a where a.isRecommend = 'yes' ")
    public Page<Message> recommendPage(Pageable pageable);
}