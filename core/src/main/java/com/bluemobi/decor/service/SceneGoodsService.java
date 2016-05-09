package com.bluemobi.decor.service;

import com.bluemobi.decor.entity.Goods;
import com.bluemobi.decor.entity.Scene;
import com.bluemobi.decor.entity.SceneGoods;
import com.bluemobi.decor.service.common.ICommonService;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * Created by gaoll on 2015/3/13.
 */
public interface SceneGoodsService extends ICommonService<SceneGoods> {

    // 查询场景中的商品，最多6条
    public List<Goods> listGoods(Integer sceneId);

    // 查询商品所属场景，最多6条
    public List<Scene> listSceneByGoodsId(Integer goodsId);

    public List<SceneGoods> listBySceneId(Integer sceneId);
    public List<Goods> findGoods(Integer sceneId);

    public void deleteBySceneId(Integer sceneId);
}
