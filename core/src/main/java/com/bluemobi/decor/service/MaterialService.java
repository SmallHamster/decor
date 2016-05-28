package com.bluemobi.decor.service;

import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.service.common.ICommonService;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * Created by gaoll on 2015/3/13.
 */
public interface MaterialService extends ICommonService<Material> {

    // 所有素材
    public Page<Material> iPageAll(int pageNum,
                                   int pageSize,
                                   String name,
                                   Integer kindTagId,
                                   Integer spaceTagId,
                                   Integer styleTagId,
                                   String sort);

    // 我的素材
    public Page<Material> iPageMy(int pageNum,
                                  int pageSize,
                                  Integer userId);
    // 我的素材
    public Page<Material> pcPageMy(int pageNum,
                                  int pageSize,
                                  Integer userId);

    // 我收藏的素材
    public Page<CollectionMaterial> iPageMyCollection(int pageNum,
                                                      int pageSize,
                                                      Integer userId);

    // 我收藏的素材
    public Page<CollectionMaterial> pageMyCollection(int pageNum,
                                                      int pageSize,
                                                      Integer userId,
                                                      String name,
                                                      Integer kindTagId,
                                                      Integer spaceTagId,
                                                      Integer styleTagId,
                                                      String sort);

    // 素材图列表（分页）
    public Page<Material> iPageWithUser(int pageNum,
                                        int pageSize,
                                        Integer kindTagId,
                                        Integer spaceTagId,
                                        Integer styleTagId,
                                        String sort,
                                        String name);

    // 根据用户ID和素材ID判断该素材是否属于该用户
    public Material iCheckMaterialByUser(User user, Integer materialId);

    // 查询素材图总数量
    public int findMaterialCount(String name);

    //可根据ID筛选查询素材列表
    public Page<Material> findMaterials(Integer id, int pageNum, int pageSize);

    //根据ID删除素材
    public void deleteMaterial(Integer id);

    //根据ID集合删除素材
    public void deleteMaterial(int[] ids);

    //上传素材
    public void insertMaterial(Integer userId,
                               String image,
                               Integer goodsImageId,
                               String kingTag,
                               String spaceTagIds,
                               String styleTagIds);

    //编辑素材
    public void updataMaterial(String image,
                               Integer materialId,
                               String kingTag,
                               String spaceTagIds,
                               String styleTagIds);

    // 查询我的素材图
    public List<Material> listMy(Integer userId, Integer number);

    // 查询我的素材图
    public List<Material> listMyCollection(Integer userId, Integer number);

    // 查询一定数量的素材图
    public List<Material> list(Integer number);
}
