package com.bluemobi.decor.service;

import com.bluemobi.decor.entity.Series;
import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.service.common.ICommonService;
import com.bluemobi.decor.service.moduleHandler.SeeNumHandler;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * Created by gaoll on 2015/3/13.
 */
public interface SeriesService extends ICommonService<Series>,SeeNumHandler {

    // 系列图列表
    public Page<Series> iPage(int pageNum,
                              int pageSize,
                              String condition,
                              Integer seriesTagId);

    // 我发布的系列图
    public Page<Series> iPageMy(int pageNum,
                                int pageSize,
                                Integer userId);

    // 接口创建系列图
    public void iAddSeries(Integer userId,
                           Integer seriesTagId,
                           String info,
                           String sceneIds);

    // web创建系列图
    public void pcAddSeries(Integer userId,
                           Integer seriesTagId,
                           String info,
                           String sceneIds);

    // 查询指定用户的系列图列表
    public List<Series> iFindSeriesByUser(User user);

    // 查询指定用户的系列图列表
    public List<Series> findSeriesByUser(User user);

    // 获取封面图全地址
    public String getHeadPath(Integer seriesId);

    // 查询所有系列图
    public int findSeries(String info);

    // 系列图列表
    public Page<Series> pageByParams(int pageNum,
                                     int pageSize,
                                     Integer id,
                                     String author,
                                     Integer seriesTagId);

    public void deleteBySeriesId(Integer seriesId);

    public void insert(Integer userId, Integer tagId, String info, String sceneIds);

    // pc端分页查询
    public Page<Series> pcPage(int pageNum,
                              int pageSize,
                              String name,
                              Integer seriesTagId);

    // 查询6条同类商品
    List<Series> sameTypeSeries(Integer seriesId);
    //系列图分页
    public  Page<Series> pcFindSeriesPage(User user,int pageNum,int pageSize);

    public Page<Series> pageOrderByPraise(int pageNum,
                               int pageSize,Integer userId);
}
