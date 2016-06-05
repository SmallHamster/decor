package com.bluemobi.decor.dao;

import com.bluemobi.decor.entity.Scene;
import com.bluemobi.decor.entity.Series;
import com.bluemobi.decor.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by gaoll on 2015/3/3.
 */
public interface SeriesDao extends JpaRepository<Series, Integer>,JpaSpecificationExecutor<Series> {

    @Query("select a from Series a where a.user = ?1")
    public List<Series> iFindSeriesByUser(User user);

    @Query("select a from Series a where a.user = ?1 order by a.id desc")
    public List<Series> findSeriesByUser(User user);

    @Query("select a from Series a where a.info like ?1")
    public List<Series> findSeries(String info);


}
