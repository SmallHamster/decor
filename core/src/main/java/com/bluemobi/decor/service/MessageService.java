package com.bluemobi.decor.service;

import com.bluemobi.decor.entity.Message;
import com.bluemobi.decor.entity.Scene;
import com.bluemobi.decor.service.common.ICommonService;
import org.springframework.data.domain.Page;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by tuyh on 2015/7/14 9:53.
 */
public interface MessageService extends ICommonService<Message> {

    // 查询资讯列表
    public Page<Message> iFindMessagePage(Integer ifAll, Integer pageNum, Integer pageSize);

    // 查询资讯列表
    public Page<Message> findMessagePage(Integer sort, String title, Integer pageNum, Integer pageSize);

    // 推荐 or 取消推荐资讯
    public void changeRecommend(Integer id, String isRecommend);

    // 推荐 or 取消推荐资讯
    public Message showToMain();

    public Message showToMainPC();

    List<Message> pcRecommendList();
    //根据分配查询资讯列表
   public Page<Message> pcPage(int pageNum,
                                int pageSize,
                                Integer tagId,String name);

    //根据ID查询资讯同类信息
   public List<Message> SameTypeMessage (Integer messageId);
    //上下页跳转
    public List<Message> PageJump(Integer messageId);
    //收藏资讯
    public void collectionMessage(Integer messageId,Integer userId);
    //取消收藏
    public void cancelledMessage(Integer messageId,Integer userId);
    //判断收藏
    public boolean ajaxJudgeCollection(Integer messageId,Integer userId);
    //增加收藏量
    public int messageCollectionAdd(Integer messageId,boolean addOrDel);

}