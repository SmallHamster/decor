package com.bluemobi.decor.dao;

import com.bluemobi.decor.entity.Scene;
import com.bluemobi.decor.entity.Series;
import com.bluemobi.decor.entity.SeriesScene;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by gaoll on 2015/3/3.
 */
public interface SeriesSceneDao extends JpaRepository<SeriesScene, Integer>,JpaSpecificationExecutor<SeriesScene> {

    @Query("select a from SeriesScene a where a.series = ?1")
    public List<SeriesScene> iFindBySeries(Series series);

    @Query("select a from SeriesScene a where a.series = ?1")
    public List<SeriesScene> pcFindBySeries(Series series);

    @Query("select a.scene from SeriesScene a where a.series.id = ?1 order by a.scene.praiseNum desc ")
    public List<Scene> findSceneListBySeriesId(Integer seriesId);

    @Query("select a.series from SeriesScene a where a.scene.id = ?1")
    public List<Series> findSeriesListBySceneId(Integer sceneId);

   /* @Query("select count(scene) from SeriesScene a where a.scene=?1 ")
    public List<Series> findSeries(Scene scene);*/

    // 根据场景图ID删除场景系列图关系
    @Modifying
    @Query("delete from SeriesScene a where a.scene.id =?1")
    public void deleteBySceneId(Integer sceneId);
    @Modifying
    @Query("delete from SeriesScene a where a.series.id =?1")
    public void deleteBySeriesId(Integer seriesId);
}
