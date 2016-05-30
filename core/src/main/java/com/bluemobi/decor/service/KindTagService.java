package com.bluemobi.decor.service;

import com.bluemobi.decor.entity.KindTag;
import com.bluemobi.decor.service.common.ICommonService;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * Created by tuyh on 2015/7/8 17:08.
 */
public interface KindTagService extends ICommonService<KindTag> {

    // 商品图分类查询
    public Page<KindTag> iFindGoodsSortPage(Integer pageNum, Integer pageSize);

    public Page<KindTag> page(Integer pageNum, Integer pageSize,final String name);

    // 根据id查询
    public List<KindTag> listByIds(List<Integer> ids);

    Page<KindTag> backendFindByCondition(int pageNum,
                                         int pageSize,
                                         final String name,
                                         final String image);

    //修改标签的图片数,num为1就+1,num为-1就减1
    public void updateKindTagSeviceNum(Integer kindTagId, int num);

    public String getTagStr(String kindTagId);

    public List<KindTag> all();
}