package com.bluemobi.decor.portal.controller.pc;


import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.City;
import com.bluemobi.decor.entity.Province;
import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.MD5Util;
import com.bluemobi.decor.portal.util.SessionUtils;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.CityService;
import com.bluemobi.decor.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 用户设置
 * Created by gaoll on 2015/3/3.
 */
@Controller
@RequestMapping(value = "/pc/userSetting")
public class UserSettingController4Pc extends CommonController {

        @Autowired
    private UserService userService;
    @Autowired
    private CityService cityService;


    @RequestMapping(value = "/goto")
    public String to(ModelMap modelMap,
                     HttpServletRequest request){
        return "pc/个人设置";
    }

    @RequestMapping(value = "/findUserById")
    public void findUserById(HttpServletRequest request, HttpServletResponse response,
                             Integer userId){
        try {
            User user=new User();
            if (userId!=null){
                user=userService.getById(userId);
            Province province=cityService.getById(user.getCity().getId()).getProvince();
            user.setProvince(province);
            }
            WebUtil.print(response, new Result(true).data(user));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }
    //修改密码
    @RequestMapping(value = "/changePassword")
    public void changePassword(HttpServletRequest request, HttpServletResponse response,
                               Integer userId, String newPassword ,String currentPassword,String code){
        try {
            String validate=(String)request.getSession().getAttribute("validate");
            String msg;
            if(code.equals(validate)){
            User user=userService.getById(userId);
            if (user.getPassword().equals( MD5Util.encodeByMD5(currentPassword))){
                user.setPassword(MD5Util.encodeByMD5(newPassword));
                userService.updateUser(user);
                msg="密码修改成功!";
            }else{
                msg="原密码错误!";
            }
                WebUtil.print(response, new Result(true).msg(msg));
            }else{
                msg="验证码错误!";
                WebUtil.print(response, new Result(true).msg(msg));
            }
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }
    @RequestMapping(value = "/saveUser")
    public void saveUser(HttpServletRequest request, HttpServletResponse response,
                             Integer userId,String userAccount,String userNickname,Integer userSex,String userMobile,
                             String userIsShow,String userCityName,String userWebsite,String userInfo){
        try {
            int bytesLength = userNickname.getBytes().length;
            if(bytesLength>10){
                WebUtil.print(response, new Result(true).msg("用户昵称过长!"));
                return;
            }
            User user =userService.getById(userId);
            user.setAccount(userAccount);
            user.setNickname(userNickname);
            user.setSex(userSex);
            user.setMobile(userMobile);
            user.setIsShow(userIsShow);
            List<City> cityList=cityService.findCityByName(userCityName);
            if (cityList.size()==1){
                user.setCity(cityList.get(0));
            }
            user.setWebsite(userWebsite);
            user.setInfo(userInfo);
            userService.updateUser(user);
            WebUtil.print(response, new Result(true).msg("操作成功!"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // 修改用户头像
    @RequestMapping(value = "/saveUserHeadImage")
    public void saveUserHeadImage(HttpServletRequest request, HttpServletResponse response,
                         String headImage){
        try {
            User user = (User)SessionUtils.get(Constant.SESSION_PC_USER);
            if(user == null){
                WebUtil.print(response, new Result(true).msg("请先登录!"));
                return;
            }
            user = userService.getById(user.getId());
            SessionUtils.put(Constant.SESSION_PC_USER, user);
            if(StringUtils.isNotEmpty(headImage)){
                user.setHeadImage(headImage);
            }
            if(StringUtils.isEmpty(user.getBackgroundImage())){
                user.setBackgroundImage(headImage);
            }
            userService.update(user);
            String nickname = user.getNickname();
            String shortNickname = nickname;
            if (nickname != null && nickname.length() > 4) {
                shortNickname = nickname.substring(0, 4) + "...";
            }
            user.setShortNickname(shortNickname);
            WebUtil.print(response, new Result(true).msg("保存成功!"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("保存失败!"));
        }
    }

    // 修改背景图
    @RequestMapping(value = "/saveUserBackgroundImage")
    public void saveUserBackgroundImage(HttpServletRequest request, HttpServletResponse response,
                                  String backgroundImage){
        try {
            User user = (User)SessionUtils.get(Constant.SESSION_PC_USER);
            if(user == null){
                WebUtil.print(response, new Result(true).msg("请先登录!"));
                return;
            }
            user = userService.getById(user.getId());
            SessionUtils.put(Constant.SESSION_PC_USER,user);
            if(StringUtils.isNotEmpty(backgroundImage)){
                user.setBackgroundImage(backgroundImage);
            }
            userService.update(user);
            WebUtil.print(response, new Result(true).msg("修改背景图成功!"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("保存失败!"));
        }
    }

}
