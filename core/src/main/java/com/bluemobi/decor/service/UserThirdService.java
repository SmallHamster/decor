package com.bluemobi.decor.service;

import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.entity.UserThird;
import com.bluemobi.decor.service.common.ICommonService;

import java.util.List;

/**
 * Created by tuyh on 2015/7/7 17:06.
 */
public interface UserThirdService extends ICommonService<UserThird> {

    // 根据OpenId查找用户信息
    public UserThird iFindByOpenId(String open_id, String type);

    // 根据用户ID查询对应的第三方绑定信息
    public List<UserThird> iFindUserThirdWithUser(User user);

    public List<UserThird> findByUserIdAndType(Integer userId, String type);
}