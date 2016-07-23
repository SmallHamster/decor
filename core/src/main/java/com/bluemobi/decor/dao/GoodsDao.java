package com.bluemobi.decor.dao;

import com.bluemobi.decor.entity.Goods;
import com.bluemobi.decor.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by gaoll on 2015/3/3.
 */
public interface GoodsDao extends JpaRepository<Goods, Integer>, JpaSpecificationExecutor<Goods> {

    @Query("select a from Goods a where a.user = ?1")
    public List<Goods> iFindGoodsByUser(User user);

    @Query("select a from Goods a where a.name like ?1")
    public List<Goods> findGoods(String name);

    @Query("select a from Goods a where a.isPass = 'yes'")
    public Page<Goods> findPage(Pageable pageable);

    @Query("select a from Goods a where a.isPass = 'yes'")
    public List<Goods> findList();

    @Query("select a from Goods a where a.kindTagIds = ?1")
    public Page<Goods> pageByParams(String kindTags, Pageable pageable);
}
