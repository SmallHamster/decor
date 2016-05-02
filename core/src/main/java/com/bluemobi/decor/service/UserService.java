package com.bluemobi.decor.service;

import com.bluemobi.decor.entity.City;
import com.bluemobi.decor.entity.Province;
import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.entity.UserThird;
import com.bluemobi.decor.service.common.ICommonService;
import org.springframework.data.domain.Page;

import java.util.List;
import java.util.Map;
import java.util.Objects;


/**
 * Created by gaoll on 2015/3/13.
 */
public interface UserService extends ICommonService<User> {

    // 后台用户登录操作
    public Boolean backendLogin(String username, String password);

    // pc端登录操作
    public User pcLogin(String username, String password);

    // pc端第三方登录操作
    public User pcLoginPlus(String username, String password);

    // 根据手机号查找指定用户信息
    public User iFindByMobile(String mobile);

    // 根据手机号查找指定用户信息
    public User findByMobile(String mobile);

    // 根据呢称查找指定用户信息
    public User iFindByNickname(String nickname);

    // 根据账号查找指定用户信息
    public User iFindByAccount(String account);

    // 根据用户手机号和密码查询用户信息
    public User iFindByMobileAndPassword(String mobile, String password);

    // 用户注册操作
    User iRegister(User user);

    // 用户注册操作
    String pcRegister(User user);

    // 用户注册操作
    String pcResetPassword(String mobile,String password);

    // 将用户ID跟第三方OpenId绑定
    public void bindingOpenId(User user, String open_id, String type);

    // 根据用户ID和第三方OpenId获取绑定信息
    public UserThird iCheckBinding(User user, String open_id, String type);

    public UserThird findByOpenidAndType(String open_id, String type);

    public Page<User> iPageUser(Integer cityId, String name, String sort, Integer pageNum, Integer pageSize);

    public Page<User> bAdmin(Integer pageNum, Integer pageSize, String nickname, String account);

    public Page<User> QAdmin(Integer pageNum, Integer pageSize, String nickname, String account, Integer id);

    public Page<User> BAdmin(Integer pageNum, Integer pageSize, String nickname, String account, Integer id);

    // 启用 or 禁用单个用户
    public void changeStatus(Integer id, String status);

    // 批量启用 or 禁用用户
    public void batchChangeStatus(String ids, String status);

    // 推荐 or 取消推荐单个用户
    public void changeRecommend(Integer id, String isRecommend);

    // 保存管理员
    public User saveAdmin(User user,Integer roleId);

    // 保存管理员
    public Boolean isAccountExist(String account);

    // 首页查询最新用户
    public Page<User> PageToMain(Integer pageNum, Integer pageSize);

    public String iModifyPassword(Integer userId,String oldPassword,String newPassword);
    //展示所有省份和城市
    public List<Province> showProvince();
    //根据省份ID查询所有城市
    public List<City> showCity(Integer provinceId);
    //根据条件查询用户分页
    public  Page<User> pcPage(Integer pageNum,Integer pageSize, Integer cityId ,String sort,String name,Integer provinceId);
    //FANS最多的四位
    public List<User> maxFans();
    //查询当前用户是否被登录用户关注
    public boolean IsAttentionByUser(Integer userId,Integer sessionUserId);
    //对关注状态进行添加删除
    public  void  updateIsAttention(Integer userId,Integer sessionUserId,boolean addOrDel);
    //更改FANS数量
    public void updateFansNum( Integer userId,boolean addOrDel);
    //修改用户信息
    public  void updateUser(User user);
    // 粉丝数+1
    public void fansNumAddOne(Integer userId);
    // 粉丝数-1
    public void fansNumCutOne(Integer userId);

    public List<User> allUser();
}
