package com.bluemobi.decor.service;

import com.bluemobi.decor.entity.GoodsImage;
import com.bluemobi.decor.service.common.ICommonService;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * Created by gaoll on 2015/3/13.
 */
public interface GoodsImageService extends ICommonService<GoodsImage> {

    List<GoodsImage> listByGoodsId(Integer goodsId);

    Page<GoodsImage> findMaterial(Integer materialId, String styleId, String spaceId, String tagId, int pageNum, int pageSize);

    Page<GoodsImage> pageByKindTag(int pageNum, int pageSize,String kindTagId);

    public void deleteByGoodsId(Integer goodsId);

    public void clearByGoodsId(Integer goodsId);
}
